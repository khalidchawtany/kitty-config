#!/usr/bin/env sh
all_tabs="$(
    kitty @ ls | /usr/local/bin/jq -r '.[] .tabs[] | (.id|tostring) + " -> " + .title|split("\n")|join(" ")' | column -ts $'\t'
)"

new_tab_id="$(/usr/local/bin/fzf --reverse <<< "${all_tabs}" | awk '{ print $1 }')"

kitty @ focus-tab -m id:"${new_tab_id}"

kitty @ close-window --self

# #!/usr/bin/env bash
# /usr/local/bin/fzf --with-nth 2..  --bind 'enter:execute-silent(kitty @ focus-tab -m id:{1})+accept' > /dev/null \
#     <<<$(kitty @ ls | /usr/local/bin/jq -r '.[] .tabs[] | (.id|tostring) + " -> " + .title') && exit
