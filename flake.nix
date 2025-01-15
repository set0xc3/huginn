{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
      };

      odin = pkgs.odin.overrideAttrs (oldAttrs: {
        version = "0-unstable-2025-01-15";
        src = pkgs.fetchFromGitHub {
          owner = "odin-lang";
          repo = "Odin";
          rev = "e55b65291685c8a1fc3d70252a73f01c7c6f253c";
          hash = "sha256-9h5xRop4MGZKIPha7XZmFAWasv74Owhcq4Z6yRilQz8=";
        };
      });
    in {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          xorg.libX11
          xorg.libXi
          xorg.libXcursor
          alsa-lib
          libGL

          odin
        ];
      };
    });
}
