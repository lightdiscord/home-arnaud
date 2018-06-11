{ callPackage, ...}:

# TODO: Create protonmail package
{
    home.packages = [
        protonmail-bridge
    ];

    services.gnome-keyring.enable = true;
}
