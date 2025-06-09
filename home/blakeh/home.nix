{ pkgs, ... }:

{
  imports = [
    ./shell.nix
  ];

  home.packages = with pkgs; [
    # Programming
    neovim
    zed-editor
    # Productivity
    obsidian
    thunderbird
    obs-studio
    gimp
    darktable
    # Media
    ncspot # Spotify
    # Communication
    vesktop # discord client
    signal-desktop
  ];

  # see configuration.nix for flatpaks

  home.stateVersion = "24.11";
}