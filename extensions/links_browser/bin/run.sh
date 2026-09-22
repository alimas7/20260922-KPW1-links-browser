#!/bin/sh
cd "$(dirname "$0")"

KINDLE_STORAGE_CONFIG="/mnt/us/documents/.links_config"
LOCAL_LINKS_HOME="/home/root/.links"

if [ ! -d "$KINDLE_STORAGE_CONFIG" ]; then
    echo "First-time launch detected. Instantiating configuration templates..."
    mkdir -p "$KINDLE_STORAGE_CONFIG"
    
    cat << 'EOF' > "$KINDLE_STORAGE_CONFIG/bookmarks"
https://frogfind.com|FrogFind (Modern Web Engine Converter)
http://wiby.me|Wiby (Classic Minimal Web Search)
http://text.npr.org|NPR Text-Only News Portal
https://lite.cnn.com|CNN Lite Headline Stream
https://68k.news|68k.news (Google News Parsed into Pure Text)
http://wttr.in|wttr.in (Pure Terminal Text Weather Report)
https://txtify.it|Txtify (Converts pasted links into clean text layouts)
https://brutalist.report|Brutalist Report (Flat headline wire aggregator)
EOF
fi

rm -rf "$LOCAL_LINKS_HOME"
ln -sf "$KINDLE_STORAGE_CONFIG" "$LOCAL_LINKS_HOME"

lipc-set-prop com.lab126.appmgrd stop 2>/dev/null
killall cvm 2>/dev/null

if [ -x /usr/sbin/eink.sh ]; then
    /usr/sbin/eink.sh clear
elif [ -x /usr/bin/eink_prog ]; then
    /usr/bin/eink_prog -c
fi

export HOME=/home/root
export TERM=linux

./links -g -driver fb /dev/fb0 "https://frogfind.com"

clear
lipc-set-prop com.lab126.appmgrd start "{\"appId\":\"com.lab126.booklet.home\"}"
initctl start framework 2>/dev/null
