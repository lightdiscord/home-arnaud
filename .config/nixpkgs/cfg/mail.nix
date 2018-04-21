{ pkgs, ...}:

# TODO: Wait for Protonmail bridge
{
    home.packages = [
        pkgs.nylas-mail-bin
        (pkgs.callPackage ../pkgs/protonmail.nix {}) 
    ];

    services.gnome-keyring.enable = true;
}