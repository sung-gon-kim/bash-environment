#!/bin/bash

# Check if a directory exists.
isDirectory() {
    [[ -d $1 ]];
}

# Check if a string exists in the given file.
contains() {
    local file=${1}
    local string=${2}
    grep ${string} ${file} &> /dev/null
}

# Install linux packages
installPackages() {
    sudo apt-get update
    sudo apt-get upgrade -y
    sudo apt-get install \
	 ack-grep \
	 build-essential \
	 cmake \
	 emacs \
	 emacs-nox \
	 grep \
	 git \
	 wget
}

# Install bash-git-prompt
installBashGitPrompt() {
    local program="bash-git-prompt"
    local target="${HOME}/.${program}"
    local bashrc="${HOME}/.bashrc"
    local git="https://github.com/magicmonty/bash-git-prompt.git"
    local header="# BASH-GIT-PROMPT CONFIGURATION"
    local script="scripts/bash-git-prompt.script"

    if isDirectory ${target} ; then
	echo "${program}: already exists at ${target}"
    else
	git clone ${git} ${target}
	echo "${program}: downloaded at ${target}"
    fi

    if contains ${bashrc} ${header} ; then
	echo "${program}: already configured"
    else
	cat ${script} >> ${bashrc}
	echo "${program}: configured"
    fi
}

# Main
installPackages
installBashGitPrompt
