@ECHO OFF

ECHO Etape 1 - assignation des variables et creation du dossier de traitement temporaire

REM variables potentiellement modifiables
REM repertoire d'installation de qgis
SET QGIS="C:\Program Files\QGIS 3.34.8
REM emplacement des traitements intermediaires
mkdir %USERPROFILE%\Documents\traitement_donnees_etageres
SET WORK_PLACE=%USERPROFILE%\Documents\traitement_donnees_etageres
mkdir %WORK_PLACE%\temp
REM emplacement des couches de déocupages mel et communales
SET LAYER_PLACE=V:\1_sig\projets\ref_donnees_etageres
REM url de l'api ogc de la geomplateforme. L'option TYPENAMES est celle permettant d'indiquer une couche spécifique
SET URL_INFO=https://data.geopf.fr
SET URL_GEOP="%URL_INFO%/wfs/ows?SERVICE=WFS&REQUEST=GetFeature&VERSION=2.0.0&TYPENAMES=

REM il faut aussi configurer GDAL_DATA car on utilise gdal/ogr en dehors du shell osgeo4w
SET GDAL_DATA=%QGIS%\apps\gdal\share\gdal"
REM curl n'arrive pas a certifier les certifs ssl auto renouvelés à travers le proxy de la mel (y comprit ceux des serveurs de la mel) à travers lui alors on désactive la verif ssl pour les wfs
SET GDAL_HTTP_UNSAFESSL=YES
REM options de créations
SET OPTIONS_CREA_ETAPE2=-append -t_srs EPSG:2154 --config OGR_WFS_PAGE_SIZE=100000 -gt 65536 -makevalid
REM enregistrement de l'horaire de lancement du script
SET STARTTIME=%TIME%

