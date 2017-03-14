{ pkgs ? import (builtins.fetchTarball  # revision for reproducible builds
  "https://github.com/nixos/nixpkgs-channels/archive/nixos-16.09.tar.gz") {}
, editline ? import ../editline { pkgs = pkgs; }
}:

with pkgs;

stdenv.mkDerivation rec {
  version = "3.12.1";
  name = "hfst-${version}";

  src = fetchurl {
    url = "http://github.com/hfst/hfst/archive/v3.12.1.tar.gz";
    sha256 = "49c11cb7b0faa3b2b8e97f374530be0263f4f1591fcdd9397ab34bb5fe947d26";
  };

  preConfigure = ''
    ./autogen.sh
  '';

  configureFlags = [
   "--enable-proc"
  ];

  postConfigure = ''
    ./scripts/generate-cc-files.sh
  '';

  preInstall = ''
    mkdir -p $out/bin
  '';

  buildInputs = [
    editline
    autoconf
    automake
    bison
    flex
    libtool
    ncurses
    readline
    zlib
  ];
}
