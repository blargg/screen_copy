{
  description = "Simple utility to copy text from images on your screen.";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux = {
      screen_copy = import ./pkgs/screen_copy.nix { pkgs = nixpkgs.legacyPackages.x86_64-linux; };
      screen_copy_wayland = import ./pkgs/screen_copy_wayland.nix { pkgs = nixpkgs.legacyPackages.x86_64-linux; };
    };

    overlays.default = final: prev: {
      screen_copy = import ./pkgs/screen_copy.nix { pkgs = prev; };
      screen_copy_wayland = import ./pkgs/screen_copy_wayland.nix { pkgs = prev; };
    };

  };
}
