#!/bin/bash

PWD=$(pwd)

echo ""
echo "processing airport-codes.csv..."
echo "1/1 ogr2ogr.."
ogr2ogr -f "GeoJSON" airport-codes.json "
		<OGRVRTDataSource>
		    <OGRVRTLayer name='airport-codes'>
		        <SrcDataSource>${PWD}/../source/airport-codes.csv</SrcDataSource>
		        <GeometryType>wkbPoint</GeometryType>
		        <LayerSRS>WGS84</LayerSRS>
		        <GeometryField encoding='PointFromColumns' x='longitude_deg' y='latitude_deg'/>
		        <Field name='ident' src='ident' type='String'/>
		        <Field name='type' src='type' type='String'/>
		        <Field name='name' src='name' type='String'/>
		        <Field name='elevation_ft' src='elevation_ft' type='Integer'/>
		        <Field name='continent' src='continent' type='String'/>
		        <Field name='iso_country' src='iso_country' type='String'/>
		        <Field name='iso_region' src='iso_region' type='String'/>
		        <Field name='municipality' src='municipality' type='String'/>
		        <Field name='gps_code' src='gps_code' type='String'/>
		        <Field name='iata_code' src='iata_code' type='String'/>
		        <Field name='local_code' src='local_code' type='String'/>
		    </OGRVRTLayer>
		</OGRVRTDataSource>"

echo ""
echo "processing lsystns.upc... (not implemented yet)"
echo ""

echo ""
echo "processing madis-stations.txt... (not implemented yet)"
echo ""

echo ""
echo "processing master.txt... (not implemented yet)"
echo ""

echo ""
echo "processing sfstns.tbl..."
echo "1/5 create sfstns.tbl.csv.tmp.. (may take a wile)"
cat ../source/sfstns.tbl | while read line
do
   echo $(echo ${line:0:9} | sed 's/ //g'),$(echo ${line:9:7} | sed 's/ //g'),$(echo ${line:16:33} | sed 's/ //g'),$(echo ${line:49:3} | sed 's/ //g'),$(echo ${line:52:3} | sed 's/ //g'),$(echo ${line:55:6} | sed 's/ //g'),$(echo ${line:61:7} | sed 's/ //g'),$(echo ${line:68:6} | sed 's/ //g') \
   >> sfstns.tbl.csv.tmp
done

echo "2/5 create sfstns.tbl.csv with correct lat lon.."
LC_NUMERIC=en_US.UTF-8 awk '{FS=","; OFS=","; lat = $6 / 100 ; lon = $7 / 100; print $1,$2,$3,$4,$5,lat,lon,$8}' sfstns.tbl.csv.tmp > sfstns.tbl.csv

echo "3/5 add header to correct csv.."
echo -e "stid,synop_id,name,state,country,lat,lon,alt\n$(cat sfstns.tbl.csv)" > sfstns.tbl.csv

echo "4/5 ogr2ogr.."
ogr2ogr -f "GeoJSON" sfstns.tbl.json "
		<OGRVRTDataSource>
		    <OGRVRTLayer name='sfstns.tbl'>
		        <SrcDataSource>${PWD}/sfstns.tbl.csv</SrcDataSource>
		        <GeometryType>wkbPoint</GeometryType>
		        <LayerSRS>WGS84</LayerSRS>
		        <GeometryField encoding='PointFromColumns' x='lon' y='lat'/>
		        <Field name='stid' src='stid' type='String'/>
		        <Field name='synop_id' src='synop_id' type='Integer'/>
		        <Field name='name' src='name' type='String'/>
		        <Field name='state' src='state' type='String'/>
		        <Field name='country' src='country' type='String'/>
		        <Field name='alt' src='alt' type='Integer'/>
		    </OGRVRTLayer>
		</OGRVRTDataSource>"

echo "5/5 delete sfstns.tbl.csv*.."
rm sfstns.tbl.csv*

echo ""
echo "processing stations.txt... (not implemented yet)"
echo ""