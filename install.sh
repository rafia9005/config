#!/bin/bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

if [ "$EUID" -eq 0 ]; then 
    print_error "Jangan jalankan script ini sebagai root!"
    exit 1
fi

if [ ! -f /etc/arch-release ]; then
    print_error "Script ini hanya untuk Arch Linux!"
    exit 1
fi

print_info "Memulai instalasi dependensi..."
echo ""

print_info "Mengupdate sistem..."
sudo pacman -Syu --noconfirm

PACKAGES=(
    "xorg"
    "xorg-server"
    "xorg-xinit"
    "xorg-xrandr"
    "xorg-xsetroot"
    "bspwm"
    "sxhkd"
    "picom"
    "alacritty"
    "rofi"
    "dunst"
    "libnotify"
    "polybar"
    "thunar"
    "thunar-volman"
    "thunar-archive-plugin"
    "gvfs"
    "nitrogen"
    "feh"
    "scrot"
    "maim"
    "xclip"
    "libinput"
    "libinput-gestures"
    "xf86-input-libinput"
    "pulseaudio"
    "pulseaudio-alsa"
    "pavucontrol"
    "alsa-utils"
    "ttf-dejavu"
    "ttf-liberation"
    "noto-fonts"
    "noto-fonts-emoji"
    "ttf-font-awesome"
    "ttf-jetbrains-mono"
    "ttf-jetbrains-mono-nerd"
    "htop"
    "neofetch"
    "git"
    "curl"
    "wget"
    "unzip"
    "zip"
    "xdotool"
    "xdo"
    "xprop"
    "networkmanager"
    "network-manager-applet"
    "brightnessctl"
    "light"
    "feh"
    "sxiv"
    "p7zip"
    "unrar"
    "xclip"
    "xsel"
    "acpi"
    "acpid"
    "lightdm"
    "lightdm-gtk-greeter"
    "gtk3"
    "gtk4"
    "gtk-engine-murrine"
    "gtk-engines"
    "gnome-themes-extra"
    "lxappearance"
    "qt5ct"
    "kvantum"
    "papirus-icon-theme"
    "arc-icon-theme"
    "xcursor-themes"
    "breeze"
    "xsettingsd"
    "dconf-editor"
)

print_info "Menginstall packages utama..."
for package in "${PACKAGES[@]}"; do
    if pacman -Qs $package > /dev/null ; then
        print_success "$package sudah terinstall"
    else
        print_info "Menginstall $package..."
        sudo pacman -S --noconfirm $package
    fi
done

echo ""
print_success "Semua packages utama berhasil diinstall!"
echo ""

if ! command -v yay &> /dev/null; then
    print_info "Menginstall yay (AUR helper)..."
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ~
    print_success "yay berhasil diinstall!"
else
    print_success "yay sudah terinstall"
fi

AUR_PACKAGES=(
    "picom-git"
    "polybar-git"
    "escrotum-git"
    "nerd-fonts-complete"
    "nordic-theme"
    "catppuccin-gtk-theme-mocha"
    "gruvbox-material-gtk-theme-git"
    "tokyo-night-gtk-theme-git"
    "bibata-cursor-theme"
    "tela-icon-theme"
)

print_info "Apakah Anda ingin menginstall package dari AUR? (y/n)"
read -r response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    print_info "Menginstall packages dari AUR..."
    for package in "${AUR_PACKAGES[@]}"; do
        if yay -Qs $package > /dev/null ; then
            print_success "$package sudah terinstall"
        else
            print_info "Menginstall $package..."
            yay -S --noconfirm $package
        fi
    done
fi

echo ""

print_info "Setting up libinput-gestures..."
sudo gpasswd -a $USER input
if [ -f "libinput-gestures.conf" ]; then
    print_info "Menyalin konfigurasi libinput-gestures..."
    mkdir -p ~/.config
    cp libinput-gestures.conf ~/.config/
    print_success "Konfigurasi libinput-gestures berhasil disalin"
