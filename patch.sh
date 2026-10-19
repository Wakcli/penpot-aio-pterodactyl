set -euo pipefail

for f in /etc/cont-init.d/*.sh /etc/services.d/*/run /usr/local/bin/env-helpers.sh; do
	sed -i 's#/appdata#/home/container/appdata#g' "$f"
done

python3 - <<'PY'
from pathlib import Path

p = Path("/etc/services.d/frontend/run")
s = p.read_text()
needle = 'exec nginx -g "daemon off;"'
patch = ''': "${SERVER_PORT:=8080}"
sed -i "s/listen 8080 /listen ${SERVER_PORT} /" /etc/nginx/nginx.conf

'''
if needle not in s:
	raise SystemExit("frontend run: nginx exec not found")
p.write_text(s.replace(needle, patch + needle, 1))
PY
