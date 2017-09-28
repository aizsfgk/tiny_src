#!/bin/bash
# 批量改变当前目录的文件大小写
# 
# TODO: 如果是目录继续进入修改
# 

function change() {
	for files in $(ls)
	do
		case $1 in
			"down")
				str=$(echo $files | tr 'A-Z' 'a-z')
				;;
			"up")
				str=$(echo $files | tr 'a-z' 'A-Z')
				;;
			*)
				echo "$1 not match"
				;;
	    esac
		if [ "$files" == `echo $0|sed 's/.\///g'` ];then
			echo "$(pwd)$files not be changed"
			continue
		else
			# 等宽打印
			printf "%s%15s\n" $(pwd)$files $str
			# echo "move $(pwd)$files $str"
		fi
		mv $files $str
		if [ -d $files ];then
			cd $files
			change $@
			cd ../
		fi
	done
}

function main() {
	if [ $# -ne 1 ]; then
		echo "usage: $0 must has one param{up|down}"
		exit 1
	fi

	echo "**********************"
	echo "....start...."
	echo

	change $@

	echo
	echo "....end...."
	echo "**********************"
}

main $@
