# Estudo da Api telescope

## Objetivo

Aprimorar meu uso da api Telescope utilizando comandos de linha
e a biblioteca libuv.

## new.sh
Esse programa cria um arquivo lua com a numeração sequencial.
Ou seja, se existe o arquivo *n-exemplo.lua*, ele cria outro arquivo
de nome *(n+1)-exemplo.lua*, com o conteúdo do primeiro.

```bash
sh new.sh| sh
```

## É pog, mas ajuda.
```
#!/usr/bin/env bash

ls *-exemplo.lua |
xargs -L1        |
sort -n          |
tail -1          |
cut -d'-' -f1    |
while read n; do printf "cp %02d-exemplo.lua %02d-exemplo.lua\n" "$n" "$((n + 1))"; done
```
## Os três pontos :)

Os três programas dessa série são:

 - [telescope](https://github.com/nvim-telescope/telescope.nvim)
 - [plenary](https://github.com/nvim-lua/plenary.nvim)
 - [neovim](https://github.com/neovim/neovim)

## Sobre mim

Me chamo Ivan, sou engenheiro eletricista e sócio proprietário
da 42algoritmos.com.br.

