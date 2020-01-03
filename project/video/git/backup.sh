#!/usr/bin/env bash

if [ -z $1 ]
	then
	echo 'Usage: source dir is empty'
	echo './backup.sh source_dir backup_dir'		
	exit 1
fi

if [ -z $2 ]
  then
  echo 'Usage: backup dir is empty'
  echo './backup.sh source_dir backup_dir'      
  exit 1
fi

echo "work dir is $(dirname $(readlink -f $0))" 
cd $(dirname $(readlink -f $0))

current="$(dirname $(readlink -f $0))"
source_dir="${1}"
backup_dir="${2}"

if [ ! -d "${backup_dir}" ]
then
  echo "backup dir is not exist"
  exit 1
fi

if [ ! -d "${source_dir}" ]
then
  echo "source dir is not exist"
  exit 1
fi


if [ -d "${backup_dir}/backend_video" ]
then
  rm -rf ${backup_dir}/backend_video;
fi

mkdir ${backup_dir}/backend_video

if [ -d "${source_dir}/backend_video" ]
then
for file in `ls ${source_dir}/backend_video`
do
if [ -d "${source_dir}/backend_video/${file}" ]; then
  if [ "${file}" != "storage" ]; then
    cp -a ${source_dir}/backend_video/${file} ${backup_dir}/backend_video/${file}
  fi
else
  cp -f ${source_dir}/backend_video/${file} ${backup_dir}/backend_video/${file}
fi
done
tar -cf ${backup_dir}/backend_video/backend_video.tar *
echo "backup success"
else 
echo "backup fail"
fi




