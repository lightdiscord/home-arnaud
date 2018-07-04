{ ... }:

let
    arnaud = (import /etc/nixos/misc/users/arnaud.nix);
    editor = "nvim";
in {
    programs.git = {
        enable = true;

        signing = {
            signByDefault = true;
            key = arnaud.gpg;
        };

        userEmail = arnaud.email;
        userName = arnaud.nickname;

        extraConfig = ''
            [core]
            editor=${editor}
        '';
    };
}
