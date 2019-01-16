#!/bin/bash
# read -p "please input a num: "  num
if echo $1 | grep -q '[^0-9]'
then
        echo "this is not a num,please input num"
        exit 1
fi