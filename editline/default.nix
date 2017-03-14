{ pkgs ? import (builtins.fetchTarball  # revision for reproducible builds
  "https://github.com/nixos/nixpkgs-channels/archive/nixos-16.09.tar.gz") {}
}:

pkgs.stdenv.mkDerivation rec {
  version = "1.15.2";
  name = "editline-${version}";

  src = pkgs.fetchurl {
    url = "https://github.com/troglobit/editline/archive/1.15.2.tar.gz";
    sha256 = "d2969eabc1bfe3f25d65715a2eb782473ab6fad576ff2106b82cb87803f52b47";
  };

  preConfigure = ''
    ./autogen.sh
  '';

  buildInputs = [
    pkgs.autoconf
    pkgs.automake
    pkgs.libtool
    pkgs.ncurses
  ];
}
