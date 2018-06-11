{ lib, vimUtils, builder ? vimUtils.buildVimPluginFrom2Nix, fetchFromGitHub }:

let
    build = {
        owner, repo, rev ? "HEAD", name ? repo, sha256
    }: builder {
        inherit name;
        src = fetchFromGitHub {
            fetchSubmodules = true;
            inherit name owner repo rev sha256;
        };
    };
in {
    languages = {
        nix = build {
            owner = "LnL7";
            repo = "vim-nix";
            sha256 = "1x3gaiz2wbqykzhk0zj0krjp81m5rxhk80pcg96f4gyqp7hxrx78";
        };

        rust = build {
            owner = "rust-lang";
            repo = "rust.vim";
            sha256 = "1mn4jijfzz2jq215dnwkq5gxiw0ysmvrsrvq4aypr2ms2040iqiq";
        };
    };

    tools = {
        ale = build {
            owner = "w0rp";
            repo = "ale";
            sha256 = "1lfh4bk9hvkaps8nlz3mq5br2q915yaf8fvb7m3fxa2ysd37nsvk";
        };

        ctrlp = build {
            owner = "ctrlpvim";
            repo = "ctrlp.vim";
            sha256 = "1wa2kxiwipnxwd19gyv6grgqn0ms6zdxsj2xg80whkk3namlgg7m";
        };

        editorconfig = build {
            owner = "editorconfig";
            repo = "editorconfig-vim";
            sha256 = "1wazl37ivn9nhsy296g1ncvvwc78930lbp8arhwavr52mzpfji21";
        };

        fugitive = build {
            owner = "tpope";
            repo = "vim-fugitive";
            sha256 = "0nbqqp62mjj7a0q2jagqm3dzabsqdh3asqffwvqwhn3qcc2slw1i";
        };
    };

    theme.perun = build {
        owner = "aradunovic";
        repo = "perun.vim";
        sha256 = "04s5lj8yvha07m22709fy7c35x0047n6dwmqjgmfnv6cqwd1qirs";
    };
}
