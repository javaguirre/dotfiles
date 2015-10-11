# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

. $fish_path/oh-my-fish.fish

# Theme
# set fish_theme bobthefish
Theme 'clearance'
Plugin 'extract'
Plugin 'tmux'
Plugin 'vi-mode'

# Path to your custom folder (default path is $FISH/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish
alias emacs  "emacs -nw"
alias e  "emacs -nw"
alias shutit "shutdown -h now"
