local actions      = require "telescope.actions"
local action_state = require "telescope.actions.state"
local pickers      = require "telescope.pickers"
local finders      = require "telescope.finders"
local sorters      = require "telescope.sorters"
local dropdown     = require "telescope.themes".get_dropdown()
local scan         = require "plenary.scandir"

local function file_exists(fname)
  local stat = vim.loop.fs_stat(fname)
  return (stat and stat.type) or false
end

local function enter(prompt_bufnr)
  local selected = action_state.get_selected_entry()
  local fname = selected[1]
  print(vim.inspect(selected))
  actions.close(prompt_bufnr)

  -- vim.cmd("vsplit")
  -- local win = vim.api.nvim_get_current_win()
  -- local buf = vim.api.nvim_create_buf(true, false)
  -- vim.api.nvim_win_set_buf(win, buf)
  -- vim.api.nvim_buf_set_name(buf, "cheetah.yml")

  print(fname)
--[[
  if file_exists(fname) then
	print(fname)
	-- vim.cmd("0r "..fname)
	-- vim.api.nvim_command('write')
  else
	print("Não encontrei o template:", fname)
  end ]]

end

-- local home  = vim.env.HOME
-- local cwd   = '.config/nvim/w/data/example'
-- local dir   = string.format("%s/%s",home, cwd)
-- local files = scan.scan_dir(dir, { hidden = true, depth = 1 })

local files = {
  "agua", "fogo", "vento", "terra"
}

local opts = {
  finder = finders.new_table {
	results = {
	  { "red", "#ff0000" },
	  { "green", "#00ff00" },
	  { "blue", "#0000ff" },
	},
	entry_maker = function(entry)
	  return {
		value = entry,
		display = "[".. entry[1] .."]",
		ordinal = entry[1],
	  }
	end
  },
  sorter = sorters.get_generic_fuzzy_sorter({}),

  attach_mappings = function(prompt_bufnr, map)
	map("i", "<CR>", enter)
	return true
  end

}

local picker = pickers.new(dropdown, opts)

picker:find()

--vim: set ft=lua nowrap:
