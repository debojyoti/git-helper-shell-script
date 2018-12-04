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

#	Execution start point
function start_execution {
	valid_input
	if [[ "$?" -eq 1 ]]; then
		echo $PASSED_ARGS_LENGTH
		
	fi
}

#	Start execution
start_execution