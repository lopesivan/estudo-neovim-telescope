local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"

local dirs = {
  '~/.config/nvim/after/plugin',
  '~/.config/nvim/after/ftplugin',
}

local input = {"rg", "--line-number", "--column", ""}

for _, path in ipairs(dirs) do
	table.insert(input, vim.fn.expand(path))
end

local opts = {
  finder = finders.new_oneshot_job(input),
  sorter = sorters.get_generic_fuzzy_sorter(),
}

local picker = pickers.new(opts)

picker:find()

