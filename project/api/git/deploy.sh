 #!/bin/bash

if [ -z $1 ];then
	echo "./deploy.sh PK06_bestboxDB_backend_main_20190927_1443.tar.gz"
	exit 1
fi

current="$(dirname $(readlink -f $0))";
root="/var/test/bestbox3_internet";
echo "current dir ${current}";
echo "root dir ${root}";


if [ -d "./oldbackend_internet" ];then
   rm -rf ./oldbackend_internet;
fi

if [ -d "${root}/backend_internet" ];then
	cp -a ${root}/backend_internet ${current}/oldbackend_internet;
fi

tar -xzf $1
cd ./backend_internet                                          

if [ -d "./storage" ];then
	rm -rf ./storage
fi

if [ -d "${current}/oldbackend_internet" ];then
	cp -p ${current}/oldbackend_internet/.env  ./
fi

if [ -d "${current}/oldbackend_internet/config/" ];then
cp -p ${current}/oldbackend_internet/config/constants.php ./config/
fi

if [ -d "${current}/oldbackend_internet/storage" ];then
    cp -a ${current}/oldbackend_internet/storage  ./
else
    mkdir storage
fi

rm -rf   ./public/storage

chown www-data:www-data -R ./
chmod -R 755 storage

if [ $2 ];then
	rm -rf ${root}/backend_internet;
	mv ${current}/backend_internet ${root};
fi

if [ -d "${HOME}/oldbackend_internet" ];then
	rm -rf ${HOME}/oldbackend_internet
fi


mv ${current}/oldbackend_internet ${HOME}

cd ${root}/backend_internet
/usr/bin/php artisan storage:link

