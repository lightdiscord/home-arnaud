{ pkgs, ... }:

let
    packages = with pkgs; [
        chromium
    ];
in {
    imports = [
        ./programs/git.nix
    ];

    home.packages = packages;

    programs.home-manager = {
        enable = true;
        path = "https://github.com/rycee/home-manager/archive/master.tar.gz";
    };
}