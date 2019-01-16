#!bin/bash

function regularFile(){
    if [ "$2" = "all" ];
    then
	regSize=$(du -a $1|awk '{v1="test -f";v2=$2;if(!system(v1" "v2)){sum+=$1}};END{print sum?sum:0}')
	echo "regular file size: "$regSize" KB"
    else
	regSize=$(du -a --max-depth=$2 $1|awk '{v1="test -f";v2=$2;if(!system(v1" "v2)){sum+=$1}};END{print sum?sum:0}')
        echo "max-depth = "$2" ; regular file size: "$regSize" KB"	
    fi
}


root_dir=$1
max_depth=$2
regularFile $root_dir $max_depth


