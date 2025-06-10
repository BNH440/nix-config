{ pkgs, ... }:

{
  imports = [
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
    # Media
    ncspot # Spotify
    # Communication
    vesktop # discord client
    signal-desktop
    slack
    # Games
    prismlauncher # minecraft
    lutris
    bottles
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/xhtml+xml" = "app.zen_browser.zen.desktop";
      "text/html" = "app.zen_browser.zen.desktop";
      "text/xml" = "app.zen_browser.zen.desktop";
      "x-scheme-handler/ftp" = "app.zen_browser.zen.desktop";
      "x-scheme-handler/http" = "app.zen_browser.zen.desktop";
      "x-scheme-handler/https" = "app.zen_browser.zen.desktop";
      "x-scheme-handler/discord" = "vesktop.desktop";
      "x-scheme-handler/mailto" = "userapp-Thunderbird-RCWD62.desktop";
      "message/rfc822" = "userapp-Thunderbird-RCWD62.desktop";
      "x-scheme-handler/mid" = "userapp-Thunderbird-RCWD62.desktop";
      "x-scheme-handler/webcal" = "userapp-Thunderbird-YK0M62.desktop";
      "text/calendar" = "userapp-Thunderbird-YK0M62.desktop";
      "application/x-extension-ics" = "userapp-Thunderbird-YK0M62.desktop";
      "x-scheme-handler/webcals" = "userapp-Thunderbird-YK0M62.desktop";
      "image/webp" = "qimgv.desktop";
      "image/png" = "qimgv.desktop";
      "image/jpeg" = "qimgv.desktop";
    };
  };

  # see configuration.nix for flatpaks

  home.stateVersion = "24.11";
}
