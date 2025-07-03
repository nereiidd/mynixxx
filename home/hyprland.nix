{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    wayland
    swww
    foot
    firefox
    rofi-wayland
    dunst
    libnotify
    brightnessctl                  #brightness keybind
    pamixer                        #volume keybind
    wl-clip-persist                #keep copy after program closes
    cliphist                       #Wayland clipboard manager with support for multimedia
    wl-clipboard                   #Command-line copy/paste utility wl-copy wl-paste
    grim                           #screenshot dependecy
    slurp                          #screenshot dependecy
    jq                             #JSON processor / screenshot dependecy
    hyprpicker                     #screenshot dependecy / colorpicker
    inputs.hypr-contrib.packages.${pkgs.system}.grimblast #screenshot
    xdg-utils
    waybar
    telegram-desktop
    neofetch
    xdg-desktop-portal-hyprland
    xkeyboard_config
    open-vm-tools
    imv
   # lollypop
   # vlc
   # mpv
   # obsidian
    unzip
    mesa
    nekoray
  ];

  systemd.user.targets.hyprland-session.Unit.Wants = [
    "xdg-desktop-autostart.target"
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    xwayland = {
      enable = true;
      # hidpi = true;
    };
    systemd.enable = true;
  };
}
