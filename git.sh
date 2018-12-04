#!/bin/bash


#	Fast Push: > ./git -fp "Commit message" "Push branch name"
#	
#	Fast Pull & Push: > ./git -fpp "Pull banch name" "Commit message" "Push branch name"




#	Color declarations
RED='\033[0;31m'
Color_Off='\033[0m'

BRed='\033[1;31m'
BCyan='\033[1;36m'
BYellow='\033[1;33m'



#	Get passed arguments length
PASSED_ARGS_LENGTH=$#

#	Store all cmd args
CMD_ARGS=("$@")

#	Check if valid no of arguments passed
function valid_input {
	if [ "$PASSED_ARGS_LENGTH" -eq 0 ]; then
		echo "No action specified"
		return 0
	else
		return 1
	fi
}

function validate_action {
	ACTION_SPECIFIED="${CMD_ARGS[0]}"
	(case $ACTION_SPECIFIED in
		"-fp") if [[ "$PASSED_ARGS_LENGTH" -ge 2 ]]; then
					return 1
				else
					echo -e "${BRed}Error: Fast Push requires minimum 1 additional argument \n${BCyan}Try: ./git.sh --fp <Commit Message> <Push branch name> \n${BCyan}Or try: ./git.sh --fp <Commit Message> ${BYellow}(Current branch will be used)"
					return 0
				fi;;

		"-fpp") echo "Fast push & pull";;
		*) echo -e "${BRed}Error: ${CMD_ARGS[0]} is not a valid action \n${BCyan}Try: ${BYellow}./git.sh --help ${BCyan}to get the lists of valid actions";;
	esac)
}

function fast_push {
	echo "Inside fast push"
	git add -A
	git commit -m "${CMD_ARGS[1]}"
	git push
}

function execute_action {
	ACTION_SPECIFIED="${CMD_ARGS[0]}"
	(case $ACTION_SPECIFIED in
		"-fp") fast_push;;
		"-fpp") echo "Fast push & pull";;
		*) echo -e "${BRed}Error: ${CMD_ARGS[0]} is not a valid action \n${BCyan}Try: ${BYellow}./git.sh --help ${BCyan}to get the lists of valid actions";;
	esac)
}


#	Execution start point
valid_input
if [[ "$?" -eq 1 ]]; then
	# echo $PASSED_ARGS_LENGTH
	validate_action 
	if [[ "$?" -eq 1 ]]; then
		echo "${CMD_ARGS[1]}"
		execute_action
		echo "done"
	fi
fi

# for ARG in "${CMD_ARGS[@]}"; do
# 		    echo "$ARG"
# 		done
# 		
# 		echo "${CMD_ARGS[1]}"