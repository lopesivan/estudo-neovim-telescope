-- File: ~/.config/nvim/lua/core/clipmenu_telescope.lua
-- Last Change: Sun, 28 Dec 2025 - 09:05:48
-- Author: Sergio Araujo
-- Purpose: Access clipmenu history (new layout, robust, unique entries, multi-hash)
-- tags: [utils, lua, clipboard, clipmenu]
-- vim: set ts=2 sw=2 tw=78 et fenc=utf-8 ft=lua nospell:

-- NOTA: Sugiro compilar a última versão do clipmenu
-- https://github.com/cdown/clipmenu

local M = {}
local uv = vim.loop

local has_telescope, pickers = pcall(require, 'telescope.pickers')
if not has_telescope then
  vim.notify('Telescope não está instalado.', vim.log.levels.ERROR)
  return M
end
local finders = require('telescope.finders')
local previewers = require('telescope.previewers')
local conf = require('telescope.config').values
local action_state = require('telescope.actions.state')
local actions = require('telescope.actions')

-- Verifica se executável existe
local function executable_exists(cmd) return vim.fn.executable(cmd) == 1 end

-- Pega todas as hash folders de uma clipmenu.* e retorna ordenadas por mtime decrescente
local function get_hash_folders(clip_dir)
  local hashes = {}
  local handle = uv.fs_scandir(clip_dir)
  if not handle then return hashes end

  while true do
    local name, type_ = uv.fs_scandir_next(handle)
    if not name then break end
    if type_ == 'directory' then
      local fullpath = clip_dir .. '/' .. name
      local stat = uv.fs_stat(fullpath)
      if stat then table.insert(hashes, { path = fullpath, mtime = stat.mtime.sec }) end
    end
  end

  table.sort(hashes, function(a, b) return a.mtime > b.mtime end)
  return hashes
end

-- Pega arquivos de uma hash folder ordenados por mtime crescente
local function get_files_in_hash(hash_dir)
  local files = {}
  local handle = uv.fs_scandir(hash_dir)
  if not handle then return files end

  while true do
    local name, type_ = uv.fs_scandir_next(handle)
    if not name then break end
    if type_ == 'file' then
      local fullpath = hash_dir .. '/' .. name
      local stat = uv.fs_stat(fullpath)
      if stat then table.insert(files, { path = fullpath, mtime = stat.mtime.sec }) end
    end
  end

  table.sort(files, function(a, b) return a.mtime < b.mtime end)
  return files
end

-- Função para pegar entradas únicas do clipmenu com limite, percorrendo múltiplas hash folders
local function get_clipmenu_entries(limit)
  limit = limit or 20
  local entries = {}
  local seen = {}

  local cm_dir = os.getenv('CM_DIR') or vim.fn.expand('~/.local/share/clipmenu')
  local clip_dirs = vim.fn.glob(cm_dir .. '/clipmenu.*', 1, 1)
  if #clip_dirs == 0 then return entries end

  table.sort(clip_dirs, function(a, b) return a > b end)
  local clip_dir = clip_dirs[1]

  local hash_folders = get_hash_folders(clip_dir)

  for _, hash in ipairs(hash_folders) do
    local files = get_files_in_hash(hash.path)
    for _, file in ipairs(files) do
      local content_lines = vim.fn.readfile(file.path) or {}
      local content = table.concat(content_lines, '\n')

      if not seen[content] then
        seen[content] = true
        table.insert(entries, {
          display = content:gsub('\n', ' '):sub(1, 50),
          value = content,
        })
      end

      if #entries >= limit then break end
    end
    if #entries >= limit then break end
  end

  return entries
end

-- Função pública para abrir o clipmenu no Telescope
function M.clipmenu()
  if not (executable_exists('clipmenu') or executable_exists('clipmenud')) then
    vim.notify('Clipmenu não encontrado. Instale clipmenu/clipmenud.', vim.log.levels.WARN)
    return
  end

  local entries = get_clipmenu_entries(20)
  if vim.tbl_isempty(entries) then
    vim.notify('Nenhuma entrada do clipmenu encontrada.', vim.log.levels.INFO)
    return
  end

  pickers
    .new({}, {
      prompt_title = 'Clipmenu',
      finder = finders.new_table({
        results = entries,
        entry_maker = function(entry)
          return {
            value = entry.value,
            display = entry.display,
            ordinal = entry.value,
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
      previewer = previewers.new_buffer_previewer({
        define_preview = function(self, entry, _)
          local buf = self.state.bufnr
          vim.api.nvim_buf_set_option(buf, 'filetype', 'txt')
          vim.api.nvim_buf_set_option(buf, 'wrap', true)
          vim.api.nvim_buf_set_option(buf, 'linebreak', true)
          vim.api.nvim_buf_set_option(buf, 'breakindent', true)
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(entry.value, '\n'))
        end,
      }),
      attach_mappings = function(prompt_bufnr, map)
        -- Inserir no buffer na posição do cursor (suporta múltiplas linhas)
        local function insert_clip()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)

          local row, col = unpack(vim.api.nvim_win_get_cursor(0))
          local cur_line = vim.api.nvim_get_current_line()
          local lines = vim.split(selection.value, '\n', true)

          -- divide a linha atual em antes e depois do cursor
          local before = cur_line:sub(1, col)
          local after = cur_line:sub(col + 1, -1)

          -- primeira linha inserida concatena com o começo da linha atual
          lines[1] = before .. lines[1]
          -- última linha concatenada com o resto da linha atual
          lines[#lines] = lines[#lines] .. after

          -- substitui a linha atual pelo novo bloco
          vim.api.nvim_buf_set_lines(0, row - 1, row, false, lines)

          -- coloca cursor na última linha inserida, no final
          vim.api.nvim_win_set_cursor(0, { row + #lines - 1, #lines[#lines] })

          vim.notify('Conteúdo inserido no buffer!', vim.log.levels.INFO)
        end

        -- Copiar para clipboard
        local function copy_clip()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          vim.fn.setreg('+', selection.value)
          vim.fn.setreg('*', selection.value)
          vim.notify('Conteúdo copiado para o clipboard!', vim.log.levels.INFO)
        end

        -- Mapear Enter para inserir no buffer
        map('i', '<CR>', insert_clip)
        map('n', '<CR>', insert_clip)
        -- Mapear Ctrl+Y para copiar no clipboard
        map('i', '<C-y>', copy_clip)
        map('n', '<C-y>', copy_clip)
        -- Mapear Esc para fechar o Telescope imediatamente
        map('i', '<Esc>', actions.close)
        map('n', '<Esc>', actions.close)

        return true
      end,
    })
    :find()
end

return M



