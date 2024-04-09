local utils = require("harpoon.test.utils")
local harpoon = require("harpoon")

local file_name = "/tmp/harpoon-test"
local list = harpoon:list()
local to_unload = utils.create_file(file_name, {
	"foo",
	"bar",
	"baz",
	"qux",
})
list:add()

utils.create_file(file_name .. "2", {
	"foo",
	"bar",
	"baz",
	"qux",
	"qux",
	"qux",
	"qux",
	"qux",
})
-- list:add()

-- harpoon:list():select(1)

vim.api.nvim_buf_delete(to_unload, { force = true })

-- i have to force it to be out of bounds
-- list.items[1].context = out

-- harpoon:list():select(1)

--    eq({
--        { value = file_name, context = expected}
--    }, harpoon:list().items)
