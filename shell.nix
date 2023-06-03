let
  pinned = import ./pinned.nix;
in
  { pkgs ? pinned }:
let
  inherit (pkgs) lib stdenv ruby rake bundler bundlerEnv sqlite nodejs;

  rubyEnv = bundlerEnv {
    inherit ruby;

    name = "wagthepig";

    gemfile = ./Gemfile;
    lockfile = ./Gemfile.lock;
    gemset = ./gemset.nix;

    groups = ["default" "development" "test"];
  };
in
  pkgs.mkShell {
    # bunder is here so that updates will work
    buildInputs = with pkgs; [
      rubyEnv
      nodejs
      sqlite
      bundler
      bundix
    ];
  }
