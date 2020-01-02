#!/usr/bin/env bash

echo $(dirname $(readlink -f $0))
cd $(dirname $(readlink -f $0))

current="$(dirname $(readlink -f $0))";
root="/var/www/html";

if [ -d "${current}/oldbackend_video" ]; then
  rm -rf ${current}/oldbackend_video;
fi

mkdir ${current}/oldbackend_video

if [ -d "${root}/backend_video" ]; then
for file in `ls ${root}/backend_video`
do
if [ -d "${root}/backend_video/${file}" ]; then
  if [ "${file}" != "storage" ]; then
    cp -a ${root}/backend_video/${file} ${current}/oldbackend_video/${file}
  fi
else
  cp -f ${root}/backend_video/${file} ${current}/oldbackend_video/${file}
fi
done

echo "backup success"
fi



