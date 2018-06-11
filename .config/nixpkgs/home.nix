{ lib, pkgs, ... }:

let
    sysconfig = (import <nixpkgs/nixos> {}).config;

    packages = with pkgs; ([
        taskwarrior
        gitAndTools.gitflow
        psmisc
        tig
        tmate
        gcc
        gnumake
        latest.rustChannels.nightly.rust
        nvim.package
    ] ++ lib.optionals sysconfig.services.xserver.enable [
        chromium
        discord
        spotify
        pavucontrol
        google-chrome
        feh
        obs-studio
        netflix
    ]);
in {
    imports = ([
        ./cfg/git.nix
        ./cfg/fish
    ] ++ lib.optionals sysconfig.services.xserver.enable [
        ./cfg/i3wm
        ./cfg/vscode
        ./cfg/redshift.nix
        ./cfg/firefox
    ]);

    home.packages = packages;
    home.keyboard.layout = "fr";

    manual.manpages.enable = false;

    programs.home-manager = {
        enable = true;
        path = https://github.com/rycee/home-manager/archive/master.tar.gz;
    };
}
