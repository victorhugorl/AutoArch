#!/bin/bash
# script to install packages

set -e

echo "Updating system..."
sudo pacman -Syu --noconfirm

echo "installing basic utilities"
sudo pacman -S --noconfirm --needed \
nano \
git \
curl \
wget \
htop \
neofetch \
unzip \
openssh \
networkmanager \
bluez \
bluez-utils \
cups \
avahi \
reflector \
steam \
base-devel \
go \
zsh \
dkms \
perl \
gcc \
make \
mariadb-clients \
openssl \
readline \
sqlite \
llvm \
ncurses \
xz \
tk \
libffi \
flatpak \
xf86-video-amdgpu \
vulkan-tools \
code


echo "installing yay..."

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ~

echo "installing packages from yay"
yay -S --noconfirm \
ttf-ms-fonts \
spotube \
xboxdrv \
brave \


echo "installing some adicional packages..."
sudo pacman -Sy --noconfirm \
retroarch \
qbittorrent \
firefox \
libreoffice-fresh \
vlc \
postgresql \
virtualbox \
virtualbox-host-modules-arch \
linux-rt-headers \
obs-studio \

echo "installing some packages with flatpak..."
flatpak install flathub net.pcsx2.PCSX2
flatpak install flathub net.rpcs3.RPCS3
flatpak install flathub net.shadps4.shadPS4
flatpak install flathub info.cemu.Cemu
flatpak install flathub org.DolphinEmu.dolphin-emu
flatpak install flathub io.github.ryubing.Ryujinx

echo "installing ollama..."
curl -fsSL https://ollama.com/install.sh | sh

echo "installing docker..."
sudo pacman -S --noconfirm docker
sudo systemctl enable --now docker

echo "adding user to docker group..."
sudo usermod -aG docker $USER

echo "installing vulkan and mesa drivers..."
sudo pacman -S --noconfirm \
vulkan-radeon \
mesa

echo "installing waydroid..."
yay -Sy --noconfirm waydroid
waydroid init -s GAPPS
sudo systemctl enable --now waydroid-container.service

echo "setting up font..."
mkdir -p ~/.fonts
git clone https://github.com/pdf/ubuntu-mono-powerline-ttf.git ~/.fonts/ubuntu-mono-powerline-ttf

fc-cache -vf

echo "setting zsh as default shell..."
chsh -s /bin/zsh

echo "setting up ohMyZsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "space ship zsh theme..."
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

echo "setting up zsh-autosuggestions..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "setting up zsh-syntax-highlighting..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Alterar o .zshrc para usar o Spaceship Prompt e outros plugins
sed -i 's/ZSH_THEME=".*"/ZSH_THEME="spaceship"/' ~/.zshrc
sed -i 's/plugins=(.*)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc

cd ~

