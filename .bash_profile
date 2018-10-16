
source ~/.git-prompt.sh

if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi

alias start=/bin/wsl-open.sh
alias powershell=/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe
alias diff=colordiff

# Open tmux in first existing session if it exists
function tmux() {
    /usr/bin/tmux attach $@ || /usr/bin/tmux $@
}

# Get mad if rebasing without -i
# User proper git executable depending on path - used for WSL
function git() {
    for i in "$@"; do
        if [[ $i == "rebase" ]] ; then
            f=0
            for j in "$@"; do
                if [[ $j == "-i" ]] ; then
                    f=1
                    break
                fi
            done
            if [[ $f == 0 ]] ; then
                echo "YOU FORGOT TO DO INTERACTIVE MODE!"
                return 1
            fi
            break
        fi
    done

    # Note - this will disrupt git's core.editor
    REALPATH=`readlink -f ${PWD}`
    if [ "${REALPATH:0:5}" == "/mnt/" ]; then
        git.exe "$@"
    else
        /usr/bin/git "$@"
    fi
}

# List files that contain a certain text
# Optional param for dir
function findText() {
    if [ $# == 0 ]; then
        return
    fi

    dir="$PWD/"
    if [ $# -gt 1 ]; then
        dir="$1"
        shift
    fi

    for i in "$@"; do
        echo "Searching $i in $dir"
        find "$dir" -type f -exec grep -il "$i" {} \;
    done
}

# Macro to find a file
function findFile() {
    if [ $# == 0 ]; then
        return
    fi

    dir="$PWD/"
    if [ $# -gt 1 ]; then
        dir="$1"
        shift
    fi

    echo "Searching $1 in $dir"
    find $dir -type f -name "$1"
}

export PS1="\[\e[32m\]\u\[\e[m\]\[\e[32m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\]\[\e[32m\]:\[\e[m\]\[\e[37m\]\w\[\e[35m\]   \$(__git_ps1 '(%s)')\[\e[33m\]\\n\$\[\e[m\] "

export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}:${PWD/#$HOME/~}\007"'
