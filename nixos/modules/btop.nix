{ pkgs, ... }:
{
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "horizon";
      theme_background = false;
      update_ms = 500;
      rounded_corners = true;
    };
  };
  home.packages = with pkgs; [ nvtopPackages.intel ];
}
