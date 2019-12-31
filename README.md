# varain
Fabric Deploy

### Install
pip3 install fabric3


### Using
1. 编写shell 保存到project/git目录下
2. 制作归档包
fab -f payment.py --set env_name=test make_package:git_hashcode
3. 备份(项目部署目录的上传生成一个bak包)
fab -f payment.py --set env_name=test backup
4. 部署
fab -f payment.py --set env_name=test deploy
5. 回滚
fab -f payment.py --set env_name=test rollback
