local template = {}

local function file_exists(fname)
	local stat = vim.loop.fs_stat(fname)
	return (stat and stat.type) or false
end
-- Or use vim.fn.filereadable(fname)

template.load = function()
	-- filetype is a buffer-local option `vim.bo`
	local filetype  = vim.bo.filetype
	local extension = vim.fn.expand "%:e"
	local home = vim.env.HOME

	if filetype == "" then
		filetype = vim.fn.expand "%"
	end

	local fname = string.format("%s/.config/nvim/templates/%s/skel.%s", home,  filetype, extension)

	if file_exists(fname) then
		vim.cmd("0r "..fname)

		vim.cmd([[ silent! %s/|n|/\=substitute(expand('%'),'.*\/', '', '')/g ]])
		vim.cmd([[ silent! %s/|n%|/\=substitute(s:filename,'.*\/', '', '')/g ]])
		vim.cmd([[ silent! %s/|d|/\=substitute(strftime('%c'),'.*\/', '', '')/g ]])
		vim.cmd([[ silent! %s/|user.name|/\=substitute(system('git config user.name'), '\n$', '', '')/g ]])
		vim.cmd([[ silent! %s/|user.email|/\=substitute(substitute(substitute(system('git config user.email'), '\n$', '', ''), '\s(at)\s','@',''), '\s(dot)\s', '.', 'g')/g ]])
		vim.cmd([[ silent! %s/|user.site|/\=substitute(system('git config user.site'), '\n$', '', '')/g ]])
	else
		print("Não encontrei o template:", fname)
	end

end

template.yaml = function()

	local filetype  = vim.bo.filetype
	local home = vim.env.HOME
	local fname = string.format("%s/.config/nvim/templates/%s/cheetah.yml",home, filetype)

	vim.cmd('vsplit')
	local win = vim.api.nvim_get_current_win()
	local buf = vim.api.nvim_create_buf(true, false)
	vim.api.nvim_win_set_buf(win, buf)
	vim.api.nvim_buf_set_name(buf, "cheetah.yml")
	vim.bo.filetype = "yaml"

	if file_exists(fname) then
		vim.cmd("0r "..fname)
		vim.api.nvim_command('write')
	else
		print("Não encontrei o template:", fname)
	end

end

return template
