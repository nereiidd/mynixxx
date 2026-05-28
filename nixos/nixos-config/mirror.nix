{ config, pkgs, lib, ... }:

{
  # Better: Override fetchurl's mirror list via nixpkgs config
  nixpkgs.config = {
    # Add your mirror as the primary GNU mirror
    # This affects all packages that use fetchurl with "mirror://gnu/"
    fetchers = {
      mirror = {
        # Prepend your mirror to the existing list
        gnu = [ 
          "https://ftp.yz.yamagata-u.ac.jp/pub/GNU/"
        ];
      };
    };
  };
}
