#!/bin/bash
# check_domain for nagios
# Version: 1.0
# 05.07.2021  FOURGOUS Alexandre, France
#---------------------------------------------------

if [ "$#" == "0" ]; then
    echo "You need tu supply at least one argument!"
    exit 1
fi

DOMAINS=( '.com' '.fr' '.io' )

ELEMENTS=${#DOMAINS[@]}

while (( "$#" )); do

        for (( i=0;i<$ELEMENTS;i++));
                do
                        whois $1${DOMAINS[${i}]} | egrep -q \ '^No match|^NOT FO                                                                                                                  UND|^Not fo|AVAILABLE|^No Data Fou|has not been regi|No entri'
                if [ $? -eq 0 ];
                then
                        echo "$1${DOMAINS[${i}]} : available"
                        status=2
                else
                        status=0
                fi
  done

shift

done

if [ "$status" == "0" ]; then
        echo "aucun nom de domaine dispo"
fi

exit $status

#################
