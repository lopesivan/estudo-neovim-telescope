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
  actions.close(prompt_bufnr)

  vim.cmd("vsplit")
  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_create_buf(true, false)
  vim.api.nvim_win_set_buf(win, buf)
  vim.api.nvim_buf_set_name(buf, selected.display)

  if file_exists(selected.filename) then
	vim.cmd("0r "..selected.filename)
	-- vim.api.nvim_command('write')
  else
	print("Não encontrei o template:", selected.display)
  end

end

local home  = vim.env.HOME
local cwd   = vim.fn.stdpath('config')
local path  = string.format("%s/%s",cwd,"/w/data/example")
local files = scan.scan_dir(path, { hidden = true, depth = 1 })
-- local files = vim.fn.globpath(path, "*", true, true)

local acceptable_files = {}
for _, v in ipairs(files) do
  table.insert(acceptable_files, vim.fn.fnamemodify(v, ":t"))
end

local opts = {
  finder = finders.new_table {
	results = acceptable_files,
	entry_maker = function(line)
	  return {
		ordinal = line,
		display = line,
		filename = path.."/" .. line,
	  }
	end,
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
