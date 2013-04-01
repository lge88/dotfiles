# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
export SYSTEM=`uname`

# Language settings:
if [[ $SYSTEM == 'Linux' ]]; then
    export LANG="en_US.utf8"
    export LC_ALL="en_US.utf8"
    export LC_CTYPE="en_US.utf8"    
fi

if [[ $SYSTEM == 'Darwin' ]]; then
    export PATH=$HOME/bin:/opt/local/bin:$PATH
    export LD_LIBRARY_PATH=/opt/local/lib
fi

# Add some custom search path:
export PATH=${TOOLBOX_PATH}/bin:$PATH

export PATH=/usr/local/MATLAB/R2012b/bin:$PATH
export PATH=$DEVELOP_PATH/server/node-opensees-server/bin:$PATH
export PATH=$DEVELOP_PATH/gmsh/build:$PATH
export PATH=$DEVELOP_PATH/OpenSees/BUILD/debug/bin:$PATH
export PATH=/opt/ParaView-3.98.0-Linux-64bit/bin:$PATH
export PATH=~/GiDx64/11.1.2d:$PATH
export PATH=/opt/mongodb-linux-x86_64-2.2.2/bin:$PATH
export PATH=/opt/redis-2.6.9/src:$PATH
export PATH=/opt/nomad.3.5.1:$PATH
export PATH=/opt/apache-maven-3.0.4/bin:$PATH
export PATH=~/Develop/eclipse/elasticsearch/target/releases/elasticsearch-0.21.0.Beta1-SNAPSHOT/bin:$PATH
export PATH=~/Develop/Android/adt-bundle-linux-x86_64-20130219/eclipse:$PATH
export PATH=~/Develop/Android/adt-bundle-linux-x86_64-20130219/sdk/tools:$PATH
export PATH=~/Develop/Android/adt-bundle-linux-x86_64-20130219/sdk/platform-tools:$PATH
export PATH=~/Develop/Android/android-ndk-r8d:$PATH
export ANT_HOME=~/local/apache-ant-1.8.4/bin
export PATH=/opt/cisco/vpn/bin:$PATH


# export PATH=~/bin/eclipse:$PATH
# export PATH=~/bin/AptanaStudio3:$PATH

# Compiled Matlab code settings:
# export LD_LIBRARY_PATH=/usr/local/lib
# export LD_LIBRARY_PATH=/usr/local/MATLAB/R2012b/runtime/glnxa64:${LD_LIBRARY_PATH}
# export LD_LIBRARY_PATH=/usr/local/MATLAB/R2012b/bin/glnxa64:${LD_LIBRARY_PATH}
# export LD_LIBRARY_PATH=/usr/local/MATLAB/R2012b/sys/os/glnxa64:${LD_LIBRARY_PATH}
# export LD_LIBRARY_PATH=/usr/local/MATLAB/R2012b/sys/java/jre/glnxa64/jre/lib/amd64/native_threads:${LD_LIBRARY_PATH}
# export LD_LIBRARY_PATH=/usr/local/MATLAB/R2012b/sys/java/jre/glnxa64/jre/lib/amd64/server:${LD_LIBRARY_PATH}
# export LD_LIBRARY_PATH=/usr/local/MATLAB/R2012b/sys/java/jre/glnxa64/jre/lib/amd64:${LD_LIBRARY_PATH}
# export XAPPLRESDIR=/usr/local/MATLAB/R2012b/X11/app-defaults

# osg settings:
# export PATH=$PATH:~/Develop/osg/debug/bin
# export LD_LIBRARY_PATH=~/Develop/osg/debug/lib:$LD_LIBRARY_PATH
# export OSG_FILE_PATH=~/Develop/OpenSceneGraph-Data-3.0.0

# nvm settings:
export USE_NODE_VERSION="v0.8.18"
if [[ ${SYSTEM} == 'Darwin' ]]; then
    export NVM_DIR=~/.nvm
else 
    export NVM_DIR=~/nvm
fi

if [[ -e $NVM_DIR ]]; then
    . $NVM_DIR/nvm.sh
    [[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion
    nvm use $USE_NODE_VERSION > /dev/null 2>&1
fi

export SENCHA_TOUCH_SDK= "~/Develop/js/sencha/touch-2.1.1"
export PATH=~/Develop/js/sencha/Sencha/Cmd/3.1.0.239:$PATH
export SENCHA_CMD_3_0_0="~/Develop/js/sencha/Sencha/Cmd/3.1.0.239"
