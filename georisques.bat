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
REM url de l'api ogc de la geomplateforme. L'option TYPENAMES est celle permettant d'indiquer une couche spécifique
SET URL_INFO=https://georisques.gouv.fr
SET URL_GEOP="%URL_INFO%/services?SERVICE=WFS&REQUEST=GetFeature&VERSION=2.0.0&TYPENAMES=

REM Bounding box de la MEL
SET BBOX=685042 7044714 719323 7077571

REM il faut configurer GDAL_DATA car on utilise gdal/ogr en dehors du shell osgeo4w
SET GDAL_DATA=%QGIS%\apps\gdal\share\gdal"
REM curl n'arrive pas a certifier les certifs ssl auto renouvelés à travers le proxy de la mel (y comprit ceux des serveurs de la mel) à travers lui alors on désactive la verif ssl pour les wfs
SET GDAL_HTTP_UNSAFESSL=YES
REM options de créations
SET OPTIONS_CREA_ETAPE2=-append -spat_srs EPSG:2154 -spat %BBOX% -t_srs EPSG:2154 -clipdst %LAYER_PLACE%\mel.fgb --config OGR_WFS_PAGE_SIZE=100000 -gt 65536 -makevalid -lco FID=OBJECTID
REM enregistrement de l'horaire de lancement du script
SET STARTTIME=%TIME%

REM /////////////// Début étape 2 ///////////////

(
ECHO
ECHO Etape 2 - conversion en geopackage et extraction zonage mel
ECHO
)

ECHO couche Anciens sites industriels et activités de service - polygones
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/georisques.gpkg -nln Anciens_sites_industriels_et_activites_de_service_polygon WFS:%URL_GEOP%ms:SSP_ETS_GE_POLYGON"

ECHO couche Anciens sites industriels et activités de service - points
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POINT %WORK_PLACE%/georisques.gpkg -nln Anciens_sites_industriels_et_activites_de_service_polygon WFS:%URL_GEOP%ms:SSP_ETS_GE_POINT"

ECHO couche Canalisations de transport de matières dangereuses : Gaz naturel
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/georisques.gpkg -nln canalisations_transport_matrieres_dangereuses_gaz WFS:%URL_GEOP%ms:C_GAZ"

ECHO couche Canalisations de transport de matières dangereuses : Hydrocarbures
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/georisques.gpkg -nln canalisations_transport_matrieres_dangereuses_hydrocarbures WFS:%URL_GEOP%ms:C_HYDROCARBURES"

ECHO couche Canalisations de transport de matières dangereuses : Produits chimiques
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/georisques.gpkg -nln canalisations_transport_matrieres_dangereuses_produits_chimiques WFS:%URL_GEOP%ms:C_PRODUITS_CHIM"

ECHO couche Cavités souterraines abandonnées d'origine non minière
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POINT %WORK_PLACE%/georisques.gpkg -nln avites_souterraines_abandonnees_d_origine_non_miniere WFS:%URL_GEOP%ms:CAVITE_LOCALISEE"

ECHO couche Cavités souterraines abandonnées d'origine non minière
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POINT %WORK_PLACE%/georisques.gpkg -nln avites_souterraines_abandonnees_d_origine_non_miniere WFS:%URL_GEOP%ms:CAVITE_LOCALISEE"

ECHO couche Communes concernées par un PPR Inondation approuvé
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/georisques.gpkg -nln communes_pprn_inondations_approuve WFS:%URL_GEOP%ms:PPRN_COMMUNE_RISQINOND_APPROUV"

ECHO couche Communes concernées par un PPR Inondation prescrit
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/georisques.gpkg -nln communes_pprn_inondations_prescrit WFS:%URL_GEOP%ms:PPRN_COMMUNE_RISQINOND_PRESCRIT"

ECHO couche Communes concernées par un PPR Mouvement de terrain - Affaissements et effondrements (Cavités souterraines) approuvé
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/georisques.gpkg -nln communes_pprn_cavites_souterraines_approuve WFS:%URL_GEOP%ms:PRN_COMMUNE_CAVITE_APPROUV"

ECHO couche Communes concernées par un PPR Mouvement de terrain - Affaissements et effondrements (Cavités souterraines) prescrit
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/georisques.gpkg -nln communes_pprn_cavites_souterraines_prescrit WFS:%URL_GEOP%ms:PRN_COMMUNE_CAVITE_PRESCRIT"

ECHO couche Communes concernées par un PPR Mouvement de terrain - Tassements différentiels (Argile) approuvé
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/georisques.gpkg -nln communes_pprn_tassements_argiles_approuve WFS:%URL_GEOP%ms:PRN_COMMUNE_ARGILE_APPROUV"

