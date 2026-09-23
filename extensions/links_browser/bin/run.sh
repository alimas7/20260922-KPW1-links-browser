#!/bin/sh

APP_DIR="/mnt/us/extensions/links_browser"
APP="$APP_DIR/bin/links"
LOG="/mnt/us/links-browser.log"

export HOME="/mnt/us"
export SSL_CERT_FILE="$APP_DIR/cacert.pem"
export SSL_CERT_DIR=""

{
    echo "===== Links HTTPS diagnostic ====="
    date
    echo
    echo "CA bundle:"
    ls -l "$SSL_CERT_FILE"
    echo
    "$APP" -dump https://example.org/
    echo
    echo "Exit status: $?"
} > "$LOG" 2>&1

exit 0