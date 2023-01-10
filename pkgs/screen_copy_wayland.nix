{ pkgs }:
pkgs.writeShellApplication {
  name = "screen_copy";
  runtimeInputs = with pkgs; [
    grim
    slurp
    tesseract
    wl-clipboard
  ];

  text = ''
  grim -g "$(slurp -d)" - | tesseract stdin stdout | wl-copy
  '';
}
