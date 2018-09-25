
if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi

alias start=/bin/wsl-open.sh
alias powershell=/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe

# Get mad if rebasing without -i
function git() {
    for i in "$@"; do
        if [[ $i == "rebase" ]] ; then
            x=0
            for i in "$@"; do
                if [[ $i == "-i" ]] ; then
                    x=1
                fi
            done
            if [[ $x == 0 ]] ; then
                echo "YOU FORGOT TO DO INTERACTIVE MODE!"
                return 1
            fi
        fi
    done
    /usr/bin/git $@
}

# Prompt
export PS1="\[\e[32m\]\u\[\e[m\]\[\e[32m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\]\[\e[32m\]:\[\e[m\]\[\e[37m\]\w\[\e[35m\]   \$(__git_ps1 '(%s)')\[\e[33m\]\\n\$\[\e[m\] "

# Title
export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}:${PWD/#$HOME/~}\007"'
