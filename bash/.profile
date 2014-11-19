# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh # This loads NVM

ANDROID_SDK="$HOME/apps/android-sdk-linux"
ANDROID_NDK="$HOME/apps/android-ndk-r8"
export ANDROID_HOME=/home/javaguirre/apps/android-sdk-linux/
export NODE_MODULES="$HOME/node_modules/.bin"
export COFFEEPATH=/usr/lib/coffee-script/bin/
export GOPATH=$HOME/code/go
export GOROOT=/usr/lib/go
export PYTHONSTARTUP=$HOME/.pythonrc
export RBENV="$HOME/.rbenv/bin"
export CASKPATH="/home/javaguirre/.cask/bin"
export PATH=$RBENV:$PATH:"$HOME/.gem/ruby/1.9.1/bin":"/usr/share/java/apache-ant/bin":"$ANDROID_SDK/tools":"$ANDROID_SDK/platform-tools":"$GOROOT/bin":"$ANDROID_NDK":"$GWT_PATH":"$COFFEEPATH":"$NODE_MODULES":"$GOPATH/bin:$CASKPATH"
export JAVA_HOME='/usr/lib/jvm/java-8-openjdk'

# virtualenv
# source /usr/bin/virtualenvwrapper.sh
# export WORKON_HOME="$HOME/.virtualenvs"
# export PIP_VIRTUALENV_BASE=$WORKON_HOME
# export PIP_RESPECT_VIRTUALENV=true
