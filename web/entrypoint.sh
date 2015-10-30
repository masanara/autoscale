#!/bin/bash

echo "<h1>HOSTNAME:$HOSTNAME</h1>" > /usr/share/nginx/html/index.html

MYIP=`hostname -i | tr -d '\n'`

cat << EOT | curl -XPUT http://$CONSUL_PORT_8500_TCP_ADDR:$CONSUL_PORT_8500_TCP_PORT/v1/agent/service/register -d @-
{
  "ID": "web-app_$HOSTNAME",
  "Address": "$MYIP",
  "Name": "web-app",
  "tags": ["web-app"],
  "port": 80,
  "check": {
    "script": "curl $MYIP:80 > /dev/null 2>&1",
    "interval": "10s"
  }
}
EOT

nginx
