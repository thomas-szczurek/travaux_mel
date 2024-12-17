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
SET URL_INFO=https://www.data.gouv.fr

REM Bounding box de la MEL
SET BBOX=685042 7044714 719323 7077571

REM il faut configurer GDAL_DATA car on utilise gdal/ogr en dehors du shell osgeo4w
SET GDAL_DATA=%QGIS%\apps\gdal\share\gdal"
REM curl n'arrive pas a certifier les certifs ssl auto renouvelés à travers le proxy de la mel (y comprit ceux des serveurs de la mel) à travers lui alors on désactive la verif ssl pour les wfs
SET GDAL_HTTP_UNSAFESSL=YES
REM options de créations
SET OPTIONS_CREA_ETAPE2=-append -spat_srs EPSG:2154 -spat %BBOX% -t_srs EPSG:2154 -clipdst %LAYER_PLACE%\mel.fgb -gt 65536 -makevalid -lco FID=OBJECTID
REM enregistrement de l'horaire de lancement du script
SET STARTTIME_TOT=%TIME%

REM /////////////// Début étape 2 ///////////////

cd %WORK_PLACE%

REM /////////////// Annuaire de l'éducation
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
) > %WORK_PLACE%/informations_annuaire_education.txt

copy /b /v /y %WORK_PLACE%/annuaire_education.gpkg \\volt\infogeo\Donnees\Externe\ministere_education\annuaire_education.gpkg
copy /b /v /y %WORK_PLACE%/informations_annuaire_education.txt \\volt\infogeo\Donnees\Externe\ministere_education\informations_annuaire_education.txt

REM /////////////// Zones d'Aides à finalite regionale (AFR)
(
ECHO
ECHO Etape 2 - Zones d'Aides à finalité régionale (AFR)
ECHO
)

REM enregistrement de l'horaire de lancement du téléchargement
SET STARTTIME=%TIME%
SET URL_DWL=%URL_INFO%/fr/datasets/r/fc9e3b9a-cd0b-493a-8c9c-3ab422da42f8


for /f "delims=" %%A in ('curl -L -s -o nul -w "%%{url_effective}" %URL_DWL%') do set FINAL_URL=%%A
for %%A in ("%FINAL_URL%") do set FILE_NAME=%%~nA%%~xA
curl -L -o "%FILE_NAME%" %URL_DWL% --ssl-no-revoke
for %%F in ("%FILE_NAME%") do set FILE_SHORT=%%~nF
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln %FILE_NAME% -lco FID=objectid %WORK_PLACE%/%FILE_SHORT%_l93.gpkg %WORK_PLACE%/%FILE_SHORT%.gpkg

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
ECHO Quoi : Annuaire de l'éducation
ECHO Source : Ministère de l'éducation
ECHO Source : %URL_INFO%
ECHO Téléchargement le : %TIME%
ECHO Durée de téléchargement : %HOURS%h. %MINUTES%min. %SECONDS%sec
) > %WORK_PLACE%/informations_afr.txt

copy /b /v /y %WORK_PLACE%/%FILE_NAME% \\volt\infogeo\Donnees\Externe\anct\%FILE_NAME%
copy /b /v /y %WORK_PLACE%/informations_afr.txt \\volt\infogeo\Donnees\Externe\anct\informations_afr.txt

REM /////////////// Début étape 3 ///////////////
(
ECHO
ECHO Etape 3 - nettoyage
ECHO
)

del /s /q %WORK_PLACE%

REM /////////////// Début étape finale ///////////////
(
ECHO
ECHO Etape 5 - Calcul durée d'exécution du script
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