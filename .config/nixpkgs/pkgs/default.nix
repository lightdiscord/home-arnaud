self: super:

rec {
    nvim.package = self.callPackage ./neovim {};

    nvim.plugins = self.callPackage ./neovim/plugins.nix {};

    netflix = self.callPackage ./netflix.nix {};
}
