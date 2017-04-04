
ONE='1'

while read f1 f2  f3 appname curlendpoint  curlresponse soapaction authorization contenttype

do


     if [ "$f1" == 'wget'  ]
	then  
#	echo "Linux Command" $f1
#	echo "URL"   $wsdlurl
#	echo "System" $f3
#	echo "Name" $appname
	wsdlurl=$f2
#	echo      "$wsdlurl" | sed -e 's/^"//'  -e 's/"$//'
       tempwsdlurl=$(echo  "$wsdlurl" | sed -e 's/^"//'  -e 's/"$//')
        
 #      echo wsdlurl $tempwsdlurl 
	wget         $tempwsdlurl        -o test.log

	INPUT=$(grep -w -c 200 test.log)

	if [ $INPUT == $ONE ]
		 then
        		echo $appname         $f3                                  is UP
	 	else
       			 echo $appname        $f3                                   is DOWN
	fi


     fi



     if [ "$f1" == 'curl'  ]
        then
        
#echo  $curlendpoint   
#echo $authorization
#echo $soapaction

#echo $f2







	

 curl -s   --header "Content-Type:$contenttype"  --header  $soapaction --header "Authorization:Basic $authorization"  --data @"/opt/pop/conf/healthcheck_scripts/$f2" $curlendpoint      -o test.log   2>&1

echo ----endpoint-----------

echo  $curlendpoint

echo ----------end endpoint----------------

echo  -----request-----------------------------
echo
cat  /opt/pop/conf/healthcheck_scripts/$f2

echo -------end request------------------------

echo -------response --------------------------------

cat test.log

echo 
echo  -------end response----------------------------

        INPUT=$(grep -w -c $curlresponse  test.log)
	#echo $INPUT
	#	echo '    ' 
	#echo $curlresponse


        if [ "$INPUT" -ge  "$ONE" ]
                 then
                        echo $appname         $f3                                  is PROXY-UP
                else
                         echo $appname        $f3                                   is PROXY-DOWN
        fi


     fi




         	if [ "$f1"  == 'portopen'  ]
		then 
				nc -z -w5 $f2 $f3 > test.log
				  INPUT=$(grep -w -c succeeded test.log)

        if [ "$INPUT" == "$ONE" ]
                 then
                        echo $appname         $f3                                  is UP
                else
                         echo $appname        $f3                                   is DOWN
        fi

		 
		 fi
done < /opt/pop/conf/ESB_healthcheck.conf


#	rm  -rf  /opt/pop/conf/test.log

 #       rm -rf /opt/pop/conf/*.svc*

  #      rm -rf /opt/pop/conf/*?wsdl*
#	rm -rf /opt/pop/conf/index.htm*
