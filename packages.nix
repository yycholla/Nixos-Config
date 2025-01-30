{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    #  neovim
    git
    gh
    kitty
    rofi-wayland
    swww
    pkgs.home-manager
    pkgs.hyprpanel
    pkgs.alejandra
    stremio
    vscode
    hwinfo
  ];
}
