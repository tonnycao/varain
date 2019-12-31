import sys
from fabric.api import *
from config.config import *

#fab --set env_name=dev make_package:2e87903ef86dfc14358cf35f8e8bc41a95ee4131

env_name = 'dev'
pro_name = 'api'
parameters = []
host_info = REMOTE_HOSTS[env.env_name]
env.hosts = host_info.get('host')
env.port = host_info.get('port')
env.user = host_info.get('user')
env.password = host_info.get('password')
exclude_files = EXCLUDE_FILES[pro_name]
host_info = host_info

git_path = ("%s/project/%s/git" % (sys.path[0], pro_name))
remote_path = REMOTE_PATH[env_name][pro_name]
local_path = git_path + '/' + PRO_DIR_MAP[pro_name]
pro_name_dir = PRO_DIR_MAP[pro_name]

'''
制作归档包tar
'''
def make_package(version):
    cmd = 'sh ' + git_path + '/mk_dev_main_bsb.sh ' + version
    local(command=cmd)


'''
下载排除文件
'''
def download():
    remote_dir = remote_path
    local_dir = local_path
    for file in exclude_files:
        get(remote_path=remote_dir + "/" + file, local_path=local_dir + "/" + file)


'''
打包
'''


def tar():
    target_dir = local_path
    name = pro_name_dir + '.tar'
    local("tar -cf " + name + " " + target_dir)


'''
解包
'''
def untar( name):
    local("tar -xf " + name)


'''
上传文件
'''
def upload():
    local_paths = local_path + '/' + pro_name_dir + '.tar'
    remote_paths = remote_path
    put(local_path=local_paths, remote_path=remote_paths)


'''
执行远程命令
'''


def myrun():
    lcd(remote_path)
    run("tar -xf " + pro_name_dir + '.tar')


'''
备份
'''


def backup(self):
    pass


'''
回滚
'''


def rollback():
    pass


'''
部署
'''
def deploy():
    download()
    tar()
    upload()
    myrun()