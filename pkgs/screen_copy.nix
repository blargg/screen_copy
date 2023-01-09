{ pkgs }:
pkgs.writeShellApplication {
  name = "screen_copy";
  runtimeInputs = with pkgs; [ scrot tesseract xclip ];

  text = ''
  scrot -s - | tesseract stdin stdout | xclip -in -selection clipboard
  '';
}
