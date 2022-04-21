#!/usr/bin/env bash

ls -rtl *.lua                       |
cut -d" " -f9                       |
tail -1                             |
sed 's/\([0-9]\+\)-exemplo.lua/\1/' |
sed 's/^0//'                        |
while read n; do printf "cp %02d-exemplo.lua %02d-exemplo.lua\n" "$n" "$((n + 1))"; done
