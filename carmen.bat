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
SET URL_INFO=https://ws.carmencarto.fr
SET URL_GEOP="%URL_INFO%/WFS/119/fxx_inpn?SERVICE=WFS&REQUEST=GetFeature&VERSION=2.0.0&TYPENAMES=

REM Bounding box de la MEL
SET BBOX=685042 7044714 719323 7077571

REM il faut configurer GDAL_DATA car on utilise gdal/ogr en dehors du shell osgeo4w
SET GDAL_DATA=%QGIS%\apps\gdal\share\gdal"
REM curl n'arrive pas a certifier les certifs ssl auto renouvelés à travers le proxy de la mel (y comprit ceux des serveurs de la mel) à travers lui alors on désactive la verif ssl pour les wfs
SET GDAL_HTTP_UNSAFESSL=YES
REM options de créations
SET OPTIONS_CREA_ETAPE2=-append -spat_srs EPSG:2154 -spat %BBOX% -t_srs EPSG:2154 --config OGR_WFS_PAGE_SIZE=100000 -gt 65536 -makevalid -lco FID=OBJECTID
REM enregistrement de l'horaire de lancement du script
SET STARTTIME=%TIME%

REM /////////////// Début étape 2 ///////////////

(
ECHO
ECHO Etape 2 - conversion en geopackage et extraction zonage mel
ECHO
)

ECHO couche Arrêté listes de sites d'intérêt géologique
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/carmen.gpkg -nln Arrete_listes_de_sites_dinteret_geologique WFS:%URL_GEOP%ms:Arrete_listes_de_sites_dinteret_geologique"

ECHO couche Arrêtés de protection d'habitats naturels
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/carmen.gpkg -nln Arretes_de_protection_d_habitats_naturels WFS:%URL_GEOP%ms:Arretes_de_protection_d_habitats_naturels"

ECHO couche Arrêtés de protection de biotope
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/carmen.gpkg -nln Arretes_de_protection_de_biotope WFS:%URL_GEOP%ms:Arretes_de_protection_de_biotope"

ECHO couche Arrêtés de protection de géotope
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/carmen.gpkg -nln Arretes_de_protection_de_geotope WFS:%URL_GEOP%ms:Arretes_de_protection_de_geotope"

ECHO couche Biens du patrimoine mondial de l'UNESCO
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/carmen.gpkg -nln Bien_du_patrimoine_mondial_de_l_UNESCO WFS:%URL_GEOP%ms:Bien_du_patrimoine_mondial_de_l_UNESCO"

ECHO couche Géoparcs
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/carmen.gpkg -nln Geoparcs WFS:%URL_GEOP%ms:Geoparcs"

ECHO couche Parcs nationaux
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/carmen.gpkg -nln Parcs_nationaux WFS:%URL_GEOP%ms:Parcs_nationaux"

ECHO couche Parcs naturels marins
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/carmen.gpkg -nln Parc_naturel_marin WFS:%URL_GEOP%ms:Parc_naturel_marin"

ECHO couche Parcs naturels régionaux
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/carmen.gpkg -nln Parcs_naturels_regionaux WFS:%URL_GEOP%ms:Parcs_naturels_regionaux"

ECHO couche Périmètre de protection d'une réserve naturelle nationale
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/carmen.gpkg -nln Perimetre_de_protection_dune_reserve_naturelle_nationale WFS:%URL_GEOP%ms:Perimetre_de_protection_dune_reserve_naturelle_nationale"

ECHO couche Périmètre de protection d'une réserve naturelle régionale
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/carmen.gpkg -nln Perimetre_de_protection_dune_reserve_naturelle_regionale WFS:%URL_GEOP%ms:Perimetre_de_protection_dune_reserve_naturelle_regionale"

ECHO couche Réserves biologiques
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/carmen.gpkg -nln Reserves_biologiques WFS:%URL_GEOP%ms:Reserves_biologiques"

