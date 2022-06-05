{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    nci = {
      url = "github:yusdacra/nix-cargo-integration";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nci, ... } @ inputs:
    inputs.nci.lib.makeOutputs {
      root = ./.;
      overrides = {
        # crateOverrides = common: prev: {
        #   "openssl-sys" = prev: {
        #     buildInputs = (prev.buildInputs or [ ]) ++ [ ];
        #     nativeBuildInputs = (prev.nativeBuildInputs or [ ]) ++ [ common.pkgs.pkgconfig ];
        #   };
        # };
        shell = common: prev: {
          packages =
            prev.packages
            ++ [
              common.pkgs.rust-analyzer
              common.pkgs.cargo-watch
              common.pkgs.cargo-edit
            ];
          commands = prev.commands;
          env = prev.env;
        };
      };
    };
}
