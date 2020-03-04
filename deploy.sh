#!/usr/bin/env bash
rsync -av --progress ./ ~/ --exclude .git
