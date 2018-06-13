{ pkgs, ... }:

{
    home.packages = with pkgs; [
        protonmail-bridge
    ];

    services.gnome-keyring = {
        enable = true;
        components = ["secrets"];
    };
}
