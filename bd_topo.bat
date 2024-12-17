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
SET URL_INFO=https://data.geopf.fr
SET URL_GEOP="%URL_INFO%/wfs/ows?SERVICE=WFS&REQUEST=GetFeature&VERSION=2.0.0&TYPENAMES=

REM Bounding box de la MEL
SET BBOX=685042 7044714 719323 7077571

REM il faut configurer GDAL_DATA car on utilise gdal/ogr en dehors du shell osgeo4w
SET GDAL_DATA=%QGIS%\apps\gdal\share\gdal"
REM curl n'arrive pas a certifier les certifs ssl auto renouvelés à travers le proxy de la mel (y comprit ceux des serveurs de la mel) à travers lui alors on désactive la verif ssl pour les wfs
SET GDAL_HTTP_UNSAFESSL=YES
REM options de créations
SET OPTIONS_CREA_ETAPE2=-append -spat_srs EPSG:2154 -spat %BBOX% -t_srs EPSG:2154 --config OGR_WFS_PAGE_SIZE=100000 -gt 65536 -makevalid -lco FID=objectid
REM enregistrement de l'horaire de lancement du script
SET STARTTIME=%TIME%

REM /////////////// Début étape 2 ///////////////

(
ECHO
ECHO Etape 2 - conversion en geopackage et extraction zonage mel
ECHO
)

ECHO couche Arrondissements
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/bd_topo.gpkg -nln arrondissements WFS:%URL_GEOP%BDTOPO_V3:arrondissement"

ECHO couche Arrondissements municipaux
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/bd_topo.gpkg -nln arrondissement_municipal WFS:%URL_GEOP%BDTOPO_V3:arrondissement_municipal"

ECHO couche Autres itinéraires
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt LINESTRING %WORK_PLACE%/bd_topo.gpkg -nln itineraire_autre WFS:%URL_GEOP%BDTOPO_V3:itineraire_autre"

ECHO couche Aérodromes
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/bd_topo.gpkg -nln aerodrome WFS:%URL_GEOP%BDTOPO_V3:aerodrome"

ECHO couche Bassins versants topographiques
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/bd_topo.gpkg -nln bassin_versant_topographique WFS:%URL_GEOP%BDTOPO_V3:bassin_versant_topographique"

ECHO couche Canalisations
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt LINESTRING %WORK_PLACE%/bd_topo.gpkg -nln canalisation WFS:%URL_GEOP%BDTOPO_V3:canalisation"

ECHO couche Cimetières
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/bd_topo.gpkg -nln cimetiere WFS:%URL_GEOP%BDTOPO_V3:cimetiere"

ECHO couche Collectivités territoriales
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/bd_topo.gpkg -nln collectivite_territoriale WFS:%URL_GEOP%BDTOPO_V3:collectivite_territoriale"

ECHO couche Communes
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/bd_topo.gpkg -nln commune WFS:%URL_GEOP%BDTOPO_V3:commune"

ECHO couche Communes associées ou déleguées
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/bd_topo.gpkg -nln commune_associee_ou_deleguee WFS:%URL_GEOP%BDTOPO_V3:commune_associee_ou_deleguee"

ECHO couche Condominiums
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/bd_topo.gpkg -nln condominium WFS:%URL_GEOP%BDTOPO_V3:condominium"

ECHO couche Constructions linéaires
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt LINESTRING %WORK_PLACE%/bd_topo.gpkg -nln construction_lineaire WFS:%URL_GEOP%BDTOPO_V3:construction_lineaire"

ECHO couche Constructions ponctuelles
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POINT %WORK_PLACE%/bd_topo.gpkg -nln construction_ponctuelle WFS:%URL_GEOP%BDTOPO_V3:construction_ponctuelle"

ECHO couche Constructions surfaciques
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/bd_topo.gpkg -nln construction_surfacique WFS:%URL_GEOP%BDTOPO_V3:construction_surfacique"

ECHO couche Cours d'eau
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt LINESTRING %WORK_PLACE%/bd_topo.gpkg -nln cours_d_eau WFS:%URL_GEOP%BDTOPO_V3:cours_d_eau"

ECHO couche Départements
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/bd_topo.gpkg -nln departement WFS:%URL_GEOP%BDTOPO_V3:departement"

ECHO couche Détails hydrographiques
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POINT %WORK_PLACE%/bd_topo.gpkg -nln detail_hydrographique WFS:%URL_GEOP%BDTOPO_V3:detail_hydrographique"

