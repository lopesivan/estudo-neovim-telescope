local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"
local dropdown = require "telescope.themes".get_dropdown()

local input = {'rg', '--files'}

local opts = {
  finder = finders.new_oneshot_job(input),
  sorter = sorters.get_generic_fuzzy_sorter({}),
}

local picker = pickers.new(dropdown, opts)

picker:find()

