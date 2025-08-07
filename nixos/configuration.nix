{ inputs, config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
     # ./nekoray.nix
      ./steam.nix
      ./nh.nix
      ./flatpak.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "surtrnixos";
  networking.networkmanager.enable = true;

  time.timeZone = "";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
  #  font = "Lat2-Terminus16"; # Lat2-Terminus16
    keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  };
  
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

 # services.libinput.enable = true;

  users.users.surtr = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [
      tree
    ];
  };

  programs.git.enable = true;
  environment.systemPackages = with pkgs; [
    git
    wget
    nh
    lact
  ];
  
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = [ "multi-user.target"  ];

  virtualisation.waydroid.enable = true;

 # services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };  

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"      
        "flakes"
      ];
      substituters = [
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
        "https://nix-gaming.cachix.org"
        "https://ghostty.cachix.org"
      ];
      trusted-substituters = [
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
        "https://nix-gaming.cachix.org"
        "https://ghostty.cachix.org"     
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
      ];
    };
  };
  nixpkgs.config.allowUnfree = true;

  programs.nekoray.enable = true;
  programs.nekoray.tunMode.enable = true;
   
 # services.sing-box.enable = true;
 # services.xray.enable = true;
 # services.xray.settingsFile = "/home/surtr/.local/share/v2rayN/binConfigs/config.json";
  services.resolved.enable = true;
  services.cloudflare-warp.enable = true;

  networking.firewall.enable = true;
  networking.firewall.checkReversePath = "loose";
  services.openssh.enable = true;
  services.logind.lidSwitch = "ignore";
    
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useUserPackages = true;
    useGlobalPkgs = true;
    users.surtr = {
      imports =
          [ ../modules/default.nix ];
      home.username = "surtr";
      home.homeDirectory = "/home/surtr";
      home.stateVersion = "24.05";
      programs.home-manager.enable = true;
      programs.fish = {
        enable = true;
        interactiveShellInit = ''
          set fish_greeting # Disable greeting
        '';
      };
    };
  };

  documentation.man.generateCaches = false;
  programs.fish.enable = true;
 # users.defaultUserShell = pkgs.fish;
  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default;
    portalPackage =
      inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = [ "gtk" ];
      hyprland.default = [
        "gtk"
        "hyprland"
      ];
    };
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };


  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}

