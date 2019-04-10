#!/bin/bash

## merge all shapefiles in a directory


mkdir final >/dev/null

file="final/merge.shp"
nr=0

for i in $(ls *.shp) ; do
      # utpakking fra mappe $(ls) #over
      #if [[ "$i" != *.sh ]]; then
      #  mv $i/* .
      #fi
      
      #echo $i/$i.shp
      
      if [ -f "$file" ] ; then
        if [ ${nr} -eq 0  ] ; then
          #copy the first file!
          ogr2ogr -f "ESRI Shapefile" -t_srs EPSG:4326 $file $i
        else
          #Merge with the next shapefile
             ogr2ogr -f "ESRI Shapefile" -t_srs EPSG:4326 -update -append $file $i -nln merge
        fi
      fi

      nr=$((${nr}+1))
done
