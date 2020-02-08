{ pkgs, lib, ... }:

with lib;

let
  alacritty = import configs/alacritty;
  htop = import configs/htop;
  rofi = import configs/rofi;
  i3wm = import configs/i3wm;
in {
  nixpkgs.overlays = import ./overlays;

  fonts.fontconfig.enable = true;

  home.keyboard.layout = "fr";

  xsession.enable = true;
  xsession.windowManager.command = "${pkgs.i3}/bin/i3";

  home.packages =
    builtins.concatMap
      (module: pkgs.callPackage module.packages {})
      [
        alacritty
        htop
        rofi
        i3wm
      ]
    ++ (with pkgs; [ gnome3.adwaita-icon-theme hicolor-icon-theme i3 ]);

    home.file = let
      mapFiles = map (mapAttrs (_: source: { inherit source; }));
    in mkMerge (mapFiles [
      alacritty.files
      htop.files
      rofi.files
      i3wm.files
    ]);

  gtk.enable = true;
  gtk.iconTheme = {
    package = pkgs.paper-icon-theme;
    name = "Paper";
  };
}
