{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim
    croc
    zed-editor
    obsidian
    starship
  ];

  # see configuration.nix for flatpaks

  programs.bash.enable = true;
  home.shell.enableBashIntegration = true;
  programs.starship.enable = true;
  home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
  home.file.".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
  home.file.".config/foot/foot.ini".source = ./foot.ini;
  home.file.".config/starship.toml".source = ./starship.toml;
  home.file."wallpaper.png".source = ./wallpaper.png;

  home.stateVersion = "24.11";
}
