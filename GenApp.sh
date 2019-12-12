name=$1
app=$2

goos=""
goarch=""

if [[ $name == "linux" ]]; then
	$goos="linux"
	$goarch=amd64
elif [[ $name == "arm" ]]; then
	goos=linux
	goarch=arm
elif [[ $name == "mac" ]]; then
	goos=darwin
	goarch=amd64
elif [[ $name == "win" ]]; then
	goos=windows
	goarch=amd64
elif [[ $name == "server" ]]; then
	name="当前"
	app="server"
elif [[ $name == "client" ]]; then
	name="当前"
	app="client"
else
	name="当前"
fi

if [[ $app == "" ]]; then
	app="server"
fi

echo ======================================================
echo "开始生成${name}平台${app}端 >>>>>"

if [[ $app == "server" ]]; then
	echo 执行生成命令 "GOOS="$goos" GOARCH="$goarch" release-server"
	GOOS=$goos GOARCH=$goarch make release-server
else
	echo 执行生成命令 "GOOS="$goos" GOARCH="$goarch" release-client"
	GOOS=$goos GOARCH=$goarch make release-client
fi

echo 生成完毕 保存在bin目录中
echo ======================================================