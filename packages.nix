{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = [
    #  neovim
    pkgs.wget
    pkgs.direnv
    pkgs.sway
    pkgs.stow
    # pkgs.neovim
    pkgs.lunarvim
    pkgs.ghostty
    pkgs.psmisc
    pkgs.zip
    pkgs.python313
    pkgs.python313Packages.pip
    pkgs.nodejs
    pkgs.btop
    pkgs.unzip
    pkgs.gum
    pkgs.rsync
    pkgs.figlet
    pkgs.vim
    pkgs.xdg-user-dirs
    pkgs.man-pages
    pkgs.networkmanager
    pkgs.git
    pkgs.pywal
    pkgs.gh
    pkgs.zip
    pkgs.xz
    pkgs.unzip
    pkgs.zsh
    pkgs.bat
    pkgs.ranger
    pkgs.starship
    pkgs.networkmanagerapplet
    pkgs.catppuccin
    pkgs.waybar
    pkgs.kitty
    pkgs.jetbrains-mono
    pkgs.hyprpaper
    pkgs.rofi-wayland
    pkgs.home-manager
    pkgs.alejandra
    pkgs.fastfetch
    pkgs.stremio
    pkgs.vscode
    pkgs.hwinfo
    inputs.swww.packages.${pkgs.system}.swww
    inputs.pyprland.packages.${pkgs.system}.pyprland
    pkgs.nushell
    pkgs.wayvnc
    pkgs.rustc
    pkgs.cargo
    pkgs.gcc
    pkgs.barrier
    pkgs.carapace
  ];
}
