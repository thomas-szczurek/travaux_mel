"""
***************************************************************************
*                                                                         *
*   This program is free software; you can redistribute it and/or modify  *
*   it under the terms of the GNU General Public License as published by  *
*   the Free Software Foundation; either version 2 of the License, or     *
*   (at your option) any later version.                                   *
*                                                                         *
***************************************************************************
"""
from math import ceil
from math import floor
from PyQt5.QtWidgets import QFileDialog
import os
import numpy as np
import shapely
import pandas as pd
import geopandas as gpd
import matplotlib.pyplot as plt
from qgis.PyQt.QtCore import QCoreApplication
from qgis import processing
from qgis.core import (QgsProcessing,
                       QgsExpression,
                       QgsExpressionContext,
                       QgsFeatureSink,
                       QgsProcessingException,
                       QgsProcessingAlgorithm,
                       QgsProcessingParameterFeatureSource,
                       QgsVectorLayer,
                       QgsProject,
                       QgsProcessingParameterFeatureSink)

# Fonction permettant de charger une geodataframe dans le projet qgis courant
def gdf_to_layer(gdf_name, name_in_project):
    vlayer = QgsVectorLayer(gdf_name.to_json(to_wgs84=True),name_in_project,"ogr")
    QgsProject.instance().addMapLayer(vlayer)
    return vlayer

# Fonction permettant de trouver l'objet d'une df ordonnée selon x ayant l'attribut x le plus proche d'une valeur donnée et de renvoyer son index
def find_neighbours(value, df, colname):
    exactmatch = df[df[colname] == value]
    if not exactmatch.empty:
        return exactmatch.index[0]
    else:
        lowerneighbour_ind = df[df[colname] < value][colname].idxmax()
        upperneighbour_ind = df[df[colname] > value][colname].idxmin()
        if  abs(lowerneighbour_ind - value) < abs(upperneighbour_ind - value):
            return lowerneighbour_ind
        else:
            return upperneighbour_ind

