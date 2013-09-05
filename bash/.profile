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
[[ -s /home/javaguirre/.nvm/nvm.sh ]] && . /home/javaguirre/.nvm/nvm.sh # This loads NVM

APPENGINE_PATH="$HOME/apps/google_appengine"
ANDROID_SDK="$HOME/apps/android-sdk-linux"
ANDROID_NDK="$HOME/apps/android-ndk-r8"
#JDK_PATH="/usr/lib/jvm/jdk1.7.0"
#export YEOMAN="$HOME/node_modules/yeoman/bin"
export NODE_MODULES="$HOME/node_modules/.bin"
export COFFEEPATH=/usr/lib/coffee-script/bin/
export GOPATH=$HOME/Proyectos/go
export GOROOT=/usr/lib/go
export PYTHONSTARTUP=$HOME/.pythonrc
export GWT_PATH="$HOME/apps/gwt-2.5.0.rc1"
export PYTHONPATH=$PYTHONPATH:"$HOME/Proyectos/django-apps":"$HOME/Proyectos/gigas/":"$HOME/Proyectos/python/sabrosous/sabrosous":$APPENGINE_PATH
export PATH=$PATH:"$HOME/.gem/ruby/1.9.1/bin":"/usr/share/java/apache-ant/bin":"$ANDROID_SDK/tools":"$ANDROID_SDK/platform-tools":"$GOROOT/bin":"$ANDROID_NDK":"$GWT_PATH":"$COFFEEPATH":"$NODE_MODULES":"$GOPATH/bin"
export JAVA_HOME='/usr'
export JYTHONPATH=$JYTHONPATH:$JDK_PATH
export CLASSPATH=$CLASSPATH:"$JDK_PATH/lib/tools.jar":"$HOME/Proyectos/java/myexperiments"
export ANDROID_SRC="$HOME/Proyectos/android/sl4a-src"
export CHROME_BIN="chromium"

# virtualenv
source /usr/bin/virtualenvwrapper.sh
export WORKON_HOME="$HOME/.virtualenvs"
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export PIP_RESPECT_VIRTUALENV=true
