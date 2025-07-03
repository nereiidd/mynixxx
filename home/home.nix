# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs, ... }:
{
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./hyprland.nix
    ./hyprconfig.nix
    ./variables.nix
    ./rofi.nix
    ./waybar
    ./swaync/swaync.nix
    ./superfile/superfile.nix
    ./foot/foot.nix
    ./gtk.nix
    ./btop.nix
    ./nemo.nix
  ];
}
