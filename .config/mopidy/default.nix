{ pkgs, ... }:

let

    links = import ../nixpkgs/links.nix {};
    inherit (links) mopidy;

in {

    imports = [
        mopidy
    ];

    services.mopidy = {
        enable = true;
        extensionPackages = with pkgs; [ mopidy-gmusic ];
        configuration = import ./configuration.nix;
    };

}
