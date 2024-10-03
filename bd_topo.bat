@ECHO OFF

ECHO Etape 1 - assignation des variables et creation du dossier de traitement temporaire

REM variables potentiellement modifiables
REM repertoire d'installation de qgis
SET QGIS="C:\Program Files\QGIS 3.34.8
REM emplacement des traitements intermediaires
SET WORK_PLACE=%USERPROFILE%\Documents\3_tests\donnees_ref
REM url de l'api ogc de la geomplateforme. L'option TYPENAMES est celle permettant d'indiquer une couche spécifique
SET URL_INFO=https://data.geopf.fr
SET URL_GEOP="%URL_INFO%/wfs/ows?SERVICE=WFS&REQUEST=GetFeature&VERSION=2.0.0&TYPENAMES=

REM Bounding Box de la MEL
SET BBOX=685041 7044713 719322 7077570
REM il faut aussi configurer GDAL_DATA car on utilise gdal/ogr en dehors du shell osgeo4w
SET GDAL_DATA=%QGIS%\apps\gdal\share\gdal"
REM le proxy de la mel étant tellement bien configuré que curl n'arrive pas à certifier les certifs ssl (y comprit ceux des serveurs de la mel lol) à travers lui alors on désactive la verif ssl pour les wfs
SET GDAL_HTTP_UNSAFESSL=YES
REM options de créations
SET OPTIONS_CREA_ETAPE2=-append -spat_srs EPSG:2154 -spat %BBOX% -t_srs EPSG:2154 -clipdst %WORK_PLACE%\mel.fgb --config OGR_WFS_PAGE_SIZE=100000 -gt 65536 -makevalid -lco FID=OBJECTID
REM enregistrement de l'horaire de lancement du script
SET STARTTIME=%TIME%

mkdir %WORK_PLACE%\temp

ECHO Etape 2 - conversion en geopackage et extraction zonage mel

ECHO couche arrondissements
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTIPOLYGON %WORK_PLACE%/temp/bd_topo.gpkg -nln arrondissement WFS:%URL_GEOP%BDTOPO_V3:arrondissement"

ECHO couche arrondissements_municipaux
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTIPOLYGON %WORK_PLACE%/temp/bd_topo.gpkg -nln arrondissement_municipal WFS:%URL_GEOP%BDTOPO_V3:arrondissement_municipal"

ECHO couche autres itineraires
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTILINESTRING %WORK_PLACE%/temp/bd_topo.gpkg -nln itineraire_autre WFS:%URL_GEOP%BDTOPO_V3:itineraire_autre"

ECHO couche aerodromes
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTIPOLYGON %WORK_PLACE%/temp/bd_topo.gpkg -nln aerodrome WFS:%URL_GEOP%BDTOPO_V3:aerodrome"

ECHO couche bassins_versants_topologiques
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTISURFACE %WORK_PLACE%/temp/bd_topo.gpkg -nln bassin_versant_topographique WFS:%URL_GEOP%BDTOPO_V3:bassin_versant_topographique"

REM ECHO couche batiments
REM %QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTISURFACE %WORK_PLACE%/temp/bd_topo.gpkg -nln batiment WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO couche canalisations
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt LINESTRING %WORK_PLACE%/temp/bd_topo.gpkg -nln canalisation WFS:%URL_GEOP%BDTOPO_V3:canalisation"

ECHO couche cimetieres
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTIPOLYGON %WORK_PLACE%/temp/bd_topo.gpkg -nln cimetiere WFS:%URL_GEOP%BDTOPO_V3:cimetiere"

ECHO couche collectivite_territoriale
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTIPOLYGON %WORK_PLACE%/temp/bd_topo.gpkg -nln collectivite_territoriale WFS:%URL_GEOP%BDTOPO_V3:collectivite_territoriale"

ECHO couche communes
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTIPOLYGON %WORK_PLACE%/temp/bd_topo.gpkg -nln commune WFS:%URL_GEOP%BDTOPO_V3:commune"

ECHO couche communes associees ou deleguees
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTIPOLYGON %WORK_PLACE%/temp/bd_topo.gpkg -nln communes_associees_ou_deleguees WFS:%URL_GEOP%BDTOPO_V3:commune_associee_ou_deleguee"

ECHO couche condominium
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTIPOLYGON %WORK_PLACE%/temp/bd_topo.gpkg -nln condominium WFS:%URL_GEOP%BDTOPO_V3:condominium"

ECHO couche construction_lineaire
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTILINESTRING %WORK_PLACE%/temp/bd_topo.gpkg -nln construction_lineaire WFS:%URL_GEOP%BDTOPO_V3:construction_lineaire"

ECHO couche construction_ponctuelle
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POINT %WORK_PLACE%/temp/bd_topo.gpkg -nln construction_ponctuelle WFS:%URL_GEOP%BDTOPO_V3:construction_ponctuelle"

ECHO couche construction_surfacique
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTIPOLYGON %WORK_PLACE%/temp/bd_topo.gpkg -nln construction_surfacique WFS:%URL_GEOP%BDTOPO_V3:construction_surfacique"

