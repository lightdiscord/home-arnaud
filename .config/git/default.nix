{ ... }:

let
    arnaud = (import /etc/nixos/common/users/arnaud/data.nix);
    editor = "code --wait";
in {
    programs.git = {
        enable = true;

        signing = {
            signByDefault = true;
            key = arnaud.keys.gpg;
        };

        userEmail = arnaud.email;
        userName = arnaud.nickname;

        extraConfig = ''
            [core]
            editor=${editor}
        '';
    };
}
