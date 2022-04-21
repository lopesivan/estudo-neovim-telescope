local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"
local dropdown = require "telescope.themes".get_dropdown()


function enter(prompt_bufnr)
  local selected = action_state.get_selected_entry()
  -- print(vim.inspect(selected))
  cmd  = 'colorscheme '.. selected[1]
  vim.cmd(cmd)
  actions.close(prompt_bufnr)
end

local opts = {
  finder = finders.new_table {"pablo", "blue", "morning", "shine"},

  sorters = sorters.get_generic_fuzzy_sorter({}),

  attach_mappings = function(prompt_bufnr, map)
	map("i", "<CR>", enter)
	return true
  end
}

local colors = pickers.new(dropdown, opts)

colors:find()

