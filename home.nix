{
  config,
  pkgs,
  system,
  inputs,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "yycholla";
  home.homeDirectory = "/home/yycholla";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    zip
    xz
    unzip
    p7zip
    oh-my-zsh
    oh-my-posh
    inputs.zen-browser.packages."${system}".specific
    zsh
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
    git = {
      enable = true;
      userName = "yycholla";
      userEmail = "hanway.colin@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
        credential.helper = "oauth";
      };
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        ll = "ls -l";
        update = "~/mysystem/nixos-rebuild.sh";
      };
      history.size = 10000;
      #ohMyZsh = {
      #  enable = true;
      #  plugins = [
      #    "git"
      #    "thefuck"
      #  ];
      #  theme = "robbyrussell";
      #};
    };
  };
  # Catpussy thing
  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "blue";
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
