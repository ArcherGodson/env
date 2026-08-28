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

echo "Required packages:$REQUIRED_PKG"
if [ -n "$REQUIRED_PKG" ]; then
    SUDO_CMD=""
    if [ "$EUID" -ne 0 ] && command -v sudo &> /dev/null; then
        SUDO_CMD="sudo"
    fi

    # Проверяем, есть ли пакетные менеджеры
    if command -v apt-get &> /dev/null; then
        $SUDO_CMD apt-get update -qq
        $SUDO_CMD apt-get install -y $REQUIRED_PKG
    elif command -v dnf &> /dev/null; then
        $SUDO_CMD dnf install -y $REQUIRED_PKG
    elif command -v yum &> /dev/null; then
        $SUDO_CMD yum install -y $REQUIRED_PKG
    elif command -v apk &> /dev/null; then
        # Alpine Linux
        $SUDO_CMD apk add $REQUIRED_PKG
    elif command -v pacman &> /dev/null; then
        # Arch Linux
        $SUDO_CMD pacman -S --noconfirm $REQUIRED_PKG
    else
        echo "[!] Package manager not found (apt/dnf/yum/apk/pacman)"
        echo "[!] Trying to continue without installing packages"
        echo "[!] Please install these packages manually:$REQUIRED_PKG"
        echo "[!] Note: In Docker containers, packages should already be installed or handled by the base image."
    fi
fi

echo "Syncing $REPO in $HOME"
rsync -av --progress $REPO $HOME --exclude .git --exclude deploy.sh
