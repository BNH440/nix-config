{ config, pkgs, ... }:

{
  home.packages = [];
  programs.bash.enable = true;
  home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
  home.file.".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
  home.file."wallpaper.png".source = ./wallpaper.png;

  home.stateVersion = "24.11";
}
