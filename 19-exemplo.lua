local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"

local input = {'rg', '--line-number', '--column',''}

local opts = {
  finder = finders.new_oneshot_job(input),
  sorters = sorters.get_generic_fuzzy_sorter({}),
}

local picker = pickers.new(opts)

picker:find()

--  FIXME: 💩   > Não funciona conforme o previsto
