
if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi

alias start=/bin/wsl-open.sh
alias powershell=/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe

# Get mad if rebasing without -i
# Includes WSL override 
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
    
    REALPATH=`readlink -f ${PWD}`
    if [ "${REALPATH:0:5}" == "/mnt/" ]; then
        git.exe "$@"
    else
        /usr/bin/git "$@"
    fi    
}

# Prompt
export PS1="\[\e[32m\]\u\[\e[m\]\[\e[32m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\]\[\e[32m\]:\[\e[m\]\[\e[37m\]\w\[\e[35m\]   \$(__git_ps1 '(%s)')\[\e[33m\]\\n\$\[\e[m\] "

# Title
export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}:${PWD/#$HOME/~}\007"'
