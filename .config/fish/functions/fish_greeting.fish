function fish_greeting
    if test -n $TMUX
        tmux new
        clear
    end
end
