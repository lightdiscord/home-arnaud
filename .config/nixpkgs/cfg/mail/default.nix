{ pkgs, ... }:

{
    home.packages = with pkgs; [
        libsecret
        protonmail-bridge
        thunderbird
    ];

    services.gnome-keyring = {
        enable = true;
        components = ["secrets"];
    };
}
