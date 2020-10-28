#!/bin/zsh

code=0
for code2 in {0..15}
do
    # -P - prompt expansion, -n no new line
    print -P -n -- "%F{$((code * 16 + code2))}█%f"
done
echo ''

base=16
for code in {0..37};
do
    for code2 in {0..5}
    do
        # -P - prompt expansion, -n no new line
        print -P -n -- "%F{$((base + code * 6 + code2))}█%f"
    done
    echo ''
done

code=15
for code2 in {0..15}
do
    # -P - prompt expansion, -n no new line
    print -P -n -- "%F{$((code * 16 + code2))}█%f"
done
echo ''
