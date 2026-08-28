#!/usr/bin/env bash
REPO="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/"
HOME="$(eval echo ~$USER)/"

REQUIRED_PKG=""
for pkg in "rsync zsh htop tmux mc"
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

echo "Syncing $REPO in $HOME"
rsync -av --progress $REPO $HOME --exclude .git --exclude deploy.sh
