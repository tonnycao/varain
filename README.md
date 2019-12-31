# varain
Fabric Deploy

### Install
pip3 install fabric3


### Using
1. 制作归档包
fab --set env_name=test make_package:git_hashcode
2. 部署
fab --set env_name=test deploy 
