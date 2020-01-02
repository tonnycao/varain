#!/usr/bin/env bash

echo $(dirname $(readlink -f $0))
cd $(dirname $(readlink -f $0))

current="$(dirname $(readlink -f $0))";
root="/var/www/html";
target=""
echo "start rollback..."

if [ ! -d "${target}/oldbackend_video" ]; then
   echo "no backup files"
   exit 1
fi

# mkdir ${current}/oldbackend_video

if [ -d "${target}/oldbackend_video" ]; then
for file in `ls ${target}/oldbackend_video`
do
if [ -d "${target}/oldbackend_video/${file}" ]; then
  if [ "${file}" != "storage" ]; then
    cp -a ${target}/oldbackend_video/${file} ${root}/backend_video/${file}
  fi
else
  cp -f ${target}/oldbackend_video/${file} ${root}/backend_video/${file}
fi
done

echo "rollback success"
fi


