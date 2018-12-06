#!/bin/bash




#	Color declarations
RED='\033[0;31m'
Color_Off='\033[0m'

BRed='\033[1;31m'
BCyan='\033[1;36m'
BYellow='\033[1;33m'

#	Font weights
bold=$(tput bold)
normal=$(tput sgr0)


#	Get passed arguments length
PASSED_ARGS_LENGTH=$#

#	Store all cmd args
CMD_ARGS=("$@")

#	Check if valid no of arguments passed
function valid_input {
	if [ "$PASSED_ARGS_LENGTH" -eq 0 ]; then
		echo -e "${BRed}Error: No action specified"
		return 0
	else
		return 1
	fi
}

function prompt_user {
	echo -e "$1"
	select answer in "$2" "$3"; do
	    case $answer in
	        Yes ) return 1;;
	        No ) return 0;;
	    esac
	done
}

function validate_action {
	ACTION_SPECIFIED="${CMD_ARGS[0]}"
	(case $ACTION_SPECIFIED in
		"-fps") if [[ "$PASSED_ARGS_LENGTH" -ge 2 ]]; then
					return 1
				else
					echo -e "${BRed}Error: Fast Push requires minimum 1 additional argument \n${BCyan}Try: ${BYellow}./git.sh --fp <Commit Message> <Push branch name> \n${BCyan}Or try: ${BYellow}./git.sh --fp <Commit Message> ${BCyan}(Current branch will be used)"
					return 0
				fi;;

		"-fpp") echo "Fast push & pull";;
		"-ipl") return 1;;
		"-help") return 1;;
		*) echo -e "${BRed}Error: ${CMD_ARGS[0]} is not a valid action \n${BCyan}Try: ${BYellow}./git.sh --help ${BCyan}to get the lists of valid actions";;
	esac)
}

function fast_push {
	echo -e "${BCyan}Executing ${BYellow}git status${Color_Off}";
	git status
	prompt_user "${BCyan}Continue to commit and push?${BYellow}" "Yes" "No" 
	if [[ "$?" -eq 1 ]]; then
		git add -A
		git commit -m "${CMD_ARGS[1]}"
		if [ "$PASSED_ARGS_LENGTH" -eq 3 ]; then
			git checkout -b "${CMD_ARGS[2]}"
			git push origin "${CMD_ARGS[2]}"
		else
			git push
		fi
	else
		echo "Fast push aborted!"
	fi
}

function interactive_pull {
	#	Show current branch 
	echo -e "${BCyan}Current Branch: ${BYellow}";
	git branch

	#	Show remote commmit graph
	echo -e "\n${BCyan}Press any key to show commit graph: ${BYellow}";
	read ANY_KEY_INPUT
	echo -e "\n${BCyan}Showing commit graph${Color_Off}${bold}"
	git log --graph --oneline --decorate --all

	#	Prompt for pull branch name
	echo -e "\n${BCyan}Enter branch name to pull or press ctrl+c to exit${BYellow}"
	read PULL_BRANCH_NAME

	#	Pull the branch
	echo -e "\n${BCyan}Pulling branch: ${BYellow}${PULL_BRANCH_NAME}${Color_Off}${bold}"
	git pull origin "${PULL_BRANCH_NAME}" 
}

function show_all_allowed_actions {
	echo -e "\n\n${BCyan}List of allowed actions:-"
	echo -e "> ${BYellow}./git.sh -fps \"commit message\" \"pull branch name\" \t: ${Color_Off}${bold}Fast push"
	echo -e "${BCyan}> ${BYellow}./git.sh -ipl \t\t\t\t\t: ${Color_Off}${bold}Interactive-Pull\n"
}

function execute_action {
	ACTION_SPECIFIED="${CMD_ARGS[0]}"
	(case $ACTION_SPECIFIED in
		"-fps") fast_push;;
		"-ipl") interactive_pull;;
		"-fpp") echo "Fast push & pull";;
		"-help") show_all_allowed_actions;;
		*) echo -e "${BRed}Error: ${CMD_ARGS[0]} is not a valid action \n${BCyan}Try: ${BYellow}./git.sh -help ${BCyan}to get the lists of valid actions";;
	esac)
}


#	Execution start point
valid_input
if [[ "$?" -eq 1 ]]; then
	# echo $PASSED_ARGS_LENGTH
	validate_action 
	if [[ "$?" -eq 1 ]]; then
		# echo "${CMD_ARGS[1]}"
		execute_action
	fi
fi

# for ARG in "${CMD_ARGS[@]}"; do
# 		    echo "$ARG"
# 		done
# 		
# 		echo "${CMD_ARGS[1]}"