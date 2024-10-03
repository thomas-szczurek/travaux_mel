@ECHO OFF

ECHO Etape 1 - assignation des variables

REM variables potentiellement modifiables
REM url stable vers la donnee
SET URL=https://www.data.gouv.fr/fr/datasets/r/9eb02ac9-4bce-4fa8-a6f7-451c5b366f66
REM repertoire d'installation de qgis
SET QGIS="C:\Program Files\QGIS 3.34.8
REM emplacement des traitements intermediaires
SET WORK_PLACE=%USERPROFILE%\Documents\3_tests\donnees_ref

SET BBOX=685041 7044713 719322 7077570
REM il faut aussi configurer GDAL_DATA car on utilise gdal/ogr en dehors du shell osgeo4w
SET GDAL_DATA=%QGIS%\apps\gdal\share\gdal"

ECHO ANNUAIRE DE L EDUCATION
ECHO Etape 2 - telechargement du fichier

curl -o %WORK_PLACE%\annuaire_educ.geojson %URL% --ssl-no-revoke -L

ECHO Etape 3 - conversion en geopackage et extraction zonage mel

%QGIS%/bin/ogr2ogr.exe" -spat_srs EPSG:2154 -spat %BBOX% -t_srs EPSG:2154 -clipdst %WORK_PLACE%\mel.fgb -makevalid -nln annuaire_educ -lco FID=OBJECTID %WORK_PLACE%\annuaire_educ.gpkg %WORK_PLACE%\annuaire_educ.geojson
del %WORK_PLACE%\annuaire_educ.geojson

ECHO Etape 4 - creation information.txt

(
ECHO QUOI : Annuaire de l'education
ECHO PROVENANCE / URL DE TELECHARGEMENT : %URL%
ECHO DATE D ACQUISITION : %DATE%
ECHO AGENT : %USERNAME% 
) > %WORK_PLACE%\informations.txt

