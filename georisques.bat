@ECHO OFF

ECHO Etape 1 - assignation des variables

REM variables potentiellement modifiables
REM repertoire d'installation de qgis
SET QGIS="C:\Program Files\QGIS 3.34.8
REM emplacement des traitements intermediaires
SET WORK_PLACE=%USERPROFILE%\Documents\3_tests\donnees_ref
SET URL_GEOR="https://georisques.gouv.fr

SET BBOX=685041 7044713 719322 7077570
REM il faut aussi configurer GDAL_DATA car on utilise gdal/ogr en dehors du shell osgeo4w
SET GDAL_DATA=%QGIS%\apps\gdal\share\gdal"
REM curl n'arrive pas à certifier les certifs ssl (y comprit ceux des serveurs de la mel) à travers le proxy de la mel donc on désactive la verif ssl pour les wfs
SET GDAL_HTTP_UNSAFESSL=YES

ECHO Etape 2 - conversion en geopackage et extraction zonage mel

%QGIS%/bin/ogr2ogr.exe" -spat_srs EPSG:2154 -spat %BBOX% -t_srs EPSG:2154 -clipdst %WORK_PLACE%\mel.fgb -makevalid -nln aciens_sites_indus_ou_activite_service -lco FID=OBJECTID %WORK_PLACE%/test.gpkg WFS:%URL_GEOR%/services?VERSION=2.0.0&TYPENAME=ms:SSP_ETS_GE_POINT"

(
ECHO QUOI : Anciens sites industriels et activités de service
ECHO PROVENANCE / URL DE TELECHARGEMENT : Serveur WFS de %URL_GEOR%"
ECHO DATE D ACQUISITION : %DATE%
ECHO AGENT : %USERNAME% 
) > %WORK_PLACE%\informations.txt
