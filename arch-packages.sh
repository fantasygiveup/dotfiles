#!/usr/bin/env bash
#

pushd /tmp || return
git clone https://aur.archlinux.org/yay.git
cd yay || return
makepkg -is --noconfirm
rm -rf yay
popd || return

yay -Syu --noconfirm

pkgs=(
    audacity
    bc
    betterbird-bin  # thunderbird but better
    biber  # required by homepage
    cmake
    cronie  # crontab
    dmidecode  # virt-manager
    dnsmasq  # virt-manager
    docker
    docker-compose
    docker-scan # scan vulnerabilities
    fd
    ffmpeg
    firefox
    fzf
    gnupg
    google-cloud-cli # work related
    google-cloud-cli-gke-gcloud-auth-plugin # work related
    graphviz
    htop
    hugo  # homepage
    hunspell-en_us
    inetutils # hostname
    inkscape
    jq
    k9s # cli k8s frontend
    kubectl
    lazygit
    lf # cli file navigator
    libreoffice-fresh
    libreoffice-fresh-en-gb
    libreoffice-fresh-uk
    libvirt
    lua-language-server
    mpv
    neofetch
    nmap
    nodejs-lts-hydrogen
    noto-color-emoji-fontconfig # fix alacritty emoji
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji  # fix alacritty emoji
    npm
    nvim
    p7zip
    pandoc
    perl-file-mimeinfo # provides mimeopen and mimetype (see https://wiki.archlinux.org/title/default_applications#perl-file-mimeinfo)
    pigz # docker
    pomatez  # pomodoro app
    postgresql
    python-pip
    qbittorrent
    qemu # virt-manager
    qemu-emulators-full # libvirt
    qt5-wayland
    qt6-wayland
    ripgrep
    rust
    rust-analyzer
    shellcheck
    slack-desktop
    stylua
    tea
    texlive-bibtexextra # homepage
    texlive-fontsextra # homepage
    texlive-latexextra # homepage
    tmux
    tree
    ttf-jetbrains-mono-nerd
    unzip
    usbutils  # lsusb
    virt-manager
    viu # preview images in the terminal
    wireguard-tools
    wireshark-qt
    wl-clipboard
    xdg-desktop-portal
    xdg-desktop-portal-wlr  # (powered by wireplumber) required for screen sharing on Wayland
    yamllint
    yarn
    yarr # rss browser reader
    yt-dlp
    zip
    zsh-autosuggestions
    zsh-syntax-highlighting
    speech-dispatcher  # required by firefox
)

gnome_pkgs=(
    gnome-terminal
    gpaste # clipboard manager
    obsidian-icon-theme
    xclip
)

sway_pkgs=(
    autotiling-rs  # spiral tiling sway/i3
    bemenu # wayland menu / runner
    blueman # bluetooth manager
    brightnessctl # part of sway wm
    cliphist # persistent clipboard history
    gnome-keyring # required by auto unlock gpg, ssh keys
    grim # for color-pick
    gtk-engine-murrine # required for arc theme
    gvfs-mtp  # android mtp
    imagemagick # required by grim
    imv # image viewer
    libsecret # required by auto unlock gpg, ssh keys
    mako # notification service
    man-pages # posix pages
    mtpfs # android mtp
    otf-font-awesome  # required by waybar
    pipewire-pulse
    pulsemixer # sound cli interface
    python-i3ipc # sway rpc
    seahorse # required by auto unlock gpg, ssh keys
    slurp  # select regeion on Wayland
    swaybg  # set background from terminal
    swayidle  # see sway/config
    swaylock  # see sway/config
    thunar  # gui file manager
    ttf-roboto  # required by waybar
    ttf-roboto-mono  # required by waybar
    ttf-ubuntu-font-family
    ttf-ubuntu-mono-nerd
    ttf-ubuntu-nerd
    waybar # part of sway wm
    wev-git # transcribe keyboard and mouth events
    wf-recorder  # audio and screen recording for Wayland
    wlsunset # day/night gamma adjustments
    xdg-utils # xdg-open
    xfce4-settings  # for xfce4-appearance-settings
)


## Ubuntu fonts.
[ -x "$(command -v gnome-shell)" ] && yay -Rnsdd bubblewrap --noconfirm
yay -S fontconfig-ubuntu
[ -x "$(command -v gnome-shell)" ] && yay yay -S bubblewrap --noconfirm

# Install packages.
yay -S "${pkgs[@]}"
[ -x "$(command -v gnome-shell)" ] && yay -S "${gnome_pkgs[@]}"
[ -n "$SWAYSOCK" ] && yay -S "${sway_pkgs[@]}"

sudo -H python3 -m pip install pyright virtualenv yapf flake8
sudo -H npm install -g n vscode-css-languageserver-bin vscode-langservers-extracted typescript typescript-language-server eslint prettier emmet-ls pyright

go install golang.org/x/tools/gopls@latest
go install golang.org/x/tools/cmd/goimports@latest
go install github.com/segmentio/golines@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install github.com/illia-danko/fdir@latest

sudo usermod -a -G docker "$USER"
sudo usermod -a -G libvirt "$USER"
sudo usermod -a -G wireshark "$USER"
sudo systemctl enable libvirtd.service --now
sudo systemctl enable docker.service --now
sudo systemctl enable cronie.service --now
systemctl --user enable wireplumber --now  # audio
systemctl --user enable pipewire-pulse.service --now  # bluetooth

if [ -n "$SWAYSOCK" ]; then
    # Auto open on login ssh and gpg keys.
    sudo perl -i -p -e 's/components=".*"/components="pkcs11,secrets,ssh"/;' \
        /usr/lib/systemd/user/gnome-keyring-daemon.service
    systemctl --user enable gcr-ssh-agent.service

    f="/etc/pam.d/login"
    s="auth optional pam_gnome_keyring.so"
    grep -q "$s" "$f" || (echo "$s" | sudo tee -a "$f")
    s="session optional pam_gnome_keyring.so auto_start"
    grep -q "$s" "$f" || (echo "$s" | sudo tee -a "$f")
    unset f s
fi
