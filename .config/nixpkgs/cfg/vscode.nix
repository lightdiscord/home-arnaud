{ nixpkgs, pkgs, lib, ... }:

let
    config = {
        "window.menuBarVisibility" = "toggle";
        "git.confirmSync" = false;
        "workbench.iconTheme" = "material-icon-theme";
        "workbench.colorTheme" = "Panda Syntax";
        "material-icon-theme.folders.theme" = "specific";
        "rust-client.rustupPath" = "${pkgs.rustup}/bin/rustup";
    };

    extensions = [
        {
            name = "bbenoist.nix";
            version = "1.0.1";
            sha256 = "0zd0n9f5z1f0ckzfjr38xw2zzmcxg1gjrava7yahg5cvdcw6l35b";
        }
        {
            name = "belfz.search-crates-io";
            version = "1.2.0";
            sha256 = "0izdcpvqiaxs850xz7xz6m4yhh72i73inx75f2jdqf7q9amzp5xq";
        }
        {
            name = "rust-lang.rust";
            version = "0.4.1";
            sha256 = "1sqh8mxia7w0zdrbzvk7acw6aasqa1p6l2f3knzmpsijdb6si8g8";
        }
        {
            name = "tinkertrain.theme-panda";
            version = "1.2.0";
            sha256 = "0nv71rv7rksqf4hdh7j9iaj4l0xipm67pg8wc5dbipv13liigxdq";
        }
        {
            name = "vscodevim.vim";
            version = "0.11.4";
            sha256 = "1bx106xag2mjqi6izrm5d1fayznwvqc47ckv50i1ck2192gc9gm3";
        }
        {
            name = "PKief.material-icon-theme";
            version = "3.3.0";
            sha256 = "09dd2407c3bajqvyjzprsyc11ziwsyraw6qir3v3mpkrsrlmi7a0";
        }
    ];

    format = { name, version, sha256, ... }:
        let
            split = lib.splitString "." name;
        in {
            name = lib.head ( lib.tail split );
            publisher = lib.head split;
            inherit sha256 version;
        };
in {
    home.file = {
        ".config/Code/User/settings.json".text = (builtins.toJSON config);
    };

    home.packages = [
        (pkgs.vscode-with-extensions.override {
            vscodeExtensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace (
                lib.imap0 (i: format) extensions
            );
        })
    ];
}