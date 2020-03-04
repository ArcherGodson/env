#!/usr/bin/env bash
rsync -av --progress ./ ~/ --exclude .git --exclude deploy.sh
