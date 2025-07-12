{ writeShellApplication, openai-whisper, sox }:
writeShellApplication {
  name = "whisper-transcribe";
  runtimeInputs = [ openai-whisper sox ];

  text = builtins.readFile ./transcribe.sh;
}
