local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"

-- local input = {'rg', '--line-number', '--column', "", vim.fn.expand('~/.config/nvim/w/data/example')}
local input = {'rg', '', vim.fn.expand('~/.config/nvim/w/data/example')}

local opts = {
  finder = finders.new_oneshot_job(input),
  sorters = sorters.get_generic_fuzzy_sorter(),
}

local picker = pickers.new(opts)

picker:find()

