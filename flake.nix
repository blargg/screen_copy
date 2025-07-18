{
  description = "Simple utility to copy text from images on your screen.";

  # inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.nixpkgs.url = "flake:nixpkgs";

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux =
      let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        callPackage = pkgs.callPackage;
      in
      {
        screen_copy = callPackage ./pkgs/screen_copy.nix { };
        whisper-transcribe = callPackage ./pkgs/whisper-transcribe.nix { }; # Updated import
      };

    overlays.default = final: prev:
      let
        callPackage = final.callPackage;
      in
      {
        screen_copy = callPackage ./pkgs/screen_copy.nix { };
        whisper-transcribe = callPackage ./pkgs/whisper-transcribe.nix { }; # Updated import
      };

  };
}
