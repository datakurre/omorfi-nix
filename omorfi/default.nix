{ pkgs ? import (builtins.fetchTarball  # revision for reproducible builds
  "https://github.com/nixos/nixpkgs-channels/archive/nixos-16.09.tar.gz") {}
, hfst ? import ../hfst { pkgs = pkgs; }
, hfst_ospell ? import ../hfst-ospell { pkgs = pkgs; }
, pyhfst ? import ../pyhfst { pkgs = pkgs; }
, vislcg3 ? import ../vislcg3 { pkgs = pkgs; }
}:

with pkgs;

let self = {
  python3_hfst = python3.buildEnv.override {
    extraLibs = [ pyhfst ];
  };
};

in

stdenv.mkDerivation rec {
  version = "20161115";
  name = "omorfi-${version}";

  src = fetchurl {
    url = "https://github.com/flammie/omorfi/archive/20161115.tar.gz";
    sha256 = "1500d65ab50dac1b1ce29fdf683dfd344d584ed15a40d5ae2d5d720fadba4827";
  };

  # Patch UnicodeDecode/EncodeErrors
  postPatch = ''
    sed -i -e "s|'r', newline|'r', encoding='utf-8', newline|g" src/python/*.py
    sed -i -e "s|\"r\", newline|'r', encoding='utf-8', newline|g" src/python/*.py
    sed -i -e "s|'w', newline|'w', encoding='utf-8', newline|g" src/python/*.py
    sed -i -e "s|\"w\", newline|'w', encoding='utf-8', newline|g" src/python/*.py
    sed -i -e "s|FileType('w')|FileType('w', encoding='utf-8')|g" src/python/*.py
    sed -i -e "s|FileType(\"w\")|FileType('w', encoding='utf-8')|g" src/python/*.py
  '';

  preConfigure = ''
    ./autogen.sh
  '';

  configureFlags = [
   "--enable-segmenter"
   "--enable-lemmatiser"
   "--enable-hyphenator"
  ];

  buildInputs = with self; [
    autoconf
    automake
    hfst
    hfst_ospell
    libtool
    python3_hfst
    time
    vislcg3
    zip
 ];
}
