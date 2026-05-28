{
  description = "Your new nix config";

  inputs = {
   # nixpkgs.url = "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";   

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland = {
      url = "github:hyprwm/Hyprland";
     # inputs.nixpkgs.follows = "nixpkgs";
    };

    hypr-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "hyprland/nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    nur.url = "github:nix-community/NUR";

    nix-gaming.url = "github:fufexan/nix-gaming";

    ghostty = {
      url = "github:ghostty-org/ghostty";
      inputs.nixpkgs.follows = "nixpkgs"; 
    };
  };

 # nixConfig = {
 #   extra-substituters = [
 #     "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
 #   ];
 #   extra-trusted-public-keys = [
 #     "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
 #   ];
 # };

  #nixConfig = {
    #substituters = [
      #"https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store?priority=10"
      #"https://cache.nixos.org"
    #];
    #trusted-public-keys = [
      #"cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    #];
  #};

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs:
  let
    username = "surtr";
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    lib = nixpkgs.lib;
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      surtrnixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit self inputs;};
        modules = [./nixos-config/configuration.nix];
      };
    };
  };
}
