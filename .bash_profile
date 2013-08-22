# .bash_profile

# User specific environment and startup programs
export SYSTEM=`uname`

pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH=${1}:$PATH
    fi
}

# Set up my paths
export DEVELOP_PATH=~/Develop
export DROPBOX_PATH=~/Dropbox
export TOOLBOX_PATH=~/Dropbox/toolbox
export DOTFILES_PATH=~/.dotfiles
export ISE_PATH=${DEVELOP_PATH}/js/ife

# Remotes:
export GIT_BB="ssh://git@bitbucket.org/lge"
export GIT_GH="git@github.com:lge88"
# TODO: put repos under a subfolder
export GIT_ME="git@lige.me:GL"
export GIT_VIS="git@vision2.ucsd.edu:GL"

if [[ $SYSTEM == 'Darwin' ]]; then
    pathadd $HOME/bin
    pathadd /opt/local/bin
    pathadd /usr/local/texbin
    export LD_LIBRARY_PATH=/opt/local/lib
    sudo () { ( unset LD_LIBRARY_PATH DYLD_LIBRARY_PATH; exec command sudo $* ) }
fi

# External softwares:
pathadd /usr/local/MATLAB/R2013b/bin
pathadd /opt/ParaView-3.98.0-Linux-64bit/bin
pathadd /opt/mongodb-linux-x86_64-2.2.2/bin
pathadd /opt/mongodb-linux-x86_64-2.4.4/bin
pathadd /opt/redis-2.6.9/src
pathadd /opt/nomad.3.5.1
pathadd /opt/apache-maven-3.0.4/bin
pathadd /opt/cisco/vpn/bin
pathadd ~/GiDx64/11.1.2d
pathadd ~/Develop/server/node-opensees-server/bin
pathadd ~/Develop/gmsh/build
pathadd ~/Develop/OpenSees/BUILD/debug/bin
pathadd ~/Develop/eclipse/elasticsearch/target/releases/elasticsearch-0.21.0.Beta1-SNAPSHOT/bin
pathadd ~/Develop/Android/adt-bundle-linux-x86_64-20130219/eclipse
pathadd ~/Develop/Android/adt-bundle-linux-x86_64-20130219/sdk/tools
pathadd ~/Develop/Android/adt-bundle-linux-x86_64-20130219/sdk/platform-tools
pathadd ~/Develop/Android/android-ndk-r8d
pathadd ~/Develop/js/sencha/Sencha/Cmd/3.1.0.239
pathadd ~/bin/eclipse
pathadd ~/bin/AptanaStudio3

export ANT_HOME=~/local/apache-ant-1.8.4/bin
export SENCHA_TOUCH_SDK="~/Develop/js/sencha/touch-2.1.1"
export SENCHA_CMD_3_0_0="~/Develop/js/sencha/Sencha/Cmd/3.1.0.239"

# Language settings:
if [[ $SYSTEM == 'Linux' ]]; then
    export LANG="en_US.utf8"
    export LC_ALL="en_US.utf8"
    export LC_CTYPE="en_US.utf8"
fi

# My toolboxes:
pathadd ${TOOLBOX_PATH}/bin
pathadd ${DOTFILES_PATH}/.bin
pathadd ${ISE_PATH}/bin

# NVM settings:
export USE_NODE_VERSION="v0.8.18"

if [[ -r ~/nvm/nvm.sh ]]; then
    . ~/nvm/nvm.sh
    [[ -r ~/nvm/bash_completion ]] && . ~/nvm/bash_completion
    nvm use $USE_NODE_VERSION > /dev/null 2>&1
fi

# Github cli util:
eval "$(hub alias -s)"

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi
