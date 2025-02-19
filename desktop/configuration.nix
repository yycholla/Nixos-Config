# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../nvf-configurations.nix
    ../packages.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  fonts.fontDir.enable = true;

  users.defaultUserShell = pkgs.zsh;
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "yycholla-nixd";
    networkmanager = {
      enable = true;
    };
  };

  # Set your time zone.
  time.timeZone = "America/Denver";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  # Enable the X11 windowing system.
  services = {
    tailscale = {
      enable = true;
    };
    xserver = {
      enable = true;
      # videoDrivers = ["nvidia"];
      displayManager = {
        gdm = {
          enable = true;
          wayland = true;
        };
      };
      # Set keyboard type
      xkb = {
        layout = "us";
        variant = "";
      };
    };
    fail2ban.enable = true;
    openssh = {
      enable = true;
      ports = [22];
      settings = {
        X11Forwarding = true;
        PasswordAuthentication = true;
        UseDns = true;
        PermitRootLogin = "prohibit-password";
      };
    };
    sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;
    };
    displayManager = {
      autoLogin = {
        enable = true;
        user = "yycholla";
      };
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      jack.enable = true;
    };
    # Enable CUPS to print documents.
    printing = {
      enable = true;
    };
    lorri = {
      enable = true;
    };
  };

  # Enable sound with pipewire.
  security.rtkit.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.yycholla = {
    isNormalUser = true;
    description = "Colin Hanway";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
  };

  # Install firefox.
  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;
      xwayland.enable = true;
    };
    zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
      autosuggestions.enable = true;
      ohMyZsh = {
        enable = true;
      };
    };
    starship = {
      enable = true;
    };
  };
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    HOSTNAME = "yycholla-nixd";
  };
  hardware = {
    graphics.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
    nerd-fonts.fira-code
    jetbrains-mono
    nerd-fonts.iosevka-term
  ];
  environment.variables = {
    EDITOR = "nvim";
    HOSTNAME = "yycholla-nixd";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.

  networking.firewall = {
    enable = true;
  };
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
