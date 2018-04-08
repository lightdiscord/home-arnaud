{ lib, pkgs, ... }:

let
    sysconfig = (import <nixpkgs/nixos> {}).config;

    packages = with pkgs; ([
    	taskwarrior
        gitAndTools.gitflow
    ] ++ lib.optionals sysconfig.services.xserver.enable [
        chromium
        discord
        spotify
        pavucontrol
        google-chrome
    ]);
in {
    imports = ([
        ./cfg/git.nix
        ./cfg/fish
    ] ++ lib.optionals sysconfig.services.xserver.enable [
        ./cfg/i3wm.nix
        ./cfg/netflix.nix
    ]);

    home.packages = packages;
    home.keyboard.layout = "fr";

    programs.home-manager = {
        enable = true;
        path = "https://github.com/rycee/home-manager/archive/master.tar.gz";
    };
}
