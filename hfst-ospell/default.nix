{ pkgs ? import (builtins.fetchTarball  # revision for reproducible builds
  "https://github.com/nixos/nixpkgs-channels/archive/nixos-16.09.tar.gz") {}
, editline ? import ../editline { pkgs = pkgs; }
}:

with pkgs;

stdenv.mkDerivation rec {
  version = "0.4.5";
  name = "hfst-ospell-${version}";

  src = fetchurl {
    url = "https://github.com/hfst/hfst-ospell/archive/v0.4.5.tar.gz";
    sha256 = "ec4a3399c24602b606146c2e64137cbdb8467c68b49c579f8714ac3f14115dec";
  };

  preConfigure = ''
    ./autogen.sh
  '';

  buildInputs = [
    autoconf
    automake
    bzip2
    glibmm
    icu
    libarchive
    libtool
    libxmlxx
    lzma
    pkgconfig
  ];
}
