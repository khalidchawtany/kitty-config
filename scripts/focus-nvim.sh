#!/usr/bin/env sh
# nvim_window_id="$(kitty @ ls | /usr/local/bin/jq -r '.[] .tabs[].windows[] | select(.foreground_processes[].cmdline[] == "nvim") | (.id|tostring)')"
nvim_window_id="$(kitty @ ls | /usr/local/bin/jq -r '[.[] .tabs[].windows[] | select(.foreground_processes[].cmdline[] == "nvim")] | .[0] | (.id|tostring)')"

# if no nvim window is found, return 1
if [ -z "${nvim_window_id}" ]; then
    echo "1"
    exit 1
fi

# or if nvim_window_id is null
if [ "${nvim_window_id}" = "null" ]; then
    echo "1"
    exit 1
fi
kitty @ focus-window -m id:"${nvim_window_id}"
