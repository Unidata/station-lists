# geojson

this folder contians the derived GeoJSON of the CSV files in the /source folder

## raw2geojson

script to transform the CSVs the GeoJSON

### requirement

GDAL (`ogr2ogr`) with GeoJSON driver

### execute

1. `cd geojson`
2. `rm *.json*`
3. `./raw2geojson.sh`