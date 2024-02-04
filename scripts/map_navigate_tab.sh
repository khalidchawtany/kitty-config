#!/usr/bin/env sh
nvim_window_id="$(kitty @ ls | /usr/local/bin/jq -r '[.[] .tabs[].windows[] | select(.foreground_processes[].cmdline[] == "nvim")] | .[0] | (.id|tostring)')"
current_window_id="$(kitty @ ls | /usr/local/bin/jq -r '[.[] .tabs[] | select(.is_active == true)] | .[0] | (.active_window_history).[0]')"

index="$(($1-1))"

# echo "ls: $(kitty @ ls)"
# echo "nvim_window_id: $nvim_window_id"
# echo "current_window_id: $current_window_id"
if [ "$nvim_window_id" = "$current_window_id" ]; then 
    kitty @ send-key -m id:"${nvim_window_id}" "cmd+$1"
else
    str="[.[] .tabs[]] | .[$index] | (.id)"
    # tab_id="$(kitty @ ls | /usr/local/bin/jq -r '[.[] .tabs[]] | .[0] | (.id)')"
    tab_id="$(kitty @ ls | /usr/local/bin/jq -r "$str")"
    kitty @ focus-tab -m id:"${tab_id}"
fi;

