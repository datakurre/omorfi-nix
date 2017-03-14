{ pkgs ? import (builtins.fetchTarball  # revision for reproducible builds
  "https://github.com/nixos/nixpkgs-channels/archive/nixos-16.09.tar.gz") {}
}:

with pkgs;

pkgs.stdenv.mkDerivation rec {
  version = "0.9.9r10800";
  name = "vislcg3-${version}";

  src = pkgs.fetchurl {
    # http://visl.sdu.dk/download/vislcg3/cg3-0.9.9~r10800.tar.bz2
    url = "https://goo.gl/cqKe23";
    sha256 = "c85446c671fdb55dc01bf6092dd32ccb05ad4e057563d5c4293ee2409df610ba";
  };

  unpackCmd = ''
    tar xjvf $src
  '';

  buildInputs = [
    boost
    cmake
    gperftools
    icu
  ];
}
