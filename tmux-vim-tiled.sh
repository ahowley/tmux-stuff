session_name=$(tmux display-message -p '#S')

tmux move-window -r

tmux select-window -t "$session_name:vim"
tmux join-pane -s "$session_name:git" -t "$session_name:vim" -d
tmux join-pane -s "$session_name:term" -t "$session_name:vim" -d

tmux select-layout main-horizontal
tmux resize-pane -D 10
