#!/bin/bash
if [ -z $1 ];then
   echo "video_deploy.sh PK06_bestboxDB_backend_video_20190927_1637.tar.gz"
	exit 1
fi

echo $(dirname $(readlink -f $0))
cd $(dirname $(readlink -f $0))

current="$(dirname $(readlink -f $0))";
root="/var/www/html";

echo "root: ${root}";
echo "current: ${current}";

if [ -d "${current}/oldbackend_video" ]; then
  rm -rf ${current}/oldbackend_video;
fi

mkdir ${current}/oldbackend_video

if [ -d "${root}/oldbackend_video" ]; then
for file in `ls ${root}/backend_video`
do
if [ -d "${root}/backend_video/${file}" ]; then
  if [ "${file}" != "storage" ]; then
    cp -a ${root}/backend_video/${file} ./oldbackend_video/${file}
  fi
else
  cp -f ${root}/backend_video/${file} ./oldbackend_video/${file}
fi
done

echo "backup sucess"
fi

tar -xzf $1

if [ -d "./backend_video/config" ]; then
  rm -rf ./backend_video/config
fi

if [ -d "./backend_video/storage" ]; then
  rm -rf ./backend_video/storage
fi

if [ ! -d "${root}/backend_video" ]; then
  mkdir ${root}/backend_video;
  chown www-data:www-data -R ${root}/backend_video
fi

for file in `ls backend_video`
do
if [ -d "${current}/backend_video/${file}" ]; then
   if [[ "${file}" != "config" ]] && [[ "${file}" != "storage" ]]; then
      cp -a ${current}/backend_video/${file} ${root}/backend_video/${file}
   fi
else
  cp -f ${current}/backend_video/${file} ${root}/backend_video/${file};
  #cp -f ${current}/backend_video/${file} ${root}/backend_video/${file}
fi
done

echo "cp success"

if [ -d "${HOME}/oldbackend_video" ]; then
rm -rf ${HOME}/oldbackend_video
fi

if [ -d "${current}/oldbackend_video" ];then
mv ${current}/oldbackend_video ${HOME};
fi

echo "deploy success"
