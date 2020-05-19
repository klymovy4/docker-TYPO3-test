#!/usr/bin/env bash

HTTPDUSER="www-data"

BLACK="\033[30m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
PINK="\033[35m"
CYAN="\033[36m"
WHITE="\033[37m"
NORMAL="\033[0;39m"
NC="\033[0m" # No Color

function echo_done() {
    echo -e "                       ... ${GREEN}done${NC}\r$1 "
}

#  ================================================================================ Typo3
BASE_PATH="/var/www/html/typo3"
if [[ ! -d "$BASE_PATH" ]]; then
  echo "Started building Typo3"
  composer create-project "typo3/cms-base-distribution:^10.4" $BASE_PATH
  touch $BASE_PATH/public/FIRST_INSTALL
fi
echo "Typo3 - READY"

# Restart SSH Server
sudo service ssh restart