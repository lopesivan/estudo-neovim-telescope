local utils = require("harpoon.test.utils")
local Buffer = require("harpoon.buffer")
local harpoon = require("harpoon")

-- harpoon.ui:toggle_quick_menu(harpoon:list())

-- local one_f = os.tmpname()
local one_f = "/workspace/denver.txt"
local one = utils.create_file(one_f, { "one" })

vim.api.nvim_set_current_buf(one)
-- Buffer.set_contents(harpoon.ui.bufnr, one)
harpoon:list():replace_at(1)

harpoon.ui:toggle_quick_menu(harpoon:list())

--print(vim.inspect(harpoon:list().items))
