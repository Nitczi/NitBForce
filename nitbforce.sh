#!/bin/bash

Help(){
	echo "NitBForce Script"
	echo "-h -- Open this manual"
	echo "-u -- Specifies the URL to attack."
	echo "-w -- set a wordlist for files."
	echo
	echo "-e [OPTIONAL] -- Specifies an extension. Used to brute force files."
	echo "		 php, txt, asp, pdf..."
	echo
	echo "Usage example: $0 -u example-site.com -w wordlist"
	echo "Usage example: $0 -u example-site.com -w wordlist -e php"
	echo
	exit
}


while getopts ":he:u:w:" option; do
        case $option in
                h)
                        Help
                        exit;;
                w)
			wordlist=$OPTARG
			;;

		u)
			url=${OPTARG}
			;;

		e)
			ext=$OPTARG
			;;
		*)
			echo "You do not passed the options correctly"
			echo "See the help menu with: $0 -h"
			echo
                        exit;;
       	esac
done


if [ "$1" = "" ]
then
	echo "Invalid usage"
	echo "Type: $0 -h to see the manual"
	exit 1
fi

###### Verifiy if necessary options were passed #######

if [ -z "$wordlist" ]
then
        echo "You need to specify the wordlist to attack the target"
	echo "Read the manual with: $0 -h"
        exit 1
fi

if [ ! -r "$wordlist" ]
then
	echo "This file doesn't exist in the current directory."
	exit 1
fi
#######################################################


################## Brute Forcing DIR ##################
for list in $(cat $wordlist)
do
	resp=$(curl -s -o /dev/null -H "User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:47.0) Gecko/20100101 Firefox/47.0" -w "%{http_code}" http://$url/$list)
	if [ $resp = "200" ] || [ $resp = "301" ]
	then
		echo "Directory Found: $url/$list"
	fi
done
######################################################

################## Brute Forcing files ################

if [ ! -z $ext ]
then
	echo
	echo "Searching for files..."
	sleep 2
	for list in $(cat $wordlist)
	do
        	resp=$(curl -s -o /dev/null -H "User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:47.0) Gecko/20100101 Firefox/47.0" -w "%{http_code}" http://$url/$list.$ext)
        	if [ $resp = "200" ] || [ $resp = "301" ]
        	then
                	echo "File Found: $url/$list.$ext"
        	fi
	done

fi
####################################################
