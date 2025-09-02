#!/usr/bin/env fish

if count $argv > 0
    ghostty -e fish -c "$argv"
else
    ghostty -e fish
end
