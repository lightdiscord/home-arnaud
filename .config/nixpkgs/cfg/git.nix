{ ... }:

let
    user = {
        name = "LightDiscord";
        email = "arnaud@lightdiscord.me";
    };

    editor = "nvim";

    key = (import /etc/nixos/misc/keys.nix).gpg.arnaud;
in {
    programs.git = {
        enable = true;
        signing = {
            signByDefault = true;
            inherit key;
        };

        userEmail = user.email;
        userName = user.name;

        extraConfig = ''
            [core]
            editor=${editor}
        '';
    };
}
