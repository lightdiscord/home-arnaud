{ lib, pkgs, ... }:

let
    sysconfig = (import <nixpkgs/nixos> {}).config;

    overlays = {
        mozilla = import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz);
    };

    nixpkgs = import <nixpkgs> { overlays = [ overlays.mozilla ]; };

    # nodejs = pkgs.callPackage <nixpkgs/pkgs/development/web/nodejs/nodejs.nix> {};

    packages = with pkgs; ([
    	taskwarrior
        gitAndTools.gitflow
        psmisc

        gcc
        gnumake

        # (
        #     nodejs {
        #         enableNpm = true;
        #         version = "10.0.0";
        #         sha256 = "0l5bx2j4f2ij19kx14my7g7k37j3fn9qpjvbisjvhpbm42810fg2";
        #         patches = [];
        #     }
        # )

        nixpkgs.latest.rustChannels.nightly.rust
    ] ++ lib.optionals sysconfig.services.xserver.enable [
        chromium
        #(pkgs.callPackage ./pkgs/discord.nix {})
        discord
        spotify
        pavucontrol
        google-chrome
        nixpkgs.latest.firefox-nightly-bin
        feh
        obs-studio
        #robo3t
        (pkgs.callPackage ./pkgs/robo3t.nix {})
        (pkgs.callPackage ./pkgs/dunst.nix {})
    ]);
in {
    imports = ([
        ./cfg/git.nix
        ./cfg/fish
    ] ++ lib.optionals sysconfig.services.xserver.enable [
        ./cfg/i3wm
        ./cfg/netflix.nix
        ./cfg/vscode
        ./cfg/mail.nix
        ./cfg/redshift.nix
    ]);

    home.packages = packages;
    home.keyboard.layout = "fr";

    programs.home-manager = {
        enable = true;
        path = "https://github.com/rycee/home-manager/archive/master.tar.gz";
    };
}
