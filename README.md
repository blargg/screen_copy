# screen_copy

This lets you copy text from places on the screen you normally can't, like text in a PNG image, or part of a program UI that you cannot select.

It runs it through tesseract OCR, so there will sometimes be mistakes, but it's better than nothing.

This currently only supports x server, and will not work for wayland. Adding wayland would be a welcome addition.

# Try it out (with nix flakes and x server)

You can run the command right now with:
```
nix run github:blargg/screen_copy#screen_copy
```

When it finishes installing, you will be able to click and drag over a rectangle of your screen. You should then be able to paste the text you selected from your clipboard buffer (ctrl+v, usually).

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
