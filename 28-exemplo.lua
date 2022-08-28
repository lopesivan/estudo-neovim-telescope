local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"
local dropdown = require "telescope.themes".get_dropdown()

local function enter(prompt_bufnr)
  local selected = action_state.get_selected_entry()
  local cmd  = 'colorscheme '.. selected[1]
  vim.cmd(cmd)

  local cwd   = vim.fn.stdpath('config')
  local init = string.format("%s/%s",cwd,"/scratch/telescope/arquivo.txt")
  local cmd_job = "sed -i '$d' " .. init .." && echo '".. cmd .."' >>" .. init
  vim.fn.jobstart(cmd_job)
  actions.close(prompt_bufnr)
end

local function next_color(prompt_bufnr)
  actions.move_selection_next(prompt_bufnr)
  local selected = action_state.get_selected_entry()
  local cmd  = 'colorscheme '.. selected[1]
  vim.cmd(cmd)
end

local function prev_color(prompt_bufnr)
  actions.move_selection_previous(prompt_bufnr)
  local selected = action_state.get_selected_entry()
  local cmd  = 'colorscheme '.. selected[1]
  vim.cmd(cmd)
end

-- :h getcompletion
-- getcompletion({pat}, {type} [, {filtered}])		*getcompletion()*
local color_table ={
    "blue",
    "delek",
    "adwaita",
    "desert",
}

local opts = {
  finder = finders.new_table (color_table),
  sorter = sorters.get_generic_fuzzy_sorter({}),
  attach_mappings = function(prompt_bufnr, map)
	map("i", "<CR>", enter)
	-- map("i", "<Down>", next_color)
	-- map("i", "<Up>", prev_color)
	return true
  end
}

local colors = pickers.new(dropdown, opts)

colors:find()

