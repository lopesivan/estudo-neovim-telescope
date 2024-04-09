local List = require("harpoon.list")
local Config = require("harpoon.config")

local config = Config.merge_config({
	foo = {
		decode = function(item)
			-- split item on :
			local parts = vim.split(item, ":")
			return {
				value = parts,
				context = nil,
			}
		end,

		display = function(item)
			return table.concat(item.value, "---")
		end,
	},
})

local list_config = Config.get_config(config, "foo")
local list = List.decode(list_config, "foo", { "f:oo::bar", "baz:qux" })
local displayed = list:display()

print(vim.inspect(displayed))
print(displayed[1])
