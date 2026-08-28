#!/usr/bin/env bash

set -e

MAIN_SCRIPT="deploy.sh" 
REPO_NAME="env-master"
URL="https://github.com/ArcherGodson/env/archive/refs/heads/master.zip"

REQUIRED_PKG=""
if ! command -v unzip &> /dev/null; then
    echo "[-] Утилита 'unzip' не найдена."
    REQUIRED_PKG="$REQUIRED_PKG unzip"
fi

if ! command -v rsync &> /dev/null; then
    echo "[-] Утилита 'rsync' не найдена."
    REQUIRED_PKG="$REQUIRED_PKG rsync"
fi

if [ -n "$REQUIRED_PKG" ]; then
    echo "[*] Пытаемся автоматически установить отсутствующие пакеты:$REQUIRED_PKG..."
    
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
        echo "[!] Package manager not found (apt/dnf/yum)."
        echo "[!] Install packages manualy:$REQUIRED_PKG"
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

