
{ config, lib, pkgs,inputs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix  
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  stylix = {
    enable = true;
    image = ./wallpaper.png;
    polarity = "dark";
  };
  hardware.bluetooth.enable = true; # 
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
  networking.hostName = "edmondo"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  programs.ssh.startAgent = true;
  boot.loader.systemd-boot.consoleMode = "1";
  # Set your time zone.
  time.timeZone = "America/New_York";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  security.pam.loginLimits = [
    {
      domain = "*";
      type = "soft";
      item = "nofile";
      value = "64000";
    }
  ];
  users.users.edmondo = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    initialPassword = "pw123";
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
      git
      tree
    ];
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];


  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    font-awesome
    fira-code
    noto-fonts
    noto-fonts-emoji
    liberation_ttf
  ];
  programs.neovim.enable = true;
  programs.thunar.enable = true;

  programs.git = {
    enable = true;
  };

  environment.variables.OH_MY_ZSH_PATH = "${pkgs.oh-my-zsh}/share/oh-my-zsh";



  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    bat
    bitwarden-desktop
    bitwarden-cli
    bitwarden-menu
    bluetuith
    brave
    cargo
    colorls
    dunst
    element-desktop
    fzf
    gcc
    go
    google-chrome
    hyprpaper
    kitty
    libnotify
    neofetch
    networkmanagerapplet
    nixpkgs-fmt
    nodejs
    obsidian
    oh-my-zsh
    pavucontrol
    pnpm
    pyenv
    python3
    inputs.pyprland.packages.${pkgs.system}.default
    ripgrep
    rofi-wayland
    rustup
    slack
    starship
    stow
    swww
    tmux
    tmuxifier
    unzip
    vim
    waybar
    wget
    whatsapp-for-linux
    wl-clipboard
    zoxide
  ];

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.zsh.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;

  };

  programs.waybar.enable = true;
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      options = "";
    };
  };
  services.displayManager.sddm = {
    wayland.enable = true;
    enable = true;
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}

