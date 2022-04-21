local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"
local themes = require "telescope.themes"

local mini ={
  layout_strategy = "vertical",
  layout_config = {
		width = 100,
		height = 80,
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

  sorters = sorters.get_generic_fuzzy_sorter({}),
}

local dropdown = themes.get_dropdown()
local ivy = themes.get_ivy()
local cursor = themes.get_cursor()

local colors = pickers.new(cursor, opts)

colors:find()

print(vim.inspect(dropdown))
