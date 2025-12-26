    #!/bin/bash
    # use lemonboys bar to display titlebars
    barPids=/tmp/titleBarPids
    touch $barPids
    floating="$(bspc query -T -d| grep " f"| awk '{print $4" "$6}' 2> /dev/null)"

    if [[ "$floating" == "" ]];then
        kill $(cat $barPids)
        rm $barPids
        exit
    fi
    kill $(cat $barPids)
    rm $barPids
    echo "$floating"| while read id geo; do
        geoBar=$(echo $geo| sed -e 's/+\|x/ /g'| awk '{print $1+4"x20+"$3"+"$4-20}')
        echo "%{c}$(xtitle $id)"| bar -g $geoBar -p -d &
        echo $! >> $barPids
    done
