if [ -z $1 ]
	then
	echo 'Usage:    git version'
	echo './mk_dev_websocket_bsb.sh ce0a7ed3bf964149f186bcc50e6b05b45d01275b'		
	exit 1
fi

if [ $2 ]
  then
  echo 'Usage: too many parameter'
  echo './mk_dev_websocket_bsb.sh ce0a7ed3bf964149f186bcc50e6b05b45d01275b'      
  exit 1
fi


CURTIME=`date +%Y%m%d_%H%M`
export GIT_SSL_NO_VERIFY=1

current="$(dirname $(readlink -f $0))"
echo "work dir is: ${current}"


if [ -d "${current}/backend_internet_websocket" ]
then
rm -rf ${current}/backend_internet_websocket
fi


git clone -b dev https://192.168.8.61/pi05_bestbox3/backend_internet_websocket.git  ${current}/backend_internet_websocket
cd ${current}/backend_internet_websocket

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
echo "tar package please waiting..."
#cp -p gitver.txt ./

if [ -d "${current}/backend_internet_websocket/.git" ];
then
rm -rf ${current}/backend_internet_websocket/.git;
fi

if [ -f "${current}/backend_internet_websocket/.env" ];
then
rm -f ${current}/backend_internet_websocket/.env;
fi

if [ -f "${current}/backend_internet_websocket/.env.example" ];
then
rm -f ${current}/backend_internet_websocket/.env.example;
fi

if [ -f "${current}/backend_internet_websocket/.gitignore" ];
then
rm -f ${current}/backend_internet_websocket/.gitignore;
fi

if [ -f "${current}/backend_internet_websocket/.gitattributes" ];
then
rm -f ${current}/backend_internet_websocket/.gitattributes;
fi


find ./ -type d -exec chmod 775 {} \;
find ./ -type f -exec chmod 644 {} \;
cd ..
tar -czf PK06_bestboxDB_backend_websocket_${CURTIME}.tar.gz backend_websocket
md5sum PK06_bestboxDB_backend_websocket_${CURTIME}.tar.gz > md5_backend_websocket_${CURTIME}.txt 



