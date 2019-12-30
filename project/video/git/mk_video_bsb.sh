#!/bin/bash

if [ -z $1 ]
	then
	echo 'Usage:    git version'
	echo './mk_dev_video_bsb.sh ad01f54ca5f243013cc102775e0992e1478246fc'		
	exit 1
fi

if [ $2 ]
  then
  echo 'Usage: too many parameter'
  echo './mk_dev_video_bsb.sh ad01f54ca5f243013cc102775e0992e1478246fc'      
  exit 1
fi

CURTIME=`date +%Y%m%d_%H%M`
export GIT_SSL_NO_VERIFY=1
rm -rf ./backend_video
git clone -b master https://192.168.8.61/pi05_bestbox3/backend_video.git  ./backend_video
cd ./backend_video


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

if [ -d ".git" ];then
rm -rf .git;
fi

if [ -d "storage" ];then
rm -rf storage;
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

if [ -f "up-rewrite.conf" ];then
rm -f up-rewrite.conf;
fi

if [ -f "public/web.config" ];then
rm -f public/web.config;
fi

find ./ -type d -exec chmod 775 {} \;
find ./ -type f -exec chmod 644 {} \;
cd ..
tar -czf PK06_bestboxDB_backend_video_${CURTIME}.tar.gz backend_video
md5sum PK06_bestboxDB_backend_video_${CURTIME}.tar.gz > md5_backend_video_${CURTIME}.txt


