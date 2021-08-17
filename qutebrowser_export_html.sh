#!/bin/bash

# qutebrowser_export_html.sh
# this script generates a simple html startpage for qutebrowser
# containing quickmarks, bookmarks and history.

print_usage() {
  echo "Usage: $0 [-q quickmarks] [-b bookmarks] [-h history] [-l history-limit] [-o out] [-r]"
  echo "    -q     specify quickmark file (default: ~/.config/qutebrowser/quickmarks)"
  echo "    -b     specify bookmarks file (default: ~/.config/qutebrowser/bookmarks/urls)"
  echo "    -h     specify history sqlite database (default: ~/.local/share/qutebrowser/history.sqlite)"
  echo "    -l     specify history display limit (default: 50)"
  echo "    -o     specify html output file (default: ~/.config/qutebrowser/qutebrowser.html)"
  echo "    -r     open generated html file in qutebrowser"
}

# generate html and open via keybind:
# bind ; spawn ~/qutebrowser_export_html.sh -r

# credits: original script by John L. Godlee: https://johngodlee.github.io/2018/12/01/qute-w3m.html

# defaults
# quickmarks location
quickmarks=~/.config/qutebrowser/quickmarks

# bookmarks location
bookmarks=~/.config/qutebrowser/bookmarks/urls

# history location
history=~/.local/share/qutebrowser/history.sqlite
history_limit=10

# generated html file
out=~/.config/qutebrowser/qutebrowser.html

# open html in qutebrowser
open=false


while getopts "q:b:h:l:o:r" opt; do
  case $opt in
    q) quickmarks=$OPTARG ;;
    b) bookmarks=$OPTARG ;;
    h) history=$OPTARG ;;
    l) history_limit=$OPTARG ;;
    o) out=$OPTARG ;;
    r) open=true ;;
    *) print_usage
       exit 1
  esac
done

touch "$out"

echo "<html><head><title>qutebrowser bookmarks</title></head>
<body>" > "$out"


echo "<table><tr>
<th style='max-width: 20%'>Quickmarks</th>
<th style='max-width: 40%'>Bookmarks</th>
<th style='max-width: 40%'>History</th>
</tr>" >> "$out"

echo "<tr><td style='vertical-align:top'><ul>" >> "$out"
while read -r line; do
    url=$(sed 's@.* @@' <<< "$line")
    desc=$(sed 's/\(.*\) .*/\1/' <<< "$line")
    echo "<li><a href=\"$url\">$desc</a>" >> "$out"
done < "$quickmarks"

echo "</ul></td>" >> "$out"

echo "<td style='vertical-align:top'><ul>" >> "$out"

while read -r line; do
    url=$(echo "$line" | cut -d " " -f 1)
    desc=${line#* }
    echo "<li><a href=\"$url\">$desc</a>" >> "$out"
done < "$bookmarks"

echo "<td style='vertical-align:top'>" >> "$out"

hist=$(sqlite3 -separator ' ' "$history" "select url,title from History ORDER BY atime DESC LIMIT $history_limit")

while IFS= read -r line; do
    url=$(echo "$line" | cut -d " " -f 1)
    desc=${line#* }
    echo "<li><a href=\"$url\">$desc</a>" >> "$out"
done <<< "$hist"

echo "</td></tr>
</table>
</body>
</html>" >> "$out"

if [ "$open" = true ] ; then
    qutebrowser "$out"
fi