ECHO couche cours_d_eau
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTILINESTRING %WORK_PLACE%/temp/bd_topo.gpkg -nln cours_d_eau WFS:%URL_GEOP%BDTOPO_V3:cours_d_eau"

ECHO couche departement
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTIPOLYGON %WORK_PLACE%/temp/bd_topo.gpkg -nln departement WFS:%URL_GEOP%BDTOPO_V3:departement"

ECHO couche detail_hydrographique
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POINT %WORK_PLACE%/temp/bd_topo.gpkg -nln detail_hydrographique WFS:%URL_GEOP%BDTOPO_V3:detail_hydrographique"

ECHO couche detail_orographique
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POINT %WORK_PLACE%/temp/bd_topo.gpkg -nln detail_orographique WFS:%URL_GEOP%BDTOPO_V3:detail_orographique"

ECHO couche epci
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTIPOLYGON %WORK_PLACE%/temp/bd_topo.gpkg -nln epci WFS:%URL_GEOP%BDTOPO_V3:epci"

ECHO couche erp
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POINT %WORK_PLACE%/temp/bd_topo.gpkg -nln erp WFS:%URL_GEOP%BDTOPO_V3:erp"

ECHO couche foret_publique
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTIPOLYGON %WORK_PLACE%/temp/bd_topo.gpkg -nln foret_publique WFS:%URL_GEOP%BDTOPO_V3:foret_publique"

ECHO couche haies
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTILINESTRING %WORK_PLACE%/temp/bd_topo.gpkg -nln haie WFS:%URL_GEOP%BDTOPO_V3:haie"

ECHO couche lieu_dit_non_habite
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POINT %WORK_PLACE%/temp/bd_topo.gpkg -nln lieu_dit_non_habite WFS:%URL_GEOP%BDTOPO_V3:lieu_dit_non_habite"

ECHO couche ligne_orographique
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTILINESTRING %WORK_PLACE%/temp/bd_topo.gpkg -nln ligne_orographique WFS:%URL_GEOP%BDTOPO_V3:ligne_orographique"

ECHO couche ligne_electrique
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTILINESTRING %WORK_PLACE%/temp/bd_topo.gpkg -nln ligne_electrique WFS:%URL_GEOP%BDTOPO_V3:ligne_electrique"

ECHO couche limite_terre_mer
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTILINESTRING %WORK_PLACE%/temp/bd_topo.gpkg -nln limite_terre_mer WFS:%URL_GEOP%BDTOPO_V3:limite_terre_mer"

ECHO couche non_communication
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POINT %WORK_PLACE%/temp/bd_topo.gpkg -nln non_communication WFS:%URL_GEOP%BDTOPO_V3:non_communication"

ECHO couche noeud_hydrographique
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POINT %WORK_PLACE%/temp/bd_topo.gpkg -nln noeud_hydrographique WFS:%URL_GEOP%BDTOPO_V3:noeud_hydrographique"

ECHO couche parc_ou_reserve
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTIPOLYGON %WORK_PLACE%/temp/bd_topo.gpkg -nln parc_ou_reserve WFS:%URL_GEOP%BDTOPO_V3:parc_ou_reserve"

ECHO couche piste_d_aerodrome
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTIPOLYGON %WORK_PLACE%/temp/bd_topo.gpkg -nln piste_d_aerodrome WFS:%URL_GEOP%BDTOPO_V3:piste_d_aerodrome"

ECHO couche plan_d_eau
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTIPOLYGON %WORK_PLACE%/temp/bd_topo.gpkg -nln plan_d_eau WFS:%URL_GEOP%BDTOPO_V3:plan_d_eau"

ECHO couche point_de_repere
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POINT %WORK_PLACE%/temp/bd_topo.gpkg -nln point_de_repere WFS:%URL_GEOP%BDTOPO_V3:point_de_repere"

ECHO couche point_du_reseau
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POINT %WORK_PLACE%/temp/bd_topo.gpkg -nln point_du_reseau WFS:%URL_GEOP%BDTOPO_V3:point_du_reseau"

ECHO couche poste_de_transformation
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTIPOLYGON %WORK_PLACE%/temp/bd_topo.gpkg -nln poste_de_transformation WFS:%URL_GEOP%BDTOPO_V3:poste_de_transformation"

ECHO couche pylone
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POINT %WORK_PLACE%/temp/bd_topo.gpkg -nln pylone WFS:%URL_GEOP%BDTOPO_V3:pylone"

ECHO couche route_numerotee_ou_nommee
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTILINESTRING %WORK_PLACE%/temp/bd_topo.gpkg -nln route_numerotee_ou_nommee WFS:%URL_GEOP%BDTOPO_V3:route_numerotee_ou_nommee"

ECHO couche region
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTIPOLYGON %WORK_PLACE%/temp/bd_topo.gpkg -nln region WFS:%URL_GEOP%BDTOPO_V3:region"

ECHO couche reservoir
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTIPOLYGON %WORK_PLACE%/temp/bd_topo.gpkg -nln reservoir WFS:%URL_GEOP%BDTOPO_V3:reservoir"

