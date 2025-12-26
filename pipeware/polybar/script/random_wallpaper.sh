#!/bin/bash

# Path ke direktori wallpaper Anda
WALLPAPER_DIR="$HOME/Pictures/wallpaper"

# Tambahkan direktori wallpaper ke konfigurasi Nitrogen (jika belum)
# Nitrogen perlu tahu direktori mana yang harus diacak
# (Biasanya ini dilakukan manual di GUI, tapi kita coba tambahkan di sini jika perlu)
# nitrogen --set-dir "$WALLPAPER_DIR" &> /dev/null

# Jalankan Nitrogen untuk memilih wallpaper acak dari direktori yang sudah terdaftar,
# dan mengaturnya dengan mode --set-zoom-fill.
# Jika direktori sudah terdaftar di GUI Nitrogen, perintah ini akan berfungsi.

nitrogen --random --set-zoom-fill "$WALLPAPER_DIR"

# Jika `--set-zoom-fill` membutuhkan nama file, bukan direktori,
# kita mungkin perlu menggunakan perintah yang lebih sederhana:
# nitrogen --random --set-zoom-fill 
# (Perintah ini mengasumsikan direktori sudah ditambahkan di GUI Nitrogen)
