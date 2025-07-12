set -e

# Record the audio
SPEECH_FILE=$(mktemp)
rec -v 2 -d -c 1 -t wav "$SPEECH_FILE" silence 1 1 0.1% 1 0:02 0.1%

# Transcribe the audio
OUTPUT_DIR=$(mktemp -d)
whisper "$SPEECH_FILE" --model tiny.en --device cuda -o "$OUTPUT_DIR" --output_format txt

file_name=$(basename "${SPEECH_FILE%.*}")
cat "$OUTPUT_DIR/$file_name.txt"
rm "$SPEECH_FILE"
rm -r "$OUTPUT_DIR"
