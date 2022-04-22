local M = {}

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"
local dropdown = require "telescope.themes".get_dropdown()


local function file_exists(fname)
    local stat = vim.loop.fs_stat(fname)
    return (stat and stat.type) or false
end
-- Or use vim.fn.filereadable(fname)

local function enter(prompt_bufnr)
  local selected = action_state.get_selected_entry()

  local fname = selected[1]

  actions.close(prompt_bufnr)

  -- local win = vim.api.nvim_get_current_win()
  -- local buf = vim.api.nvim_create_buf(true, false)
  -- vim.api.nvim_win_set_buf(win, buf)
  -- vim.api.nvim_buf_set_name(buf, "cheetah.yml")

  if file_exists(fname) then
    vim.cmd("0r "..fname)
	-- vim.api.nvim_command('write')
  else
    print("Não encontrei o template:", fname)
  end

end

function M.load()

local opts = {
  finder = finders.new_table {
	"/home/ivan/.config/nvim/w/data/example/fibo.se",
	"/home/ivan/.config/nvim/w/data/example/strcat.mingw32",
	"/home/ivan/.config/nvim/w/data/example/binomial.bc",
	"/home/ivan/.config/nvim/w/data/example/sieve.delphi",
	"/home/ivan/.config/nvim/w/data/example/sieve.pike",
	"/home/ivan/.config/nvim/w/data/example/forster_log.bc",
	"/home/ivan/.config/nvim/w/data/example/csubloop.sh",
	"/home/ivan/.config/nvim/w/data/example/hanoi.cpp",
	"/home/ivan/.config/nvim/w/data/example/sieve.ocamlb",
	"/home/ivan/.config/nvim/w/data/example/sieve.nice",
  },

  sorter = sorters.get_generic_fuzzy_sorter({}),

  attach_mappings = function(prompt_bufnr, map)
	map("i", "<CR>", enter)
	return true
  end
}

local colors = pickers.new(dropdown, opts)

colors:find()

end

return M
