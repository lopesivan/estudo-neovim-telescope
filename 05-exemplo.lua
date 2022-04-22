local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"

local mini ={
  layout_strategy = "vertical",
  layout_config = {
		width = 100,
		height = 100,
		prompt_position = "top",
  },
  sorting_strategy = "ascending",
}

local opts = {
  finder = finders.new_table {
	"/home/ivan/.config/nvim/templates/go/models/hello.md",
	"/home/ivan/.config/nvim/templates/go/models/hello/hello.go",
	"/home/ivan/.config/nvim/templates/go/models/hello/go.mod",
  },

  sorter = sorters.get_generic_fuzzy_sorter({}),
}

local colors = pickers.new(mini, opts)

colors:find()
