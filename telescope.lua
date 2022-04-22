-- https://github.com/nvim-telescope/telescope.nvim/blob/master/developers.md
local M = {}

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local previewers = require("telescope.previewers")

Colors = function(opts)
  pickers.new(opts, {
    prompt_title = "Colors",
    -- finder = finders.new_table {
    --   results = {"red", "blue", "green", "yellow", "brown", "orange"}
    -- },
    finder = finders.new_oneshot_job { "curl","cht.sh/:list", opts },

    -- finder = finders.new_table {
    --   results = {
    --     { "red", "#ff0000" },
    --     { "green", "#00ff00" },
    --     { "blue", "#0000ff" },
    --   },
    --   entry_maker = function(entry)
    --     return {
    --       value = entry,
    --       display = entry[1],
    --       ordinal = entry[1],
    --     }
    --   end
    -- },

    sorter = conf.generic_sorter(opts),
    previewer = previewers.new_termopen_previewer({
      get_command = function(entry,status)
        -- print(vim.inspect(entry))
        -- local selection = action_state.get_selected_entry()
        -- print(vim.inspect(selection))
        --
        return { "curl", "cht.sh/"..entry[1]}
      end
    }),

    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        -- local data = vim.api.nvim_exec("!curl cht.sh/"..selection[1],false)
        print(vim.inspect(selection))
        -- print(vim.inspect(data))
        -- vim.api.nvim_put({data}, "", false, true)
      end)
      return true
    end,

  borderchars             = {"─", "│", "─", "│", "┌", "┐", "┘", "└"},
  }):find()
end


M.search_nvin_dotfiles = function()
  require("telescope.builtin").find_files({
    prompt_title = "< Nvim Config >",
    cwd = "~/.config/nvim",
    search_dirs = {"lua", "plugin"}
  })
end

M.cheat_sheet = function()
  require("telescope.builtin").find_files({
    prompt_title = "< Nvim Config >",
    cwd = "~/.config/nvim",
    search_dirs = {"lua", "plugin"}
  })
end
return M;
