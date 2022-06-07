#!/bin/bash

PWD=$(dirname $0)

# Check if a directory exists.
isDirectory() {
    [[ -d $1 ]];
}

# Check if a file exists.
isFile() {
    [[ -f $1 ]];
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
    sudo apt-get install -y \
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
    local origin="https://github.com/magicmonty/bash-git-prompt.git"
    local target="${HOME}/.${program}"
    local config="${HOME}/.bashrc"
    local marker="# BASH-GIT-PROMPT CONFIGURATION"
    local script="${PWD}/scripts/bash-git-prompt.script"

    if isDirectory ${target} ; then
	echo "${program}: already exists at ${target}"
    else
	git clone ${origin} ${target}
	echo "${program}: downloaded at ${target}"
    fi

    if contains ${config} ${marker} ; then
	echo "${program}: already configured"
    else
	cat ${script} >> ${config}
	echo "${program}: configured"
    fi
}

# Setup emacs
setupEmacs() {
    local program="google-c-style.el"
    local origin="https://raw.githubusercontent.com/google/styleguide/gh-pages/google-c-style.el"
    local target="${HOME}/.emacs.d/google/${program}"
    local config="${HOME}/.emacs"
    local marker="; EMACS CONFIGURATION"
    local script="${PWD}/scripts/emacs.script"

    if isDirectory ${target} ; then
	echo "${program}: already exists at ${target}"
    else
	mkdir -p $(dirname ${target})
	wget ${origin} -O ${target}
	echo "${program}: downloaded at ${target}"
    fi

    if contains ${config} ${marker} ; then
	echo "${program}: already configured"
    else
	cat ${script} >> ${config}
	echo "${program} configured"
    fi
}

# Main
installPackages
installBashGitPrompt
setupEmacs
