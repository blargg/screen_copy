{ pkgs }:
with pkgs;
let script = ''
${scrot}/bin/scrot -s - | ${tesseract}/bin/tesseract stdin stdout | ${xclip}/bin/xclip -in -selection clipboard
'';
in
stdenv.mkDerivation {
  name = "screen-copy";
  src = "";

  # TODO is this needed?
  buildInputs = [
    xclip
    tesseract
    scrot
  ];

  buildCommand = ''
    mkdir -p $out/bin
    echo '${script}' > $out/bin/screen_copy
    chmod +rx $out/bin/screen_copy
  '';
}