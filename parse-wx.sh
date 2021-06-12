#!/bin/bash
SQLCMD="mysql -h HOSTNAME -u wx -pPASSWORD DATABASE -e "

mkdir /tmp/wx
cd /tmp/wx

wget http://w1.weather.gov/xml/current_obs/all_xml.zip >/dev/null 2>/dev/null
mkdir work
unzip -d work all_xml.zip

cd work
cat -- *.xml > allwx.txt
$SQLCMD "START TRANSACTION; DELETE FROM nws; LOAD XML LOCAL INFILE 'allwx.txt' REPLACE INTO TABLE nws ROWS IDENTIFIED BY '<current_observation>'; COMMIT;"
cd ..
rm -rf work
rm all_xml.zip
cd /
rm -rf /tmp/wx

