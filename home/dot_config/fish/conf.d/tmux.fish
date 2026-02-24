if type -q tmux
    alias tm 'tmux attach -t (basename $PWD) || tmux new -s (basename $PWD)'
end