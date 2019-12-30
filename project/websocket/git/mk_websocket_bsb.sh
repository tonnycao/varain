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
rm -rf ./backend_websocket
git clone -b master https://192.168.8.61/pi05_bestbox3/backend_internet_websocket.git  ./backend_websocket
cd ./backend_websocket

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

cp -p gitver.txt ./

rm -rf ./.git
rm -f .env.example;
rm -f .gitignore;


find ./ -type d -exec chmod 775 {} \;
find ./ -type f -exec chmod 644 {} \;
cd ..
tar -czf PK06_bestboxDB_backend_websocket_${CURTIME}.tar.gz backend_websocket
md5sum PK06_bestboxDB_backend_websocket_${CURTIME}.tar.gz > md5_backend_websocket_${CURTIME}.txt
