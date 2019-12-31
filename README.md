# varain
Fabric Deploy

### Install
pip3 install fabric3


### Using
1. 制作归档包
fab --set env_name=test make_package:git_hashcode
2. 备份(项目部署目录的上传生成一个bak包)
fab --set env_name=test backup
3. 部署
fab --set env_name=test deploy
4. 回滚
 fab --set env_name=test rollback
