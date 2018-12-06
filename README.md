# git-helper-shell-script

Shell script to perform common git operations with less typings

## Installation
Place the  `git.sh` file as a sibling of `.git` directory in your project

> For permission related issues, give it execution permission by running `sudo chmod +x git.sh`

## Usage

#### Fast push
```sh
./git.sh -fps "commit message" "push branch name"
```
> The second argument `push branch name` is optional. 

If `push branch name` is mentioned it will try to push in that branch, but if the branch doesn't exist it will create and push 

#### Interactive pull
```sh
./git.sh -ipl
```
It will show current branch, git commit graph and ask for branch name to pull interactively

#### Show all allowed actions
```sh
./git.sh -help
```
It will show all allowed actions with proper command format