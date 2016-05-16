#!/bin/sh

DB="aapoo_base"
DOC="fce232d2f7d657d17f38b41fbe005b06"
#HOST="media01.tor1.voxter.net"
POST="15984"

if [ ! $2 ]; then
  echo "Usage: $0 <server> <GET|PUT|ALL> <INT> ";
  echo "e.g. localhost GET 100"
  exit 1;
fi
set -m # Enable Job Control

# GET
# 30 * 10
if [ $2 == "GET" ]; then
  for i in `seq 30`; do # start 30 jobs in parallel
    curl -X GET http://127.0.0.1:5984/$DB/$DOC?[1-$3]
  done
fi
# Wait for all parallel jobs to finish
while [ 1 ]; do fg 2> /dev/null; [ $? == 1 ] && break; done;



#PUT (CREATES new documents under the account)
if [ $2 == "PUT" ]; then
   cd .
   RAND=`cat count`
   let RANDplus=RAND+$3
   while [ $RAND -lt $RANDplus ]; do
     echo The counter is $RAND
     let RAND=RAND+1
     echo $RAND > count

     curl -H "Content-Type:application/json" -X PUT http://127.0.0.1:5984/$DB/$RAND -d '{"apps":{"userportal":{"api_url":"https://api.test.com:8443/v1","default":true,"desc":"Manageyourcallforwarding,seecallhistoryintheUserPortal","icon":"userportal","id":"userportal","label":"UserPortal"}},"call_forward":{"direct_calls_only":false,"enabled":false,"ignore_early_media":true,"keep_caller_id":true,"number":"","require_keypress":false,"substitute":false},"caller_id":{"external":{"number":"+16NULL"}},"caller_id_options":{},"email":"PUT OPERATION","enabled":true,"fax_to_email_enabled":true,"first_name":"sarahs","hotdesk":{"enabled":false,"keep_logged_in_elsewhere":false,"require_pin":false},"id":"$RAND","is_sub_account_rep":false,"last_name":"b.ca","media":{},"music_on_hold":{},"notifications":{},"priv_level":"user","pvt_account_db":"account%2F00%2F17%2F7c5838d8d2c0a75b31d6389bec72","pvt_account_id":"00177c5838d8d2c0a75b31d6389bec72","pvt_created":63540116038,"pvt_md5_auth":"1dfba8dad69f3c3b101409dd2656a208","pvt_modified":63582351480,"pvt_sha1_auth":"e461b16e109b530797dbbe5103af18c80aa75302","pvt_type":"user","pvt_vsn":"1","require_password_update":false,"timezone":"America/Vancouver","username":"s","verified":false,"vm_to_email_enabled":true}'

  done
fi

#POST (UPDATES the existing document)
if [ $2 == "POST" ]; then

  for i in `seq 1 $3`; do
    echo $i
    curl -H "Content-Type:application/json" -X POST http://127.0.0.1:5984/$DB/ -d '{"apps":{"userportal":{"api_url":"https://api.test.com:8443/v1","default":true,"desc":"Manageyourcallforwarding,seecallhistoryintheUserPortal","icon":"userportal","id":"userportal","label":"UserPortal"}},"call_forward":{"direct_calls_only":false,"enabled":false,"ignore_early_media":true,"keep_caller_id":true,"number":"","require_keypress":false,"substitute":false},"caller_id":{"external":{"number":"+16NUL"}},"caller_id_options":{},"email":"POST OPERATION","enabled":true,"fax_to_email_enabled":true,"first_name":"sarahs","hotdesk":{"enabled":false,"keep_logged_in_elsewhere":false,"require_pin":false},"id":"$RAND","is_sub_account_rep":false,"last_name":"b.ca","media":{},"music_on_hold":{},"notifications":{},"priv_level":"user","pvt_account_db":"account%2F00%2F17%2F7c5838d8d2c0a75b31d6389bec72","pvt_account_id":"00177c5838d8d2c0a75b31d6389bec72","pvt_created":63540116038,"pvt_md5_auth":"1dfba8dad69f3c3b101409dd2656a208","pvt_modified":63582351480,"pvt_sha1_auth":"e461b16e109b530797dbbe5103af18c80aa75302","pvt_type":"user","pvt_vsn":"1","require_password_update":false,"timezone":"America/Vancouver","username":"s","verified":false,"vm_to_email_enabled":true}'

  done
fi


if [ $2 == "ATT" ]; then

  for i in `seq 1 $3`; do
        echo $i
        RAND=$(echo `date +%s%N` | md5sum | awk '{print $1}')

        curl -H "Content-Type: image/gif" -X PUT http://localhost:5984/$DB/ATTACHME$RAND/homer.gif --data-binary @homer.gif


  done
fi

