function fish_greeting
    if test -n $TMUX
        tmux attach -t central; or tmux new -s central
        clear
    end
end