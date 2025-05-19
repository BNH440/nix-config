{ pkgs, ... }:

{
  imports = [
    ./appearance.nix
    ./hyprpanel.nix
    ./shell.nix
  ];

  home.packages = with pkgs; [
    # Programming
    zed-editor
    nil # nixos language support
    nixd # ^^
    # Productivity
    obsidian
    thunderbird-bin
    gimp
    darktable
    # Media
    ncspot # Spotify
    # Communication
    vesktop # discord client
    signal-desktop
    # Games
    prismlauncher # minecraft
    lutris
    bottles
  ];

  # see configuration.nix for flatpaks

  home.stateVersion = "24.11";
}
