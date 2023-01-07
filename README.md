# screen_copy

This lets you copy text from places on the screen you normally can't, like text in a PNG image, or part of a program UI that you cannot select.

It runs it through tesseract OCR, so there will sometimes be mistakes, but it's better than nothing.

# Nixos install.

Add this flake to your inputs.
```
inputs.screen_copy = {
  url = "github:blargg/screen_copy";
  inputs.nixpkgs.follows = "nixpkgs";
};
```

Then add the overlay to your configuration, and then use the package
```
{
    nixpkgs.overlays = [ screen_copy.overlays.default ];

    # Install the package to the system packages, or use it however you need.
    environment.systemPackages = [ pkgs.screen_copy ];
}
```

At this point, you can use screen_copy like any other nix package.

# Roadmap
I'm looking for better OCR, as long as it is just as easy to install and use.

Add support for wayland. Currently only works for X.

The long term goal is to merge this in to a larger repo, like nixpkgs.
