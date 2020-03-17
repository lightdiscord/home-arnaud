{
  require = [ ./home-manager/nixos ];

  home-manager.useUserPackages = true;
  home-manager.users.arnaud = import ./default.nix;
}
