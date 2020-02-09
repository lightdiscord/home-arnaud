{ lib, pkgs, ... }:

with lib;

let

  modules = [
    ./alacritty
    ./htop
    ./i3wm
    ./i3status
    ./rofi
  ];

  installPackages = module: {
    home.packages = pkgs.callPackage module.packages {};
  };

  installFiles = module: {
    home.file = mapAttrs
      (_: source: { inherit source; })
      module.files;
  };

  installModule = module: mkMerge [
    (mkIf (module ? packages) (installPackages module))
    (mkIf (module ? files) (installFiles module))
  ];

in
  mkMerge (map installModule (map import modules))
