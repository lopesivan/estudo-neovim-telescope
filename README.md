# Estudo da Api telescope

## Objetivo

Aprimorar meu uso da api Telescope utilizando comandos de linha
e a biblioteca libuv.

## new.sh

Esse programa cria um arquivo lua com a numeração sequencial.
Ou seja, se existe o arquivo _n-harpoon.lua_, ele cria outro arquivo
de nome _(n+1)-harpoon.lua_, com o conteúdo do primeiro.

```bash
sh new.sh| sh
```

## É pog, mas ajuda.

```
$ git status --porcelain|
cut -c 1-3 --complement |
sort -n |
xargs -L1 -I{}  echo "git add {} && git commit -m '{}'"
```

## Os três pontos :)

Os três programas dessa série são:

- [telescope](https://github.com/nvim-telescope/telescope.nvim)
- [plenary](https://github.com/nvim-lua/plenary.nvim)
- [neovim](https://github.com/neovim/neovim)

## Sobre mim

Me chamo Ivan, sou engenheiro eletricista e sócio proprietário
da 42algoritmos.com.br.
