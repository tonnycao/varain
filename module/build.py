# -*- coding: utf-8 -*-
# @Time    : 2019/12/30 11:12
# @Author  : Tonny Cao
# @Email   : 647812411@qq.com
# @File    : build.py
# @Software: PyCharm
import sys
import os


class BUILD(object):
    def __init__(self, pro_name, env_name):
        self.pro_name = pro_name
        self.env_name = env_name
        self.svn_path = ("%s/project/%s/svn" % (sys.path[0], self.pro_name))

    def Maven_Build(self):
        self.command = str("cd %s; mvn clean package -P%s -Dmaven.test.skip=true" % (
            self.svn_path, self.env_name)
        )

        try:
            print("\nStart maven build in webapp.\n")
            self.result = os.system(self.command)
            assert self.result == 0
        except AssertionError:
            print("\nMvn build error!\n")
            sys.exit()  # 异常退出，这个再模块中非常重要


