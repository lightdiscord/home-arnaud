self: super:

let
    callPackage = self.callPackage;
in rec {
    overrides = {
        neovim = callPackage ./neovim {};

        st = callPackage ./st {};
    };

    nvimPlugins = callPackage ./neovim/plugins.nix {};

    netflix = callPackage ./netflix {};

    protonmail-bridge = callPackage ./protonmail {};
}
