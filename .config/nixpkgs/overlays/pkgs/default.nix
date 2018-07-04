self: super:

let
    callPackage = self.callPackage;
in rec {
    overrides = {
        neovim = callPackage ~/.config/nvim {};

        st = callPackage ./st {};
    };

    nvimPlugins = callPackage ./neovim/plugins.nix {};

    netflix = callPackage ./netflix {};

    protonmail-bridge = callPackage ./protonmail {};

    # TODO: Make this package functional
    mailspring = callPackage ./mailspring {};
}
