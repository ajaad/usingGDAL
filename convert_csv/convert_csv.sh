#!/bin/bash


# This script converts a list of coordinates into any GDAL-supportet coordinate system.


# headers: point_ID,X,Y

# This script reads the list from stdin and export it to stdout.
# please use it like this:
# $ cat coordinate_list.csv | bash convert.sh > new_list.csv  

## PARAMETERS
delim=","
from_sys="EPSG:25832"
to_sys="EPSG:4326"
##

count_base=0
while read LINE; do
    count_base=$(($count_base + 1))
    if [ "$count_base" -eq 1 ]; then
        echo ${LINE}
        continue
    fi

    coord=$(echo $LINE | tr ${delim} "\n")

    count=0
    for var in ${coord}; do 
        count=$(($count + 1))
        X=0;Y=0;H=0
        case $count in
            1) ident=${var}
            ;;
            2) X=${var} #the X value is in row 2.
            ;;
            3) Y=${var}
            ;;
            4) H=${var}
        esac
    done
    
    translated=$(echo $X $Y $H | gdaltransform -s_srs ${from_sys} -t_srs ${to_sys} | tr " " ${delim})

    echo -e ${ident}${delim}${translated}

done < /dev/stdin

