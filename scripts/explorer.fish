#!/usr/bin/env fish

set tmp (mktemp -t "yazi-cdw.XXXXXX")
yazi $argv --cwd-file="$tmp"
if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]
    rm -f -- "$tmp"
    cd -- $cwd
    fish
else
    rm -f -- "$tmp"
end
