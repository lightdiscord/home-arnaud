{ lib, pkgs, ... }:

let
    sysconfig = (import <nixpkgs/nixos> {}).config;

    packages = with pkgs; ([
        psmisc
        tig
        tmate
        gcc
        gnumake
        latest.rustChannels.nightly.rust
        #(rustChannelOf { date = "2018-06-20"; channel = "nightly"; }).rust
        overrides.st
        (callPackage ~/.config/nvim {})
    ] ++ lib.optionals sysconfig.services.xserver.enable [
        discord
        pavucontrol
        google-chrome
        feh
        xsel
        xclip
    ]);
in {
    imports = ([
        ~/.config/git
        ./cfg/fish
        ./cfg/news.nix
        ./cfg/gpg-agent.nix
    ] ++ lib.optionals sysconfig.services.xserver.enable [
        ~/.config/i3
        ./cfg/redshift.nix
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
