session_name=$(tmux display-message -p '#S')

while tmux next-window 2> /dev/null; do
    tmux kill-window
done
tmux movew -r
tmux rename-window term
tmux break-pane -s "$session_name:term.2" -n git -d
tmux break-pane -s "$session_name:term.0" -n vim
tmux swap-window -t -1
tmux select-window -t "$session_name:vim"

