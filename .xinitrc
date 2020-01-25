picom --config ~/.config/picom/picom.conf &
~/.fehbg &
xrdb ~/.Xresources &
nvidia-settings --load-config-only & 
xset r rate 250 70 &
exec bspwm
# exec i3
