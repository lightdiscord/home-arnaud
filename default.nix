{ pkgs, lib, ... }:

let
  nixos-unstable = import <nixos-unstable> { };

  alacritty = import configs/alacritty;
  htop = import configs/htop;
in {
  nixpkgs.overlays = [
    (
      self: super: {
        alacritty = nixos-unstable.alacritty;
      }
    )
  ];

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
