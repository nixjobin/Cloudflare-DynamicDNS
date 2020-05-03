#!/bin/bash
#Author : redhatjobin

############## Add your CloudFlare Credentials Here ##############

cf_email=your-login-id@gmail.com   # Your Login email id
api_key=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX # Get this from CloudFlare MySettings > Global API key Section
zone_name=example.com   # Your Website name in CloudFlare eg: example.com
record_name=ddns           # A record name for DynamicDNS eg: ddns


###################################################################

identify () {
zone_identifier=`curl -s -X GET "https://api.cloudflare.com/client/v4/zones?name=$zone_name" -H "X-Auth-Email: $cf_email" -H "X-Auth-Key: $api_key" -H "Content-Type: application/json" | cut -d'"' -f6`

record_identifier=`curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$zone_identifier/dns_records?name=$record_name.$zone_name" -H "X-Auth-Email: $cf_email" -H "X-Auth-Key: $api_key" -H "Content-Type: application/json" |grep -v zone_id |grep "id" | cut -d'"' -f4`

if [ $record_identifier == "page" ] ; then
    echo "Zone Does not exist, Dont Worry, I will create it for you :)"
    createzone
else
    echo " "
fi

}
#echo $cf_email , $api_key , $zone_name , $record_name , $zone_identifier , $record_identifier

createzone () {
curl -X POST "https://api.cloudflare.com/client/v4/zones/$zone_identifier/dns_records" -H "X-Auth-Email: $cf_email" -H "X-Auth-Key: $api_key" -H "Content-Type: application/json" --data '{"type":"A","name":"'$record_name'","content":"'$ipnow'","ttl":120,"proxied":false}'     
}

dnschange () {
curl -X PUT "https://api.cloudflare.com/client/v4/zones/$zone_identifier/dns_records/$record_identifier" -H "X-Auth-Email: $cf_email" -H "X-Auth-Key: $api_key" -H "Content-Type: application/json" --data '{"type":"A","name":"'$record_name'","content":"'$ipnow'","ttl":120,"proxied":false}'
}


ipnow=`dig +short myip.opendns.com @resolver1.opendns.com`
iplive=`cat /tmp/mypublicip`

if [ "$iplive" == "$ipnow" ];then
  echo "No change in IP - Live : $iplive Now : $ipnow"
else 
    echo "IP change is required from $iplive to $ipnow"
    identify
    dnschange
    echo $ipnow > /tmp/mypublicip
fi

exit 0
