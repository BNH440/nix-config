{ inputs, ... }:
{
  imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];

  programs.hyprpanel = {

    # Enable the module.
    # Default: false
    enable = true;

    # Automatically restart HyprPanel with systemd.
    # Useful when updating your config so that you
    # don't need to manually restart it.
    # Default: false
    systemd.enable = true;

    # Add '/nix/store/.../hyprpanel' to your
    # Hyprland config 'exec-once'.
    # Default: false
    hyprland.enable = true;

    # Fix the overwrite issue with HyprPanel.
    # See below for more information.
    # Default: false
    overwrite.enable = true;

    # Override the final config with an arbitrary set.
    # Useful for overriding colors in your selected theme.
    # Default: {}
    override = {};

    # Configure and theme almost all options from the GUI.
    # Options that require '{}' or '[]' are not yet implemented,
    # except for the layout above.
    # See 'https://hyprpanel.com/configuration/settings.html'.
    # Default: <same as gui>
    settings = {
      bar.launcher.autoDetectIcon = true;
      bar.workspaces.show_numbered = true;
      bar.windowtitle.custom_title = true;

      # Configure bar layouts for monitors.
      # See 'https://hyprpanel.com/configuration/panel.html'.
      # Default: null
      bar.layouts = {
        "0" = {
        left = [ "dashboard" "workspaces" "windowtitle" ];
        middle = [ "media" ];
        right = [
            "volume"
            "network"
            # "bluetooth"
            "systray"
            "clock"
            "notifications"
        ];
        };
      };

      menus.dashboard.directories.enabled = false;

      menus.clock = {
        time = {
          military = false;
          hideSeconds = true;
        };
        weather.unit = "imperial";
      };

      # Import a theme from './themes/*.json'.
      # Default: ""
      theme.name = "monochrome";

      theme.bar.transparent = true;

      theme.font = {
        name = "MesloLGS Nerd Font Regular";
        size = "0.9rem";
      };
    };
  };
}
