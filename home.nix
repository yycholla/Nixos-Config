{
  system,
  inputs,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    username = "yycholla";
    homeDirectory = "/home/yycholla";
    stateVersion = "24.11"; # Please read the comment before changing.
  };

  home.packages = [
    inputs.zen-browser.packages."${system}".specific
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/yycholla/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  programs = {
    nushell = {
      enable = false;
      shellAliases = {
        ll = "ls -l";
        update = "~/scripts/nixos-rebuild.sh";
        cat = "bat";
      };
      configFile = {
        text = ''          '
                    use std/util "path add"
                    $env.config.buffer_editor = "nvim"
                    path add "/home/yycholla/.cargo/bin"
                    $env.config.show_banner = false
                    mkdir ($nu.data-dir | path join "vendor/autoload")
                    starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
                    source ~/Nixos-Config/dotfiles/nushell/catppuccin_machiato.nu

                    pokeget random --hide-name | fastfetch --file-raw -
        '';
      };
      envFile = {
      };
    };
    kitty = {
      enable = false;
      themeFile = "Catppuccin-Mocha";
      font.name = "JetBrains Mono";
      settings = {
        shell = "nu";
      };
    };
  };
  # Catpussy thing
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = false;
}
