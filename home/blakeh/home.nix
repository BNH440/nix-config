{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./appearance.nix
    ./hyprpanel.nix
  ];

  home.packages = with pkgs; [
    # Programming
    neovim
    zed-editor
    # Productivity
    obsidian
    thunderbird
    obs-studio
    # Media
    ncspot # Spotify
    # Communication
    vesktop # discord client
    # CLI
    croc
    starship
    thefuck
    btop
    lazygit
    # Theming
    adwaita-icon-theme
    vanilla-dmz # cursor theme
  ];

  # see configuration.nix for flatpaks

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      neofetch --disable packages
    '';
  };
  programs.starship = {
    enable = true;
    settings = {
      format = ''$username$hostname$directory$git_branch$git_state$git_status$cmd_duration$line_break$python$character'';

      directory.style = "bright-blue";

      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
        vimcmd_symbol = "[❮](green)";
      };

      git_branch = {
        format = "[$branch]($style)";
        style = "bright-white";
      };

      git_status = {
        format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)";
        style = "cyan";
        conflicted = "";
        untracked = "";
        modified = "";
        staged = "";
        renamed = "";
        deleted = "";
        stashed = "≡";
      };

      git_state = {
        format = ''([$state( $progress_current/$progress_total)]($style)) '';
        style = "bright-white";
      };

      cmd_duration = {
        format = "[$duration]($style) ";
        style = "yellow";
      };

      python = {
        format = "[$virtualenv]($style) ";
        style = "bright-white";
      };
    };
  };
  home.shell.enableBashIntegration = true;
  home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
  home.file.".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
  home.file.".config/foot/foot.ini".source = lib.mkForce ./foot.ini;
  home.file."wallpaper.png".source = ./wallpaper.png;
  home.file.".config/hypr/hyprlock.conf".source = ./hyprlock.conf;

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

  home.stateVersion = "24.11";
}
