{ pkgs, ... }:

let
    packages = with pkgs; [
        chromium
        discord
        spotify
    ];
in {
    imports = [
        ./cfg/git.nix
        ./cfg/i3wm.nix
    ];

    home.packages = packages;

    programs.home-manager = {
        enable = true;
        path = "https://github.com/rycee/home-manager/archive/master.tar.gz";
    };
}