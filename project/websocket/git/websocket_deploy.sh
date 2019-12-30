#!/bin/bash

if [ -z $1 ];then
   echo "websocket_deploy.sh PK06_bestboxDB_backend_websocket_20190927_1127.tar.gz"
	exit 1
fi

echo $(dirname $(readlink -f $0))
cd $(dirname $(readlink -f $0))

current="$(dirname $(readlink -f $0))";
root="/var/test/bestbox3_internet";
echo "current dir ${current}";
echo "root dir ${root}";

if [ -d "oldbackend_internet_websocket" ];then
	rm -rf oldbackend_internet_websocket
fi

mv ${root}/backend_internet_websocket oldbackend_internet_websocket

if [ -d "${current}/backend_websocket" ];then
   rm -rf ${current}/backend_websocket
fi

tar -xzf $1
mv backend_websocket backend_internet_websocket
cd ./backend_internet_websocket

if [ -d "storage" ];then
	rm -rf storage
fi

if [ -d "runtime" ];then
	rm -rf runtime
fi

if [ -f .env ];then
	rm -rf .env
fi

if [ -d "${current}/oldbackend_internet_websocket/storage" ];then
	cp -a ${current}/oldbackend_internet_websocket/storage  ./ ;
else
	mkdir storage;
fi

if [ -d "${current}/oldbackend_internet_websocket/runtime" ];then
	cp -a ${current}/oldbackend_internet_websocket/runtime ./ ;
else
	mkdir runtime;
fi

if [ -f "${current}/oldbackend_internet_websocket/.env" ];then
  cp ${current}/oldbackend_internet_websocket/.env ./.env
fi

chown www-data:www-data -R ./
chmod -R 755 storage
chmod -R 755 runtime

if [ $2 ];then
	rm -rf ${root}/backend_internet_websocket;
	mv ${current}/backend_internet_websocket ${root};
fi

if [ -d "${HOME}/oldbackend_internet_websocket" ];then
	rm -rf ${HOME}/oldbackend_internet_websocket;
fi

mv ${current}/oldbackend_internet_websocket ${HOME}

