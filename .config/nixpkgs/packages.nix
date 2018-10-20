{ config, lib, pkgs, ... }:

with lib;
with pkgs;

let

	sysconfig = import ./sysconfig.nix {};
	links = import ./links.nix {};

	inherit (links) neovim;

	packages = ([
		psmisc
		tmate
		gcc
		gnumake
		rustup
		neomutt
		htop
		bat
		(callPackage neovim {})
	] ++ optionals sysconfig.xserver [
		discord
		pavucontrol
		google-chrome
		feh
		vscode
		xsel
		xclip
		shutter
		thunderbird
		kitty
		libreoffice
		protonmail-bridge
	]);

in {

	home.packages = packages;

}
