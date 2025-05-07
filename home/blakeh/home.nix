{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim
    croc
    zed-editor
    obsidian
  ];

  services.flatpak.packages = [
    { appId = "app.zen_browser.zen"; origin = "flathub";  }
    { appId = "com.discordapp.Discord"; origin = "flathub";  }
    { appId = "com.spotify.Client"; origin = "flathub";  }
  ];

  programs.bash.enable = true;
  home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
  home.file.".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
  home.file."wallpaper.png".source = ./wallpaper.png;

  home.stateVersion = "24.11";
}