REM Bounding box de la MEL
SET BBOX=685042 7044714 719323 7077571
REM Bounding Box des communes de la MEL
SET BBOX1=694818 7047272 697512 7051253
SET BBOX2=708211 7055789 714729 7064067
SET BBOX3=692575 7045560 696664 7050049
SET BBOX4=712212 7055173 714395 7057206
SET BBOX5=689819 7064639 693005 7067758
SET BBOX6=685041 7053509 689247 7058166
SET BBOX7=714413 7054922 719322 7059133
SET BBOX8=692307 7054744 695698 7057849
SET BBOX9=685403 7047767 687658 7050497
SET BBOX10=691475 7044786 693344 7048552
SET BBOX11=712805 7052235 714932 7055329
SET BBOX12=689034 7059365 692790 7063243
SET BBOX13=703973 7072421 707081 7076025
SET BBOX14=704656 7065065 709520 7070363
SET BBOX15=696606 7060180 698195 7062274
SET BBOX16=696069 7045769 698327 7048032
SET BBOX17=695796 7058002 698022 7059690
SET BBOX18=698523 7061726 700760 7064247
SET BBOX19=690059 7061088 694986 7064961
SET BBOX20=713831 7055613 716086 7058605
SET BBOX21=698454 7069816 703474 7075290
SET BBOX22=686488 7061711 690897 7065476
SET BBOX23=709636 7062257 712315 7066323
SET BBOX24=694204 7057566 696243 7059088
SET BBOX25=695551 7068072 700540 7072117
SET BBOX26=698911 7053443 701968 7056234
SET BBOX27=692316 7058731 697911 7062460
SET BBOX28=694430 7056202 696152 7057998
SET BBOX29=703783 7053494 706343 7057283
SET BBOX30=712526 7058816 713941 7060199
SET BBOX31=687940 7055135 691443 7059219
SET BBOX32=690816 7053204 694543 7057109
SET BBOX33=713635 7053961 716945 7056170
SET BBOX34=706602 7059700 708851 7061790
SET BBOX35=694540 7064647 698731 7070364
SET BBOX36=706723 7050124 711816 7054436
SET BBOX37=695489 7055867 698170 7058807
SET BBOX38=689604 7048117 691673 7049931
SET BBOX39=706328 7073405 711432 7077570
SET BBOX40=697666 7053883 700821 7057923
SET BBOX41=700170 7059830 703348 7063921
SET BBOX42=711455 7059616 715642 7064008
SET BBOX43=714576 7062982 715219 7063533
SET BBOX44=687656 7051965 691121 7055676
SET BBOX45=697661 7050678 701526 7054092
SET BBOX46=692522 7062827 697156 7067477
SET BBOX47=706861 7055821 709788 7058197
SET BBOX48=697731 7055982 708934 7062707
SET BBOX49=686372 7049678 689711 7054164
SET BBOX50=715170 7063323 718785 7066192
SET BBOX51=706135 7052676 709925 7056949
SET BBOX52=702459 7069106 707780 7073130
SET BBOX53=699563 7054759 703488 7058738
SET BBOX54=714121 7062606 716843 7065454
SET BBOX55=703980 7060529 705918 7063285
SET BBOX56=690213 7056240 692438 7059642
SET BBOX57=708526 7065994 710844 7069044
SET BBOX58=704879 7061215 709365 7068233
SET BBOX59=701658 7062747 705968 7065639
SET BBOX60=692502 7044713 694817 7048298
SET BBOX61=688769 7048766 692591 7052096
SET BBOX62=709802 7071404 713026 7075123
SET BBOX63=699223 7051538 702816 7053910
SET BBOX64=696610 7062344 698881 7065194
SET BBOX65=711428 7051167 712799 7052696
SET BBOX66=694726 7061219 697919 7064171
SET BBOX67=697440 7066303 703449 7070658
SET BBOX68=691142 7057640 694513 7060797
SET BBOX69=705055 7054627 708142 7057890
SET BBOX70=714405 7059637 717762 7062371
SET BBOX71=706123 7069357 710162 7074792
SET BBOX72=710699 7063559 715387 7068009
SET BBOX73=709434 7052233 713711 7056336
SET BBOX74=691272 7048434 694141 7053621
SET BBOX75=701450 7061214 704421 7063909
SET BBOX76=697406 7057589 700998 7059793
SET BBOX77=686494 7047588 690224 7050401
SET BBOX78=702879 7050954 705492 7054242
SET BBOX79=694944 7052572 698829 7056509
SET BBOX80=715435 7061544 717484 7063810
SET BBOX81=708392 7066261 713915 7072502
SET BBOX82=698717 7046695 705082 7052873
SET BBOX83=712450 7056913 714449 7059249
SET BBOX84=704608 7051892 706810 7053876
SET BBOX85=695790 7071008 699396 7073423
SET BBOX86=697824 7062522 701686 7067518
SET BBOX87=700947 7063853 705413 7069820
SET BBOX88=707746 7061559 710605 7066403
SET BBOX89=700872 7052661 704653 7056022
SET BBOX90=712118 7065754 718510 7071186
SET BBOX91=693164 7050357 697699 7055493
SET BBOX92=702512 7071445 704487 7076024
SET BBOX93=689278 7051275 691824 7053613
SET BBOX94=714436 7058215 718369 7060766
SET BBOX95=692932 7048735 695098 7050779


REM /////////////// Début étape 2 ///////////////
(
ECHO
ECHO Etape 2 - conversion en geopackage et extraction zonage mel
ECHO
)

