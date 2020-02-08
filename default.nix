{ pkgs, lib, ... }:

let
  alacritty = import configs/alacritty;
  htop = import configs/htop;
in {
  nixpkgs.overlays = import ./overlays;

  fonts.fontconfig.enable = true;

  home.packages =
    builtins.concatMap
      (packages: pkgs.callPackage packages {})
      [
        alacritty.packages
        htop.packages
      ];

  home.file = lib.mkMerge (map (lib.mapAttrs (_: source: { inherit source; })) [ alacritty.files htop.files ]);
}
