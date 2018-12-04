#!/bin/bash


#	Fast Push: > ./git --fp "Commit message" "Push branch name"
#	
#	Fast Pull & Push: > ./git --fpp "Pull banch name" "Commit message" "Push branch name"


#	Get passed arguments length
PASSED_ARGS_LENGTH=$#


function execute {
	if [ "$PASSED_ARGS_LENGTH" -eq 0 ]; then
		echo "No action specified"
	else
		echo $PASSED_ARGS_LENGTH
	fi 
	
}

execute