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

      libs = with pkgs; [
      ];
    in {
      devShells.default = pkgs.mkShell {
        LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath libs;

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