ECHO commune 1
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX1% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 1 -nlt POLYGON %WORK_PLACE%/temp/1.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 2
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX2% -clipdst%LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 2 -nlt POLYGON %WORK_PLACE%/temp/2.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 3
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX3% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 3 -nlt POLYGON %WORK_PLACE%/temp/3.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 4
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX4% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 4 -nlt POLYGON %WORK_PLACE%/temp/4.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 5
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX5% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 5 -nlt POLYGON %WORK_PLACE%/temp/5.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 6
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX6% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 6 -nlt POLYGON %WORK_PLACE%/temp/6.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 7
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX7% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 7 -nlt POLYGON %WORK_PLACE%/temp/7.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 8
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX8% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 7 -nlt POLYGON %WORK_PLACE%/temp/8.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 9
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX9% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 9 -nlt POLYGON %WORK_PLACE%/temp/9.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 10
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX10% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 10 -nlt POLYGON %WORK_PLACE%/temp/10.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 11
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX11% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 11 -nlt POLYGON %WORK_PLACE%/temp/11.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 12
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX12% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 12 -nlt POLYGON %WORK_PLACE%/temp/12.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 13
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX13% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 13 -nlt POLYGON %WORK_PLACE%/temp/13.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 14
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX14% -clipdst %LAYER_PLACE%%\com\com_mel.gpkg -clipdstlayer 14 -nlt POLYGON %WORK_PLACE%/temp/14.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 15
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX15% -clipdst %%LAYER_PLACE%%\com\com_mel.gpkg -clipdstlayer 15 -nlt POLYGON %WORK_PLACE%/temp/15.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 16
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX16% -clipdst %%LAYER_PLACE%%\com\com_mel.gpkg -clipdstlayer 16 -nlt POLYGON %WORK_PLACE%/temp/16.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 17
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX17% -clipdst %LAYER_PLACE%%\com\com_mel.gpkg -clipdstlayer 17 -nlt POLYGON %WORK_PLACE%/temp/17.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 18
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX18% -clipdst %LAYER_PLACE%%\com\com_mel.gpkg -clipdstlayer 18 -nlt POLYGON %WORK_PLACE%/temp/18.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 19
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX19% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 19 -nlt POLYGON %WORK_PLACE%/temp/19.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 20
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX20% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 20 -nlt POLYGON %WORK_PLACE%/temp/20.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 21
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX21% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 21 -nlt POLYGON %WORK_PLACE%/temp/21.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 22
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX22% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 22 -nlt POLYGON %WORK_PLACE%/temp/22.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 23
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX23% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 23 -nlt POLYGON %WORK_PLACE%/temp/23.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 24
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX24% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 24 -nlt POLYGON %WORK_PLACE%/temp/24.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 25
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX25% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 25 -nlt POLYGON %WORK_PLACE%/temp/25.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 26
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX26% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 26 -nlt POLYGON %WORK_PLACE%/temp/26.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 27
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX27% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 27 -nlt POLYGON %WORK_PLACE%/temp/27.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 28
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX28% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 28 -nlt POLYGON %WORK_PLACE%/temp/28.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 29
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX29% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 29 -nlt POLYGON %WORK_PLACE%/temp/29.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 30
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX30% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 30 -nlt POLYGON %WORK_PLACE%/temp/30.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 31
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX31% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 31 -nlt POLYGON %WORK_PLACE%/temp/31.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 32
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX32% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 32 -nlt POLYGON %WORK_PLACE%/temp/32.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 33
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX33% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 33 -nlt POLYGON %WORK_PLACE%/temp/33.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 34
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX34% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 34 -nlt POLYGON %WORK_PLACE%/temp/34.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 35
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX35% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 35 -nlt POLYGON %WORK_PLACE%/temp/35.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 36
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX36% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 36 -nlt POLYGON %WORK_PLACE%/temp/36.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 37
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX37% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 37 -nlt POLYGON %WORK_PLACE%/temp/37.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 38
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX38% -clipdst %LAYER_PLACE%com\com_mel.gpkg -clipdstlayer 38 -nlt POLYGON %WORK_PLACE%/temp/38.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 39
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX39% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 39 -nlt POLYGON %WORK_PLACE%/temp/39.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 40
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX40% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 40 -nlt POLYGON %WORK_PLACE%/temp/40.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 41
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX41% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 41 -nlt POLYGON %WORK_PLACE%/temp/41.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 42
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX42% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 42 -nlt POLYGON %WORK_PLACE%/temp/42.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 43
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX43% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 43 -nlt POLYGON %WORK_PLACE%/temp/43.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 44
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX44% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 44 -nlt POLYGON %WORK_PLACE%/temp/44.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 45
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX45% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 45 -nlt POLYGON %WORK_PLACE%/temp/45.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 46
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX46% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 46 -nlt POLYGON %WORK_PLACE%/temp/46.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 47
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX47% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 47 -nlt POLYGON %WORK_PLACE%/temp/47.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 48
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX48% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 48 -nlt POLYGON %WORK_PLACE%/temp/48.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 49
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX49% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 49 -nlt POLYGON %WORK_PLACE%/temp/49.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 50
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX50% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 50 -nlt POLYGON %WORK_PLACE%/temp/50.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 51
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX51% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 51 -nlt POLYGON %WORK_PLACE%/temp/51.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 52
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX52% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 52 -nlt POLYGON %WORK_PLACE%/temp/52.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 53
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX53% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 53 -nlt POLYGON %WORK_PLACE%/temp/53.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 54
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX54% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 54 -nlt POLYGON %WORK_PLACE%/temp/54.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 55
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX55% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 55 -nlt POLYGON %WORK_PLACE%/temp/55.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 56
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX56% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 56 -nlt POLYGON %WORK_PLACE%/temp/56.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 57
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX57% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 57 -nlt POLYGON %WORK_PLACE%/temp/57.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 58
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX58% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 58 -nlt POLYGON %WORK_PLACE%/temp/58.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 59
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX59% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 59 -nlt POLYGON %WORK_PLACE%/temp/59.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 60
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX60% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 60 -nlt POLYGON %WORK_PLACE%/temp/60.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 61
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX61% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 61 -nlt POLYGON %WORK_PLACE%/temp/61.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 62
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX62% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 62 -nlt POLYGON %WORK_PLACE%/temp/62.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 63
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX63% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 63 -nlt POLYGON %WORK_PLACE%/temp/63.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 64
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX64% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 64 -nlt POLYGON %WORK_PLACE%/temp/64.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 65
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX65% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 65 -nlt POLYGON %WORK_PLACE%/temp/65.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 66
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX66% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 66 -nlt POLYGON %WORK_PLACE%/temp/66.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 67
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX67% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 67 -nlt POLYGON %WORK_PLACE%/temp/67.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 68
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX68% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 68 -nlt POLYGON %WORK_PLACE%/temp/68.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 69
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX69% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 69 -nlt POLYGON %WORK_PLACE%/temp/69.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 70
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX70% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 70 -nlt POLYGON %WORK_PLACE%/temp/70.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 71
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX71% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 71 -nlt POLYGON %WORK_PLACE%/temp/71.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 72
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX72% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 72 -nlt POLYGON %WORK_PLACE%/temp/72.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 73
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX73% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 73 -nlt POLYGON %WORK_PLACE%/temp/73.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 74
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX74% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 74 -nlt POLYGON %WORK_PLACE%/temp/74.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 75
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX75% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 75 -nlt POLYGON %WORK_PLACE%/temp/75.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 76
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX76% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 76 -nlt POLYGON %WORK_PLACE%/temp/76.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 77
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX77% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 77 -nlt POLYGON %WORK_PLACE%/temp/77.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 78
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX78% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 78 -nlt POLYGON %WORK_PLACE%/temp/78.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 79
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX79% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 79 -nlt POLYGON %WORK_PLACE%/temp/79.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 80
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX80% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 80 -nlt POLYGON %WORK_PLACE%/temp/80.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 81
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX81% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 81 -nlt POLYGON %WORK_PLACE%/temp/81.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 82
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX82% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 82 -nlt POLYGON %WORK_PLACE%/temp/82.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 83
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX83% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 83 -nlt POLYGON %WORK_PLACE%/temp/83.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 84
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX84% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 84 -nlt POLYGON %WORK_PLACE%/temp/84.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 85
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX85% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 85 -nlt POLYGON %WORK_PLACE%/temp/85.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 86
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX86% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 86 -nlt POLYGON %WORK_PLACE%/temp/86.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 87
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX87% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 87 -nlt POLYGON %WORK_PLACE%/temp/87.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 88
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX88% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 88 -nlt POLYGON %WORK_PLACE%/temp/88.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 89
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX89% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 89 -nlt POLYGON %WORK_PLACE%/temp/89.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 90
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX90% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 90 -nlt POLYGON %WORK_PLACE%/temp/90.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 91
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX91% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 91 -nlt POLYGON %WORK_PLACE%/temp/91.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 92
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX92% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 92 -nlt POLYGON %WORK_PLACE%/temp/92.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 93
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX93% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 93 -nlt POLYGON %WORK_PLACE%/temp/93.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 94
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX94% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 94 -nlt POLYGON %WORK_PLACE%/temp/94.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 95
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf %OPTIONS_CREA_ETAPE2% -spat_srs EPSG:2154 -spat %BBOX95% -clipdst %LAYER_PLACE%\com\com_mel.gpkg -clipdstlayer 95 -nlt POLYGON %WORK_PLACE%/temp/95.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

