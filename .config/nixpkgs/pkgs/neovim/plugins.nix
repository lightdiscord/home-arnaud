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

        toml = build {
            owner = "cespare";
            repo = "vim-toml";
            sha256 = "0nnm4ja5j9gcsl9cv7ra30slrlpjpy4dsl0ykg0yhdq1vbby3m6n";
        };

        fish = build {
            owner = "dag";
            repo = "vim-fish";
            sha256 = "1yvjlm90alc4zsdsppkmsja33wsgm2q6kkn9dxn6xqwnq4jw5s7h";
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

        nerdtree = build {
            owner = "scrooloose";
            repo = "nerdtree";
            sha256 = "0snx080kdyb5qqip9skcsda8zy231lqady7fwfqmhp40nx5s6zdn";
        };

        header = build {
            owner = "alpertuna";
            repo = "vim-header";
            sha256 = "0ssbcqm3048yzj6srjd67lkidff6i0hsblal890y49fb261yflpg";
        };

        airline = build {
            owner = "vim-airline";
            repo = "vim-airline";
            sha256 = "0g4g5fa0qy6hagic590sksa8z6xlmigdan64bya06jr9m7fd8a1a";
        };
    };

    theme = {
        perun = build {
            owner = "aradunovic";
            repo = "perun.vim";
            sha256 = "04s5lj8yvha07m22709fy7c35x0047n6dwmqjgmfnv6cqwd1qirs";
          };

        papaya = build {
            owner = "henrynewcomer";
            repo = "vim-theme-papaya";
            sha256 = "0il684ha2h9p3sbjgxmkpa8l6khiv70b0zjcb3aa7fimzrdbcc9d";
        };

        airline = build {
            owner = "vim-airline";
            repo = "vim-airline-themes";
            sha256 = "1j9y9irrzsq1bwp3b22ls016byi0yc9ymigzhw0n180rk6nb36c7";
        };
    };
}
