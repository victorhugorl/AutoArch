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
code \
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
python-openssl \
flatpak \
xf86-video-amdgpu \
vulkan-tools \

echo "installing pyenv"
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

echo "setting pyenv in .zshrc..."

echo -e "\n# Configuração do pyenv" >> ~/.zshrc
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'if command -v pyenv 1>/dev/null 2>&1; then' >> ~/.zshrc
echo '  eval "$(pyenv init -)"' >> ~/.zshrc
echo 'fi' >> ~/.zshrc

echo "setting zsh as default shell..."
chsh -s /bin/zsh
zsh

echo "setting up ohMyZsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "space ship zsh theme..."
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

echo "setting up zsh-autosuggestions..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Alterar o .zshrc para usar o Spaceship Prompt e outros plugins
sed -i 's/ZSH_THEME=".*"/ZSH_THEME="spaceship"/' ~/.zshrc
sed -i 's/plugins=(.*)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc

echo "setting up font..."
mkdir -p ~/.fonts
git clone https://github.com/pdf/ubuntu-mono-powerline-ttf.git ~/.fonts/ubuntu-mono-powerline-ttf
fc-cache -vf

source ~/.zshrc

cd ~

echo "installing nvm and nodejs..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

nvm install node
nvm use node


echo "installing yay..."

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..

echo "installing packages from yay"
yay -S --noconfirm \
ttf-ms-fonts \
spotube \
xboxdrv \




echo "installing some adicional packages..."
pacman -Sy --noconfirm \
retroarch \
qbittorrent \
libreoffice-fresh \
vlc \
postgresql \
virtualbox \
virtualbox-host-modules-arch \
linux-rt-headers \
obs-studio \

echo "installing some packages with flatpak..."
flatpak install flathub net.rpcs3.RPCS3
flatpak install flathub net.pcsx2.PCSX2
flatpak install flathub org.DolphinEmu.dolphin-emu
flatpak install flathub net.shadps4.shadPS4


echo "installing ollama..."
curl -fsSL https://ollama.com/install.sh | sh

echo "installing docker..."
sudo pacman -S docker
sudo systemctl enable --now docker

echo "installing vulkan drivers..."
sudo pacman -S vulkan-radeon





fc-cache -vf
