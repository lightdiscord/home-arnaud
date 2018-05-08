{ lib, pkgs, ... }:

let
    sysconfig = (import <nixpkgs/nixos> {}).config;

    pkgs = import ./pkgs;

    packages = with pkgs; ([
        taskwarrior
        gitAndTools.gitflow
        psmisc
        tig
        tmate
        gcc
        gnumake
        latest.rustChannels.nightly.rust
    ] ++ lib.optionals sysconfig.services.xserver.enable [
        chromium
        (callPackage <nixpkgs/pkgs/applications/networking/instant-messengers/discord> {})
        spotify
        pavucontrol
        google-chrome
        feh
        obs-studio
    ]);
in {
    imports = ([
        ./cfg/git.nix
        ./cfg/fish
        ./cfg/nvim
    ] ++ lib.optionals sysconfig.services.xserver.enable [
        ./cfg/i3wm
        ./cfg/netflix.nix
        ./cfg/vscode
        ./cfg/mail.nix
        ./cfg/redshift.nix
        ./cfg/firefox
    ]);

    home.packages = packages;
    home.keyboard.layout = "fr";

    manual.manpages.enable = false;

    programs.home-manager = {
        enable = true;
        path = "https://github.com/rycee/home-manager/archive/master.tar.gz";
    };
}
