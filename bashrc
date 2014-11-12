# .bashrc
export SYSTEM=`uname`

PS1="(\u@\h \W) > "
if [[ $SYSTEM == 'Darwin' ]]; then
  TERM=xterm-256color
  PROMPT_COMMAND='echo -ne "\033]0;`command pwd`\007"'
fi

umask 022

function pathadd() { [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]] && export PATH=${1}:$PATH; }

# Set up my paths
pathadd ~/bin
pathadd ~/dotfiles/bin

if [[ $SYSTEM == 'Darwin' ]]; then
  export LD_LIBRARY_PATH=/opt/local/lib
  pathadd /opt/local/bin
  pathadd /opt/local/sbin
fi

# paste board, osx pbcopy/pbpaste equivalent
[[ $SYSTEM == 'Linux' ]] && alias pbcopy='xclip -selection clipboard'
alias pb='pbcopy'

# copy and print working directory
[[ $SYSTEM == 'Darwin' ]] && alias pwd='command pwd | tee >(tr -d "\n" | pbcopy)'

# System open command:
[[ ${SYSTEM} == Linux ]] && alias open='gnome-open'
alias o='open'

# git shortcuts:
alias gst='git status'
alias gdf='git diff --color'

# utils
alias now='date "+%Y/%m/%d %H:%M:%S" | tee >(tr -d "\n" | pbcopy)'
alias ip='ipconfig getifaddr en1 | tee >(tr -d "\n" | pbcopy)'

# Emacs
[[ $SYSTEM == 'Darwin' ]] && alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs'
alias estart='emacs --daemon'
alias estop='emacsclient -e "(kill-emacs)"'
alias erestart='estop;estart'
export EDITOR='emacsclient -t'

function e() {
  if [[ $(emacsclient -e "(message \"hi\")") == \"hi\" ]]; then
    emacsclient -c -n $*;
  else
    estart && emacsclient -c -n $*;
  fi
}
alias et='emacsclient -t'

# Easy to try something out:
function mkdircd () { mkdir -p "$@" && eval cd "\"\$$#\""; }
alias t="mkdircd ~/tmp/`date +%Y%m%d`"
alias mkdir='mkdir -p'
alias j='jobs -l'

# Pretty-print of some PATH variables:
alias path='echo -e ${PATH//:/\\n}'
alias ldpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'

if [[ $SYSTEM == 'Darwin' ]]; then
  alias ls='ls -G' && alias la='ls -lGa' && alias ll='ls -l'
else
  alias ls='ls -h --color=auto' && alias ll='ls -l' && alias la='ll -A'
fi

function sanitize() { chmod -R u=rwX,g=rX,o= "$@"; }

function ndb() {
  local p=${2:-8888}
  [ ! -z $1 ] && node --debug-brk $1 &
  node-inspector --web-port=$p > /dev/null 2>&1 &
  sleep 0.5 && open "http://localhost:${p}/debug?port=5858" > /dev/null 2>&1
}

# Completion
__ac_cmds="sudo man which type gdb help"
for __ac_cmd in ${__ac_cmds}; do
  complete -cf ${__ac_cmd}
done

### Git auto-complete
[[ -f ~/.git-completion.sh ]] && . ~/.git-completion.sh

# z
[[ -f ~/z/z.sh ]] && . ~/z/z.sh && alias zt='z -t'

# NVM settings:
function __init_nvm() { [[ -r ~/nvm/nvm.sh ]] && . ~/nvm/nvm.sh; }
__init_nvm

# pyenv
function __init_pyenv() {
  export PYENV_ROOT="$HOME/.pyenv"
  pathadd $PYENV_ROOT/bin
  eval "$(pyenv init -)"
}
# Very slow...
#__init_pyenv

# CalVR Variables
export CALVR_HOME=~/Develop/calvr
export CALVR_CONFIG_FILE=~/calvr_configs/lige_default.xml
alias calvr=CalVR
pathadd "$CALVR_HOME/bin"
