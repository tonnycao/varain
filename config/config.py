# -*- coding: utf-8 -*-
# @Time    : 2019/12/30 11:39
# @Author  : Tonny Cao
# @Email   : 647812411@qq.com
# @File    : config.py
# @Software: PyCharm

import os
import sys

base_path = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, base_path)

# DATA_PATH获取数据的保存路径
DATA_PATH = os.path.join(base_path, 'data')
# 日志文件路径
LOG_PATH = os.path.join(base_path, 'log')
PROJECT_PATH = os.path.join(base_path, 'project')

# git仓库地址
GIT_URL_MAPS = {
     'api': 'https://192.168.8.61/pi05_bestbox3/backend_inernet.git',
     'payment': '',
     'video': '',
     'websocket': '',
     'tv': '',
     'mobile': ''
}

# host信息
REMOTE_HOSTS = {
     'dev': {
          'host': '192.168.8.62',
          'port': 22,
          'user': 'web',
          'password': 'web'
     },
     'test': {
          'host': '',
          'port': 22,
          'user': '',
          'password': ''
     },
     'prod': {
          'host': '',
          'port': 22,
          'user': '',
          'password': ''
     }
}

# 项目远程目录
REMOTE_PATH = {
     'prod': {
          'api': '/var/www/bestbox3_internet/backend_internet',
          'payment': '/var/www/weixin_payment',
          'websocket':  '/var/www/bestbox3_internet/backend_internet_websocket',
          'video': '',
          'ip': '/var/www/bestbox3_internet/backend_ip2region',
          'tv': '',
          'mobile': ''
     },
     'test': {
          'api': '',
          'payment': '',
          'websocket':  '',
          'video': '',
          'ip': '',
          'tv': '',
          'mobile': ''
     },
     'dev': {
          'api': '',
          'payment': '',
          'websocket':  '',
          'video': '',
          'ip': '',
          'tv': '',
          'mobile': ''
     }
}

# git 默认分支
DEFAULT_GIT_BRANCH = 'dev'

# 部署排除文件

EXCLUDE_FILES = {
     'api': ['.env', 'config/constants.php'],
     'payment': ['config/config.json'],
     'websocket': ['.env'],
     'video': ['config/config.json'],
     'ip': ['config/config.json'],
     'tv': [],
     'mobile': []
}
PRO_DIR_MAP = {
     'api':  'backend_internet',
     'payment': 'weixin_payment',
     'websocket': 'backend_internet_websocket',
     'video': 'backend_video',
     'ip': 'backend_ip2region',
     'tv': '',
     'mobile': ''
}