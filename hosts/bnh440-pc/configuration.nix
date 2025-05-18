# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./nvidia.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "bnh440-pc"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
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

  # Fonts
  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.meslo-lg
  ];

  # Audio
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  # Desktop
  programs.hyprland.enable = true;
  environment.sessionVariables.XDG_CURRENT_DESKTOP = "Hyprland";
  environment.sessionVariables.NIXOS_OZONE_WL = "1"; # fix some electron apps for wayland

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
      xdg-desktop-portal-hyprland
    ];
  };

  # Apperance
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/default-dark.yaml";
    cursor = {
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
      size = 24;
    };
  };

  # Login
  services.greetd.enable = true;
  services.greetd.settings = {
    default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --asterisks --time --remember --sessions /etc/greetd/sessions --cmd Hyprland";
      user = "greeter";
    };
  };

  # Keyring
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd = {
    text = ''
        auth      substack      login
        account   include       login
        password  substack      login
        session   include       login
    '';
    enableGnomeKeyring = true;
  };

  # Lock screen
  programs.hyprlock.enable = true; # TODO re-enable hyprlock on a gpu accel machine
  security.pam.services.hyprlock = {};

  # Clipboard manager
  systemd.user.services.clipmenud = {
    description = "Clipboard menu daemon";
    wantedBy    = [ "default.target" ];
    serviceConfig = {
    ExecStart = "${pkgs.clipmenu}/bin/clipmenud";
    Restart   = "always";
    };
  };

  # Users
  users.users.blakeh = {
    isNormalUser = true;
    description = "Blake Haug";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Packages
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # CLI utilities
    vim
    wget
    git
    htop
    neofetch
    tree
    # UI
    hyprland
    hyprpanel
    hyprcursor
    foot # terminal
    wofi
    hyprpaper
    xfce.thunar # file manager
    xfce.thunar-archive-plugin
    base16-schemes
    qimgv # image viewer
    mpv # video player
    hyprlock # locking utility
    # Settings
    pavucontrol
    networkmanagerapplet
    gnome-software
    # Misc
    gvfs # fs plugin for thunar
    gnome-keyring # secret manager
    xwayland # X11 support
    wl-clipboard # Clipboard manager
    vanilla-dmz # cursor theme
    hyprpolkitagent # elevation utility
  ];

  programs.thunar.enable = true;
  programs.xfconf.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  services.flatpak.enable = true;
  services.flatpak.update.auto = {
    enable = true;
    onCalendar = "weekly";
  };
  services.flatpak.packages = [
    { appId = "app.zen_browser.zen"; origin = "flathub";  }
    { appId = "com.discordapp.Discord"; origin = "flathub";  }
    { appId = "com.spotify.Client"; origin = "flathub";  }
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';




  # # Configure keymap in X11
  # services.xserver.xkb = {
  #   layout = "us";
  #   variant = "";
  # };

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
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
