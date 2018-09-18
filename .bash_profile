
if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi

alias start=/bin/wsl-open.sh

export PS1="\[\e[32m\]\u\[\e[m\]\[\e[32m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\]\[\e[32m\]:\[\e[m\]\[\e[37m\]\w\[\e[35m\]   \$(__git_ps1 '(%s)')\[\e[33m\]\\n\$\[\e[m\] "
