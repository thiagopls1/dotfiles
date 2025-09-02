local function file_exists(name)
	local f = io.open(name, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

if file_exists(".prettierrc") or file_exists(".prettierignore") then
	-- Prettier setup
	vim.g['prettier#exec_cmd_async'] = 1
	vim.g['prettier#autoformat'] = 1
	vim.g['prettier#config#trailing_comma'] = 'all'
	vim.cmd "au BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.html,*.css,*.yaml Prettier"
end
