self: super:

let
    callPackage = self.callPackage;
in rec {
    overrides = {
        neovim = callPackage ~/.config/nvim {};

        st = callPackage ./st {};
    };
}
