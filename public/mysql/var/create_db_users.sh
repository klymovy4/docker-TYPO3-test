#!/usr/bin/env bash

PASS='1234'

mysql -u root <<MYSQL_SCRIPT
#CREATE USER IF NOT EXISTS 'ecc-user'@'%' IDENTIFIED BY '$PASS';
#GRANT ALL PRIVILEGES ON ecc.* TO 'ecc-user'@'%';
#GRANT ALL PRIVILEGES ON earnbox.* TO 'ecc-user'@'%';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

echo "MySQL users created."