fi

print_info "Membuat konfigurasi GTK default..."
mkdir -p ~/.config/gtk-3.0
mkdir -p ~/.config/gtk-4.0

cat > ~/.config/gtk-3.0/settings.ini << 'EOF'
[Settings]
gtk-theme-name=Adwaita-dark
gtk-icon-theme-name=Papirus-Dark
gtk-font-name=JetBrains Mono 10
gtk-cursor-theme-name=Breeze_Snow
gtk-cursor-theme-size=24
gtk-toolbar-style=GTK_TOOLBAR_BOTH_HORIZ
gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
gtk-button-images=1
gtk-menu-images=1
gtk-enable-event-sounds=1
gtk-enable-input-feedback-sounds=0
gtk-xft-antialias=1
gtk-xft-hinting=1
gtk-xft-hintstyle=hintfull
gtk-xft-rgba=rgb
gtk-application-prefer-dark-theme=1
EOF

print_success "Konfigurasi GTK 3.0 berhasil dibuat"

cat > ~/.config/gtk-4.0/settings.ini << 'EOF'
[Settings]
gtk-theme-name=Adwaita-dark
gtk-icon-theme-name=Papirus-Dark
gtk-font-name=JetBrains Mono 10
gtk-cursor-theme-name=Breeze_Snow
gtk-cursor-theme-size=24
gtk-application-prefer-dark-theme=1
EOF

print_success "Konfigurasi GTK 4.0 berhasil dibuat"

cat > ~/.gtkrc-2.0 << 'EOF'
gtk-theme-name="Adwaita-dark"
gtk-icon-theme-name="Papirus-Dark"
gtk-font-name="JetBrains Mono 10"
gtk-cursor-theme-name="Breeze_Snow"
gtk-cursor-theme-size=24
gtk-toolbar-style=GTK_TOOLBAR_BOTH_HORIZ
gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
gtk-button-images=1
gtk-menu-images=1
gtk-enable-event-sounds=1
gtk-enable-input-feedback-sounds=0
gtk-xft-antialias=1
gtk-xft-hinting=1
gtk-xft-hintstyle="hintfull"
gtk-xft-rgba="rgb"
EOF

print_success "Konfigurasi GTK 2.0 berhasil dibuat"

print_info "Membuat konfigurasi Qt5..."
mkdir -p ~/.config/qt5ct
cat > ~/.config/qt5ct/qt5ct.conf << 'EOF'
[Appearance]
color_scheme_path=/usr/share/qt5ct/colors/darker.conf
custom_palette=false
icon_theme=Papirus-Dark
standard_dialogs=default
style=Breeze

[Fonts]
fixed=@Variant(\0\0\0@\0\0\0\x1e\0J\0\x65\0t\0\x42\0r\0\x61\0i\0n\0s\0 \0M\0o\0n\0o@$\0\0\0\0\0\0\xff\xff\xff\xff\x5\x1\0\x32\x10)
general=@Variant(\0\0\0@\0\0\0\x1e\0J\0\x65\0t\0\x42\0r\0\x61\0i\0n\0s\0 \0M\0o\0n\0o@$\0\0\0\0\0\0\xff\xff\xff\xff\x5\x1\0\x32\x10)

[Interface]
activate_item_on_single_click=1
buttonbox_layout=0
cursor_flash_time=1000
dialog_buttons_have_icons=1
double_click_interval=400
gui_effects=@Invalid()
keyboard_scheme=2
menus_have_icons=true
show_shortcuts_in_context_menus=true
stylesheets=@Invalid()
toolbutton_style=4
underline_shortcut=1
wheel_scroll_lines=3

[SettingsWindow]
geometry=@ByteArray()
EOF

print_success "Konfigurasi Qt5 berhasil dibuat"

