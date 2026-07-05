#!/bin/bash

MODE_FILE="/tmp/theme_mode"
NITROGEN_CONFIG="$HOME/.config/nitrogen/bg-saved.cfg"
POLYBAR_WAL_COLOR="$HOME/.config/polybar/colors-wal.ini"

if [ -f "$NITROGEN_CONFIG" ]; then
    CURRENT_WALL=$(grep '^file=' "$NITROGEN_CONFIG" | head -n 1 | cut -d'=' -f2 | sed "s|~|$HOME|")
else
    exit 1
fi

if [ ! -f "$CURRENT_WALL" ]; then
    exit 1
fi

if [ ! -f "$MODE_FILE" ]; then
    echo "dark" > "$MODE_FILE"
fi

CURRENT_MODE=$(cat "$MODE_FILE")

if [ "$CURRENT_MODE" = "dark" ]; then
    NEXT_MODE="light"
    WAL_OPTS="-l"
else
    NEXT_MODE="dark"
    WAL_OPTS=""
fi

wal -n $WAL_OPTS -i "$CURRENT_WALL"
xrdb -merge "$HOME/.cache/wal/colors.Xresources"

echo "$NEXT_MODE" > "$MODE_FILE"

# Ambil warna mentah langsung dari xrdb untuk disuntikkan ke Polybar & BSPWM
c0=$(xrdb -query | grep -m 1 '\.color0:' | awk '{print $2}')
c1=$(xrdb -query | grep -m 1 '\.color1:' | awk '{print $2}')
c2=$(xrdb -query | grep -m 1 '\.color2:' | awk '{print $2}')
c3=$(xrdb -query | grep -m 1 '\.color3:' | awk '{print $2}')
c4=$(xrdb -query | grep -m 1 '\.color4:' | awk '{print $2}')
c5=$(xrdb -query | grep -m 1 '\.color5:' | awk '{print $2}')
c6=$(xrdb -query | grep -m 1 '\.color6:' | awk '{print $2}')
c7=$(xrdb -query | grep -m 1 '\.color7:' | awk '{print $2}')
c8=$(xrdb -query | grep -m 1 '\.color8:' | awk '{print $2}')
c11=$(xrdb -query | grep -m 1 '\.color11:' | awk '{print $2}')
c12=$(xrdb -query | grep -m 1 '\.color12:' | awk '{print $2}')
c13=$(xrdb -query | grep -m 1 '\.color13:' | awk '{print $2}')
c15=$(xrdb -query | grep -m 1 '\.color15:' | awk '{print $2}')
bg=$(xrdb -query | grep -m 1 '\.background:' | awk '{print $2}')
fg=$(xrdb -query | grep -m 1 '\.foreground:' | awk '{print $2}')

# BUAT FILE WARNA LANGSUNG UNTUK POLYBAR (Anti Gagal)
cat <<EOF > "$POLYBAR_WAL_COLOR"
[wal-colors]
background = $bg
foreground = $fg
blue = $c4
magenta = $c5
red = $c1
green = $c2
purple = $c13
yellow = $c3
cyan = $c6
orange = $c11
bg = $bg
bg-alt = $c8
fg = $c7
EOF

bspc config normal_border_color "$c8"
bspc config focused_border_color "$c4"
bspc config active_border_color  "$c4"

chmod +x "$HOME/.config/polybar/launch.sh"
if [ -f "$HOME/.config/polybar/launch.sh" ]; then
    "$HOME/.config/polybar/launch.sh"
fi

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
