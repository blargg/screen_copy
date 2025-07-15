{ config, writeShellApplication, openai-whisper, sox }:
writeShellApplication {
  name = "whisper-transcribe";
  runtimeInputs = [ openai-whisper sox ];

  text =
    ''
      set -e

      ${if config.cudaSupport then "" else ''echo "Warning, this was complied without cuda support, you will not be able to use the gpu.
      Enable by setting 'cudaSupport = true' in your nix config. See: https://nix.dev/manual/nix/2.30/command-ref/conf-file.html" >&2''}

      print_usage() {
        echo "Usage: whisper-transcribe [-d <device>] [-m <model>]

        Example:
        whisper-transcribe -d cuda -m tiny.en

        This will run the model on the GPU with tiny.en, a small model that is quick to load, but only supports english.

        -d: The device to run on, (cpu, cuda)
        -m: The model to use, see https://github.com/openai/whisper?tab=readme-ov-file#available-models-and-languages
        " >&2
      }


      while getopts 'd:m:h' flag; do
        case "''${flag}" in
          d) DEVICE="''${OPTARG}" ;;
          m) MODEL="''${OPTARG}" ;;
          h) print_usage
          exit 1 ;;
          *) print_usage
          exit 1 ;;
        esac
      done

      # Record the audio
      SPEECH_FILE=$(mktemp)
      rec -v 2 -d -c 1 -t wav "$SPEECH_FILE" silence 1 1 0.1% 1 0:02 0.1%

      # Transcribe the audio
      OUTPUT_DIR=$(mktemp -d)
      whisper "$SPEECH_FILE" ''${MODEL:+--model "$MODEL"} ''${DEVICE:+--device "$DEVICE"} -o "$OUTPUT_DIR" --output_format txt > /dev/null

      file_name=$(basename "''${SPEECH_FILE%.*}")
      cat "$OUTPUT_DIR/$file_name.txt"
      rm "$SPEECH_FILE"
      rm -r "$OUTPUT_DIR"
    '';
}
