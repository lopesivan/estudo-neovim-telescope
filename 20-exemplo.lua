local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"

local rg = {"rg", "--line-number", "--column", "", vim.fn.expand('~/.config/nvim/w/data/example')}

local opts = {
  finder = finders.new_oneshot_job(rg),
  sorter = sorters.get_generic_fuzzy_sorter(),
}

local picker = pickers.new(opts)

picker:find()

--  FIXME: 💩   > funciona conforme o previsto, o bug estava no sorter
--  fix(sorters -> sorter) linha 8
