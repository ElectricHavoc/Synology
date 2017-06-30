#!/bin/sh

cd /usr/syno/share/nginx/
if grep -Pq "proxy_set_header\tUpgrade" "./Portal.mustache"; then
echo Upgrade Exists
else
echo Upgrade Added
awk '/location/ {print;print "\tproxy_set_header\tUpgrade\t\t    $http_upgrade;";next}1' Portal.mustache > Portal.tmp && mv Portal.tmp Portal.mustache
awk '/location/ {print;print "\tproxy_set_header\tConnection\t    \"upgrade\";";next}1' Portal.mustache > Portal.tmp && mv Portal.tmp Portal.mustache
awk '/location/ {print;print "\tproxy_read_timeout\t86400;";next}1' Portal.mustache > Portal.tmp && mv Portal.tmp Portal.mustache
fi

sudo synoservicecfg --restart nginx
