local List = require("harpoon.list")
local Config = require("harpoon.config")

local config = Config.merge_config({
	cmd = {
		decode = function(item)
			-- split item on :
			local parts = vim.split(vim.trim(item:gsub("%s+", "")), ",")
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
local list = List.decode(list_config, "cmd", { "         valac, sss     main.vala", "./main" })
local displayed = list:display()

-- print(#list.items)
local console = require("config.console")
for index, cmd in ipairs(displayed) do
	console.exec(cmd)
end
