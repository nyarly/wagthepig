{ pkgs ? import <nixpkgs> {} }:
let
  inherit (pkgs) lib stdenv ruby rake bundler bundlerEnv sqlite nodejs;

  rubyEnv = bundlerEnv {
    name = "wagthepig";

    gemdir = ./.;

    groups = ["default" "development" "test"];
  };
in
  pkgs.mkShell {
    # bunder is here so that updates will work
    buildInputs = [rubyEnv nodejs sqlite bundler];
  }
