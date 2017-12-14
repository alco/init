function tnux
    if [ 0 -eq (count $argv) ]
        tmux new-session -s (basename (pwd))
    else
        tmux new-session -s $argv
    end
end
