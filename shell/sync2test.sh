#!/bin/bash

#   $1是文件或文件夹为空退出
#   $2是项目名称，缺省为goapk
#   $3是测试trunk分支或上线branch分支，缺省为测试trunk分支

if [ -f $1 ];then
    echo '$1' cannot be empty
    exit
else
    echo '$1' is $1
fi
PREFIX='/home/jimmychou/workspace/goapk/trunk/'
#PREFIX='~/workspace/goapk/trunk/'   #   this    is  not ok
DATA=$PREFIX$1
if [ -e $DATA ];then
    echo 'Sync file is beginning...'
    else
        echo 'file not existed'
        exit
fi
echo 'DATA is '$DATA AND '$1 is ' $1
#rsync -avH --progress '-e ssh -p 59878' $1 zhouxiaomin@192.168.1.134:/home/zhouxiaomin/$1
#rsync -avH --progress '-e ssh -p 59878' $DATA zhouxiaomin@192.168.1.134:/home/zhouxiaomin/$1
#rsync -avHc --progress '-e ssh -p 59878' $DATA zhouxiaomin@192.168.1.134:/home/zhouxiaomin/
rsync -avHc --exclude='.svn/' --progress '-e ssh -p 59878' $DATA zhouxiaomin@192.168.1.134:/home/zhouxiaomin/
#ssh -p 59878 zhouxiaomin@192.168.1.134 "sudo cp service_restart.sh /data/www/"
#ssh -p 59878 zhouxiaomin@192.168.1.134 "sudo chown -R daemon:daemon /home/zhouxiaomin/$1 && sudo chmod -R 664 /home/zhouxiaomin/$1"
ssh -p 59878 zhouxiaomin@192.168.1.134 "sudo chown -R daemon:daemon /home/zhouxiaomin/$1 && sudo chmod -R 755 /home/zhouxiaomin/$1"

#   复制到Web目录完成后再次修改权限组
ssh -p 59878 zhouxiaomin@192.168.1.134 "sudo chown -R zhouxiaomin:zhouxiaomin /home/zhouxiaomin/$1"
