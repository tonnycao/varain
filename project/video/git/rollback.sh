#!/usr/bin/env bash

if [ -z $1 ]
	then
	echo 'Usage: backup tar is empty'
	echo './rollback.sh backup_dir target_dir'		
	exit 1
fi

if [ -z $2 ]
  then
  echo 'Usage: target dir is empty'
  echo './rollback.sh backup_dir target_dir'      
  exit 1
fi

current="$(dirname $(readlink -f $0))"
backup_tar="${1}"
target_dir="${2}"

if [ ! -d "${backup_tar}" ]
then
  echo "backup tar is not exist"
  exit 1
fi

if [ ! -d "${target_dir}" ]
then
  echo "target dir is not exist"
  exit 1
fi

echo $(dirname $(readlink -f $0))
cd $(dirname $(readlink -f $0))

echo "start rollback..."

mv  ${backup_tar} ${target_dir}
cd ${target_dir}
tar -xf backend_video.tar 
echo "rollback success"


