#!/bin/bash

fd() {
    preview="git  diff -- {} | DELTA_FEATURES= delta --paging=never --features fzf-preview"
    filename=$(git diff $@ --name-only | fzf -m --ansi --preview=$preview)
    if [ -f "$filename" ]; then
        "$EDITOR" "$filename"
    else
        echo "[$0] No file selected"
        return
    fi
}

fsb() {
    local pattern=${1:-""}
    local branches branch

    if [ -n "$pattern" ]; then
        branches=$(git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short)' |
            awk 'tolower($0) ~ /'"$pattern"'/')
    else
        branches=$(git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short)')
    fi

    branch=$(echo "$branches" |
        fzf-tmux -p --reverse -1 -0 +m \
            --preview 'git log --oneline --graph --date=short --color=always -10 {}' \
            --preview-window=right:60% \
            --header "Recent branches - Enter to checkout")

    if [ -n "$branch" ]; then
        git checkout "$branch"
    else
        echo "[$0] No branch selected"
        return
    fi
}

fshow() {
    git log --graph --color=always \
        --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
        fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort --preview \
            'f() { set -- $(echo -- "$@" | grep -o "[a-f0-9]\{7\}"); [ $# -eq 0 ] || git show --color=always $1 ; }; f {}' \
            --header "enter to view, ctrl-o to checkout" \
            --bind "q:abort,ctrl-f:preview-page-down,ctrl-b:preview-page-up" \
            --bind "ctrl-o:become:(echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | xargs git checkout)" \
            --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF" --preview-window=right:60%
}
