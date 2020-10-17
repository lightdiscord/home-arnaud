{ pkgs, ... }:

{
  require = [
    ./configurations
  ];

  home.stateVersion = "20.09";
  home.keyboard.layout = "fr";

  fonts.fontconfig.enable = true;

  nixpkgs.config.allowUnfree = true;
}
