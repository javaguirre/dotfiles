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

export NODE_MODULES="$HOME/node_modules/.bin"
export COFFEEPATH=/usr/lib/coffee-script/bin/
export GOPATH=$HOME/Code/go
export GOROOT=/usr/local/opt/go/libexec
export PYTHONSTARTUP=$HOME/.pythonrc
export RBENV="$HOME/.rbenv/bin"
export PATH=$PATH:"$HOME/.gem/ruby/1.9.1/bin":"/usr/share/java/apache-ant/bin":"$GOROOT/bin":"$COFFEEPATH":"$NODE_MODULES":$GOPATH/bin:"/Users/javaguirre/bin"
export JAVA_HOME='/Library/Java/Home'

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export PATH="$HOME/.cargo/bin:$PATH"
