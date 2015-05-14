#!/bin/bash

#   $1是文件或文件夹为空退出
#   $2是项目名称，缺省为goapk
#   $3是测试trunk分支或上线branch分支，缺省为测试trunk分支

if [ -z $1 ];then
    echo 第一个参数是文件或文件夹，不能为空
    exit
fi
if [[ ! -f $1 && ! -d $1 ]]; then
    echo 文件或文件夹不存在
    exit
fi
IS_DIR=false
IS_FILE=false
if [ -f $1 ]; then
    IS_FILE=true
fi
if [ -d $1 ]; then
    IS_DIR=true
fi

if [[ $IS_FILE == true ]]; then
    echo 这是文件
fi
if [[ $IS_DIR == true ]]; then
    echo 这是文件夹
fi

if [ -z $2 ]; then
    if [ -z $3 ]; then
        PROJECT=goapk/trunk
        RELEASE_DIR=/data/www/wwwroot/new-wwwroot/$1/
    else
        PROJECT=goapk/branches/release
        RELEASE_DIR=/data/www/wwwroot/new-wwwroot/$1/
    fi
fi
PREFIX="/home/jimmychou/workspace/$PROJECT/"
#PREFIX='~/workspace/goapk/trunk/'   #   this    is  not ok
DATA=$PREFIX$1

<<NOEFFECT

cd $DATA
echo $DATA
DIFF=`svn st`
echo $DIFF
if [ -e $DATA ];then
    echo 开始同步文件
else
    echo 文件或文件夹不存在
    exit
fi
echo 'DATA is '$DATA AND '$1 is ' $1
exit

NOEFFECT

#rsync -avH --progress '-e ssh -p 59878' $1 zhouxiaomin@192.168.1.134:/home/zhouxiaomin/$1
#rsync -avH --progress '-e ssh -p 59878' $DATA zhouxiaomin@192.168.1.134:/home/zhouxiaomin/$1
#rsync -avHc --progress '-e ssh -p 59878' $DATA zhouxiaomin@192.168.1.134:/home/zhouxiaomin/
#rsync -avHc --exclude='.svn/' --progress '-e ssh -p 59878' $DATA zhouxiaomin@192.168.1.134:/home/zhouxiaomin/

cd $PREFIX
#rsync -avHcR --exclude-from=exclude_goapk.txt --progress '-e ssh -p 59878' $DATA zhouxiaomin@192.168.1.134:/home/zhouxiaomin/
#   全路径会把  home    目录也算进去
rsync -avHcR --exclude-from=exclude_goapk.txt --progress '-e ssh -p 59878' $1 zhouxiaomin@192.168.1.134:/home/zhouxiaomin/

#   -R   参数包括路径复制
#-a, --archive 归档模式，表示以递归方式传输文件，并保持所有文件属性，等于-rlptgoD
#ssh -p 59878 zhouxiaomin@192.168.1.134 "sudo cp service_restart.sh /data/www/"

echo 复制到 zhouxiaomin 目录完成
if [[ $IS_FILE == true ]]; then
    ssh -p 59878 zhouxiaomin@192.168.1.134 "sudo chmod 664 /home/zhouxiaomin/$1 && sudo chown daemon:daemon /home/zhouxiaomin/$1 && sudo cp /home/zhouxiaomin/$1 /data/www/wwwroot/new-wwwroot/$1 && sudo chown daemon:daemon /data/www/wwwroot/new-wwwroot/$1 && sudo chown zhouxiaomin:zhouxiaomin /home/zhouxiaomin/$1 && sudo chmod 644 /home/zhouxiaomin/$1"
elif [[ $IS_DIR == true ]]; then
    echo 复制文件夹
    ssh -p 59878 zhouxiaomin@192.168.1.134 "sudo chmod 755 /home/zhouxiaomin/$1 && sudo chown -R daemon:daemon /home/zhouxiaomin/$1 && sudo cp -r /home/zhouxiaomin/$1/* /data/www/wwwroot/new-wwwroot/$1/ && sudo chown -R daemon:daemon /data/www/wwwroot/new-wwwroot/$1 && sudo chmod 644 /data/www/wwwroot/new-wwwroot/$1/* && sudo chown -R zhouxiaomin:zhouxiaomin /home/zhouxiaomin/$1 && sudo chmod 755 /home/zhouxiaomin/$1 && sudo chmod 644 /home/zhouxiaomin/$1/*"
fi
#   复制到Web目录完成后再次修改权限组，否则下次再同步会遇到权限错误
echo 复制到 Web 目录完成