ECHO couche Communes concernées par un PPR Mouvement de terrain - Tassements différentiels (Argile) prescrit
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/georisques.gpkg -nln communes_pprn_tassements_argiles_prescrit WFS:%URL_GEOP%ms:PRN_COMMUNE_ARGILE_PRESCRIT"

ECHO couche Communes concernées par un PPR Mouvement de terrain approuvé
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/georisques.gpkg -nln communes_pprn_mouvement_terrain_approuve WFS:%URL_GEOP%ms:PPRN_COMMUNE_MVT_APPROUV"

ECHO couche Communes concernées par un PPR Mouvement de terrain prescrit
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/georisques.gpkg -nln communes_pprn_mouvement_terrain_prescrit WFS:%URL_GEOP%ms:PPRN_COMMUNE_MVT_PRESCRIT"

ECHO couche Communes concernées par un PPR Phénomènes météorologiques approuvé
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/georisques.gpkg -nln communes_pprn_phenomenes_meteo_approuve WFS:%URL_GEOP%ms:PPRN_COMMUNE_ATMOS_APPROUV"

ECHO couche Communes concernées par un PPR Phénomènes météorologiques prescrit
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/georisques.gpkg -nln communes_pprn_phenomenes_meteo_prescrit WFS:%URL_GEOP%ms:PPRN_COMMUNE_ATMOS_PRESCRIT"

ECHO couche Communes concernées par un PPR Risque industriel approuvé
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/georisques.gpkg -nln communes_pprn_risque_industriel_approuve WFS:%URL_GEOP%ms:PPRT_COMMUNE_RISQIND_APPROUV"

ECHO couche Communes concernées par un PPR Risque industriel prescrit
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/georisques.gpkg -nln communes_pprn_risque_industriel_prescrit WFS:%URL_GEOP%ms:PPRT_COMMUNE_RISQIND_PRESCRIT"

ECHO couche Etablissements classés IED - France métropolitaine - Rapportage 2020
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POINT %WORK_PLACE%/georisques.gpkg -nln etablissements_classes_ied WFS:%URL_GEOP%ms:ENJEUX_IED_FXX"

ECHO couche Etablissements Pollueurs
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POINT %WORK_PLACE%/georisques.gpkg -nln etablissements_pollueurs WFS:%URL_GEOP%ms:ETABLISSEMENTS_POLLUEURS"

ECHO couche Etablissements sensibles - France métropolitaine - Rapportage 2020
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POINT %WORK_PLACE%/georisques.gpkg -nln etablissements_sensibles WFS:%URL_GEOP%ms:ENJEUX_ETS_SENSIBLES_FXX"

ECHO couche Exposition au retrait-gonflement des argiles
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/georisques.gpkg -nln retrait_gonflement_des_argiles WFS:%URL_GEOP%ms:ALEARG_REALISE"

ECHO couche Hauteurs d'eau - Aléa débordement de cours d'eau fréquent ou décennal - France métropolitaine - Rapportage 2020
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/georisques.gpkg -nln hauteur_eau_alea_debordement_frequent_ou_decenal WFS:%URL_GEOP%ms:ISO_HT_01_01FOR_FXX"

ECHO couche Hauteurs d'eau - Aléa débordement de cours d'eau moyen ou centennal - France métropolitaine - Rapportage 2020
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/georisques.gpkg -nln hauteur_eau_alea_debordement_moyen_ou_centennal WFS:%URL_GEOP%ms:ISO_HT_01_02MOY_FXX"

REM /////////////// Début étape 3 ///////////////
(
ECHO
ECHO Etape 3 - Copie des fichiers
ECHO
)

copy /b /v /y %WORK_PLACE%/bd_topo.gpkg \\volt\infogeo\Donnees\Externe\GEORISQUES\georisques.gpkg

REM /////////////// Début étape 4 ///////////////
(
ECHO
ECHO Etape 4 - Creation d'informations.txt, calcul duree d'execution et nettoyage
ECHO
)

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

REM Affichage du temps d'exécution total
ECHO Temps d'execution total : %HOURS%h. %MINUTES%min. %SECONDS%sec.

(
ECHO Qui : %USER%
ECHO Quoi : Données portail de l'environnement
ECHO Source : Portail Carmen
ECHO Source : %URL_INFO%
ECHO Téléchargement le : %TIME%
ECHO Durée de téléchargement : %HOURS%h. %MINUTES%min. %SECONDS%sec
) > %WORK_PLACE%/informations.txt

copy /b /v /y %WORK_PLACE%/informations.txt \\volt\infogeo\Donnees\Externe\GEORISQUES\informations.txt

del /s /q %WORK_PLACE%


ECHO Fin !