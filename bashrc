# .bashrc

export SYSTEM=`uname`

PS1="(\u@\h \W) > "
TERM=xterm-256color
PROMPT_COMMAND='echo -ne "\033]0;`command pwd`\007"'
umask 022

function pathadd() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    export PATH=${1}:$PATH
  fi
}

# Set up my paths
export DEVELOP_PATH=~/Develop
export DROPBOX_PATH=~/Dropbox
export DOTFILES_PATH=~/dotfiles
export TMPL_PATH=${DEVELOP_PATH}/js/ise/templates:${DOTFILES_PATH}/templates

pathadd ${DOTFILES_PATH}/bin
pathadd ${DEVELOP_PATH}/scala/sbt/bin
pathadd ${DEVELOP_PATH}/OpenSees/BUILD/debug/bin

export ISE_PATH=${DEVELOP_PATH}/js/ise
pathadd ${ISE_PATH}/bin

if [[ $SYSTEM == 'Darwin' ]]; then
  pathadd $HOME/bin
  pathadd /opt/local/bin
  pathadd /usr/local/texbin
  export LD_LIBRARY_PATH=/opt/local/lib
elif [[ $SYSTEM == 'Linux' ]]; then
  pathadd /usr/local/MATLAB/R2013a/bin
  pathadd /opt/ParaView-3.98.0-Linux-64bit/bin
  # pathadd /opt/mongodb-linux-x86_64-2.2.2/bin
  # pathadd /opt/mongodb-linux-x86_64-2.4.4/bin
  # pathadd /opt/redis-2.6.9/src
  # pathadd /opt/nomad.3.5.1
  # pathadd /opt/apache-maven-3.0.4/bin
  # pathadd /opt/cisco/vpn/bin
  # pathadd ~/GiDx64/11.1.2d
  pathadd ~/Develop/server/node-opensees-server/bin
  pathadd ~/Develop/gmsh/build
  # pathadd ~/Develop/eclipse/elasticsearch/target/releases/elasticsearch-0.21.0.Beta1-SNAPSHOT/bin
  # pathadd ~/Develop/Android/adt-bundle-linux-x86_64-20130219/eclipse
  pathadd ~/Develop/Android/adt-bundle-linux-x86_64-20130219/sdk/tools
  pathadd ~/Develop/Android/adt-bundle-linux-x86_64-20130219/sdk/platform-tools
  pathadd ~/Develop/Android/android-ndk-r8d
  # pathadd ~/Develop/js/sencha/Sencha/Cmd/3.1.0.239
  # pathadd ~/bin/eclipse
  # pathadd ~/bin/AptanaStudio3
  # export ANT_HOME=~/local/apache-ant-1.8.4/bin
  # export SENCHA_TOUCH_SDK="~/Develop/js/sencha/touch-2.1.1"
  # export SENCHA_CMD_3_0_0="~/Develop/js/sencha/Sencha/Cmd/3.1.0.239"
fi

# Remotes:
function remotes {
  echo 'GL@vision2.ucsd.edu'
  echo 'GL@lige.me'
  echo 'git@github.com:lge88'
  echo 'git@bitbucket.org:lge'
}
alias vislab='ssh GL@vision2.ucsd.edu'
alias ligeme='ssh GL@lige.me'
alias linode='ssh root@192.155.82.21'
alias aliyun='ssh root@42.96.190.31'
alias ec2="ssh -i $TOOLBOX_PATH/share/likey.pem ec2-user@ec2-54-245-28-33.us-west-2.compute.amazonaws.com"

# Fix the sudo
if [[ $SYSTEM == 'Darwin' ]]; then
  sudo () { ( unset LD_LIBRARY_PATH DYLD_LIBRARY_PATH; exec command sudo $* ) }
fi

# Language
if [[ $SYSTEM == 'Linux' ]]; then
  export LANG="en_US.utf8"
  export LC_ALL="en_US.utf8"
  export LC_CTYPE="en_US.utf8"
fi

# paste board, osx pbcopy/pbpaste equivalent
if [[ $SYSTEM == 'Linux' ]]; then
  alias pbcopy='xclip -selection clipboard'
