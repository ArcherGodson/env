#!/usr/bin/env bash

set -e

MAIN_SCRIPT="deploy.sh" 
REPO_NAME="env-master"
URL="https://github.com/ArcherGodson/env/archive/refs/heads/master.zip"

TMP_DIR=$(mktemp -d)
echo "$TMP_DIR created"
cd "$TMP_DIR"

curl -sL "$URL" -o repo.zip
unzip -q repo.zip
rm repo.zip

ls -lath "$TMP_DIR"
cd "$REPO_NAME"

bash "$MAIN_SCRIPT" "$@"

rm -rf "$TMP_DIR"

