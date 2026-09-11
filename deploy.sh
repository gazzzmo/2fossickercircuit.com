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

# FTPS requires curl's explicit-TLS flag; plain FTP does not.
SSL_FLAG=""
case "$BASE" in
  ftps://*) SSL_FLAG="--ssl-reqd" ;;
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
