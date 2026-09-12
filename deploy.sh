#!/usr/bin/env bash
set -euo pipefail

# Deploy 2fossickercircuit.com to the web host over FTP(S).
# Credentials come from the environment or a gitignored .ftpcreds file.
# Never commit credentials to this repo.

DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DIR"

if [ -f .ftpcreds ]; then
  set -a
  # shellcheck disable=SC1091
  . ./.ftpcreds
  set +a
fi

: "${FTP_URL:?Set FTP_URL, e.g. ftps://ftp.example.com/public_html/}"
: "${FTP_USER:?Set FTP_USER}"
: "${FTP_PASS:?Set FTP_PASS}"

BASE="${FTP_URL%/}"

# This host uses explicit FTPS (AUTH TLS on port 21). The `ftps://` URL scheme
# would force implicit FTPS on port 990, which is closed, so use `ftp://` with
# curl's --ftp-ssl flag to negotiate TLS explicitly.
SSL_FLAG=""
case "$BASE" in
  ftp://*) SSL_FLAG="--ftp-ssl" ;;
esac

upload() {
  local file="$1"
  echo "Uploading ${file} -> ${BASE}/${file}"
  # shellcheck disable=SC2086
  curl --fail --silent --show-error ${SSL_FLAG} \
    --user "${FTP_USER}:${FTP_PASS}" \
    --upload-file "${file}" \
    "${BASE}/${file}"
}

# The whole site is index.html. Any future assets get added to this list.
for file in index.html; do
  upload "$file"
done

echo "Deploy complete."
