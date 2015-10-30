#!/bin/bash
consul agent -server -bootstrap-expect 1 -dc=local -data-dir=/tmp/consul -ui-dir=/dist -client=0.0.0.0 &
service rsyslog restart
sleep 3
consul-template -template "/etc/haproxy/haproxy.ctmpl:/etc/haproxy/haproxy.cfg:service haproxy restart"

