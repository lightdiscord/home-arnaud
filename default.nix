{ pkgs, lib, ... }:

with lib;

let
  alacritty = import configs/alacritty;
  htop = import configs/htop;
  rofi = import configs/rofi;
in {
  nixpkgs.overlays = import ./overlays;

  fonts.fontconfig.enable = true;

  home.packages =
    builtins.concatMap
      (packages: pkgs.callPackage packages {})
      [
        alacritty.packages
        htop.packages
        rofi.packages
      ]
    ++ (with pkgs; [ gnome3.adwaita-icon-theme hicolor-icon-theme ]);

    home.file = let
      mapFiles = map (mapAttrs (_: source: { inherit source; }));
    in mkMerge (mapFiles [
      alacritty.files
      htop.files
      rofi.files
    ]);

  gtk.enable = true;
  gtk.iconTheme = {
    package = pkgs.paper-icon-theme;
    name = "Paper";
  };
}