ECHO couche Réserves de biosphère
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/carmen.gpkg -nln Reserves_de_la_biosphere WFS:%URL_GEOP%ms:Reserves_de_la_biosphere"

ECHO couche Réserves Intégrales de Parcs Nationaux
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/carmen.gpkg -nln Reserves_Integrales_de_Parcs_Nationaux WFS:%URL_GEOP%ms:Reserves_Integrales_de_Parcs_Nationaux"

ECHO couche Réserves nationales de chasse et faune sauvage
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/carmen.gpkg -nln Reserves_nationales_de_chasse_et_faune_sauvage WFS:%URL_GEOP%ms:Reserves_nationales_de_chasse_et_faune_sauvage"

ECHO couche Réserves Naturelles Nationales
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/carmen.gpkg -nln Reserves_Naturelles_Nationales WFS:%URL_GEOP%ms:Reserves_Naturelles_Nationales"

ECHO couche Réserves naturelles régionales
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/carmen.gpkg -nln Reserves_naturelles_regionales WFS:%URL_GEOP%ms:Reserves_naturelles_regionales"

ECHO couche Sites d'importance communautaire
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/carmen.gpkg -nln Sites_d_importance_communautaire WFS:%URL_GEOP%ms:Sites_d_importance_communautaire"

ECHO couche Sites d'importance communautaire JOUE (ZSC,SIC)
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/carmen.gpkg -nln Sites_d_importance_communautaire_JOUE__ZSC_SIC WFS:%URL_GEOP%ms:Sites_d_importance_communautaire_JOUE__ZSC_SIC_"

ECHO couche Sites Ramsar
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/carmen.gpkg -nln Sites_Ramsar WFS:%URL_GEOP%ms:Sites_Ramsar"

ECHO couche Terrains acquis des Conservatoires des espaces naturels
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/carmen.gpkg -nln Terrains_acquis_des_Conservatoires_des_espaces_naturels WFS:%URL_GEOP%ms:Terrains_acquis_des_Conservatoires_des_espaces_naturels"

ECHO couche Terrains du Conservatoire du Littoral
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/carmen.gpkg -nln Terrains_du_Conservatoire_du_Littoral WFS:%URL_GEOP%ms:Terrains_du_Conservatoire_du_Littoral"

ECHO couche Terrains gérés par des Conservatoires d'espaces naturels
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/carmen.gpkg -nln Terrains_geres_par_des_convervatoires_d_espaces_naturels WFS:%URL_GEOP%ms:CEN_MU"

ECHO couche Znieff1
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/carmen.gpkg -nln Znieff1 WFS:%URL_GEOP%ms:Znieff1"

ECHO couche Znieff2
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/carmen.gpkg -nln Znieff1 WFS:%URL_GEOP%ms:Znieff2"

ECHO couche Zone de protection renforcée
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/carmen.gpkg -nln Zone_de_protection_renforcee WFS:%URL_GEOP%ms:Zone_de_protection_renforcee"

ECHO couche Zone Importante pour la Conservation des Oiseaux
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/carmen.gpkg -nln Zone_importante_pour_la_conservation_des_oiseaux WFS:%URL_GEOP%ms:ZICO"

ECHO couche Zone marine protégée de la convention OSPAR
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/carmen.gpkg -nln Zone_marine_protegee_par_la_convention_ospar WFS:%URL_GEOP%ms:ospar"

ECHO couche Zones de protection spéciale
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/carmen.gpkg -nln Zones_de_protection_speciale WFS:%URL_GEOP%ms:Zones_de_protection_speciale"

REM /////////////// Début étape 3 ///////////////
(
ECHO
ECHO Etape 3 - Copie des fichiers
ECHO
)

copy /b /v /y %WORK_PLACE%/bd_topo.gpkg \\volt\infogeo\Donnees\Externe\Carmen\carmen.gpkg

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

copy /b /v /y %WORK_PLACE%/informations.txt \\volt\infogeo\Donnees\Externe\Carmen\informations.txt

del /s /q %WORK_PLACE%


ECHO Fin !