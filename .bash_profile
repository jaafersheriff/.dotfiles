

if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi

if [ -f /etc/profile.d/git-prompt.sh ]; then
	source /etc/profile.d/git-prompt.sh
fi

if [ -f ~/qmk_utils/activate_msys2.sh ]; then
	source ~/qmk_utils/activate_msys2.sh
fi

for f in $(find ~/.funcs/ -name "*.sh"); do source $f; done
alias getFuncs='for f in $(find ~/.funcs/ -name "*.sh"); do echo $f && source $f; done'

shopt -s checkwinsize 

alias ls='ls -aF --color=auto'
alias ll='ls -alF --block-size=K'
alias lr='ls -RF'
alias l='ls'

alias sizeof='du -hcs'

alias diff='diff --color'

alias vscode='code'

# Open tmux in first existing session if it exists
alias tmux='/usr/bin/tmux attach $@ || /usr/bin/tmux $@'

export BETTER_MINGW_BIN="/c/MinGW/bin"
export BETTER_MINGW_BIN_MINGW32="/c/MinGW/mingw32/bin"
export BETTER_MINGW_BIN_MSYS="/c/MinGW/mingw32/bin"
export BETTER_MINGW_BIN_MSYS="/c/MinGW/mingw32/bin"
export BETTER_MINGW_BIN_MSYS="/c/Program Files/wkhtmltopdf/bin"
export PATH="$PATH:$BETTER_MINGW_BIN_MSYS:$BETTER_MINGW_BIN_MINGW32:$BETTER_MINGW_BIN"

HISTSIZE=10000
