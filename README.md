# AI Utils

A growing collections of AI based utitlies that everyone should have.

1. Copy text from images, pdfs, etc with `screen_copy`
2. Type out text from your spoken words with `whipser-transcribe`

# Try it out now

## Screen Copy

This lets you copy text from places on the screen you normally can't, like text in a PNG image, or part of a program UI that you cannot select.

You can run the command right now with:

```
nix run github:blargg/ai-utils#screen_copy
```

When it finishes installing, you will be able to click and drag over a rectangle of your screen. You should then be able to paste the text you selected from your clipboard buffer (ctrl+v, usually).

This currently only supports x server, and will not work for wayland. Adding wayland would be a welcome addition.

## Transcribing

```
nix run github:blargg/ai-utils#whisper-transcribe -- -m tiny.en -t
```

This will listen until you stop speaking, then type out the text. You can remove the `-t` to just echo to stdout, if that works better for you.

# Nixos install.

Add this flake to your inputs.

```
inputs.ai-utils = {
  url = "github:blargg/ai-utils";
  inputs.nixpkgs.follows = "nixpkgs";
};
```

Then add the overlay to your configuration, and then use the package

```
{
    nixpkgs.overlays = [ ai-utils.overlays.default ];

    # Install the package to the system packages, or use it however you need.
    environment.systemPackages = [ pkgs.screen_copy <and other packages ...>];
}
```

At this point, you can use screen_copy like any other nix package.
