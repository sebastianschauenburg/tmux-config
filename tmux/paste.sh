#!/usr/bin/env bash

set -eu

is_app_installed() {
  type "$1" &>/dev/null
}

# Resolve paste backend
paste_backend=""
if [ -n "${DISPLAY-}" ] && is_app_installed xsel; then
  paste_backend="xsel -o 2>/dev/null"
elif [ -n "${DISPLAY-}" ] && is_app_installed xclip; then
  paste_backend="xclip -o"
fi

# if paste backend is resolved, paste and exit
if [ -n "$paste_backend" ]; then
  eval "$paste_backend" | tmux load-buffer - && tmux paste-buffer
  exit;
fi
