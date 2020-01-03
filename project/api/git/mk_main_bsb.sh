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
current="$(dirname $(readlink -f $0))"
echo "work dir is: ${current}"

if [ -d "${current}/backend_internet" ]
then
	rm -rf ${current}/backend_internet
fi

git clone -b master https://192.168.8.61/pi05_bestbox3/backend_inernet.git  ${current}/backend_internet
cd ${current}/backend_internet

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
echo "tar package please waiting..."
git log -1 > gitver.txt
cp -p gitver.txt ./public/

if [ -d "${current}/backend_internet/storage" ];then
rm -rf ${current}/backend_internet/storage;
fi

if [ -d "${current}/backend_internet/.git" ];then
rm -rf ${current}/backend_internet/.git;
fi

if [ -f "${current}/backend_internet/.env.example" ];then
rm -f ${current}/backend_internet/.env.example;
fi

if [ -f "${current}/backend_internet/.gitignore" ];then
rm -f ${current}/backend_internet/.gitignore;
fi

if [ -f "${current}/backend_internet/.gitattributes" ];then
rm -f ${current}/backend_internet/.gitattributes;
fi

if [ -f "${current}/backend_internet/showdoc_api.sh" ];then
rm -f ${current}/backend_internet/showdoc_api.sh
fi

if [ -d "${current}/backend_internet/.idea" ];then 
rm -rf ${current}/backend_internet/.idea;
fi

if [ -f "${current}/backend_internet/up-rewrite.conf" ];then
rm -f ${current}/backend_internet/up-rewrite.conf;
fi

if [ -f "${current}/backend_internet/public/.gitignore" ];then
rm -f ${current}/backend_internet/public/.gitignore;
fi

if [ -f "${current}/backend_internet/public/u.php" ];then
rm -f ${current}/backend_internet/public/u.php;
fi

if [ -f "${current}/backend_internet/public/up-rewrite.conf" ];then
rm -f ${current}/backend_internet/public/up-rewrite.conf;
fi

if [ -f "${current}/backend_internet/public/web.config" ];then
rm -f ${current}/backend_internet/public/web.config;
fi

find ./ -type d -exec chmod 775 {} \;
find ./ -type f -exec chmod 644 {} \;

cd ./..

tar -czf ${current}/PK06_bestboxDB_backend_main_${CURTIME}.tar.gz ${current}/backend_internet
md5sum ${current}/PK06_bestboxDB_backend_main_${CURTIME}.tar.gz > ${current}/md5_backend_main_${CURTIME}.txt
echo "Success!" 