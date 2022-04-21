#!/usr/bin/env bash

ls *-exemplo.lua |
xargs -L1        |
sort -n          |
tail -1          |
cut -d'-' -f1    |
while read n; do printf "cp %02d-exemplo.lua %02d-exemplo.lua\n" "$n" "$((n + 1))"; done
