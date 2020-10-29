#!/usr/bin/env bash
REPO="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/"
HOME="$(eval echo ~$USER)/"
echo "Syncing $REPO in $HOME"
rsync -av --progress $REPO $HOME --exclude .git --exclude deploy.sh
