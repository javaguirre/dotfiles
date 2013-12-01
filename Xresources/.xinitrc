#!/bin/sh

DEFAULT_SESSION=dwm

case $1 in
gnome)
    exec gnome-session
    ;;
qtile)
    setxkbmap es &amp;
    feh --bg-scale ~/Imagenes/arch_wallpaper.png
    exec qtile
    ;;
*)

    setxkbmap es &amp;
    feh --bg-scale ~/Imagenes/arch_wallpaper.png
    dwmstatus &amp;

    exec $DEFAULT_SESSION
    ;;
esac
