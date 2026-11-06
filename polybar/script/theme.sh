#!/bin/bash

# --- PATH KONFIGURASI ---
POLYBAR_WAL_COLOR="$HOME/.config/polybar/colors-wal.ini"
STARSHIP_CONF="$HOME/.config/starship.toml"
ALACRITTY_COLORS="$HOME/.config/alacritty/colors.toml"

# --- PALET TOKYO NIGHT DARK ---
bg="#1a1b26"
fg="#a9b1d6"
c0="#15161e"
c1="#f7768e"
c2="#9ece6a"
c3="#e0af68"
c4="#7aa2f7"
c5="#bb9af7"
c6="#7dcfff"
c7="#a9b1d6"
c8="#414868"
c11="#ff9e64"
c12="#7aa2f7"
c13="#bb9af7"
c15="#c0caf5"

# --- 1. UPDATE XRDB (Agar Terminal/Aplikasi X11 Berubah Warna Live) ---
cat <<EOF | xrdb -merge
*.background: $bg
*.foreground: $fg
*.color0:  $c0
*.color1:  $c1
*.color2:  $c2
*.color3:  $c3
*.color4:  $c4
*.color5:  $c5
*.color6:  $c6
*.color7:  $c7
*.color8:  $c8
*.color11: $c11
*.color12: $c12
*.color13: $c13
*.color15: $c15
EOF

# --- 2. UPDATE POLYBAR WAL COLOR ---
mkdir -p "$(dirname "$POLYBAR_WAL_COLOR")"
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

# --- 3. UPDATE ALACRITTY (Auto Live-Reload) ---
mkdir -p "$(dirname "$ALACRITTY_COLORS")"
cat <<EOF > "$ALACRITTY_COLORS"
[colors.primary]
background = "$bg"
foreground = "$fg"

[colors.normal]
black   = "$c0"
red     = "$c1"
green   = "$c2"
yellow  = "$c3"
blue    = "$c4"
magenta = "$c5"
cyan    = "$c6"
white   = "$c7"

[colors.bright]
black   = "$c8"
red     = "$c1"
green   = "$c2"
yellow  = "$c3"
blue    = "$c12"
magenta = "$c13"
cyan    = "$c6"
white   = "$c15"
EOF

# --- 4. BSPWM BORDER ---
bspc config normal_border_color "$c8"
bspc config focused_border_color "$c4"
bspc config active_border_color  "$c4"

# --- 5. RESTART POLYBAR (Clean Reload) ---
killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.1; done

chmod +x "$HOME/.config/polybar/launch.sh"
if [ -f "$HOME/.config/polybar/launch.sh" ]; then
    "$HOME/.config/polybar/launch.sh" &
fi

# --- 6. STARSHIP PROMPT ---
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
