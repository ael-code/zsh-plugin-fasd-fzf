if [[ $commands[fzf] && $commands[fasd] ]]; then
    cd-fzf-widget() {
        local dir
        dir="$(fasd -Rdl "$1" | \
            fzf-tmux -1 -0 \
                    --no-sort \
                    --height=16 \
                    --reverse \
                    --toggle-sort=ctrl-r\
            )" && cd "${dir}"
        local ret=$?
        zle reset-prompt
          typeset -f zle-line-init >/dev/null && zle zle-line-init
        return $ret
    }
    zle -N cd-fzf-widget
    bindkey '\ej' cd-fzf-widget
fi

if [[ $commands[fd] ]]
then
    _FINDER_CMD='fd'
else
    _FINDER_CMD='find . -type f -type d'
fi

if [[ $commands[fzf] ]]; then
    cd-fzf-fd-widget() {
        local dir
        dir="$(dirname $(${_FINDER_CMD} | \
            fzf-tmux -1 -0 \
                    --no-sort \
                    --height=16 \
                    --reverse \
                    --toggle-sort=ctrl-r)
            )" && cd "${dir}"
        zle reset-prompt
          typeset -f zle-line-init >/dev/null && zle zle-line-init
        return $ret
    }
    zle -N cd-fzf-fd-widget
    bindkey '^j' cd-fzf-fd-widget
fi
