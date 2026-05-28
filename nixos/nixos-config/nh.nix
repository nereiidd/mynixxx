{ pkgs, ... }:
{
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 14d --keep 7";
    };
    flake = "/home/surtr/nixos/";
  };
  environment.systemPackages = with pkgs; [
    nix-output-monitor
    nvd
  ];
}
