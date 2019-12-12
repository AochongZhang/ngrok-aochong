NGROK_DOMAIN=$1
if [[ $NGROK_DOMAIN == '' ]]; then
	echo "请指定域名"
	exit
fi

echo ======================================================
echo 开始生成证书 域名=$1 

# 生成证书
mkdir keys
# 生成rootCA.key
openssl genrsa -out keys/rootCA.key 2048
# 生成rootCA.pem
openssl req -new -x509 -nodes -key keys/rootCA.key -days 10000 -subj "/CN=$NGROK_DOMAIN" -out keys/rootCA.pem
# 生成device.key
openssl genrsa -out keys/device.key 2048
# 生成device.csr
openssl req -new -key keys/device.key -subj "/CN=$NGROK_DOMAIN" -out keys/device.csr
# 生成device.crt
openssl x509 -req -in keys/device.csr -CA keys/rootCA.pem -CAkey keys/rootCA.key -CAcreateserial -days 10000 -out keys/device.crt

echo 证书生成完毕 保存在keys目录

# 替换证书
cp keys/rootCA.pem assets/client/tls/ngrokroot.crt
cp keys/device.crt assets/server/tls/snakeoil.crt
cp keys/device.key assets/server/tls/snakeoil.key

echo 证书替换完毕
echo ======================================================