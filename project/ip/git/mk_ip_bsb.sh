if [ -z $1 ]
	then
	echo 'Usage:    git version'
	echo './mk_ip_bsb.sh 3657547065089601dae61f8e60f8c3119d44b8d3'
	exit 1
fi

if [ $2 ]
  then
  echo 'Usage: too many parameter'
  echo './mk_ip_bsb.sh 3657547065089601dae61f8e60f8c3119d44b8d3'
  exit 1
fi

CURTIME=`date +%Y%m%d_%H%M`
export GIT_SSL_NO_VERIFY=1
current="$(dirname $(readlink -f $0))"
echo "work dir is: ${current}"
if [ -d "${current}/backend_ip2region"]
then
rm -rf ${current}/backend_ip2region
fi

git clone -b master https://192.168.8.61/pi05_bestbox3/backend_ip2region.git  ${current}/backend_ip2region
cd ${current}/backend_ip2region

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

if [ -d "${current}/backend_ip2region/storage" ]
then
	rm -rf ${current}/backend_ip2region/storage
fi

if [ -d "${current}/backend_ip2region/.git" ]
then
    rm -rf ${current}/backend_ip2region/.git
fi

if [ -f "${current}/backend_ip2region/.env.example" ]
then
    rm -f ${current}/backend_ip2region/.env.example
fi

if [ -f "${current}/backend_ip2region/.gitignore" ]
then
    rm -f ${current}/backend_ip2region/.gitignore
fi

if [ -f "${current}/backend_ip2region/.gitattributes" ]
then
    rm -f ${current}/backend_ip2region/.gitattributes
fi

if [ -f "${current}/backend_ip2region/up-rewrite.conf" ]
then
    rm -f ${current}/backend_ip2region/up-rewrite.conf
fi

if [ -f "${current}/backend_ip2region/public/.gitignore" ]
then
    rm -f ${current}/backend_ip2region/public/.gitignore
fi

if [ -f "${current}/backend_ip2region/public/u.php" ]
then
    rm -f ${current}/backend_ip2region/public/u.php
fi

if [ -f "${current}/backend_ip2region/public/up-rewrite.conf" ]
then
    rm -f ${current}/backend_ip2region/public/up-rewrite.conf
fi

if [ -f "${current}/backend_ip2region/public/web.config" ]
then
    rm -f ${current}/backend_ip2region/public/web.config
fi

cd ./..

tar -czf ${current}/PK06_bestboxDB_backend_ip2region_${CURTIME}.tar.gz ${current}/backend_ip2region
md5sum ${current}/PK06_bestboxDB_backend_ip2region_${CURTIME}.tar.gz > ${current}/md5_backend_ip2region_${CURTIME}.txt



