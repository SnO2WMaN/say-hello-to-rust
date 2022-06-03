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
        shell = common: prev: {
          packages =
            prev.packages
            ++ [
              common.pkgs.rust-analyzer
              common.pkgs.cargo-watch
            ];
          commands = prev.commands;
          env = prev.env;
        };
      };
    };
}
