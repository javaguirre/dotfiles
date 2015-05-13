#!/bin/sh

BG_IMG="$HOME/Pictures/arch_wallpaper.png"

if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
    eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi

export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

feh --bg-scale $BG_IMG
xset -dpms
xset s off
# dwmstatus &amp;
setxkbmap en_US -option ctrl:nocaps &amp;
pulseaudio --start
emacs -nw --daemon

exec dwm
