#!/usr/bin/env bash

set -e

MAIN_SCRIPT="deploy.sh" 
REPO_NAME="env-master"
URL="https://github.com/ArcherGodson/env/archive/refs/heads/master.zip"

REQUIRED_PKG=""
for pkg in "unzip rsync"
do
  if ! command -v $pkg &> /dev/null; then
    REQUIRED_PKG="$REQUIRED_PKG $pkg"
  fi
done

if [ -n "$REQUIRED_PKG" ]; then
    SUDO_CMD=""
    if [ "$EUID" -ne 0 ] && command -v sudo &> /dev/null; then
        SUDO_CMD="sudo"
    fi

    if command -v apt-get &> /dev/null; then
        $SUDO_CMD apt-get update -qq
        $SUDO_CMD apt-get install -y $REQUIRED_PKG
    elif command -v dnf &> /dev/null; then
        $SUDO_CMD dnf install -y $REQUIRED_PKG
    elif command -v yum &> /dev/null; then
        $SUDO_CMD yum install -y $REQUIRED_PKG
    else
        echo "[!] Package manager not found (apt/dnf/yum)"
        echo "[!] Please install these packages manually:$REQUIRED_PKG"
        exit 1
    fi
fi

TMP_DIR=$(mktemp -d)
cd "$TMP_DIR"

curl -sL "$URL" -o repo.zip
unzip -q repo.zip
rm repo.zip

ls -lath "$TMP_DIR"
cd "$REPO_NAME"

bash "$MAIN_SCRIPT" "$@"

rm -rf "$TMP_DIR"

