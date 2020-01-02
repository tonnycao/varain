# -*- coding: utf-8 -*-
# @Time    : 2019/12/30 15:39
# @Author  : Tonny Cao
# @Email   : 647812411@qq.com
# @File    : payment.py
# @Software: PyCharm

import sys
from fabric.api import *
from config.config import *

env_name = 'dev'
pro_name = 'payment'
parameters = []
host_info = REMOTE_HOSTS[env.env_name]
env.hosts = host_info.get('host')
env.port = host_info.get('port')
env.user = host_info.get('user')
env.password = host_info.get('password')
exclude_files = EXCLUDE_FILES[pro_name]
host_info = host_info

git_path = ("%s/project/%s/git" % (sys.path[0], pro_name))
remote_path = REMOTE_PATH[env.env_name][pro_name]
local_path = git_path + '/' + PRO_DIR_MAP[pro_name]
pro_name_dir = PRO_DIR_MAP[pro_name]


def make_package(version):
    '''
    制作归档包tar
    '''
    cmd = 'sh ' + git_path + '/mk_dev_payment_bsb.sh ' + version
    local(command=cmd)


def download():
    '''
    下载排除文件
    '''
    remote_dir = remote_path
    local_dir = local_path
    for file in exclude_files:
        get(remote_path=remote_dir + "/" + file, local_path=local_dir + "/" + file)


def tar():
    '''
    打包
    '''
    target_dir = local_path
    name = pro_name_dir + '.tar'
    local("cd "+target_dir+" && tar -cf " + name + " *")


def untar( name):
    '''
    解包
    '''
    local("tar -xf " + name)


def remote_untar():
    '''
    远程解压
    '''
    file = pro_name_dir + '.tar'
    run("cd " + remote_path + " && tar -xf " + file)
    run("cd " + remote_path + " && rm -rf " + file)


def upload():
    '''
    上传文件
    '''
    local_paths = local_path + '/' + pro_name_dir + '.tar'
    remote_paths = remote_path
    put(local_path=local_paths, remote_path=remote_paths)


def backup():
    '''
    备份
    '''
    name = pro_name_dir + '_bak.tar'
    dir_list = remote_path.split('/')
    del dir_list[len(dir_list)-1]
    target_dir = '/'.join(dir_list)
    run("cd " + remote_path + " && tar -cf " + name + " *")
    run("cd " + remote_path + " && mv " + name + " " + target_dir)


def rollback():
    '''
   回滚
   '''
    name = pro_name_dir + '_bak.tar'
    dir_list = remote_path.split('/')
    del dir_list[len(dir_list) - 1]
    source_dir = '/'.join(dir_list)
    run("cd " + source_dir + " && mv " + name + " "+remote_path)
    run("cd "+remote_path + " && tar -xf " + name)


def deploy():
    '''
    部署
    '''
    download()
    tar()
    upload()
    remote_untar()