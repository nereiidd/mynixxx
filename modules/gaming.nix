{ pkgs, inputs,  ... }:
{

  home.packages = with pkgs; [
   # inputs.nix-gaming.packages.${pkgs.system}.wine-ge
    wineWowPackages.waylandFull
    winetricks
    mangohud
    protonup-qt
    lutris
    bottles
   # heroic
    gamemode
    gamescope
  ];
}
