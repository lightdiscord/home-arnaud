self: super:

rec {
    overrides = {
        neovim = self.callPackage ./neovim {};

        st = self.callPackage ./st {};
    };

    nvimPlugins = self.callPackage ./neovim/plugins.nix {};

    netflix = self.callPackage ./netflix.nix {};


}
