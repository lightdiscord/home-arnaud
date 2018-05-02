{ pkgs, lib, package, scripts, modifier, volume, ... }:

lib.recursiveUpdate (lib.mapAttrs' (name: value: lib.nameValuePair (modifier + "+" + name) value) {
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

        "Control+Left" = "move workspace to output left";
        "Control+Right" = "move workspace to output right";

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

        "KP_Add" = "exec --no-startup-id ${scripts.random {}}";
        "Shift+KP_Add" = "exec --no-startup-id ${scripts.random { move = true; }}";
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
}