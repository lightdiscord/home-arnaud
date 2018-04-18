{ pkgs, ...}:

# TODO: Wait for Protonmail bridge
{
    home.packages = [ pkgs.nylas-mail-bin ];

    services.gnome-keyring.enable = true;
}