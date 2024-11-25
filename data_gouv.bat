@ECHO OFF
REM /////////////// Début étape 1 ///////////////
ECHO Etape 1 - assignation des variables et creation du dossier de traitement temporaire

REM variables potentiellement modifiables
REM repertoire d'installation de qgis
SET QGIS="C:\Program Files\QGIS 3.34.8
REM emplacement des traitements intermediaires
mkdir %USERPROFILE%\Documents\traitement_donnees_etageres
SET WORK_PLACE=%USERPROFILE%\Documents\traitement_donnees_etageres
REM emplacement des couches de déocupages mel et communales
SET LAYER_PLACE=V:\1_sig\projets\ref_donnees_etageres

REM Bounding box de la MEL
SET BBOX=685042 7044714 719323 7077571

REM il faut configurer GDAL_DATA car on utilise gdal/ogr en dehors du shell osgeo4w
SET GDAL_DATA=%QGIS%\apps\gdal\share\gdal"
REM curl n'arrive pas a certifier les certifs ssl auto renouvelés à travers le proxy de la mel (y comprit ceux des serveurs de la mel) à travers lui alors on désactive la verif ssl pour les wfs
SET GDAL_HTTP_UNSAFESSL=YES
REM options de créations
SET OPTIONS_CREA_ETAPE2=-append -spat_srs EPSG:2154 -spat %BBOX% -t_srs EPSG:2154 -clipdst %LAYER_PLACE%\mel.fgb --config OGR_WFS_PAGE_SIZE=100000 -gt 65536 -makevalid -lco FID=OBJECTID
REM enregistrement de l'horaire de lancement du script
SET STARTTIME_TOT=%TIME%

REM url de l'api ogc de la geomplateforme. L'option TYPENAMES est celle permettant d'indiquer une couche spécifique
SET URL_INFO=https://www.data.gouv.fr
SET URL_GEOP="%URL_INFO%/wfs/ows?SERVICE=WFS&REQUEST=GetFeature&VERSION=2.0.0&TYPENAMES=

REM /////////////// Début étape 2 ///////////////
(
ECHO
ECHO Etape 2 - Annuaire de l'education
ECHO
)

REM enregistrement de l'horaire de lancement du téléchargement
SET STARTTIME=%TIME%
SET URL_DWL=%URL_INFO%/fr/datasets/r/9eb02ac9-4bce-4fa8-a6f7-451c5b366f66
curl %URL_DWL% %WORK_PLACE%/annuaire_education.geojson --ssl-no-revoke -L
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln annuaire_education -lco FID=OBJECTID %WORK_PLACE%/annuaire_education.gpkg %WORK_PLACE%/annuaire_education.geojson

REM Enregistrer l'heure de fin
SET ENDTIME=%TIME%

REM Convertir STARTTIME et ENDTIME en secondes
for /f "tokens=1-3 delims=:" %%a in ("%STARTTIME%") do (
    set /a STARTSEC=3600*1%%a+60*1%%b+1%%c
)
for /f "tokens=1-3 delims=:" %%a in ("%ENDTIME%") do (
    set /a ENDSEC=3600*1%%a+60*1%%b+1%%c
)

REM Calculer la différence en secondes
SET /a DELTA=%ENDSEC%-%STARTSEC%

REM Convertir DELTA en heures, minutes et secondes
SET /a HOURS=%DELTA% / 3600
SET /a DELTA=%DELTA% %% 3600
SET /a MINUTES=%DELTA% / 60
SET /a SECONDS=%DELTA% %% 60

(
ECHO Qui : %USER%
ECHO Quoi : Annuaire de l'écudcation
ECHO Source : Ministère de l'éducation
ECHO Source : %URL_INFO%
ECHO Téléchargement le : %TIME%
ECHO Durée de téléchargement : %HOURS%h. %MINUTES%min. %SECONDS%sec
) > %WORK_PLACE%/informations.txt

REM /////////////// Début étape 4 ///////////////
(
ECHO
ECHO Etape 4 - Copie des fichiers et nettoyage
ECHO
)

copy /b /v /y %WORK_PLACE%/bd_topo.gpkg \\volt\infogeo\Donnees\Externe\IGN\BD_TOPO`\bd_topo.gpkg
copy /b /v /y %WORK_PLACE%/informations.txt \\volt\infogeo\Donnees\Externe\IGN\BD_TOPO`\informations.txt
del /s /q %WORK_PLACE%

REM /////////////// Début étape finale ///////////////
(
ECHO
ECHO Etape Finale - Calcul durée d'exécution du script
ECHO
)

REM Enregistrer l'heure de fin
SET ENDTIME_TOT=%TIME%

REM Convertir STARTTIME et ENDTIME en secondes
for /f "tokens=1-3 delims=:" %%a in ("%STARTTIME_TOT%") do (
    set /a STARTSEC=3600*1%%a+60*1%%b+1%%c
)
for /f "tokens=1-3 delims=:" %%a in ("%ENDTIME_TOT%") do (
    set /a ENDSEC=3600*1%%a+60*1%%b+1%%c
)

REM Calculer la différence en secondes
SET /a DELTA=%ENDSEC%-%STARTSEC%

REM Convertir DELTA en heures, minutes et secondes
SET /a HOURS=%DELTA% / 3600
SET /a DELTA=%DELTA% %% 3600
SET /a MINUTES=%DELTA% / 60
SET /a SECONDS=%DELTA% %% 60

REM Affichage du temps d'exécution total
ECHO Temps d'execution total : %HOURS%h. %MINUTES%min. %SECONDS%sec.

ECHO Fin !