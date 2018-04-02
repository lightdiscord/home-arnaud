{ lib, pkgs, ... }:

let
    sysconfig = (import <nixpkgs/nixos> {}).config;

    packages = with pkgs; ([

    ] ++ lib.optionals sysconfig.services.xserver.enable [
        chromium
        discord
        spotify
    ]);
in {
    imports = ([
        ./cfg/git.nix
    ] ++ lib.optionals sysconfig.services.xserver.enable [
        ./cfg/i3wm.nix
    ]);

    home.packages = packages;
    home.keyboard.layout = "fr";

    programs.home-manager = {
        enable = true;
        path = "https://github.com/rycee/home-manager/archive/master.tar.gz";
    };
}
