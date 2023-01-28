
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

alias py='python3'

# Open tmux in first existing session if it exists
alias tmux='TERM=xterm-256color ; /usr/bin/tmux attach $@ || /usr/bin/tmux $@'

HISTSIZE=10000

bind "set completion-ignore-case on"

MY_GIT_PROMPT="/home/jaafers/.my-git-prompt.sh"
GIT_PROMPT="/mnt/c/Program Files/Git/mingw64/share/git/completion/git-prompt.sh"
if [ -f $MY_GIT_PROMPT ]; then
	source "$MY_GIT_PROMPT" 
elif [ -f "$GIT_PROMPT" ]; then
	source "$GIT_PROMPT" 
else 
	__git_ps1 () {
    	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/' | 2>/dev/null
	}
fi

PS_DISTRIB=$(grep DISTRIB_ID /etc/lsb-release | cut -d'=' -f2)
# PS_DISTRIB_VERSION=$(grep DISTRIB_RELEASE /etc/lsb-release | cut -d'=' -f2)
PS1='\[\033]0;$TITLEPREFIX:$PWD\007\]' # set window title
PS1="$PS1"'\n'                 # new line
PS1="$PS1"'\[\033[93m\]'       # change to 
PS1="$PS1"'\D{%H:%M:%S} '      # Date
PS1="$PS1"'\[\033[32m\]'       # change to green
PS1="$PS1"'\u@\h '             # user@host<space>
PS1="$PS1"'\[\033[35m\]'       # change to purple
PS1="$PS1"'$PS_DISTRIB'        # show Distrib
PS1="$PS1"'$PS_DISTRIB_VERSION ' # show version
PS1="$PS1"'\[\033[33m\]'       # change to brownish yellow
PS1="$PS1"'\w'                 # current working directory
PS1="$PS1"'\[\033[36m\]'       # change color to cyan
PS1="$PS1"'$(__git_ps1)'       # git branch
PS1="$PS1"'\[\033[0m\]'        # change color
PS1="$PS1"'\n'                 # new line
PS1="$PS1"'$ '                 # prompt: always $

export LS_COLORS=$LS_COLORS:'ow=4;91:'

export NUMBER_OF_PROCESSORS=$(getconf _NPROCESSORS_ONLN)
