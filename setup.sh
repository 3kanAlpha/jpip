#!/bin/bash
COUNTRYLIST='JP'

# APNICから最新の情報を取得
curl -s -o ./delegated-apnic-latest http://ftp.apnic.net/stats/apnic/delegated-apnic-latest

# jpipsファイルを初期化
:> ./jpips
for country in $COUNTRYLIST
do
	for ip in `cat ./delegated-apnic-latest | grep "apnic|$country|ipv4|"`
	do
		COUNTRY=`echo $ip | awk -F"|" '{ print $2 }'`
		IPADDR=`echo $ip | awk -F"|" '{ print $4 }'`
		TMPCIDR=`echo $ip | awk -F"|" '{ print $5 }'`

		FLTCIDR=32
		while [ $TMPCIDR -ne 1 ];
		do
			TMPCIDR=$((TMPCIDR/2))
			FLTCIDR=$((FLTCIDR-1))
		done
		echo "$IPADDR/$FLTCIDR" >> ./jpips
	done
done