ECHO couche section_de_points_de_repere
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTILINESTRING %WORK_PLACE%/temp/bd_topo.gpkg -nln section_de_points_de_repere WFS:%URL_GEOP%BDTOPO_V3:section_de_points_de_repere"

ECHO couche surface_hydrographique
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTIPOLYGON %WORK_PLACE%/temp/bd_topo.gpkg -nln surface_hydrographique WFS:%URL_GEOP%BDTOPO_V3:surface_hydrographique"

ECHO couche terrain_de_sport
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTIPOLYGON %WORK_PLACE%/temp/bd_topo.gpkg -nln terrain_de_sport WFS:%URL_GEOP%BDTOPO_V3:terrain_de_sport"

ECHO couche toponymie_hydrographie
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POINT %WORK_PLACE%/temp/bd_topo.gpkg -nln toponymie_hydrographie WFS:%URL_GEOP%BDTOPO_V3:toponymie_hydrographie"

ECHO couche toponymie_bati
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POINT %WORK_PLACE%/temp/bd_topo.gpkg -nln toponymie_bati WFS:%URL_GEOP%BDTOPO_V3:toponymie_bati"

ECHO couche toponymie_lieux_nommes
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POINT %WORK_PLACE%/temp/bd_topo.gpkg -nln toponymie_lieux_nommes WFS:%URL_GEOP%BDTOPO_V3:toponymie_lieux_nommes"

ECHO couche toponymie_services_et_activites
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POINT %WORK_PLACE%/temp/bd_topo.gpkg -nln toponymie_services_et_activites WFS:%URL_GEOP%BDTOPO_V3:toponymie_services_et_activites"

ECHO couche toponymie_transport
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POINT %WORK_PLACE%/temp/bd_topo.gpkg -nln toponymie_transport WFS:%URL_GEOP%BDTOPO_V3:toponymie_transport"

ECHO couche toponymie_zones_reglementees
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POINT %WORK_PLACE%/temp/bd_topo.gpkg -nln toponymie_zones_reglementees WFS:%URL_GEOP%BDTOPO_V3:toponymie_zones_reglementees"

ECHO couche transport_par_cable
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt LINESTRING %WORK_PLACE%/temp/bd_topo.gpkg -nln transport_par_cable WFS:%URL_GEOP%BDTOPO_V3:transport_par_cable"

ECHO couche troncon_de_route
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTILINESTRING %WORK_PLACE%/temp/bd_topo.gpkg -nln troncon_de_route WFS:%URL_GEOP%BDTOPO_V3:troncon_de_route"

ECHO couche troncon_de_voie_ferree
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt LINESTRING %WORK_PLACE%/temp/bd_topo.gpkg -nln troncon_de_voie_ferree WFS:%URL_GEOP%BDTOPO_V3:troncon_de_voie_ferree"

ECHO couche troncon_hydrographique
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTILINESTRING %WORK_PLACE%/temp/bd_topo.gpkg -nln troncon_hydrographique WFS:%URL_GEOP%BDTOPO_V3:troncon_hydrographique"

ECHO couche voie_ferree_nommee
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTILINESTRING %WORK_PLACE%/temp/bd_topo.gpkg -nln voie_ferree_nommee WFS:%URL_GEOP%BDTOPO_V3:voie_ferree_nommee"

ECHO couche voie_nommee
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTILINESTRING %WORK_PLACE%/temp/bd_topo.gpkg -nln voie_nommee WFS:%URL_GEOP%BDTOPO_V3:voie_nommee"

ECHO couche zone_d_activite_ou_d_interet
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTIPOLYGON %WORK_PLACE%/temp/bd_topo.gpkg -nln zone_d_activite_ou_d_interet WFS:%URL_GEOP%BDTOPO_V3:zone_d_activite_ou_d_interet"

ECHO couche zone_d_estran
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTIPOLYGON %WORK_PLACE%/temp/bd_topo.gpkg -nln zone_d_estran WFS:%URL_GEOP%BDTOPO_V3:zone_d_estran"

ECHO couche zone_d_habitation
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTIPOLYGON %WORK_PLACE%/temp/bd_topo.gpkg -nln zone_d_habitation WFS:%URL_GEOP%BDTOPO_V3:zone_d_habitation"

ECHO couche zone_de_vegetation
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTIPOLYGON %WORK_PLACE%/temp/bd_topo.gpkg -nln zone_de_vegetation WFS:%URL_GEOP%BDTOPO_V3:zone_de_vegetation"

ECHO couche equipement_de_transport
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt MULTIPOLYGON %WORK_PLACE%/temp/bd_topo.gpkg -nln equipement_de_transport WFS:%URL_GEOP%BDTOPO_V3:equipement_de_transport"

(
ECHO QUOI : Bd Topo IGN
ECHO PROVENANCE / URL DE TELECHARGEMENT : service OGI API de la géopolateforme IGN %URL_INFO%
ECHO DATE D ACQUISITION : %DATE%
ECHO AGENT : %USERNAME% 
) > %WORK_PLACE%\informations.txt