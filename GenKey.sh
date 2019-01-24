NGROK_DOMAIN=$1
# 生成证书
echo 开始生成证书 域名=$1
mkdir keys
openssl genrsa -out keys/base.key 2048
openssl req -new -x509 -nodes -key keys/base.key -days 10000 -subj "/CN=ngrok.k8s.kim" -out keys/base.pem
openssl genrsa -out keys/server.key 2048
openssl req -new -key keys/server.key -subj "/CN=ngrok.k8s.kim" -out keys/server.csr
openssl x509 -req -in keys/server.csr -CA keys/base.pem -CAkey keys/base.key -CAcreateserial -days 10000 -out keys/server.crt

# 替换证书
cp keys/base.pem assets/client/tls/ngrokroot.crt

echo 证书生成完毕 保存在keys目录