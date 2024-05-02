while tmux next-window 2> /dev/null; do
    tmux kill-window
done
tmux movew -r
tmux rename-window term
tmux new-window -n vim
tmux new-window -n git
tmux select-window -t 1
tmux send-keys -t 2 lazygit Enter
tmux send-keys -t 1 "vim ." Enter
