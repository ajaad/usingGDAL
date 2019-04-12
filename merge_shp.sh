#!/bin/bash

## merge all shapefiles in a directory
## and export it to a subdirectory

# make folder for result
mkdir merge >/dev/null

file="merge/merge.shp"
nr=0

for i in $(ls *.shp) ; do
      if [ -f "$file" ] ; then
        if [ ${nr} -eq 0  ] ; then
          #copy the first file!
          ogr2ogr -f "ESRI Shapefile" -t_srs EPSG:4326 $final $i
        else
          #Merge with the next shapefile
          ogr2ogr -f "ESRI Shapefile" -t_srs EPSG:4326 -update -append $final $i -nln merge
        fi
      fi

      nr=$((${nr}+1))
done
