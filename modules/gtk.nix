{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
   # nerd-fonts.fira-code
   # nerd-fonts.caskaydia-cove
    nerd-fonts.symbols-only
    twemoji-color-font
    noto-fonts-emoji
   # fantasque-sans-mono
    maple-mono.truetype-autohint
  ];
  gtk = {
    enable = true;
    font = {
      name = "Maple Mono";
      size = 12;
    };
    theme = {
      name = "Nordic";   # Colloid-Green-Dark-Gruvbox # Colloid-Teal-Dark-Nord
      package = pkgs.nordic; #.override {
       # colorVariants = [ "dark" ];
       # themeVariants = [ "teal" ];
       # tweaks = [
       #   "all"
       #   "rimless"
       #   "float"
       #   "normal"
       # ];
     # };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme.override { color = "cyan"; };
    };
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };
  };
  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
  };
}
