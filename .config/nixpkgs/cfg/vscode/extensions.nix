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
}