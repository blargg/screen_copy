{ config, writeShellApplication, openai-whisper, sox, xdotool }:
writeShellApplication {
  name = "whisper-transcribe";
  runtimeInputs = [ openai-whisper sox xdotool ];

  text =
    ''
      set -e

      ${if config.cudaSupport then "" else ''echo "Warning, this was complied without cuda support, you will not be able to use the gpu.
      Enable by setting 'cudaSupport = true' in your nix config. See: https://nix.dev/manual/nix/2.30/command-ref/conf-file.html" >&2''}

      print_usage() {
        echo "Usage: whisper-transcribe [-d <device>] [-m <model>]

        Example:
        whisper-transcribe -d cuda -m tiny.en -t

        This will run the model on the GPU using the  tiny.en model, and types the text out to the current cursor location.

        -d: The device to run on, (cpu, cuda)
        -m: The model to use, see https://github.com/openai/whisper?tab=readme-ov-file#available-models-and-languages
        " >&2
      }


      while getopts 'd:m:ht' flag; do
        case "''${flag}" in
          d) DEVICE="''${OPTARG}" ;;
          m) MODEL="''${OPTARG}" ;;
          t) TYPE_OUTPUT=true ;;
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
      FILE_PATH="$OUTPUT_DIR/$file_name.txt"
      if [ "$TYPE_OUTPUT" = true ]; then
        xdotool type "$(cat "$FILE_PATH")"
      else
        cat "$FILE_PATH"
      fi
      rm "$SPEECH_FILE"
      rm -r "$OUTPUT_DIR"
    '';
}
