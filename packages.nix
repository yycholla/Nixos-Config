{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    #  neovim
    git
    gh
    networkmanagerapplet
    waybar
    kitty
    rofi-wayland
    swww
    pkgs.home-manager
    pkgs.alejandra
    stremio
    vscode
    hwinfo
  ];
}
