{
  description = "Empty nix flake.";

  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, flake-utils, ... }@inputs : flake-utils.lib.eachDefaultSystem(system: let
    pkgs = import inputs.nixpkgs-unstable { inherit system; };
  in {
    packages.default = pkgs.writeShellApplication {
      name = "m4bsplit";
      runtimeInputs = with pkgs; [ coreutils ffmpeg ];
      text = builtins.readFile ./split.sh;
    };
  });
}
