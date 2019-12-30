# -*- coding: utf-8 -*-
# @Time    : 2019/12/30 11:35
# @Author  : Tonny Cao
# @Email   : 647812411@qq.com
# @File    : api.py
# @Software: PyCharm

import sys
import os
from fabric.api import *
from config.config import *


class Api(object):

    def __init__(self, pro_name, env_name, hashcode):
        host_info = REMOTE_HOSTS[env_name]
        env.host = host_info.get('host')
        env.port = host_info.get('port')
        env.user = host_info.get('user')
        env.password = host_info.get('password')
        self.exclude_files = EXCLUDE_FILES[pro_name]
        self.host_info = host_info
        self.pro_name = pro_name
        self.env_name = env_name
        self.git_path = ("%s/project/%s/git" % (sys.path[0], self.pro_name))
        self.version = hashcode
        self.remote_path = REMOTE_PATH[env_name][pro_name]
        self.local_path = self.git_path + '/' + PRO_DIR_MAP[pro_name]
        self.pro_name_dir = PRO_DIR_MAP[pro_name]

    '''
    制作归档包tar
    '''
    def make_package(self):
        cmd = 'sh ' + self.git_path + 'mk_dev_main_bsb.sh ' + self.version
        local(command=cmd)

    '''
    下载排除文件
    '''
    def download(self):
        exclude_files = self.exclude_files
        remote_dir = self.remote_path
        local_dir = self.local_path
        for file in exclude_files:
            get(remote_path=remote_dir + "/" + file, local_path=local_dir + "/" + file)

    '''
    打包
    '''
    def tar(self):
        target_dir = self.local_path
        name = self.pro_name_dir + '.tar'
        local("tar -cf " + name + " " + target_dir)
    '''
    解包
    '''
    def untar(self, name):
        local("tar -xf " + name)

    '''
    上传文件
    '''
    def upload(self):
        local_path = self.local_path + '/' + self.pro_name_dir + '.tar'
        remote_path = self.remote_path
        put(local_path=local_path, remote_path=remote_path)

    '''
    执行远程命令
    '''
    def myrun(self):
        lcd(self.remote_path)
        run("tar -xf " + self.pro_name_dir + '.tar')

    '''
    备份
    '''
    def backup(self):
        pass

    '''
    回滚
    '''
    def rollback(self):
        pass

    '''
    部署
    '''
    def deploy(self):
        self.download()
        self.upload()
        self.myrun()

