
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"

local opts = {

  layout_strategy = "vertical",
  layout_config = {
		width = 0.4,
		height = 0.5,
  },

  finder = finders.new_table {"pablo", "blue", "morning", "shine"},
  sorters = sorters.get_generic_fuzzy_sorter({}),
}

local colors = pickers.new(opts)

colors:find()
