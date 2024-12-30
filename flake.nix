{
  description = "Machine configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    microvm.url = "github:astro/microvm.nix";
    microvm.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, microvm, ... }: {
    nixosConfigurations.my-microvm = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # Include the microvm module
        microvm.nixosModules.microvm
        # Add more modules here
        {
          networking.hostName = "my-microvm";
          microvm.hypervisor = "qemu";
          users.users.root.password = "";
        }
      ];
    };

  };
}