ECHO couche Détails orographiques
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POINT %WORK_PLACE%/bd_topo.gpkg -nln detail_orographique WFS:%URL_GEOP%BDTOPO_V3:detail_orographique"

ECHO couche EPCI
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/bd_topo.gpkg -nln epci WFS:%URL_GEOP%BDTOPO_V3:epci"

ECHO couche ERP
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POINT %WORK_PLACE%/bd_topo.gpkg -nln erp WFS:%URL_GEOP%BDTOPO_V3:erp"

ECHO couche Forêts publiques
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/bd_topo.gpkg -nln foret_publique WFS:%URL_GEOP%BDTOPO_V3:foret_publique"

ECHO couche Haies
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt LINESTRING %WORK_PLACE%/bd_topo.gpkg -nln haie WFS:%URL_GEOP%BDTOPO_V3:haie"

ECHO couche Lieux-dits non habités
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POINT %WORK_PLACE%/bd_topo.gpkg -nln lieu_dit_non_habite WFS:%URL_GEOP%BDTOPO_V3:lieu_dit_non_habite"

ECHO couche Lignes orographiques
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt LINESTRING %WORK_PLACE%/bd_topo.gpkg -nln ligne_orographique WFS:%URL_GEOP%BDTOPO_V3:ligne_orographique"

ECHO couche Lignes électriques
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt LINESTRING %WORK_PLACE%/bd_topo.gpkg -nln ligne_electrique WFS:%URL_GEOP%BDTOPO_V3:ligne_electrique"

ECHO couche Limites terre-mer
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt LINESTRING %WORK_PLACE%/bd_topo.gpkg -nln limite_terre_mer WFS:%URL_GEOP%BDTOPO_V3:limite_terre_mer"

ECHO couche Non-communications
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POINT %WORK_PLACE%/bd_topo.gpkg -nln non_communication WFS:%URL_GEOP%BDTOPO_V3:non_communication"

ECHO couche Nœuds hydrographiques
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POINT %WORK_PLACE%/bd_topo.gpkg -nln noeud_hydrographique WFS:%URL_GEOP%BDTOPO_V3:noeud_hydrographique"

ECHO couche Parcs et réserves
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/bd_topo.gpkg -nln parc_ou_reserve WFS:%URL_GEOP%BDTOPO_V3:parc_ou_reserve"

ECHO couche Pistes d'aérodrome
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/bd_topo.gpkg -nln piste_d_aerodrome WFS:%URL_GEOP%BDTOPO_V3:piste_d_aerodrome"

ECHO couche Plans d'eau
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/bd_topo.gpkg -nln plan_d_eau WFS:%URL_GEOP%BDTOPO_V3:plan_d_eau"

ECHO couche Points de repère
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POINT %WORK_PLACE%/bd_topo.gpkg -nln point_de_repere WFS:%URL_GEOP%BDTOPO_V3:point_de_repere"

ECHO couche Points de réseau
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POINT %WORK_PLACE%/bd_topo.gpkg -nln point_du_reseau WFS:%URL_GEOP%BDTOPO_V3:point_du_reseau"

ECHO couche Postes de transformation
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/bd_topo.gpkg -nln poste_de_transformation WFS:%URL_GEOP%BDTOPO_V3:poste_de_transformation"

ECHO couche Pylônes
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POINT %WORK_PLACE%/bd_topo.gpkg -nln pylone WFS:%URL_GEOP%BDTOPO_V3:pylone"

ECHO couche Routes numérotées et routes nommées
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt LINESTRING %WORK_PLACE%/bd_topo.gpkg -nln route_numerotee_ou_nommee WFS:%URL_GEOP%BDTOPO_V3:route_numerotee_ou_nommee"

ECHO couche Régions
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/bd_topo.gpkg -nln region WFS:%URL_GEOP%BDTOPO_V3:region"

ECHO couche Réservoirs
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/bd_topo.gpkg -nln reservoir WFS:%URL_GEOP%BDTOPO_V3:reservoir"

ECHO couche Sections de points de repère
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt LINESTRING %WORK_PLACE%/bd_topo.gpkg -nln section_de_points_de_repere WFS:%URL_GEOP%BDTOPO_V3:section_de_points_de_repere"

ECHO couche Surfaces hydrographiques
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/bd_topo.gpkg -nln surface_hydrographique WFS:%URL_GEOP%BDTOPO_V3:surface_hydrographique"

ECHO couche Terrains de sport
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/bd_topo.gpkg -nln terrain_de_sport WFS:%URL_GEOP%BDTOPO_V3:terrain_de_sport"

