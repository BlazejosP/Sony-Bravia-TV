#!/bin/sh
# This program can send command to Sony Bravia TV pre-android mnufactured between 2011-2013 with Direct IP commands
set -e

if [ "$1" = "" ] || [ "$2" = "" ]; then
  echo "Usage: $0 <TV_IP> <IP_COMMAND>"
  exit 1
fi


if code=$(echo | http --check-status --ignore-stdin --pretty format --headers --follow --timeout 3600 GET ''$2'');

then	
	# we cut number from header answer
	code2=$(echo $code | cut --delimiter=' ' --fields=2)
	
	#echo $code2

	#checking if communicate is with correct number
	echo ""

		if [ $code2 = "200" ]; then
  			echo "✓"
  			echo ""
  			#echo $code3
		else
  			echo " ⃠"
  			echo ""
  			echo "Command failed (HTTP_CODE: $code, try running it in a console)"
  			echo ""
		fi
		


else
	echo ""
   	case $? in
        	2) echo 'Request timed out!' ;;
        	3) echo 'Unexpected HTTP 3xx Redirection!' ;;
        	4) echo 'HTTP 4xx Client Error!' ;;
        	5) echo 'HTTP 5xx Server Error!' ;;
        	6) echo 'Exceeded --max-redirects=<n> redirects!' ;;
        	*) echo 'Other Error!' ;;
    	esac
fi



 





