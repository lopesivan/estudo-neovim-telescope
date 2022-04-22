local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"

local input = {'rg', '--line-number', '--column',''}

local opts = {
  finder = finders.new_oneshot_job(input),
  sorter = sorters.get_generic_fuzzy_sorter({}),
}

local picker = pickers.new(opts)

picker:find()

