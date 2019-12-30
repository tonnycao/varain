#!/bin/bash

if [ -z $1 ];then
  echo "payment_deploy.sh PK06_bestboxDB_backend_payment_20190927_1503.tar.gz"
  exit 1
fi



echo $(dirname $(readlink -f $0))
cd $(dirname $(readlink -f $0))

current="$(dirname $(readlink -f $0))";
root="/var/test/bestbox3_internet";
echo "current dir ${current}";
echo "root dir ${root}";

if [ -d "oldweixin_payment" ];then
rm -rf oldweixin_payment;
fi

cp -a ${root}/weixin_payment ${current}/oldweixin_payment
tar -xzf $1

mv backend_payment weixin_payment
cd weixin_payment

if [ -d "config" ];then
rm -rf config;
fi

if [ -d "tests" ];then
rm -rf tests;
fi

if [ -d "doc" ];then
rm -rf doc;
fi

if [ -d "${current}/oldweixin_payment/config" ];then
	cp -a ${current}/oldweixin_payment/config  ./
fi

if [ -d "${current}/oldweixin_payment/storage" ];then
	cp -a ${current}/oldweixin_payment/storage ./
fi

chown www-data:www-data -R ./
chmod -R 750 config

if [ $2 ];then
	rm -rf ${root}/weixin_payment;
	mv ${current}/weixin_payment ${root};
fi

if [ -d "${HOME}/oldweixin_payment" ];then
rm -rf ${HOME}/oldweixin_payment
fi

mv ${current}/oldweixin_payment ${HOME}
