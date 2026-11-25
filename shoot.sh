#!/bin/bash
# Shoot the Nov 24 news-image poster (1024x1024) via headless Chromium + CDP.
set -u
cd ~/workspace/makefun/news-image-20261124 || exit 1
URL="file:///home/hatch/workspace/makefun/news-image-20261124/poster.html"

pkill -f 'remote-debugging-port=9222' 2>/dev/null; sleep 1
rm -rf /tmp/chrome-news24

/opt/meta-chromium/chrome --headless=new --remote-debugging-port=9222 \
  --hatch-webgl-allowed-domains-file=/home/hatch/workspace/makefun/webgl-policy.txt \
  --hatch-webgl-allowed-domains-sha256=c5c85869591ff8b3491450f49cfd62912c6dd41e5cecada4e831191d3185035e \
  --allow-file-access-from-files --window-size=1024,1161 --no-sandbox \
  --user-data-dir=/tmp/chrome-news24 --no-first-run --disable-dev-shm-usage \
  --no-default-browser-check --force-device-scale-factor=1 "${URL}" >/tmp/chrome-news24.log 2>&1 &
for i in $(seq 1 40); do curl -s http://localhost:9222/json/list >/dev/null 2>&1 && break; sleep 0.5; done
node ~/workspace/makefun/shoot.mjs - "/home/hatch/workspace/makefun/news-image-20261124/entry.png" 1024 1024
pkill -f 'remote-debugging-port=9222' 2>/dev/null; sleep 1
ls -la /home/hatch/workspace/makefun/news-image-20261124/entry.png
python3 -c "from PIL import Image; im=Image.open('/home/hatch/workspace/makefun/news-image-20261124/entry.png'); print('size:', im.size, 'mode:', im.mode)"
