{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    # Theming
    adwaita-icon-theme
    vanilla-dmz # cursor theme
  ];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = lib.mkForce "prefer-dark";
      gtk-application-prefer-dark-theme = true;
    };
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Adwaita-Dark";
      package = pkgs.adwaita-icon-theme;
    };
    cursorTheme = {
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
    };
  };

  home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
  home.file.".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
  home.file."wallpaper.png".source = ./wallpaper.png;
  home.file.".config/hypr/hyprlock.conf".source = ./hyprlock.conf;
}
