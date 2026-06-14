#!/usr/bin/env bash

# Stop formatter daemons after the last Neovim instance exits.

is_nvim_running() {
  pgrep -x nvim &> /dev/null
}

stop_daemons() {
  killall -q eslint_d prettierd
}

# Exit if Neovim is still running after waiting for one second.
sleep 1
if is_nvim_running; then
  exit 0
fi

# Kill any previous ongoing checks.
current_pids=$(pgrep -f "$(basename "$0")")
echo "${current_pids}" | while read -r pid; do
  if [[ ${pid} -ne $$ ]]; then
    kill -TERM "${pid}"
    wait "${pid}"
  fi
done

# Delay before stopping daemons (5m).
sleep 300

# Before stopping, check again if Neovim is running.
if ! is_nvim_running; then
  stop_daemons
fi
