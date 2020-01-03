# varain
Fabric and Shell Deploy

### Install
pip3 install fabric3


### Using
#### 1. 编写shell 保存到project/git目录下
#### 2. 制作归档包
fab -f payment.py --set env_name=test make_package:git_hashcode
#### 3. 备份(项目部署目录的上传生成一个bak包)
fab -f payment.py --set env_name=test backup
#### 4. 下载线上配置文件
fab -f payment.py --set env_name=test download
#### 5. 部署(打包 上传 解压)
fab -f payment.py --set env_name=test deploy
#### 6. 回滚
fab -f payment.py --set env_name=test rollback
#### 7. 模块说明
a. api.py=》backend_internet   
b. payment.py=》backend_payment  
c. websocket.py=》backend_websocket  
d. video.py=》backend_video
e. ip.py =》backend_ip2region   
f. tv.py=》tv web  
g. mobile.py=》mobile web  
