{ config, pkgs, lib, ... }:

{
  imports = [ ./appearance.nix ];

  home.packages = with pkgs; [
    # Programming
    neovim
    zed-editor
    # Productivity
    obsidian
    geary
    # CLI
    croc
    starship
    thefuck
  ];

  # see configuration.nix for flatpaks

  programs.bash.enable = true;
  programs.starship.enable = true;
  home.shell.enableBashIntegration = true;
  home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
  home.file.".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
  home.file.".config/foot/foot.ini".source = lib.mkForce ./foot.ini;
  home.file.".config/starship.toml".source = lib.mkForce ./starship.toml;
  home.file."wallpaper.png".source = ./wallpaper.png;

  systemd.user.services.gnome-keyring = {
    Unit.Description = "GNOME Keyring";
    Service.ExecStart = "${pkgs.gnome-keyring}/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg";
    Install.WantedBy = [ "default.target" ];
  };

  home.stateVersion = "24.11";
}
