
if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi

alias start=/bin/wsl-open.sh

export PS1="\[\e[35m\]\u\[\e[m\]\[\e[35m\]@\[\e[m\]\[\e[35m\]\h\[\e[m\]\[\e[35m\]:\[\e[m\]\[\e[37m\]\w\[\e[36m\]   \$(__git_ps1 '(%s)')\[\e[35m\]\\n\$\[\e[m\] "
