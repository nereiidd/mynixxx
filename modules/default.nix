# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs, ... }:
{
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./hyprland
   # ./rofi.nix
    ./waybar/waybar.nix      # changed
    ./swaync/swaync.nix      # changed
    ./superfile/superfile.nix
    ./gtk.nix
    ./btop.nix
    ./nemo.nix
    ./gaming.nix
    ./ghostty.nix    # changed
    ./xdg-mimes.nix
    ./scripts/scripts.nix   
  ];
}
