# -*- coding: utf-8 -*-
# @Time    : 2019/12/27 14:02
# @Author  : Tonny Cao
# @Email   : 647812411@qq.com
# @File    : fabfile.py
# @Software: backend_payment

import tarfile
import os
import time
from fabric.api import *
from fabric.contrib.console import confirm
from fabric.utils import abort
from fabric.colors import *

#线上环境
env.hosts = ['192.168.8.62']
env.port = 22
env.user = 'web'
env.password = 'web'

REMOTE_ROOT_DIR = '/home/wwwroot/weixin_payment'
LOCAL_ROOT_DIR = 'D:/project/2019/deploy'
CONFIG = ['config/config.json', 'config/private_key.pem', 'config/public_key.pem']
TAR_NAME = 'backend_payment.tar'
TARGET_NAME = 'weixin_payment'

def download():
    '''
    下载文件
    :param file:
    :return:
    '''
    for file in CONFIG:
        get(remote_path=REMOTE_ROOT_DIR+"/"+file, local_path=LOCAL_ROOT_DIR)


def upload(file):
    '''
    上传文件
    :param file:
    :return:
    '''
    put(local_path=LOCAL_ROOT_DIR+"/"+file, remote_path=REMOTE_ROOT_DIR)


def tar(dir, name):
    target_dir = LOCAL_ROOT_DIR + "/" + dir
    local("tar -cf " + name + " " + target_dir)


def untar(dir, name):
    target_dir = LOCAL_ROOT_DIR + "/" + dir
    local("tar -xf " + name + " " + target_dir)


def tar_win(dir, name):
    '''
    本地压缩包linux环境
    :param dir:
    :param name:
    :return:
    '''
    target_dir = LOCAL_ROOT_DIR + "/" + dir
    try:
        with tarfile.open(name+".tar.gz", "w:gz") as tar:
            tar.add(target_dir, arcname=os.path.basename(target_dir))
        return True
    except Exception as e:
        print(e)
        return False


def untar_win(fname, dir):
    target_dir = LOCAL_ROOT_DIR + "/" + dir
    try:
        t = tarfile.open(fname)
        t.extractall(path=target_dir)
        return True
    except Exception as e:
        print(e)
        return False


def mk_package(branch, dir):
    fullpath = LOCAL_ROOT_DIR+'/'+dir
    local('git clone -b '+branch+' https://192.168.8.61/pi05_bestbox3/backend_payment.git  ' + fullpath)
    lcd(fullpath)
    local('git log -1 > gitver.txt')
    local('rm -rf .git')
    local('rm -rf storage')
    local('rm -f .env.example')
    local('rm -f .gitignore')
    local('rm -f .gitattributes')


def deploy():
    pass


def main():
    #解压shell脚本打包的文件
    untar()
    #下载线上环境的一些配置文件
    download()
    #打包文件
    tar()
    #上传压缩文件
    upload()
    #部署项目远程执行一些命令
    deploy()