REM /////////////// Début étape 3 ///////////////
(
ECHO
ECHO Etape 3 - Assemblage des communes
ECHO
)

ECHO commune 1
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments -lco fid=OBJECTID %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/1.fgb

ECHO commune 2
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/2.fgb

ECHO commune 3
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/3.fgb

ECHO commune 4
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/4.fgb

ECHO commune 5
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/5.fgb

ECHO commune 6 
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/6.fgb

ECHO commune 7 
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/7.fgb

ECHO commune 8 
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/8.fgb

ECHO commune 9 
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/9.fgb

ECHO commune 10
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/10.fgb

ECHO commune 11
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/11.fgb

ECHO commune 12
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/12.fgb

ECHO commune 13
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/13.fgb

ECHO commune 14
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/14.fgb

ECHO commune 15
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/15.fgb

ECHO commune 16
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/16.fgb

ECHO commune 17
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/17.fgb

ECHO commune 18
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/18.fgb

ECHO commune 19
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/19.fgb

ECHO commune 20
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/20.fgb

ECHO commune 21
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/21.fgb

ECHO commune 22
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/22.fgb

ECHO commune 23
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/23.fgb

ECHO commune 24
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/24.fgb

ECHO commune 25
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/25.fgb

ECHO commune 26
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/26.fgb

