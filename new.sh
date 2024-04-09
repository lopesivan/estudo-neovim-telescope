#!/usr/bin/env bash

suffix=exemplo
suffix=harpoon
ls *-${suffix}.lua |
	xargs -L1 |
	sort -n |
	tail -1 |
	cut -d'-' -f1 | sed 's/^0//' |
	while read n; do printf "cp %02d-${suffix}.lua %02d-${suffix}.lua\n" "$n" "$((n + 1))"; done
