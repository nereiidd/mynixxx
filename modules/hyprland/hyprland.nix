{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    wayland
    kitty
    swww
  #  foot
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
    swappy                         #edit screenshot
    zenity                         #dialouge (used for save recording)
    ffmpeg
    wf-recorder
    xdg-utils
    waybar
    telegram-desktop
    fastfetch
    xdg-desktop-portal-hyprland
    xkeyboard_config
    imv   # cli
   # lollypop
    vlc
    mpv   # cli
    obsidian
    unzip   # cli
    unrar   # cli
    file-roller  # gnome gui zip
    evince   # gnome pdf viewer
    gnome-text-editor
    dconf-editor
    mesa
    mesa-demos
    xdg-user-dirs
    shadowsocks-rust
   # qv2ray-unstable
    v2ray
    v2rayn
    xray
    sing-box
    vesktop
    rocmPackages.rocm-smi
    tree
    gamemode
    asciiquarium-transparent
    cbonsai
    cmatrix
    countryfetch
    fortune
    pipes
    caligula 
    qbittorrent
    nix-tree
    p7zip
    gnome-calculator
    go-mtpfs
    android-file-transfer
    tty-clock
    cloudflare-utils
    cloudflare-cli
    foliate
    pavucontrol
    love
    lovely-injector
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
