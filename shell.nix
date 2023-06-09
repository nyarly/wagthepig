let
  pinned = import ./pinned.nix;
in
  { pkgs ? pinned }:
let
  inherit (pkgs) lib stdenv rake bundler bundlerEnv sqlite nodejs;

  rubyEnv = bundlerEnv {
    ruby = pkgs.ruby_2_7;

    name = "wagthepig";

    gemfile = ./Gemfile;
    lockfile = ./Gemfile.lock;
    gemset = ./gemset.nix;

    groups = ["default" "development" "test"];
  };
in
  stdenv.mkDerivation {
    name = "wagthepig-dev";
  #pkgs.mkShell {
    # bunder is here so that updates will work
    buildInputs = with pkgs; [
      nodejs
      sqlite
      bundler
      bundix
      rubyEnv
    ];
  }
