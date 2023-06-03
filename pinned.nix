let
  unstableTgz = builtins.fetchTarball {
    # Descriptive name to make the store path easier to identify
    name = "nixos-nixos-21.05-2023-06-06";
    # Be sure to update the above if you update the archive
    url = https://github.com/nixos/nixpkgs/archive/022caabb5f2265ad4006c1fa5b1ebe69fb0c3faf.tar.gz;
    sha256 = "12q00nbd7fb812zchbcnmdg3pw45qhxm74hgpjmshc2dfmgkjh4n";
  };
in
import unstableTgz {}