fi
alias pb='pbcopy'

# print working directory to screen and paste board
alias cpwd='command pwd | tee /dev/tty | pbcopy'

# z
[[ -f ~/z/z.sh ]] && . ~/z/z.sh && alias zt='z -t'

# Emacs
if [[ ${SYSTEM} == Darwin ]]; then
  EMACS_APP_ROOT=/Applications/Emacs.app
  # EMACS_APP_ROOT=/Applications/MacPorts/Emacs.app
  alias emacs=${EMACS_APP_ROOT}/Contents/MacOS/Emacs
  pathadd ${EMACS_APP_ROOT}/Contents/MacOS/bin
fi

# NVM settings:
export USE_NODE_VERSION="v0.10.26"
if [[ -r ~/nvm/nvm.sh ]]; then
  . ~/nvm/nvm.sh
  [[ -r ~/nvm/bash_completion ]] && . ~/nvm/bash_completion
  nvm use $USE_NODE_VERSION > /dev/null 2>&1
fi

# Github cli util:
# eval "$(hub alias -s)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
pathadd $PYENV_ROOT/bin
# eval "$(pyenv init -)"

# System open command:
if [[ ${SYSTEM} == Linux ]]; then
  alias open='gnome-open'
fi
alias o='open'
alias o.='open .'

# Mongodb
alias mongodb-default='sudo /opt/mongodb-linux-x86_64-2.4.4/bin/mongod
--fork --logpath /var/log/mongodb.log'

# git shortcuts:
alias gffs='git flow feature start'
alias gfff='git flow feature finish'
alias gffp='git flow feature publish'
alias gffpl='git flow feature pull'
alias gst='git status'
alias gdf='git diff --color'
alias gcm='git-cm'
alias gaac='git-aac'
alias gaacp='git-aacp'

# time utils
alias today='date +%Y%m%d'
alias td='today'
alias now='date +%H%M%S'

# Emacs
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
alias e.='e .'
alias et='emacsclient -t'
alias et.='emacsclient -t .'
alias .rc="e ~/.bashrc"

alias rq='repoquery -lq'

alias vislab='ssh GL@vision2.ucsd.edu'
alias ligeme='ssh GL@lige.me'
alias linode='ssh root@192.155.82.21'
alias aliyun='ssh root@42.96.190.31'
alias ec2="ssh -i $TOOLBOX_PATH/share/likey.pem ec2-user@ec2-54-245-28-33.us-west-2.compute.amazonaws.com"

# Easy to try something out:
function mkdircd () { mkdir -p "$@" && eval cd "\"\$$#\""; }
alias t="mkdircd ${DROPBOX_PATH}/tmp/`today`"

alias mkdir='mkdir -p'
alias j='jobs -l'

# Pretty-print of some PATH variables:
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'

if [[ $SYSTEM == 'Darwin' ]]; then
  alias ls='ls -G'
  alias la='ls -lGa'
  alias ll='ls -l'
else
  alias ls='ls -h --color'
  alias ll='ls -l'
  alias la='ll -A'
fi

# Make your directories and files access rights sane.
function sanitize() { chmod -R u=rwX,g=rX,o= "$@" ;}

function ndb() {
  p=${2:-8888}
  [ ! -z $1 ] && node --debug-brk $1 &
  node-inspector --web-port=$p > /dev/null 2>&1 &
  sleep 0.5 && open "http://localhost:${p}/debug?port=5858" > /dev/null 2>&1
}

# Completion
# set auto complete for following commands:
complete -cf sudo
complete -cf man
complete -cf which
complete -cf type
complete -cf gdb
complete -cf help

# ise completion:
function _ise() {
  cur=${COMP_WORDS[COMP_CWORD]}
  local subcommands="start kill running restart logs \
debug monitor template app"
  # TODO: auto complete templates
  COMPREPLY=( $( compgen -W "$subcommands" -- $cur ) )
}
complete -o default -o nospace -F _ise  ise

### Git auto-complete
[[ -f ~/.git-completion.sh ]] && . ~/.git-completion.sh

# OPAM configuration
# . /Users/lige/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
