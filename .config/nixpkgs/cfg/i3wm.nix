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

    scripts = {
        lock = pkgs.writeScript "lock.sh" ''
            #!${pkgs.bash}/bin/bash

            cd $(mktemp -d)
            ${pkgs.imagemagick}/bin/import -window root 'bg.png'
            ${pkgs.imagemagick}/bin/convert 'bg.png' -filter Gaussian -blur 0x8 'bg.png'
            ${pkgs.i3lock}/bin/i3lock -i 'bg.png'
            rm 'bg.png'
        '';

        screenshot = { mode ? "select", ... }:
            let 
                package = "${pkgs.imagemagick}/bin/import";
                scripts = {
                    select = ''
                        ${package} $(date +"$BASE/%F_%T.jpg")
                    '';

                    window = ''
                        ID=`${pkgs.xorg.xwininfo}/bin/xwininfo | grep 'id: 0x' | grep -Eo '0x[a-z0-9]+'`
                        ${package} -window $ID $(date +"$BASE/%F_%T_window.jpg")
                    '';
                };
            in pkgs.writeScript "screenshot.sh" ''
                #!${pkgs.bash}/bin/bash

                BASE="${builtins.getEnv "HOME"}/Pictures/Screenshots"
                mkdir -p $BASE
                ${scripts.${mode}}
            '';
    };
in {
    xsession.enable = enable;
    xsession.windowManager.i3 = {
        inherit enable package;
    };
    
    xsession.windowManager.i3.config = {
        gaps.inner = 10;

        floating = {
            criteria = [
                { class = "Pinentry"; }
                { class = "Pavucontrol"; }
            ];

            inherit modifier;
        };

        keybindings = lib.recursiveUpdate (lib.mapAttrs' (name: value: lib.nameValuePair (modifier + "+" + name) value) {
            "Return" = "exec ${pkgs.alacritty}/bin/alacritty";
            "Shift+q" = "kill";
            "d" = "exec ${pkgs.j4-dmenu-desktop}/bin/j4-dmenu-desktop";

            "Left" = "focus left";
            "Down" = "focus down";
            "Up" = "focus up";
            "Right" = "focus right";

            "Shift+Left" = "move left";
            "Shift+Down" = "move down";
            "Shift+Up" = "move up";
            "Shift+Right" = "move right";

            "h" = "split h";
            "v" = "split v";
            "f" = "fullscreen toggle";

            "s" = "layout stacking";
            "w" = "layout tabbed";
            "e" = "layout toggle split";

            "Shift+space" = "floating toggle";

            "1" = "workspace 1";
            "2" = "workspace 2";
            "3" = "workspace 3";
            "4" = "workspace 4";
            "5" = "workspace 5";
            "6" = "workspace 6";
            "7" = "workspace 7";
            "8" = "workspace 8";
            "9" = "workspace 9";
            "0" = "workspace 10";

            "Shift+1" = "move container to workspace 1";
            "Shift+2" = "move container to workspace 2";
            "Shift+3" = "move container to workspace 3";
            "Shift+4" = "move container to workspace 4";
            "Shift+5" = "move container to workspace 5";
            "Shift+6" = "move container to workspace 6";
            "Shift+7" = "move container to workspace 7";
            "Shift+8" = "move container to workspace 8";
            "Shift+9" = "move container to workspace 9";
            "Shift+0" = "move container to workspace 10";

            "Shift+c" = "reload";
            "Shift+r" = "restart";
            "Shift+e" = "exec ${package}/bin/i3-nagbar -t warning -m 'Do you want to exit i3?' -b 'Yes' 'i3-msg exit'";

            "r" = "mode resize";

            "Tab" = "workspace next_on_output";
            "Shift+Tab" = "workspace prev_on_output";
        }) {
            "XF86AudioRaiseVolume" = "exec ${pkgs.alsaUtils}/bin/amixer -q set Master ${toString volume}%+";
            "XF86AudioLowerVolume" = "exec ${pkgs.alsaUtils}/bin/amixer -q set Master ${toString volume}%-";
            "XF86AudioMute" = "exec ${pkgs.alsaUtils}/bin/amixer -q set Master toggle";

            "XF86AudioPrev" = "exec ${pkgs.dbus}/bin/dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous";
            "XF86AudioPlay" = "exec ${pkgs.dbus}/bin/dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause";
            "XF86AudioNext" = "exec ${pkgs.dbus}/bin/dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next";

            "--release Print" = "exec --no-startup-id ${scripts.screenshot {}}";
            "--release Shift+Print" = "exec --no-startup-id ${scripts.screenshot { mode = "window"; }}";

            "--release ${modifier}+l" = "exec --no-startup-id ${scripts.lock}";
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
