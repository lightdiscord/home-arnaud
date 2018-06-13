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
        overrides.neovim
        overrides.st
        (callPackage <nixos/pkgs/tools/misc/bat> {})
    ] ++ lib.optionals sysconfig.services.xserver.enable [
        chromium
        discord
        spotify
        pavucontrol
        google-chrome
        feh
        obs-studio
        netflix
        xsel
    ]);
in {
    imports = ([
        ./cfg/git.nix
        ./cfg/fish
        ./cfg/news.nix
    ] ++ lib.optionals sysconfig.services.xserver.enable [
        ./cfg/i3wm
        ./cfg/vscode
        ./cfg/redshift.nix
        ./cfg/firefox
        ./cfg/mail
    ]);

    home = {
        inherit packages;
        keyboard.layout = "fr";
    };

    manual.manpages.enable = true;

    programs.home-manager = {
        enable = true;
        path = https://github.com/rycee/home-manager/archive/master.tar.gz;
    };
}
