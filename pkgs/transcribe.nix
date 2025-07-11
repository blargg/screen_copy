{ writeShellApplication, openai-whisper, sox }:
writeShellApplication {
  name = "screen_copy";
  runtimeInputs = [ openai-whisper sox ];

  text = ''
    echo TODO
  '';
}
