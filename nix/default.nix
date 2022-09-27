# https://github.com/nmattia/niv
{ sources ? import ./sources.nix
, nixpkgs ? sources."nixpkgs-17.03"
}:

let

  overlay = _: pkgs: {
  };

  pkgs = import nixpkgs {
    overlays = [ overlay ];
    config = {
    };
  };

in pkgs
