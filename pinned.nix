let
  unstableTgz = builtins.fetchTarball {
    # Descriptive name to make the store path easier to identify
    name = "nixos-nixos-21.11-2023-06-06";
    # Be sure to update the above if you update the archive
    url = https://github.com/nixos/nixpkgs/archive/eabc38219184cc3e04a974fe31857d8e0eac098d.tar.gz;
    sha256 = "04ffwp2gzq0hhz7siskw6qh9ys8ragp7285vi1zh8xjksxn1msc5";
  };
in
import unstableTgz {}
