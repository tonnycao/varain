if [ -z $1 ]
	then
	echo 'Usage:    git version'
	echo './mk_payment_bsb.sh 3657547065089601dae61f8e60f8c3119d44b8d3'		
	exit 1
fi

if [ $2 ]
  then
  echo 'Usage: too many parameter'
  echo './mk_payment_bsb.sh 3657547065089601dae61f8e60f8c3119d44b8d3'      
  exit 1
fi




CURTIME=`date +%Y%m%d_%H%M`
export GIT_SSL_NO_VERIFY=1
if [ -d "${current}/weixin_payment"]
then
rm -rf ${current}/weixin_payment
fi

git clone -b master https://192.168.8.61/pi05_bestbox3/backend_payment.git  ${current}/weixin_payment
cd ${current}/weixin_payment


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

if [ -d "${current}/weixin_payment/storage" ];then
	rm -rf ${current}/weixin_payment/storage;
fi

if [ -d "${current}/weixin_payment/.git" ];then
rm -rf ${current}/weixin_payment/.git;
fi

if [ -f "${current}/weixin_payment/.env.example" ];then
rm -f ${current}/weixin_payment/.env.example;
fi

if [ -f "${current}/weixin_payment/.gitignore" ];then
rm -f ${current}/weixin_payment/.gitignore;
fi

if [ -f "${current}/weixin_payment/.gitattributes" ];then
rm -f ${current}/weixin_payment/.gitattributes;
fi

if [ -f "${current}/weixin_payment/up-rewrite.conf" ];then
rm -f ${current}/weixin_payment/up-rewrite.conf;
fi

if [ -f "${current}/weixin_payment/public/.gitignore" ];then
rm -f ${current}/weixin_payment/public/.gitignore;
fi

if [ -f "${current}/weixin_payment/public/u.php" ];then
rm -f ${current}/weixin_payment/public/u.php;
fi

if [ -f "${current}/weixin_payment/public/up-rewrite.conf" ];then
rm -f ${current}/weixin_payment/public/up-rewrite.conf;
fi

if [ -f "${current}/weixin_payment/public/web.config" ];then
rm -f ${current}/weixin_payment/public/web.config;
fi

find ./ -type d -exec chmod 775 {} \;
find ./ -type f -exec chmod 644 {} \;
cd ..
tar -czf PK06_bestboxDB_backend_payment_${CURTIME}.tar.gz weixin_payment
md5sum PK06_bestboxDB_backend_payment_${CURTIME}.tar.gz > md5_backend_payment_${CURTIME}.txt



