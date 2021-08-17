if [ $# -lt 1 ]; then
  echo -e "Add Links To Podboat, Use Podboat As A TUI Download Manager"
  echo -e "\nUsage: $0 <url>"
  echo -e "\nExample:\n$0 http://abcxyz.com/filename.mp3"
else
  URL="$1"
  SAVE_PATH=~/mda/audio/podcast/
  GET_FILENAME="$(echo "$1" | rev | cut -d\/ -f1 | rev | sed -e 's@\%20@\_@g' )"
  
  echo "$URL" "$SAVE_PATH/$GET_FILENAME" >> ~/.config/newsboat/queue
fi
