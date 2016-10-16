#!/bin/bash

echo ""
echo "processing airport-codes.csv..."
echo ""

PWD=$(pwd)

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