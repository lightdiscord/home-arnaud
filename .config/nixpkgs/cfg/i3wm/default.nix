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

    iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus";
        size = "48x48";
    };

    dunst = (pkgs.callPackage ../../pkgs/TESTS/dunst.nix {});

    scripts = (pkgs.callPackage ./scripts.nix {
        inherit package;
    });
in {
    xsession.enable = enable;
    xsession.windowManager.i3 = {
        inherit enable package;
    };
    
    xsession.windowManager.i3.config = {
        fonts = [ "Roboto 10" ];

        keybindings = (import ./keybindings.nix {
            inherit pkgs lib package scripts modifier volume;
        });

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

    services.compton = {
        inherit enable;
    };

    services.dunst = {
        settings = {
            global = {
                font = "Roboto 14";
                markup = "full";
                format = "<b>%s</b>\\n%b";
                sort = true;
                indicate_hidden = true;
                alignment = "left";
                bounce_freq = 0;
                show_age_threshold = 60;
                word_wrap = true;
                ignore_newline = false;
                geometry = "700x5-10-25";
                shrink = false;
                transparency = 15;
                idle_threshold = 120;
                monitor = 0;
                follow = "none";
                sticky_history = true;
                history_length = 20;
                show_indicators = true;
                line_height = 0;
                separator_height = 5;
                padding = 10;
                horizontal_padding = 10;
                separator_color = "frame";
                startup_notification = "false";
                stack_duplicates = "false";
                max_icon_size = 48;
                min_icon_size = 48;
                dmenu = "${pkgs.dmenu}/bin/dmenu -p dunst:";
                browser = "${pkgs.xdg_utils}/bin/xdg-open";
                icon_position = "left";
                icon_path = config.services.dunst.settings.global.icon_folders;
            };
            frame = {
                width = 0;
                color = "#1c1c1c";
            };
            # shortcuts = {
            #     close = "ctrl+space";
            #     close_all = "ctrl+shift+space";
            #     history = "ctrl+h";
            #     context = "ctrl+shift+period";
            # };
            urgency_low = {
                background = "#ffffff";
                foreground = "#585858";
                timeout = 0;
            };
            urgency_normal = {
                background = "#212121";
                foreground = "#FAFAFA";
                timeout = 0;
            };
            urgency_critical = {
                background = "#ffffff";
                foreground = "#af0000";
                timeout = 0;
            };
            spotify = {
                appname = "Spotify";
                new_icon = "spotify-client";
                urgency = "normal";
            };
        };

        inherit enable iconTheme;
    };

    home.sessionVariables."GDK_PIXBUF_MODULE_FILE" = "${pkgs.librsvg}/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache";
    home.packages = [ dunst ];
}
