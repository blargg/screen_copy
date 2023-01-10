{ writeShellApplication, scrot, tesseract, xclip }:
writeShellApplication {
  name = "screen_copy";
  runtimeInputs = [ scrot tesseract xclip ];

  text = ''
  scrot -s - | tesseract stdin stdout | xclip -in -selection clipboard
  '';
}
