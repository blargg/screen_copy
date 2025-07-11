{ writeShellApplication, openai-whisper, sox }:
writeShellApplication {
  name = "transcribe";
  runtimeInputs = [ openai-whisper sox ];

  text = builtins.readFile ./transcribe.sh;
}
