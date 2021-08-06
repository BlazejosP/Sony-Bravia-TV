#!/bin/sh
# This program can send command to Sony Bravia TV pre-android mnufactured between 2011-2013
set -e

if [ "$1" = "" ] || [ "$2" = "" ]; then
  echo "Usage: $0 <TV_IP> <IRCC_COMMAND>"
  exit 1
fi

dane='<?xml version="1.0" encoding="utf-8"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" s:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
<s:Body>
    <u:X_SendIRCC xmlns:u="urn:schemas-sony-com:service:IRCC:1">
        <IRCCCode>'$2'</IRCCCode>
    </u:X_SendIRCC>
</s:Body>
</s:Envelope>
'


if code=$(echo $dane | http  --check-status --pretty format --headers --follow --timeout 3600 POST 'http://'$1'/IRCC' Content-Type:'application/xml');
then	
	#code3=$(echo $code)
	# we cut number from header answer
	code2=$(echo $code | cut --delimiter=' ' --fields=2)
	
	#echo $code2

	
	#checking if communicate is with correct number
	echo ""

		if [ $code2 = "200" ]; then
  			echo "✓"
  			echo ""
  			#echo $code
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

 





