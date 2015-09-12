# .bashrc
export SYSTEM=`uname`
HISTFILESIZE=2500

PS1="(\u@\h \W) > "
if [[ $SYSTEM == 'Darwin' ]]; then
  TERM=xterm-256color
  # PROMPT_COMMAND='echo -ne "\033]0;`command pwd`\007"'
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

# Emacs
[[ $SYSTEM == 'Darwin' ]] && alias emacs='~/Applications/Emacs.app/Contents/MacOS/Emacs'
export EDITOR='emacsclient -t'
alias e='emacsclient -n' e.='emacsclient -n .'
alias et='emacsclient -t' et.='emacsclient -t .'

# Atom
alias a='atom'

# Visual Studio Code
code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}

# paste board, osx pbcopy/pbpaste equivalent
[[ $SYSTEM == 'Linux' ]] && alias pbcopy='xclip -selection clipboard'
alias pb='pbcopy'

alias gist='gist -c'

# copy and print working directory
[[ $SYSTEM == 'Darwin' ]] && alias pwd='command pwd | tee >(tr -d "\n" | pbcopy)'

# System open command:
[[ ${SYSTEM} == Linux ]] && alias open='gnome-open'
alias o='open'

# git shortcuts:
alias gst='git status' gdf='git diff --color' gdfc='git diff --color --cached'

# utils
alias now='date "+%Y/%m/%d %H:%M:%S" | tee >(tr -d "\n" | pbcopy)'
alias ip='ipconfig getifaddr en0 | tee >(tr -d "\n" | pbcopy)'

# Easy to try something out:
function mkdircd () { mkdir -p "$@" && eval cd "\"\$$#\""; }
alias t="mkdircd ~/tmp/`date +%Y%m%d`"
alias mkdir='mkdir -p'
alias j='jobs -l'

# Pretty-print of some PATH variables:
alias path='echo -e ${PATH//:/\\n}' ldpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'

if [[ $SYSTEM == 'Darwin' ]]; then
  alias ls='ls -G' la='ls -lGa' ll='ls -l'
else
  alias ls='ls -h --color=auto' ll='ls -l' la='ll -A'
fi

function sanitize() { chmod -R u=rwX,g=rX,o= "$@"; }

# Completion
__ac_cmds="sudo man which type gdb help"
for __ac_cmd in ${__ac_cmds}; do
  complete -cf ${__ac_cmd}
done

# Git auto-complete
[[ -f ~/.git-completion.sh ]] && . ~/.git-completion.sh

# z
[[ -f ~/z/z.sh ]] && . ~/z/z.sh && alias zt='z -t'

# NVM settings:
function __init_nvm() {
  [[ -r ~/.nvm/nvm.sh ]] || exit
  . ~/.nvm/nvm.sh || exit
  # FIXME: why this is slow?
  nvm use v0.12 > /dev/null 2>&1
}
__init_nvm

# NPM util:
alias npmlg="npm ls -g --depth=0 | cut -d' ' -f2 | tail -n +2 | sed '/^$/d'"

# Speedtest
alias sptest='speedtest-cli'

# pyenv
function __init_pyenv() {
  export PYENV_ROOT="$HOME/.pyenv"
  pathadd $PYENV_ROOT/bin
  eval "$(pyenv init -)"
}
# __init_pyenv
