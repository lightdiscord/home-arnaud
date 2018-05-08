{ lib, ... }:

let
    build = { name, version, sha256, ... }:
        with lib;
        let
            split = splitString "." name;
        in {
            name = head ( tail split );
            publisher = head split;
            inherit sha256 version;
        };
in {
    bbenoist.nix = build {
        name = "bbenoist.nix";
        version = "1.0.1";
        sha256 = "0zd0n9f5z1f0ckzfjr38xw2zzmcxg1gjrava7yahg5cvdcw6l35b";
    };

    belfz.search-crates-io = build {
        name = "belfz.search-crates-io";
        version = "1.2.0";
        sha256 = "0izdcpvqiaxs850xz7xz6m4yhh72i73inx75f2jdqf7q9amzp5xq";
    };
    
    rust-lang.rust = build {
        name = "rust-lang.rust";
        version = "0.4.1";
        sha256 = "1sqh8mxia7w0zdrbzvk7acw6aasqa1p6l2f3knzmpsijdb6si8g8";
    };

    tinkertrain.theme-panda = build {
        name = "tinkertrain.theme-panda";
        version = "1.2.0";
        sha256 = "0nv71rv7rksqf4hdh7j9iaj4l0xipm67pg8wc5dbipv13liigxdq";
    };
    
    vscodevim.vim = build {
        name = "vscodevim.vim";
        version = "0.11.4";
        sha256 = "1bx106xag2mjqi6izrm5d1fayznwvqc47ckv50i1ck2192gc9gm3";
    };

    PKief.material-icon-theme = build {
        name = "PKief.material-icon-theme";
        version = "3.3.0";
        sha256 = "09dd2407c3bajqvyjzprsyc11ziwsyraw6qir3v3mpkrsrlmi7a0";
    };

    EditorConfig.editorconfig = build {
        name = "EditorConfig.editorconfig";
        version = "0.12.1";
        sha256 = "0c8lh20pvsxs0c1n7p0762bvfc1w5fi3gmbh3a39cxkhrizgaii4";
    };

    bungcip.better-toml = build {
        name = "bungcip.better-toml";
        version = "0.3.2";
        sha256 = "08lhzhrn6p0xwi0hcyp6lj9bvpfj87vr99klzsiy8ji7621dzql3";
    };
    
    yzhang.markdown-all-in-one = build {
        name = "yzhang.markdown-all-in-one";
        version = "1.2.0";
        sha256 = "0zr271kcqklrkrksjdnx2rfdd0qx5n476mgbvxa2nnk7a9s8ylba";
    };

    Equinusocio.vsc-material-theme = build {
        name = "Equinusocio.vsc-material-theme";
        version = "2.0.1";
        sha256 = "17irihgqxp544529x3wch0smywwijp8rm1ayg29m0v8b9jn8da9c";
    };

    wiggin77.codedox = build {
        name = "wiggin77.codedox";
        version = "1.2.7";
        sha256 = "1b3m4balmrf09iprn3xhskivc8895b5s94gysaa37xzkyy5azf9d";
    };

    wwm.better-align = build {
        name = "wwm.better-align";
        version = "1.1.6";
        sha256 = "1ldvpava9xlqy3zwwc0c04pk9dh09jwcwz5lk3b2cr1z8bxn54lh";
    };
    
    octref.vetur = build {
        name = "octref.vetur";
        version = "0.11.7";
        sha256 = "07w5p0nw7wclyni2f9xx5pdgdx06war41zrdjjdakrzpng7jy0lr";
    };
    
    vadimcn.vscode-lldb = build {
        name = "vadimcn.vscode-lldb";
        version = "0.8.6";
        sha256 = "13l8c1iv29j0x5jwysm9pn1fi2drn8lbbdvrvrx9pvc2ffa7xg3s";
    };
}