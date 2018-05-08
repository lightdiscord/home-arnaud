{ pkgs, lib, build ? pkgs.vimUtils.buildVimPluginFrom2Nix, fetchgit }:

let
    build = {
        url, sha256,
        name ? lib.last (lib.splitString "/" url),
        builder ? pkgs.vimUtils.buildVimPluginFrom2Nix
    }: builder {
        inherit name;
        src = fetchgit {
            inherit url sha256;
        };
    };
in {
    languages.nix = build {
        url = https://github.com/LnL7/vim-nix;
        sha256 = "1x3gaiz2wbqykzhk0zj0krjp81m5rxhk80pcg96f4gyqp7hxrx78";
    };
    languages.rust = build {
        url = https://github.com/rust-lang/rust.vim;
        sha256 = "1mn4jijfzz2jq215dnwkq5gxiw0ysmvrsrvq4aypr2ms2040iqiq";
    };

    tools = {
        ale = build {
            url = https://github.com/w0rp/ale;
            sha256 = "1l7sxyablbhm34gs99qlk76rflvkn6ql8i9xg8izqb0l41qwiml3";
        };

        ctrlp = build {
            url = https://github.com/ctrlpvim/ctrlp.vim;
            sha256 = "1wa2kxiwipnxwd19gyv6grgqn0ms6zdxsj2xg80whkk3namlgg7m";
        };

        editorconfig = build {
            url = https://github.com/editorconfig/editorconfig-vim;
            sha256 = "1vpxmn51w5ly1divmajm7njlp42ks2s1ii18c7np6bdca7zj1j2n";
        };

        fugitive = build {
            url = https://github.com/tpope/vim-fugitive;
            sha256 = "1gplhgcs1436ck49f38yah6c29bgz6mg6fy60hvpxnwsigyj4w1b";
        };
    };

    theme.perun = build {
        url = https://github.com/aradunovic/perun.vim;
        sha256 = "07dmrq16251vx3q2smdl32l91m5hmrrjv9r8fmpf2niczmf4ff0k";
    };
}
