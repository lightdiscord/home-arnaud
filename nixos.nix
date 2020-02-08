{ pkgs, lib, ... }:

let
  # We use builtins because of the infinite recursion
  # encountered when requiring a module that was fetched
  # using `pkgs`.
  home-manager = builtins.fetchTarball {
    url = https://github.com/rycee/home-manager/archive/df4db5063238f391352b2d334ac3e72f6fb7ade4.tar.gz;
    sha256 = "1fpz2l5jfhp4pwhv5ipn4c666nw3sqwgx6agjhafpsis0whq232q";
  };
in {
  require = [ "${home-manager}/nixos" ];

  users.users.arnaud = {
    packages = [ (pkgs.callPackage ../neovim-files { }) ];
  };

  home-manager.useUserPackages = true;
  home-manager.users.arnaud = import ./default.nix;
}
