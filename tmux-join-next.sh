#!/bin/bash

POSITIONAL_ARGS=()

while [[ $# -gt 0 ]]; do
  case $1 in
    --merge)
      MERGE=YES
      shift # past argument
      ;;
    --split)
      MERGE=NO
      shift # past argument
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

tmux move-window -r
current_window_number=$(tmux display-message -p '#I')
next_window_number=$(expr $current_window_number + 1)
next_window_name=$(tmux display-message -t $next_window_number -p "#W")

merge_or_split() {
  if [[ "$MERGE" == "YES" ]]; then
    tmux join-pane -s "$next_window_number" -t "$current_window_number" -d -h
    echo "$next_window_name" > ~/.local/bin/window_2_name.txt
  elif [[ "$MERGE" == "NO" ]]; then
    while read -r line; do recover_window_name="$line"; done < ~/.local/bin/window_2_name.txt

    tmux new-window -n "$recover_window_name"
    new_window_number=$(tmux display-message -p "#I")
    tmux join-pane -s "$current_window_number.1" -t "$new_window_number" -d
    tmux kill-pane -t 0
    tmux select-window -t "$current_window_number"
  fi
}

merge_or_split