class middle_analize(QgsProcessingAlgorithm):
    """
    This is an example algorithm that takes a vector layer and
    creates a new identical one.

    It is meant to be used as an example of how to create your own
    algorithms and explain methods and variables used to do it. An
    algorithm like this will be available in all elements, and there
    is not need for additional work.

    All Processing algorithms should extend the QgsProcessingAlgorithm
    class.
    """

    # Constants used to refer to parameters and outputs. They will be
    # used when calling the algorithm from another algorithm, or when
    # calling from the QGIS console.

    INPUT = 'INPUT'
    OUTPUT = 'OUTPUT'

    def tr(self, string):
        """
        Returns a translatable string with the self.tr() function.
        """
        return QCoreApplication.translate('Processing', string)

    def createInstance(self):
        return middle_analize()

    def name(self):
        """
        Returns the algorithm name, used for identifying the algorithm. This
        string should be fixed for the algorithm, and must not be localised.
        The name should be unique within each provider. Names should contain
        lowercase alphanumeric characters only and no spaces or other
        formatting characters.
        """
        return 'middle_analyze'

    def displayName(self):
        """
        Returns the translated algorithm name, which should be used for any
        user-visible display of the algorithm name.
        """
        return self.tr('Analyse des milieux')

    def group(self):
        """
        Returns the name of the group this algorithm belongs to. This string
        should be localised.
        """
        return self.tr('Nuages de Points')

    def groupId(self):
        """
        Returns the unique ID of the group this algorithm belongs to. This
        string should be fixed for the algorithm, and must not be localised.
        The group id should be unique within each provider. Group id should
        contain lowercase alphanumeric characters only and no spaces or other
        formatting characters.
        """
        return 'pointcloud_mel'

    def shortHelpString(self):
        """
        Returns a localised short helper string for the algorithm. This string
        should provide a basic description about what the algorithm does and the
        parameters and outputs associated with it..
        """
        return self.tr("Example algorithm short description")

    def initAlgorithm(self, config=None):
        """
        Here we define the inputs and output of the algorithm, along
        with some other properties.
        """

        # We add the input vector features source. It can have any kind of
        # geometry.

    def processAlgorithm(self, parameters, context, feedback):
        # Chargement des données, séparation des deux gdf de groupes de points et ordonancement selon z
        # Selection de la section aux formats (las, laz, copc.laz) et détection du type pour algo de transformation en pointZ
        fname = QFileDialog.getOpenFileName(None, 'Ouvrir la section','c:\\',"Las files (*.las *.laz *.copc.laz)")[0]
        if os.path.splitext(fname)[:-4] == 'copc':
            prov = 'copc'
        else:
            prov = 'pdal'
        input = prov+'://'+fname

        section_path = os.path.dirname(fname)
        os.chdir(section_path)

        # Transformation en pointZ
        laz_to_gpd = processing.run("pdal:exportvector", {'INPUT':input,'ATTRIBUTE':[],'FILTER_EXPRESSION':'','FILTER_EXTENT':None,'OUTPUT':'TEMPORARY_OUTPUT'}, is_child_algorithm=True)
        laz_to_gpd = list(laz_to_gpd.values())[0]
        # Clustering par K-moyennes pour déterminer les groupes de points et donc les assigner à un côté.
        # On préfère des K-moyennes a un DBSCAN car pas d'outliers et nombre de groupes désirés connu à l'avance (2). La méthode des K-moyennes et plus rapide
        processing.run("native:kmeansclustering", {'INPUT':laz_to_gpd,'CLUSTERS':2,'FIELD_NAME':'groupe','SIZE_FIELD_NAME':'CLUSTER_SIZE','OUTPUT':'ogr:dbname=\''+section_path+'/temp.gpkg\' table="Clusters" (geom)'}, is_child_algorithm=True)
        # Chargement dans une GeoDataFrame
        section = gpd.read_file(section_path+'/temp.gpkg', layer='Clusters', engine='pyogrio')
        section['z'] = section.get_coordinates(include_z=True)['z']
        os.remove(section_path+'/temp.gpkg')

        z_min = section['z'].min().item()
        z_min = ceil(z_min)+1
        z_max = section['z'].max().item()
        z_max = floor(z_max)-1
        section_crs = section.crs

        pts_line1 = section[section['groupe']==0]
        pts_line2 = section[section['groupe']==1]
        pts_line1 = pts_line1.sort_values('z').reset_index(drop=True)
        pts_line2 = pts_line2.sort_values('z').reset_index(drop=True)

        # Enregistrement du milieu de la base
        idx_z1 = find_neighbours(z_min, pts_line1, 'z').item()
        idx_z2 = find_neighbours(z_min, pts_line2, 'z').item()
        pt1_base = pts_line1.iloc[[idx_z1]]
        pt2_base = pts_line2.iloc[[idx_z2]]
        middlex_base = (float(pt2_base.get_coordinates()['x']) + float(pt1_base.get_coordinates()['x'])) / 2
        middley_base = (float(pt2_base.get_coordinates()['y']) + float(pt1_base.get_coordinates()['y'])) / 2
        middle_base_geom = gpd.GeoSeries([shapely.points([middlex_base, middley_base])], crs=section_crs)
        middle_base_data = {'geometry': middle_base_geom}
        middle_base_layer = gpd.GeoDataFrame(middle_base_data)
        # On enlève la dimension Z avec d'avoir une comparaison valide pour déterminer la direction d'inclinaison. On galère au lieu d'utiliser force_2d() car on a pas la version 1.0.1 de geopandas sur qgis 3.32
        pt1_basex,pt1_basey = float(pt1_base.get_coordinates()['x']), float(pt1_base.get_coordinates()['y'])
        pt2_basex,pt2_basey = float(pt2_base.get_coordinates()['x']), float(pt2_base.get_coordinates()['y'])
        pt1_base_geom, pt2_base_geom =  gpd.GeoSeries([shapely.points([pt1_basex, pt1_basey])], crs=section_crs), gpd.GeoSeries([shapely.points([pt2_basex, pt2_basey])], crs=section_crs)
        pts_1_base_data, pts_2_base_data = {'geometry': pt1_base_geom}, {'geometry': pt2_base_geom}
        pt1_base, pt2_base = gpd.GeoDataFrame(pts_1_base_data), gpd.GeoDataFrame(pts_2_base_data)


        # Boucle sur les valeurs de z
        coupes = list(range(z_min,z_max))
        bary = 'LINESTRINGZ('
        matrice = pd.DataFrame(columns=['x', 'y'])
        for c in coupes:
            # sélection des points les plus proches
            idx_z1 = find_neighbours(c, pts_line1, 'z').item()
            idx_z2 = find_neighbours(c, pts_line2, 'z').item()
            pt1 = pts_line1.iloc[[idx_z1]]
            pt2 = pts_line2.iloc[[idx_z2]]
            # Calcul des coordonnées du milieu
            middlex = (float(pt2.get_coordinates()['x']) + float(pt1.get_coordinates()['x'])) / 2
            middley = (float(pt2.get_coordinates()['y']) + float(pt1.get_coordinates()['y'])) / 2
            middlez = (float(pt1['z']) + float(pt2['z']))/2
            # Injection dans la chaine de wkt de création de la ligne
            bary = bary + str(middlex) + ' ' + str(middley) + ' ' + str(middlez) + ','
            # Création point milieu
            middle_temp_geom = gpd.GeoSeries([shapely.points([middlex, middley])], crs=section_crs)
            middle_temp_data = {'geometry': middle_temp_geom}
            middle_temp_layer = gpd.GeoDataFrame(middle_temp_data)
            # insertion du point dans la df de remise en 2d (x = distance base, y = z)
            if middle_temp_layer.distance(pt1_base).item() >= middle_temp_layer.distance(pt2_base).item():
                x = middle_temp_layer.distance(middle_base_layer)
            else:
                x = 0 - middle_temp_layer.distance(middle_base_layer)
            y = c
            matrice = pd.concat([pd.DataFrame([[x, y]], columns=matrice.columns), matrice], ignore_index=True)

        # Nettoyage final wkt line
        bary = bary[:-1] + ')'
        # Création de la LinestringZ de milieu
        middle = shapely.wkt.loads(bary)
        middle_geom = gpd.GeoSeries([middle], crs=section_crs)
        middle_data = {'geometry': middle_geom}
        middle_layer = gpd.GeoDataFrame(middle_data)
        gdf_to_layer(middle_layer, 'milieux')
        gdf_to_layer(section, 'section')

        # Création graphique
        plt.plot('x', 'y', data=matrice, linestyle='-', marker='o')
        # Droite de regression
        x = []
        i = 0
        for v in matrice['x']:
            x.append(matrice['x'][i].values[0].item())
            i += 1
        x = np.array(x)
        y = []
        i = 0
        for v in matrice['y']:
            y.append(matrice['y'][i])
            i += 1
        m, b = np.polyfit(x, y, deg=1)
        # Réglages dimensions des axes
        plt.yticks(coupes)
        if x.max() == 0:
            plt.xlim(x.min().item(),0 - x.min().item())
        else:
            plt.xlim(0 - x.max().item(),x.max().item())
        plt.xlabel('<- groupe 1 / groupe 0 ->')
        plt.plot(x, m*x + b)
        # Calcul angle (b et m sont issus du calcul de l'équation de la droite de régression ligne 135)
        xu = ((matrice[['y']].max().item()-b)/m).item()
        xd = ((matrice[['y']].min().item()-b)/m).item()
        yu = matrice[['y']].max().item()
        yd = matrice[['y']].min().item()
        exp = 'degrees(azimuth(make_point('+str(xd)+','+str(yd)+'), make_point('+str(xu)+','+str(yu)+')))'
        exp = QgsExpression(exp)
        context = QgsExpressionContext()
        angle = exp.evaluate(context)
        if angle > 180:
            angle = 360 - angle
        else:
            pass
        plt.suptitle('l\'angle est de '+str(round(angle,2))+' degrés')
        plt.show()
        return {}
