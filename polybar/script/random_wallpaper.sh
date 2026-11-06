#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/wallpaper"

if [ ! -d "$WALLPAPER_DIR" ] || [ -z "$(ls -A "$WALLPAPER_DIR")" ]; then
    exit 1
fi

RANDOM_WALL=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" \) | shuf -n 1)

chmod +x "$HOME/.config/polybar/launch.sh"

wal -n -i "$RANDOM_WALL"
nitrogen --set-zoom-fill "$RANDOM_WALL" --head=0 &> /dev/null

if [ -f "$HOME/.config/polybar/launch.sh" ]; then
    "$HOME/.config/polybar/launch.sh"
fi

c0=$(xrdb -query | grep -m 1 '\.color0:' | awk '{print $2}')
c1=$(xrdb -query | grep -m 1 '\.color1:' | awk '{print $2}')
c4=$(xrdb -query | grep -m 1 '\.color4:' | awk '{print $2}')
c7=$(xrdb -query | grep -m 1 '\.color7:' | awk '{print $2}')
c8=$(xrdb -query | grep -m 1 '\.color8:' | awk '{print $2}')
c12=$(xrdb -query | grep -m 1 '\.color12:' | awk '{print $2}')
c15=$(xrdb -query | grep -m 1 '\.color15:' | awk '{print $2}')
bg=$(xrdb -query | grep -m 1 '\.background:' | awk '{print $2}')

bspc config normal_border_color "$c8"
bspc config focused_border_color "$c4"
bspc config active_border_color  "$c4"

STARSHIP_CONF="$HOME/.config/starship.toml"
if [ -f "$STARSHIP_CONF" ]; then
    sed -i "s|color_bg1 = .*|color_bg1 = \"$c4\"|" "$STARSHIP_CONF"
    sed -i "s|color_bg2 = .*|color_bg2 = \"$c12\"|" "$STARSHIP_CONF"
    sed -i "s|color_bg3 = .*|color_bg3 = \"$c8\"|" "$STARSHIP_CONF"
    sed -i "s|color_bg4 = .*|color_bg4 = \"$c0\"|" "$STARSHIP_CONF"
    sed -i "s|color_bg5 = .*|color_bg5 = \"$bg\"|" "$STARSHIP_CONF"
    sed -i "s|color_blue  = .*|color_blue  = \"$c4\"|" "$STARSHIP_CONF"
    sed -i "s|color_gray  = .*|color_gray  = \"$c7\"|" "$STARSHIP_CONF"
    sed -i "s|color_red   = .*|color_red   = \"$c1\"|" "$STARSHIP_CONF"
    sed -i "s|color_white = .*|color_white = \"$c15\"|" "$STARSHIP_CONF"
fi

dunstctl reload &> /dev/null || pkill -USR1 dunst &> /dev/null
