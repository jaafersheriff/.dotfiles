

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

if [ -f /etc/profile.d/git-prompt.sh ]; then
    source /etc/profile.d/git-prompt.sh
fi

for f in $(find ~/.funcs/ -name "*.sh"); do source $f; done
alias getFuncs='for f in $(find ~/.funcs/ -name "*.sh"); do echo $f && source $f; done'

shopt -s checkwinsize 

alias ls='ls --color=auto'
alias ll='ls -alF --block-size=K'
alias la='ls -A'
alias l='ls -CF'

alias sizeof='du -hcs'

alias diff='diff --color'

alias vscode='code'

# Open tmux in first existing session if it exists
alias tmux='/usr/bin/tmux attach $@ || /usr/bin/tmux $@'

export BETTER_MINGW_BIN="/c/MinGW/bin"
export BETTER_MINGW_BIN_MINGW32="/c/MinGW/mingw32/bin"
export BETTER_MINGW_BIN_MSYS="/c/MinGW/mingw32/bin"
export PATH="$PATH:$BETTER_MINGW_BIN_MSYS:$BETTER_MINGW_BIN_MINGW32:$BETTER_MINGW_BIN"

HISTSIZE=10000
