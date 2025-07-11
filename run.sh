set -e
set -m

# When we exit the program, clean up all the subprocesses.
trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

# Record the audio
SPEECH_FILE=$(mktemp)
rec -v 2 -d -c 1 -t wav $SPEECH_FILE silence 1 1 0.1% 1 0:02 0.1%&

# After we put the recording in the background, record the process id
export RECORD_PID=$!
# In the background, wait 60 seconds and then kill the recording.
sleep 60 && kill -9 $RECORD_PID &
# Wait for the recording to stop. It must be killed by another process.
fg %1

# Transcribe the audio
whisper $SPEECH_FILE --model tiny.en --device cuda -o out --output_format txt

file_name=$(basename ${SPEECH_FILE%.*})
cat "out/$file_name.txt"
rm $SPEECH_FILE
