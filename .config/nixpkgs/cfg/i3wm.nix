{ config, lib, pkgs, ... }:

let
    wallpaper = pkgs.fetchurl {
        name = "wallpaper";
        url = "https://images2.alphacoders.com/697/697173.jpg";
        sha256 = "0vy3rzwm395n2jk939lmcwlpm5zri8dyrs455m9rr77h40gq80wc";
    };
in {
    xsession.windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
    };
    
    xsession.windowManager.i3.config = {
        gaps.inner = 10;

        startup = [
            { command = "feh --bg-fill ${wallpaper}"; always = true; }
        ];
    };
}