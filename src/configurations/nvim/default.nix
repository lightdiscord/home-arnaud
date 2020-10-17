{ flake-inputs, pkgs, ... }:

{
  require = [
    flake-inputs.config-nvim.nixosModules.home-manager
  ];

  home.packages = [ pkgs.neovim ];
}
