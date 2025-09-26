#!/bin/sh

samwrt() {
    chmod +x /etc/samwrt.sh && sh /etc/samwrt.sh
}

jimmywrt() {
    chmod +x /etc/jimmywrt.sh && sh /etc/jimmywrt.sh
}

echo "Load Settings:"
echo "1) SamWrt"
echo "2) JimmyWrt"
echo "0) Exit"

read -p "Please select: " choice

case "$choice" in
    1) samwrt ;;
    2) jimmywrt ;;
    *) exit 0 ;;
esac

