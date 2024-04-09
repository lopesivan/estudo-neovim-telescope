local List = require("harpoon.list")
local Config = require("harpoon.config")

local config = Config.merge_config({
	cmd = {
		decode = function(item)
			-- split item on :
			local parts = vim.split(item, ",")
			return {
				value = parts,
				context = nil,
			}
		end,

		display = function(item)
			return table.concat(item.value, " ")
		end,
	},
})

local list_config = Config.get_config(config, "cmd")
local list = List.decode(list_config, "cmd", { "valac, main.vala", "./main" })
local displayed = list:display()

for index, value in ipairs(displayed) do
	-- print(displayed[index])
	print(value)
end
-- print(#list.items)
-- local cmd = displayed[1]
-- local console = require("config.console")
-- console.exec(cmd)
