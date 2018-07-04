{ config, pkgs, ... }:

let
    inherit (pkgs) dmenu dunst papirus-icon-theme librsvg xdg_utils;

    iconTheme = {
        package = papirus-icon-theme;
        name = "Papirus";
        size = "48x48";
    };
in {
    services.dunst = {
        enable = true;

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
                dmenu = "${dmenu}/bin/dmenu -p dunst:";
                browser = "${xdg_utils}/bin/xdg-open";
                icon_position = "left";
                icon_path = config.services.dunst.settings.global.icon_folders;
            };

            frame = {
                width = 0;
                color = "#1c1c1c";
            };

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

        inherit iconTheme;
    };

    home.sessionVariables."GDK_PIXBUF_MODULE_FILE" = "${librsvg}/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache";
    home.packages = [ dunst ];
}
