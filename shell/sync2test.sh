#!/bin/bash

#   $1是文件或文件夹为空退出
#   $2是项目名称，缺省为goapk
#   $3是测试trunk分支或上线branch分支，缺省为测试trunk分支

if [ -z $1 ];then
    echo '$1' cannot be empty
    exit
else
    echo '$1' is $1
fi

rsync -avH --progress '-e ssh -p 59878' $1 zhouxiaomin@192.168.1.134:/home/zhouxiaomin/
ssh -p 59878 zhouxiaomin@192.168.1.134 "sudo cp service_restart.sh /data/www/"
