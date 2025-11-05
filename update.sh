#!/bin/bash

# Direktori tujuan backup (Diasumsikan script ini dijalankan di dalam direktori "config")
DEST_DIR="${PWD}"

# Direktori sumber konfigurasi (Home Directory)
SRC_DIR="${HOME}/.config/"

# --- Gunakan rsync untuk menyalin, mengabaikan folder .git ---

# Menyalin folder Alacritty, bspwm, nvim, picom, rofi, sxhkd, polybar, dan dunst
rsync -av \
    --exclude '.git' \
    "${SRC_DIR}alacritty" \
    "${SRC_DIR}bspwm" \
    "${SRC_DIR}nvim" \
    "${SRC_DIR}picom" \
    "${SRC_DIR}rofi" \
    "${SRC_DIR}sxhkd" \
    "${SRC_DIR}polybar" \
    "${SRC_DIR}dunst" \
    "${DEST_DIR}"

# Menyalin file libinput-gestures.conf
cp "${HOME}/.config/libinput-gestures.conf" "${DEST_DIR}"

echo "Backup konfigurasi berhasil diselesaikan. Folder .git telah diabaikan."
