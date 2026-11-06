#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/wallpaper"
CACHE_DIR="$HOME/.cache/wallpaper_thumbs"

if [ ! -d "$WALLPAPER_DIR" ] || [ -z "$(ls -A "$WALLPAPER_DIR")" ]; then
    exit 1
fi

mkdir -p "$CACHE_DIR"

chmod +x "$HOME/.config/polybar/launch.sh"

find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" \) | while read -r img; do
    img_name=$(basename "$img")
    thumb_path="$CACHE_DIR/$img_name.png"
    
    if [ ! -f "$thumb_path" ] || [ "$img" -nt "$thumb_path" ]; then
        if command -v magick &> /dev/null; then
            magick "$img" -thumbnail 120x90^ -gravity center -extent 120x90 "$thumb_path" &> /dev/null
        elif command -v convert &> /dev/null; then
            convert "$img" -thumbnail 120x90^ -gravity center -extent 120x90 "$thumb_path" &> /dev/null
        else
            cp "$img" "$thumb_path"
        fi
    fi
done

ROFI_INPUT=""
while read -r img; do
    img_name=$(basename "$img")
    thumb_path="$CACHE_DIR/$img_name.png"
    ROFI_INPUT+="$img_name\0icon\x1f$thumb_path\n"
done < <(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" \))

SELECTION=$(echo -e "$ROFI_INPUT" | rofi -dmenu \
    -i \
    -p "󰸉 Search" \
    -theme-str 'configuration { show-icons: true; icon-theme: "Papirus"; } listview { columns: 1; lines: 6; } element { orientation: horizontal; padding: 8px; } element-icon { size: 3.5em; margin: 0 12px 0 0; }')

if [ -z "$SELECTION" ]; then
    exit 0
fi

SELECTED_WALL="$WALLPAPER_DIR/$SELECTION"

if [ ! -f "$SELECTED_WALL" ]; then
    exit 1
fi

wal -n -i "$SELECTED_WALL"
nitrogen --set-zoom-fill "$SELECTED_WALL" --head=0 &> /dev/null

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
bg=$(xrdb -query | awk '/\*background:/ {print $2}')

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
