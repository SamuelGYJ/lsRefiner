#!/bin/bash

# -n 统计数量  类型遍历-type reg  深度遍历-level 2
# -s 文件大小
# -i 文件详情
# -o输出到文件

#返回距离root_dir的深度
function distance(){
    local comp=$1
    str=${comp#*$root_dir}
    OLD_IFS="$IFS"
    IFS="/"
    arr=($str)
    comp_depth=${#arr[@]}
    echo $comp_depth
    return $comp_depth
}
# $1:base dir

#递归到每个目录下，执行ll 拼接地址 筛选字段
function info(){
    echo $1
    ls -l $1| awk 'NR>=2'
    for element in `ls -A`
    do
        dir_or_file=$1"/"$element
        if test -d $dir_or_file
        then 
        # echo $dir_or_file" is dictionary"
        {
            if [ $depth -ge `distance $dir_or_file` ];
                then
                    #echo $depth
                    info $dir_or_file
            fi  
        }
        fi
    done
}

#$1: base dir
function getdir(){

    for element in `ls -a $1`
    do
        dir_or_file=$1"/"$element
        #echo $dir_or_file
        if ([ $element  = ".." ]||[ $element  = "." ])
        then 
            echo $dir_or_file" is invalid dir"
        elif test -d $dir_or_file
        then 
            ((dictionary++))
            echo $dir_or_file" is dictionary"
            {
                # 比较距离root_dir的深度是否小于规定的深度
                if [ $depth -ge `distance $dir_or_file` ];
                then
                    #echo $depth
                    getdir $dir_or_file
                fi
            }
        elif test -b $dir_or_file
        then
            echo $dir_or_file" is block"
            ((block++))
        elif test -c $dir_or_file
        then
            echo $dir_or_file" is char"
            ((char++))
        elif test -S $dir_or_file
        then
            echo $dir_or_file" is socket"
            ((socket++))
        elif test -L $dir_or_file
        then
            echo $dir_or_file" is link"
            ((link++))
        elif test -p $dir_or_file
        then
            echo $dir_or_file" is pipe"
            ((pipe++))
        elif test -f $dir_or_file
        then
            echo $dir_or_file" is regular file"
            ((reg++))
            fi
    done
}

#输入变量
# root_dir=$2
# depth=$3
dictionary=0
block=0
char=0
socket=0
pipe=0
link=0
reg=0
#getdir $root_dir
#distance /Users/yajungu/Learning/shell/test/123
#文件类型结果
# info $root_dir
#main

#aquire 文件数量
if  [ $1 = '-n' ]
    then
        if [ $# -eq 1 ]  #只有一个参数-n
        then
        # echo "只有一个参数"
        root_dir=`cd $(dirname $0); pwd -P`
        depth=1
        echo $root_dir
        elif [ $# -eq 2 ] && echo $2 | grep -q '[^0-9]' #只有-n和路径
        # elif echo $2 | grep -q '[^0-9]'
        then
        # echo "只有-n和路径"
        depth=1
        root_dir=$2
        elif [ $# -eq 2 ] #只有-n和深度
        then
        root_dir=`cd $(dirname $0); pwd -P` 
        depth=$2
        # echo "只有-n和深度"
        echo $root_dir
        elif [ $# -eq 3 ]  #有三个参数
        then 
        # echo "有三个参数"
        root_dir=$2
        depth=$3
        fi

        # echo $depth
        # echo $root_dir
        getdir $root_dir
        echo "dictionary:" $dictionary
        echo "block:" $block
        echo "char:" $char
        echo "socket:" $socket
        echo "pipe:" $pipe
        echo "link:" $link
        echo "regular file" $reg
    # if 
#acquire 文件大小
elif  [ $1 = '-s' ]
then
    if [ $# -eq 1 ]  #只有一个参数-n
        then
        # echo "只有一个参数"
        root_dir=`cd $(dirname $0); pwd -P`
        depth=1
        echo $root_dir
        elif [ $# -eq 2 ] && echo $2 | grep -q '[^0-9]' #只有-n和路径
        # elif echo $2 | grep -q '[^0-9]'
        then
        # echo "只有-n和路径"
        depth=1
        root_dir=$2
        elif [ $# -eq 2 ] #只有-n和深度
        then
        root_dir=`cd $(dirname $0); pwd -P` 
        depth=$2
        # echo "只有-n和深度"
        echo $root_dir
        elif [ $# -eq 3 ]  #有三个参数
        then 
        # echo "有三个参数"
        root_dir=$2
        depth=$3
        fi
    sh sum.sh $2 $3
#acquire 文件详情
elif [ $1 = '-i' ]
then 
    if [ $# -eq 1 ]  #只有一个参数-n
        then
        # echo "只有一个参数"
        root_dir=`cd $(dirname $0); pwd -P`
        depth=1
        echo $root_dir
        elif [ $# -eq 2 ] && echo $2 | grep -q '[^0-9]' #只有-n和路径
        # elif echo $2 | grep -q '[^0-9]'
        then
        # echo "只有-n和路径"
        depth=1
        root_dir=$2
        elif [ $# -eq 2 ] #只有-n和深度
        then
        root_dir=`cd $(dirname $0); pwd -P` 
        depth=$2
        # echo "只有-n和深度"
        echo $root_dir
        elif [ $# -eq 3 ]  #有三个参数
        then 
        # echo "有三个参数"
        root_dir=$2
        depth=$3
        fi
    info $root_dir
else
    echo "Illegal input!\n Please retry!"

fi