if ! grep -q "QT_QPA_PLATFORMTHEME" ~/.profile 2>/dev/null; then
    echo 'export QT_QPA_PLATFORMTHEME=qt5ct' >> ~/.profile
    print_success "QT_QPA_PLATFORMTHEME ditambahkan ke ~/.profile"
fi

print_success "Setup GTK & Qt configuration selesai!"
echo ""

print_info "Mengaktifkan services..."
sudo systemctl enable NetworkManager
sudo systemctl enable acpid

print_success "Services berhasil diaktifkan!"
echo ""

print_info "Apakah Anda ingin menyalin semua konfigurasi ke ~/.config? (y/n)"
read -r response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    print_info "Membuat backup konfigurasi lama..."
    if [ -d ~/.config ]; then
        mv ~/.config ~/.config.backup.$(date +%Y%m%d_%H%M%S)
        print_success "Backup dibuat di ~/.config.backup.$(date +%Y%m%d_%H%M%S)"
    fi
    
    print_info "Menyalin konfigurasi..."
    mkdir -p ~/.config
    
    for dir in alacritty bspwm dunst nvim picom polybar rofi sxhkd vesktop; do
        if [ -d "$dir" ]; then
            cp -r "$dir" ~/.config/
            print_success "Konfigurasi $dir berhasil disalin"
        fi
    done
    
    if [ -f "libinput-gestures.conf" ]; then
        cp libinput-gestures.conf ~/.config/
    fi
    
    mkdir -p ~/Pictures
    
    print_success "Semua konfigurasi berhasil disalin!"
fi

echo ""

print_info "Mengatur permission untuk scripts..."
chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/polybar/launch.sh
if [ -f ~/.config/bspwm/title_bar.sh ]; then
    chmod +x ~/.config/bspwm/title_bar.sh
fi
if [ -f ~/.config/polybar/script/brightness ]; then
    chmod +x ~/.config/polybar/script/brightness
fi
if [ -f ~/.config/polybar/script/wifi ]; then
    chmod +x ~/.config/polybar/script/wifi
fi
if [ -f ~/.config/polybar/script/colorscheme.sh ]; then
    chmod +x ~/.config/polybar/script/colorscheme.sh
fi
if [ -f ~/.config/polybar/script/random_wallpaper.sh ]; then
    chmod +x ~/.config/polybar/script/random_wallpaper.sh
fi

print_success "Permission berhasil diatur!"
echo ""

if command -v nvim &> /dev/null; then
    print_info "Apakah Anda ingin menginstall plugin Neovim sekarang? (y/n)"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        print_info "Membuka Neovim untuk menginstall plugins..."
        print_warning "Tekan :q untuk keluar setelah plugins selesai diinstall"
        sleep 2
        nvim +PackerSync
    fi
fi

echo ""
print_success "======================================"
print_success "    INSTALASI SELESAI!"
print_success "======================================"
echo ""
print_info "Langkah selanjutnya:"
echo "1. Logout dari sesi saat ini"
echo "2. Login dengan BSPWM sebagai window manager"
echo "3. Atau jalankan: startx (jika tidak menggunakan display manager)"
echo ""
print_info "Untuk menggunakan libinput-gestures, jalankan:"
echo "   libinput-gestures-setup start"
echo "   libinput-gestures-setup autostart"
echo ""
print_info "Untuk mengubah tema GTK, jalankan:"
echo "   lxappearance"
echo ""
print_info "Untuk mengubah tema Qt5, jalankan:"
echo "   qt5ct"
echo ""
print_info "Shortcut penting:"
echo "   Super + Return       : Terminal (Alacritty)"
echo "   Super + M            : Application Launcher (Rofi)"
echo "   Super + Q            : Close Window"
echo "   Super + Alt + R      : Restart BSPWM"
echo "   Super + E            : File Manager (Thunar)"
echo "   Print                : Screenshot"
echo ""
print_warning "Jangan lupa untuk restart sistem Anda!"
echo ""
