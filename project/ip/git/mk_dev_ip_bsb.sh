if [ -z $1 ]
	then
	echo 'Usage:    git version'
	echo './mk_dev_ip_bsb.sh 3657547065089601dae61f8e60f8c3119d44b8d3'
	exit 1
fi

if [ $2 ]
  then
  echo 'Usage: too many parameter'
  echo './mk_dev_ip_bsb.sh 3657547065089601dae61f8e60f8c3119d44b8d3'
  exit 1
fi

CURTIME=`date +%Y%m%d_%H%M`
export GIT_SSL_NO_VERIFY=1
current="$(dirname $(readlink -f $0))"
echo "work dir is: ${current}"
rm -rf ${current}/backend_ip2region
git clone -b dev https://192.168.8.61/pi05_bestbox3/backend_ip2region.git  ${current}/backend_ip2region
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

if [ -d "storage" ]
then
	rm -rf storage
fi

if [ -d ".git" ]
then
    rm -rf .git
fi

if [ -f ".env.example" ]
then
    rm -f .env.example
fi

if [ -f ".gitignore" ]
then
    rm -f .gitignore
fi

if [ -f ".gitattributes" ]
then
    rm -f .gitattributes
fi

if [ -f "up-rewrite.conf" ]
then
    rm -f up-rewrite.conf
fi

if [ -f "public/.gitignore" ]
then
    rm -f public/.gitignore
fi

if [ -f "public/u.php" ]
then
    rm -f public/u.php
fi

if [ -f "public/up-rewrite.conf" ]
then
    rm -f public/up-rewrite.conf
fi

if [ -f "public/web.config" ]
then
    rm -f public/web.config
fi

cd ./..

tar -czf ${current}/PK06_bestboxDB_backend_ip2region_${CURTIME}.tar.gz ${current}/backend_ip2region
md5sum ${current}/PK06_bestboxDB_backend_ip2region_${CURTIME}.tar.gz > ${current}/md5_backend_ip2region_${CURTIME}.txt



