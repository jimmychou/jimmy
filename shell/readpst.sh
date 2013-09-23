#!/bin/bash
#if [ -z $1 ];then # if后面必须有空格，我晕了个去
#$1='~/workspace/'
#$1='/home/jimmychou/workspace/20120502'
#$1=$HOME
#fi
#sub_dir=20120502
#root=$120120502/
root=/home/jimmychou/20120502/
echo $root
for i in $(ls $root);
do 
	i_dir=$root$i
	for j in $(ls $i_dir);
	do
		j_dir=$root$i/$j
		if [ -f $j_dir ];then
			echo $j_dir
			mv $j_dir $j_dir.eml
		else
			for k in $(ls $j_dir);
			do
				k_dir=$root$i/$j/$k
				echo $k_dir
				mv $k_dir $k_dir.eml
			done
		fi
	done
done
