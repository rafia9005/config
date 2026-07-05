#!/bin/bash
set -euo pipefail

SRC="${HOME}/.config/"
DEST="${PWD}"

echo "→ Backing up config to ${DEST}"

# Dirs to sync
DIRS=(alacritty bspwm dunst nvim picom pipewire polybar rofi sxhkd wal)

for d in "${DIRS[@]}"; do
    if [ -d "${SRC}${d}" ]; then
        rsync -aq --delete "${SRC}${d}/" "${DEST}/${d}/"
        echo "  ✓ ${d}"
    else
        echo "  ⚠ ${d} — missing in source"
    fi
done

# Standalone files
FILES=(libinput-gestures.conf starship.toml settings.json config.toml)

for f in "${FILES[@]}"; do
    if [ -f "${SRC}${f}" ]; then
        cp "${SRC}${f}" "${DEST}/${f}"
        echo "  ✓ ${f}"
    else
        echo "  ⚠ ${f} — missing in source"
    fi
done

echo "→ Done"
