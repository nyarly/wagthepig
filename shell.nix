{ pkgs ? import <nixpkgs> {} }:
let
  inherit (pkgs) lib stdenv ruby rake bundler bundlerEnv sqlite nodejs;

  rubyEnv = bundlerEnv {
    name = "wagthepig";

    gemdir = ./.;
  };
in
  pkgs.mkShell {
    # bunder is here so that updates will work
    buildInputs = [rubyEnv nodejs sqlite bundler];
  }
