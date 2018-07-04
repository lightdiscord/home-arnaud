# Vim-files

Also known as my neovim configuration.

---

## How to use it ?

### With home-manager ?

Clone the repository into `~/.config/nvim`.

```nix
{ pkgs, ... }:

{
	home.packages = [
		(pkgs.callPackage ~/.config/nvim {})
	];
}
```

To activate this configuration you can run

```console
$ home-manager switch
```

### Without nix ?

```console
$ mkdir -p ~/.config/nvim
$ cd ~/.config/nvim
$ git clone --single-branch -b build --recursive https://github.com/LightDiscord/Vim-files.git .
```

