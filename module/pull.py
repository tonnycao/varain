# -*- coding: utf-8 -*-
# @Time    : 2019/12/30 11:15
# @Author  : Tonny Cao
# @Email   : 647812411@qq.com
# @File    : pull.py
# @Software: PyCharm
import sys
import os
from fabric.api import *


class PULL(object):
    def __init__(self, pro_name, env_name, hashcode):
        self.pro_name = pro_name
        self.env_name = env_name
        self.git_path = ("%s/project/%s/git" % (sys.path[0], self.pro_name))
        self.version = hashcode

    def make_package(self):
        cmd = 'sh ' + self.git_path + 'mk_dev_main_bsb.sh '+self.version
        local(command=cmd)
