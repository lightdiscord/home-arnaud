{ config, lib, pkgs, ... }:

let
    enable = true;
    package = pkgs.i3-gaps;

    modifier = "Mod4";
    volume = 3;

    wallpaper = pkgs.fetchurl {
        name = "wallpaper.png";
        url = "https://images2.alphacoders.com/697/697173.jpg";
        sha256 = "0vy3rzwm395n2jk939lmcwlpm5zri8dyrs455m9rr77h40gq80wc";
    };

    scripts = (pkgs.callPackage ./scripts.nix {
        inherit package;
    });
in {
    xsession.enable = enable;
    xsession.windowManager.i3 = {
        inherit enable package;
    };
    
    xsession.windowManager.i3.config = {
        keybindings = (import ./keybindings.nix {
            inherit pkgs lib package scripts modifier volume;
        });

        gaps.inner = 10;

        floating = {
            criteria = [
                { class = "Pinentry"; }
                { class = "Pavucontrol"; }
            ];

            inherit modifier;
        };

        assigns = {
            "3" = [{ class = "discord"; }];
            "10" = [{ class = "Navigator"; } { class = "Firefox"; }];
        };

        window = {
            border = 0;
            titlebar = false;

            commands = [
                { command = "move to workspace 4"; criteria = { class = "Spotify"; }; }
            ];
        };

        startup = [
            { command = "${pkgs.feh}/bin/feh --bg-fill ${wallpaper}"; always = true; }
        ];
    };

    services.screen-locker = {
        inactiveInterval = 10;
        lockCmd = "sh ${scripts.lock}";

        inherit enable;
    };
}
