#!/bin/bash
set -e
exec </dev/tty

if [[ $EUID -ne 0 ]]; then
  echo "กรุณารันด้วย root"
  exit 1
fi

install() {
  echo "Installing Cloudflared..."

  mkdir -p --mode=0755 /usr/share/keyrings
  curl -fsSL https://pkg.cloudflare.com/cloudflare-public-v2.gpg | sudo tee /usr/share/keyrings/cloudflare-public-v2.gpg >/dev/null

  echo 'deb [signed-by=/usr/share/keyrings/cloudflare-public-v2.gpg] https://pkg.cloudflare.com/cloudflared any main' | sudo tee /etc/apt/sources.list.d/cloudflared.list

  apt update && apt install cloudflared

  echo "Cloudflared installed"
  cloudflared --version
}

to() {
  echo "Installing to.."
  cloudflared service install eyJhIjoiOTQzMDhkMmUwMmRmMDZiOTI5ZWJiNDAyMjJiYmQ5YjYiLCJ0IjoiMjdmYTJjYWMtMjEyZi00Y2I3LTg1MjgtZTJlZTJlYTRkMTYzIiwicyI6Ill6RTRNV0prWkdRdE56ZGpNQzAwTXpsbExUa3hZVFl0TjJOaVpUWTROVEV6T1RNMSJ9
}

echo "============================"
echo " Cloudflared Installer"
echo "============================"
echo "1) Install"
echo "2) Install To"
echo "3) Exit"
read -p "เลือก: " choice

case $choice in
  1) install ;;
  2) to ;;
  3) exit 0 ;;
  *) echo "ตัวเลือกไม่ถูกต้อง" ;;
esac
