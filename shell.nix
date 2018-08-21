{ pkgs ? import <nixpkgs> {} }:
let
  inherit (pkgs) lib stdenv ruby rake bundler bundlerEnv sqlite nodejs;

  rubyEnv = bundlerEnv {
    name = "wagthepig";

    gemdir = ./.;
  };
in
  pkgs.mkShell {
    buildInputs = [rubyEnv nodejs sqlite];
  }
