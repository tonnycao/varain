#!/bin/bash

if [ -z $1 ]
	then
	echo 'Usage:    git version'
	echo './mk_dev_main_bsb.sh ed71cc648c7df8b4b10f6026a0a821cfa031dd88'		
	exit 1
fi

if [ $2 ]
  then
  echo 'Usage: too many parameter'
  echo './mk_dev_main_bsb.sh ed71cc648c7df8b4b10f6026a0a821cfa031dd88'      
  exit 1
fi

CURTIME=`date +%Y%m%d_%H%M`
export GIT_SSL_NO_VERIFY=1
rm -rf ./backend_internet
git clone -b dev https://192.168.8.61/pi05_bestbox3/backend_inernet.git  ./backend_internet
cd ./backend_internet

#git checkout  $1
ic_Ret=`git checkout  $1 2>&1 | grep 'error' | wc -l`
#echo ${ic_Ret}
if [ ${ic_Ret} -le 0 ]
	then
	echo 'checkout ok '
	else
	echo ${ic_Ret}:"There is an checkout error"
	exit 1
fi


sleep 1
git log -1 > gitver.txt
cp -p gitver.txt ./public/

if [ -d "storage" ];then
rm -rf storage;
fi

if [ -d ".git" ];then
rm -rf .git;
fi

if [ -f ".env.example" ];then
rm -f .env.example;
fi

if [ -f ".gitignore" ];then
rm -f .gitignore;
fi

if [ -f ".gitattributes" ];then
rm -f .gitattributes;
fi

if [ -f "showdoc_api.sh" ];then
rm -f showdoc_api.sh
fi

if [ -d ".idea" ];then 
rm -rf .idea;
fi

if [ -f "up-rewrite.conf" ];then
rm -f up-rewrite.conf;
fi

if [ -f "public/.gitignore" ];then
rm -f public/.gitignore;
fi

if [ -f "public/u.php" ];then
rm -f public/u.php;
fi

if [ -f "public/up-rewrite.conf" ];then
rm -f public/up-rewrite.conf;
fi

if [ -f "public/web.config" ];then
rm -f public/web.config;
fi

find ./ -type d -exec chmod 775 {} \;
find ./ -type f -exec chmod 644 {} \;
cd ..
tar -czf PK06_bestboxDB_backend_main_${CURTIME}.tar.gz backend_internet
md5sum PK06_bestboxDB_backend_main_${CURTIME}.tar.gz > md5_backend_main_${CURTIME}.txt
