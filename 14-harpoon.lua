local utils = require("harpoon.test.utils")
local Buffer = require("harpoon.buffer")
local harpoon = require("harpoon")
local Path = require("pathlib")

local folder = Path(".")
local foo = folder / "foo.txt"
local one_f = tostring(foo)
local one = utils.create_file(one_f, {})

vim.api.nvim_set_current_buf(one)

local cmd = "e! | r /workspace/a.lua | 1d"
vim.api.nvim_command(cmd)
-- utils.key(":e! | r /workspace/a.lua | 1d<CR>")

-- Buffer.set_contents(harpoon.ui.bufnr, one)
harpoon:list():replace_at(1)

harpoon.ui:toggle_quick_menu(harpoon:list())

--print(vim.inspect(harpoon:list().items))
