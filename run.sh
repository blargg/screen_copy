set -e

# Record the audio
SPEECH_FILE=$(mktemp)
rec -v 2 -d -c 1 -t wav $SPEECH_FILE silence 1 1 0.1% 1 0:02 0.1%

# Transcribe the audio
whisper $SPEECH_FILE --model tiny.en --device cuda -o out --output_format txt

file_name=$(basename ${SPEECH_FILE%.*})
cat "out/$file_name.txt"
rm $SPEECH_FILE
