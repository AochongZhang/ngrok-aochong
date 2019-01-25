# ngrok-aochong

### 在ngrok源码基础上增加自动配置构建脚本

## 安装前环境

#### 一台有公网ip的服务器

#### go语言环境

##### CentOS

```shell
yum install -y golang
```

##### macOS

```shell
brew install golang
```

#### git

## 安装步骤

### 1. 克隆代码到本地

```shell
git clone https://github.com/AochongZhang/ngrok-aochong.git
```

### 2. 生成证书

使用在此之前, 建立一个字域名解析到你的服务器

例: ngrok.xxx.com 和 *.ngrok.xxx.com 都解析到你的服务器ip

```shell
# 生成证书
./GenKey.sh ngrok.xxx.com
```

生成的证书保存在keys目录

### 3. 生成可执行程序

```shell
# 生成指定平台服务端
./GenApp.sh 平台名 serever

# 生成指定平台客户端
./GenApp.sh 平台名 client
# 或
./GenApp.sh 平台名

# 生成当前平台服务端
./GenApp.sh serever

# 生成当前平台客户端
./GenApp.sh client
# 或
./GenApp.sh

# 平台名
linux # linux 64位
arm # linux arm架构, 树莓派、安卓手机等
mac # macOS 64位
windows # Windows 64位
```

### 4. 部署服务端

将keys中的server.key和server.crt同服务端可执行程序一同上传到服务器

```shell
# 服务端启动命令
生成的服务端 -tlsKey=server.key -tlsCrt=server.crt -domain="域名" -httpAddr=":端口" -httpsAddr=":端口"
```

#### 服务器开放端口

服务器防火墙需开放以上配置的端口及4443端口

### 5. 启动客户端

#### 修改配置文件

ngrok.yml

<<<<<<< HEAD
```yaml
server_addr: 域名:4443
trust_host_root_certs: false
# tunnels:
#  服务名:
#    remote_port: 远端端口
#    proto:
#      tcp: 本地端口
```

#### 启动

```shell
# 启动命令
生成的客户端 -config ngrok.yml start 服务名
=======
# 启动命令
ngrok -config=ngrok.cfg -log=ngrok.log -subdomain=子域名 端口
>>>>>>> origin/master
```

