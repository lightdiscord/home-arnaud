{ callPackage, neovim, nvim, ... }:

let
    plugins.start = with nvim.plugins; [
        languages.nix
        languages.rust
        tools.ale
        tools.ctrlp
        tools.editorconfig
        tools.fugitive
        theme.perun
    ];

    plugins.opt = with nvim.plugins; [];

    withRuby = true;

    withPython = true;
    extraPythonPackages = [];
    
    withPython3 = true;
    extraPython3Packages = [];
in neovim.override {
    inherit withRuby withPython extraPythonPackages withPython3 extraPython3Packages;

    configure = {
        customRC = "source ${builtins.getEnv "HOME"}/.config/nvim/init.vim";

        packages.myVimPackage = {
            inherit (plugins) start opt;
        };
    };
}