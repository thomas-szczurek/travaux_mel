@ECHO OFF

ECHO Etape 1 - assignation des variables et creation du dossier de traitement temporaire

REM variables potentiellement modifiables
REM repertoire d'installation de qgis
SET QGIS="C:\Program Files\QGIS 3.34.8
REM emplacement des traitements intermediaires
SET WORK_PLACE=V:\1_sig\projets\ref_donnees_etageres
REM url de l'api ogc de la geomplateforme. L'option TYPENAMES est celle permettant d'indiquer une couche spécifique
SET URL_INFO=https://data.geopf.fr
SET URL_GEOP="%URL_INFO%/wfs/ows?SERVICE=WFS&REQUEST=GetFeature&VERSION=2.0.0&TYPENAMES=

REM il faut aussi configurer GDAL_DATA car on utilise gdal/ogr en dehors du shell osgeo4w
SET GDAL_DATA=%QGIS%\apps\gdal\share\gdal"
REM curl n'arrive pas à certifier les certifs ssl (y comprit ceux des serveurs de la mel) à travers le proxy de la mel donc on désactive la verif ssl pour les wfs
SET GDAL_HTTP_UNSAFESSL=YES
REM options de créations
SET OPTIONS_CREA_ETAPE2=-append -t_srs EPSG:2154 -clipdst %WORK_PLACE%\com\com_mel.gpkg --config OGR_WFS_PAGE_SIZE=100000 -gt 65536 -makevalid
REM enregistrement de l'horaire de lancement du script
SET STARTTIME=%TIME%

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

mkdir %WORK_PLACE%\temp

ECHO Etape 2 - conversion en geopackage et extraction zonage mel

ECHO commune 1
SET BBOX=%BBOX1%
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf -spat_srs EPSG:2154 -spat %BBOX% %OPTIONS_CREA_ETAPE2% -clipdstlayer 1 -nlt MULTIPOLYGON %WORK_PLACE%/temp/bat_bd_topo1.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 2
SET BBOX=%BBOX2%
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf -spat_srs EPSG:2154 -spat %BBOX% %OPTIONS_CREA_ETAPE2% -clipdstlayer 2 -nlt MULTIPOLYGON %WORK_PLACE%/temp/bat_bd_topo2.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 3
SET BBOX=%BBOX3%
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf -spat_srs EPSG:2154 -spat %BBOX% %OPTIONS_CREA_ETAPE2% -clipdstlayer 3 -nlt MULTIPOLYGON %WORK_PLACE%/temp/bat_bd_topo3.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 4
SET BBOX=%BBOX4%
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf -spat_srs EPSG:2154 -spat %BBOX% %OPTIONS_CREA_ETAPE2% -clipdstlayer 4 -nlt MULTIPOLYGON %WORK_PLACE%/temp/bat_bd_topo4.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO commune 5
SET BBOX=%BBOX5%
%QGIS%/bin/ogr2ogr.exe" -f FlatGeobuf -spat_srs EPSG:2154 -spat %BBOX% %OPTIONS_CREA_ETAPE2% -clipdstlayer 5 -nlt MULTIPOLYGON %WORK_PLACE%/temp/bat_bd_topo5.fgb WFS:%URL_GEOP%BDTOPO_V3:batiment"

ECHO fusion
%QGIS%/bin/ogr2ogr.exe" -f GPKG -append -lco FID=objectid %WORK_PLACE%/temp/bat_bd_topo.gpkg %WORK_PLACE%/temp/bat_bd_topo1.fgb
del %WORK_PLACE%\temp\bat_bd_topo1.fgb
%QGIS%/bin/ogr2ogr.exe" -f GPKG -append -lco FID=objectid %WORK_PLACE%/temp/bat_bd_topo.gpkg %WORK_PLACE%/temp/bat_bd_topo2.fgb
del %WORK_PLACE%\temp\bat_bd_topo2.fgb
%QGIS%/bin/ogr2ogr.exe" -f GPKG -append -lco FID=objectid %WORK_PLACE%/temp/bat_bd_topo.gpkg %WORK_PLACE%/temp/bat_bd_topo3.fgb
del %WORK_PLACE%\temp\bat_bd_topo3.fgb
%QGIS%/bin/ogr2ogr.exe" -f GPKG -append -lco FID=objectid %WORK_PLACE%/temp/bat_bd_topo.gpkg %WORK_PLACE%/temp/bat_bd_topo4.fgb
del %WORK_PLACE%\temp\bat_bd_topo4.fgb
%QGIS%/bin/ogr2ogr.exe" -f GPKG -append -lco FID=objectid %WORK_PLACE%/temp/bat_bd_topo.gpkg %WORK_PLACE%/temp/bat_bd_topo5.fgb
del %WORK_PLACE%\temp\bat_bd_topo5.fgb
