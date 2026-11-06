#!/bin/bash

# Ambil wallpaper yang saat ini diatur oleh Nitrogen
WALLPAPER=$(nitrogen --get-current)

# Ambil warna dominan dari wallpaper
# Menggunakan ImageMagick untuk mendapatkan warna dari gambar
COLOR=$(convert "$WALLPAPER" -resize 1x1 txt:- | grep -oP '#\w+')

# Cetak warna
echo "$COLOR"

