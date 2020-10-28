#!/bin/zsh

for code in {0..15};
do
    for code2 in {0..15}
    do
        # -P - prompt expansion, -n no new line
        print -P -- "%F{$((code * 16 + code2))}███████%f - $((code * 16 + code2))"
    done
done
