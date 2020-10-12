#!/usr/bin/env bash
rsync -av --progress $(dir $0) ~/ --exclude .git --exclude deploy.sh
