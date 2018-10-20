{ config, lib, pkgs, ... }:

with lib;

let

	sysconfig = import ./sysconfig.nix {};
	links = import ./links.nix {};

	inherit (links) awesome;

in {
	nixpkgs.config = import ./config.nix;

	imports = ([
		./packages.nix

		../git
		../../.gnupg
	] ++ optionals sysconfig.xserver [
		awesome

		../redshift
		../mopidy
	]);

	home = {
		keyboard.layout = "fr";
	};

	services.gnome-keyring = {
		enable = true;
		components = ["secrets" "pkcs11" "ssh"];
	};

	manual.manpages.enable = true;

	services.compton.enable = sysconfig.xserver;
}
