{
  description = "Simple utility to copy text from images on your screen.";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux = {
      screen_copy = import ./pkgs/screen_copy.nix { pkgs = nixpkgs.legacyPackages.x86_64-linux; };
      default = self.packages.x86_64-linux.screen_copy;
    };

  };
}
