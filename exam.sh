#!/bin/bash

#
# Bash script for exam calculation
#
# Version 0.9
#
# Usage:
# 			exam.sh --help or -h for help
#			exam.sh (-p or --per) <percent>
#				percent: 0-100 %
#			exam.sh -c --cpo <credit points>
#				credit points: 0-15 points
# Result:
#			exam passed
#				percent more then 50% or
#				credit points more than 5 points
# or
#			exam failed
#				percent less then 50% or
#                               credit points less than 5 points
# 


################# FUNCTIONS ####################
# Capture CTRL+C
trap CtrlC INT
function CtrlC() {
read -p "exam.sh cancelled! really ? [y/N] " -n 1 -r
echo

if ! [[ $REPLY =~ ^[Yy]$ ]]
then
	echo "In Hamburg sagt man TSCHÜSS!!"
	echo " "
	exit 1
else
	echo " "
fi
}

# Help
help() {
	echo ""
        echo "exam.sh"
        echo ""
        echo " Usage:"
        echo "                       exam.sh --help or -h for help"
        echo "                       exam.sh (-p or --per) <percent>"
    	echo "                               percent: 0-100 %"
        echo "                       exam.sh -c --cpo <credit points>"
        echo "                               credit points: 0-15 points"
        echo " Result:"
        echo "                       exam passed"
        echo "                               percent more then 50% or"
        echo "                               credit points more than 5 points"
        echo " or"
        echo "                       exam failed"
        echo "                               percent less then 50% or"
        echo "                               credit points less than 5 points"
        echo ""
        echo "---"
        echo ""
	exit 1
}

# Credit Points
cpo(){
	if [ $in_num -le 4 -a $in_num -ge 0 ]
	then
		echo ""
		echo -e "\e[1mexam \e[91mfailed\e[0m"
		echo ""
	else
		if  [ $in_num -ge 5 -a $in_num -le 15 ]
		then
			echo ""
                	echo -e "\e[1mexam \e[92mpassed\e[0m"
                	echo ""
		else
			echo ""
                	echo "wrong input $in_num"
                	echo "-> exam.sh -h or -help"
			echo ""
			help
		fi

	fi
	exit 0
}

# Percent
per(){
        if [ $in_num -le 49 -a $in_num -ge 0 ]
        then
                echo ""
                echo -e "\e[1mexam \e[91mfailed\e[0m"
                echo ""
        else
                if  [ $in_num -ge 50 -a $in_num -le 100 ]
                then
                        echo ""
                        echo -e "\e[1mexam \e[92mpassed\e[0m"
                        echo ""
                else
                        echo ""
                        echo "wrong input $in_num"
                        echo "-> exam.sh -h or -help"
                        echo ""
                        help
                fi

        fi
	exit 0
}


################ main ########################

if [ $# -lt 1 ]
then
	help
fi

if [ $# -eq 1 ]
then
        if [ $1 = "--help" -o $1 = "-h" ]
        then
                help
        else
		if ! [[ "$1" =~ ^[0-9]+$ ]]
    		then
        		echo ""
                    	echo "wrong input: $1 "
                    	echo "Sorry integers only"
			echo "-> exam.sh -h or -help"
                    	echo ""
                    	help
		else
			let in_num=$1
			per
		fi
	fi
fi


if [ $# > 1 ]
then
	let in_num=$2

	if [ $1 = "--help" -o $1 = "-h" ]
	then
		help
	fi

	case $1 in
		"-c") cpo;;
		"--cpo") cpo;;
		"") per;;
		"-p") per;;
		"--per") per;;
		*)  echo ""
                    echo "wrong input: $1 $in_num"
                    echo "-> exam.sh -h or -help"
                    echo "" 
 		    help;;
	esac
else
	echo ":-("
fi

exit 0
