# ngrok-aochong

### 在ngrok源码基础上增加自动配置构建脚本

## 安装前准备

+ 外网可以访问的服务器
+ 域名，并解析到该服务器
+ go语言环境
+ git

#### Go安装

##### CentOS

```shell
yum install golang
```

##### macOS

```shell
brew install golang
```

## 安装步骤

### 1. 克隆代码到本地

```shell
git clone https://github.com/AochongZhang/ngrok-aochong.git
```

### 2. 生成证书

```shell
# 生成证书
./GenKey.sh 域名
```

生成的证书保存在keys目录

### 3. 生成可执行程序

```shell
# 生成指定平台服务端
./GenApp.sh 平台名 server

# 生成指定平台客户端
./GenApp.sh 平台名 client

# 生成当前平台服务端
./GenApp.sh server

# 生成当前平台客户端
./GenApp.sh client

# 平台名
linux # linux 64位
arm # linux arm架构, 树莓派、安卓手机等
mac # macOS 64位
win # Windows 64位
```

### 4. 部署服务端

```shell
# 服务端启动命令
生成的服务端 -domain="域名" -httpAddr=":端口" -httpsAddr=":端口"

# 获取帮助信息
生成的服务端 -h
```

#### 服务器开放端口

服务器防火墙需开放以上配置的端口及4443端口(可通过-tunnelAddr参数修改)

### 5. 启动客户端

#### 修改配置文件

ngrok.yml

```yaml
# 服务端地址
server_addr: "ip:端口"
# 是否信任系统根证书
trust_host_root_certs: false
# 本地web调试地址，默认127.0.0.1:4040
# inspect_addr: "0.0.0.0:9999"
tunnels:
  # 服务名
  server1:
    # 可选，指定子域名，不指定默认为服务名
    # subdomain: "example"
    # 可选，指定用户名密码
    # auth: "user:password"
    # 可选，只适用于TCP隧道
    # remote_port: 端口
    proto:
      # 本地端口 http, https, tcp
      http: 8080
```

#### 启动

```shell
# 启动命令
生成的客户端 -config ngrok.yml start 服务名
```

