#!/bin/bash


#	Fast Push: > ./git --fp "Commit message" "Push branch name"
#	
#	Fast Pull & Push: > ./git --fpp "Pull banch name" "Commit message" "Push branch name"


#	Get passed arguments length
PASSED_ARGS_LENGTH=$#

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
	ACTION_SPECIFIED="$1"
	(case $ACTION_SPECIFIED in
		"--fp") echo "Fast Push"
				if [[ "$PASSED_ARGS_LENGTH" -eq 3 ]]; then
					echo "Right"
				else
					echo "Wrong"
				fi;;
				
		"--fpp") echo "Fast push & pull";;
		*) echo "Wrong";;
	esac)

	return 1
}


#	Execution start point
valid_input
if [[ "$?" -eq 1 ]]; then
	# echo $PASSED_ARGS_LENGTH
	ACTION_SPECIFIED=$1;
	validate_action "$ACTION_SPECIFIED"
	if [[ "$?" -eq 1 ]]; then
		echo "done"
	fi
fi