ECHO commune 27
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/27.fgb

ECHO commune 28
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/28.fgb

ECHO commune 29
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/29.fgb

ECHO commune 30
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/30.fgb

ECHO commune 31
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/31.fgb

ECHO commune 32
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/32.fgb

ECHO commune 33
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/33.fgb

ECHO commune 34
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/34.fgb

ECHO commune 35
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/35.fgb

ECHO commune 36
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/36.fgb

ECHO commune 37
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/37.fgb

ECHO commune 38
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/38.fgb

ECHO commune 39
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/39.fgb

ECHO commune 40
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/40.fgb

ECHO commune 41
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/41.fgb

ECHO commune 42
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/42.fgb

ECHO commune 43
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/43.fgb

ECHO commune 44
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/44.fgb

ECHO commune 45
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/45.fgb

ECHO commune 46
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/46.fgb

ECHO commune 47
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/47.fgb

ECHO commune 48
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/48.fgb

ECHO commune 49
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/49.fgb

ECHO commune 50
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/50.fgb

ECHO commune 51
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/51.fgb

ECHO commune 52
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/52.fgb

ECHO commune 53
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/53.fgb

ECHO commune 54
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/54.fgb

ECHO commune 55
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/55.fgb

ECHO commune 56
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/56.fgb

ECHO commune 57
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/57.fgb

ECHO commune 58
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/58.fgb

ECHO commune 59
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/59.fgb

ECHO commune 60
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/60.fgb

ECHO commune 61
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/61.fgb

ECHO commune 62
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/62.fgb

ECHO commune 63
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/63.fgb

ECHO commune 64
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/64.fgb

ECHO commune 65
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/65.fgb

ECHO commune 66
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/66.fgb

ECHO commune 67
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/67.fgb

ECHO commune 68
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/68.fgb

ECHO commune 69
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/69.fgb

ECHO commune 70
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/70.fgb

ECHO commune 71
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/71.fgb

ECHO commune 72
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/72.fgb

ECHO commune 73
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/73.fgb

ECHO commune 74
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/74.fgb

ECHO commune 75
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/75.fgb

ECHO commune 76
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/76.fgb

ECHO commune 77
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/77.fgb

ECHO commune 78
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/78.fgb

ECHO commune 79
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/79.fgb

ECHO commune 80
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/80.fgb

ECHO commune 81
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/81.fgb

ECHO commune 82
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/82.fgb

ECHO commune 83
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/83.fgb

ECHO commune 84
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/84.fgb

ECHO commune 85
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/85.fgb

ECHO commune 86
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/86.fgb

ECHO commune 87
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/87.fgb

ECHO commune 88
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/88.fgb

ECHO commune 89
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/89.fgb

ECHO commune 90
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/90.fgb

ECHO commune 91
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/91.fgb

ECHO commune 92
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/92.fgb

ECHO commune 93
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/93.fgb

ECHO commune 94
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/94.fgb

ECHO commune 95
%QGIS%/bin/ogr2ogr.exe" -f GPKG %OPTIONS_CREA_ETAPE2% -nlt POLYGON -nln batiments %WORK_PLACE%/bd_topo_batiments.gpkg %WORK_PLACE%/temp/95.fgb

DEL /S /Q %WORK_PLACE%/temp

REM /////////////// Début étape 4 ///////////////
(
ECHO
ECHO Etape 4 - Calcul duree d execution et creation d informations.txt
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
echo Temps d'execution total : %HOURS%h. %MINUTES%min. %SECONDS%sec.

(
ECHO Qui : %USER%
ECHO Quoi : Bd topo
ECHO Source : IGN
ECHO Source : %URL_INFO%
ECHO Téléchargement le : %TIME%
ECHO Durée de téléchargement : %HOURS%h. %MINUTES%min. %SECONDS%sec
) > %WORKPLACE%\informations.txt

ECHO Fin !