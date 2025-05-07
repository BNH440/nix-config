{ config, pkgs, ... }:

{
  home.packages = [];
  programs.bash.enable = true;
  home.file.".config/hypr/hyprland.conf".source = ./user/hyprland.conf;
  home.file.".config/hypr/hyprpaper.conf".source = ./user/hyprpaper.conf;
  home.file."wallpaper.png".source = ./user/wallpaper.png;

  home.stateVersion = "24.11";
}