ECHO couche Toponymies d'hydrographie
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POINT %WORK_PLACE%/bd_topo.gpkg -nln toponymie_hydrographie WFS:%URL_GEOP%BDTOPO_V3:toponymie_hydrographie"

ECHO couche Toponymies de bâti
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POINT %WORK_PLACE%/bd_topo.gpkg -nln toponymie_bati WFS:%URL_GEOP%BDTOPO_V3:toponymie_bati"

ECHO couche Toponymies de lieux nommés
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POINT %WORK_PLACE%/bd_topo.gpkg -nln toponymie_lieux_nommes WFS:%URL_GEOP%BDTOPO_V3:toponymie_lieux_nommes"

ECHO couche Toponymies des services et activités
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POINT %WORK_PLACE%/bd_topo.gpkg -nln toponymie_services_et_activites WFS:%URL_GEOP%BDTOPO_V3:toponymie_services_et_activites"

ECHO couche Toponymies des transports
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POINT %WORK_PLACE%/bd_topo.gpkg -nln toponymie_transport WFS:%URL_GEOP%BDTOPO_V3:toponymie_transport"

ECHO couche Toponymies des zones réglementées
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POINT %WORK_PLACE%/bd_topo.gpkg -nln toponymie_zones_reglementee WFS:%URL_GEOP%BDTOPO_V3:toponymie_zones_reglementee"

ECHO couche Transports par câble
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt LINESTRING %WORK_PLACE%/bd_topo.gpkg -nln transport_par_cable WFS:%URL_GEOP%BDTOPO_V3:transport_par_cable"

ECHO couche Tronçons de route
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt LINESTRING %WORK_PLACE%/bd_topo.gpkg -nln troncon_de_route WFS:%URL_GEOP%BDTOPO_V3:troncon_de_route"

ECHO couche Tronçons de voie ferrée
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt LINESTRING %WORK_PLACE%/bd_topo.gpkg -nln troncon_de_voie_ferree WFS:%URL_GEOP%BDTOPO_V3:troncon_de_voie_ferree"

ECHO couche Tronçons hydrographiques
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt LINESTRING %WORK_PLACE%/bd_topo.gpkg -nln troncon_hydrographique WFS:%URL_GEOP%BDTOPO_V3:troncon_hydrographique"

ECHO couche Voies ferrées nommées
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt LINESTRING %WORK_PLACE%/bd_topo.gpkg -nln voie_ferree_nommee WFS:%URL_GEOP%BDTOPO_V3:voie_ferree_nommee"

ECHO couche Voies nommées
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt LINESTRING %WORK_PLACE%/bd_topo.gpkg -nln voie_nommee WFS:%URL_GEOP%BDTOPO_V3:voie_nommee"

ECHO couche Zones d'activité et zones d'intérêt
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/bd_topo.gpkg -nln zone_d_activite_ou_d_interet WFS:%URL_GEOP%BDTOPO_V3:zone_d_activite_ou_d_interet"

ECHO couche Zones d'estran
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/bd_topo.gpkg -nln zone_d_estran WFS:%URL_GEOP%BDTOPO_V3:zone_d_estran"

ECHO couche Zones d'habitation
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/bd_topo.gpkg -nln zone_d_habitation WFS:%URL_GEOP%BDTOPO_V3:zone_d_habitation"

ECHO couche Zones de végétation
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/bd_topo.gpkg -nln zone_de_vegetation WFS:%URL_GEOP%BDTOPO_V3:zone_de_vegetation"

ECHO couche Équipements de transport
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON %WORK_PLACE%/bd_topo.gpkg -nln equipement_de_transport WFS:%URL_GEOP%BDTOPO_V3:equipement_de_transport"

REM /////////////// Début étape 3 ///////////////
(
ECHO
ECHO Etape 3 - Copie des fichiers
ECHO
)

copy /b /v /y %WORK_PLACE%/bd_topo.gpkg \\volt\infogeo\Donnees\Externe\IGN\BD_TOPO\bd_topo.gpkg

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
ECHO Quoi : Bd topo
ECHO Source : IGN
ECHO Source : %URL_INFO%
ECHO Téléchargement le : %TIME%
ECHO Durée de téléchargement : %HOURS%h. %MINUTES%min. %SECONDS%sec
) > %WORK_PLACE%/informations.txt

copy /b /v /y %WORK_PLACE%/informations.txt \\volt\infogeo\Donnees\Externe\IGN\BD_TOPO\informations.txt

del /s /q %WORK_PLACE%


ECHO Fin !