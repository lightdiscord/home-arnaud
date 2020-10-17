{
  description = "My user environment managed by nix with home-manager";

  inputs = {
    home-manager.url = "github:nix-community/home-manager/e7d5531cfa770afc591f8dc5542eb4fba9962885";
    config-nvim.url = "github:lightdiscord/config-nvim";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosModules.home-arnaud = { config, ... }: {
      require = [ ./src/default.nix ];
    };

    nixosModules.nixos = { config, lib, ... }: with lib; {
      imports = [
        inputs.home-manager.nixosModules.home-manager
      ];

      # Used to access flake inputs from the submodule.
      options.home-manager.users = mkOption {
        type = types.attrsOf (types.submoduleWith {
          modules = [ ];
          specialArgs = {
            flake-inputs = inputs;
          };
        });
      };

      config = {
        home-manager.useUserPackages = true;
        home-manager.users.arnaud = self.nixosModules.home-arnaud;
      };
    };
  };
}
