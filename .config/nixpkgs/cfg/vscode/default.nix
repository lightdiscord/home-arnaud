{ nixpkgs, pkgs, lib, ... }:

let
    config = {
        "window.menuBarVisibility" = "toggle";
        "git.confirmSync" = false;
        "workbench.iconTheme" = "material-icon-theme";
        "workbench.colorTheme" = "Solarized Light";
        "material-icon-theme.folders.theme" = "specific";
        "rust-client.rustupPath" = "${pkgs.rustup}/bin/rustup";
    };

    extensions = with (pkgs.callPackage ./extensions.nix { }); [
        bbenoist.nix
        belfz.search-crates-io
        rust-lang.rust
        tinkertrain.theme-panda
        vscodevim.vim
        PKief.material-icon-theme
        EditorConfig.editorconfig
        bungcip.better-toml
        yzhang.markdown-all-in-one
    ];
in {
    home.file = {
        ".config/Code/User/settings.json".text = (builtins.toJSON config);
    };

    home.packages = [
        (pkgs.vscode-with-extensions.override {
            vscodeExtensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace extensions;
        })
    ];
}