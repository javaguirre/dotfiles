alias ls='ls --color=auto'
alias grep='grep --colour'
alias cleanmails='sudo postsuper -d ALL'
alias shutit='sudo shutdown -h now'
alias qserver="python2 -m SimpleHTTPServer"
alias selserver="java -jar /usr/share/selenium-server/selenium-server-standalone.jar"
alias php-shell='cd $HOME/code/php/PHP_Shell && php php-shell-cmd.php'
alias eclipse='$HOME/apps/eclipse/eclipse'
#alias offlineimap='$HOME/code/python/offlineimap/bin/offlineimap'
alias mutt='cd ~/Desktop && source ~/.virtualenvs/mutt/bin/activate && mutt'
alias record='gst-launch-0.10 pulsesrc device=alsa_input.pci-0000_00_1b.0.analog-stereo ! adder name=mix ! audioconvert ! vorbisenc ! oggmux ! filesink location=20121126-095037.ogg { pulsesrc
                device=alsa_output.pci-0000_00_1b.0.analog-stereo.monitor ! mix. }'
alias emacs='emacs -nw'
alias addon-sdk="cd /opt/addon-sdk && source bin/activate; cd -"
