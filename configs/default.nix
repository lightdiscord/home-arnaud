{ lib, pkgs, ... }:

with lib;

let

  modules = [
    ./alacritty
    ./htop
    # ./i3wm
    # ./i3status
    ./rofi
    ./npmrc
    ./awesomewm
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

  callModule = module: if isFunction module
    then pkgs.callPackage module { }
    else module;

in
  mkMerge (map (module: installModule (callModule (import module))) modules)
