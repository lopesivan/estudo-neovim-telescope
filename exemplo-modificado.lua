local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"
local dropdown = require "telescope.themes".get_dropdown()



-- local filetype  = vim.bo.filetype
-- local extension = vim.fn.expand "%:e"

local home = vim.env.HOME
local cwd = '.config/nvim/w/data/example'
local path = string.format("%s/%s",home, cwd)
local input = {'rg', path}

local opts = {
  finder = finders.new_oneshot_job(input),
  sorters = sorters.get_generic_fuzzy_sorter({}),
}

local colors = pickers.new(dropdown, opts)

colors:find()

