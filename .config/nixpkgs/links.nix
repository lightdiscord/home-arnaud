{ ... }:

let

	sysconfig = import ./sysconfig.nix {};

	homeDirectory = sysconfig.users.users.arnaud.home;
	configHome = "${homeDirectory}/.config";

	fallback = rec {
		method = file: uri: if builtins.pathExists file then file else (fetchTarball uri);
		home = file: method "${homeDirectory}/${file}";
		config = file: method "${configHome}/${file}";
	};

	inherit (fallback) config;
in {

	neovim = config "nvim" https://github.com/lightdiscord/vim-files/archive/master.tar.gz;

	awesome = config "awesome" https://github.com/lightdiscord/awesome/archive.master.tar.gz;

	mopidy = fetchTarball https://github.com/lightdiscord/mopidy-nix/archive/master.tar.gz;

}
