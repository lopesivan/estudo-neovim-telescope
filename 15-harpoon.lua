local has_dotenv, dotenv = pcall(require, "dotenv")
if not has_dotenv then
	return
end

if vim.env.GIT == nil then
	dotenv.autocmd()
else
	print(vim.env.GIT)
	local deploy = vim.env.GIT

	local start_pos = deploy:find("{") + 1

	local result = deploy:sub(start_pos, end_pos)
	print(result)
end
