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

#### 科学上网

## 安装步骤

### 1. 克隆代码到本地

```shell
git clone https://github.com/AochongZhang/ngrok-aochong.git
```

### 2. 生成证书

使用在此之前, 建立一个字域名解析到你的服务器

例: ngrok.xxx.com 和 *.ngrok.xxx.com 都解析到你的服务器ip

```shell
./GenKey.sh ngrok.xxx.com
```

生成的证书保存在keys目录

### 3. 生成可执行程序

```shell
# 系统: linux darwin windows
# 生成服务端
GOOS=系统 GOARCH=amd64 make release-server
# 生成客户端
GOOS=系统 GOARCH=amd64 make release-client
```

生成的可执行程序保存在bin目录中

### 4. 部署服务端

将keys中的server.key和server.crt同服务端可执行程序一同上传到服务器

```shell
# 服务端启动命令
生成的服务端 -tlsKey=server.key -tlsCrt=server.crt -domain="域名" -httpAddr=":端口" -httpsAddr=":端口"
```

#### 服务器开放端口

服务器防火墙需开放以上配置的端口及4443端口

### 5. 启动客户端

```shell
# 生成配置文件
./GenConf.sh 域名

# 启动命令 字域名例: xx.ngrok.xxx.com 端口为服务端配置的端口
ngrok -config=ngrok.cfg -log=ngrok.log -subdomain=子域名 端口
```

