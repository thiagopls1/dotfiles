local theme = {
	fill = 'TabLineFill',
	head = 'TabLine',
	current_tab = 'TabLineSel',
	tab = 'TabLine',
	win = 'TabLine',
	tail = 'TabLine',
}

require "tabby".setup {
	line = function(line)
		return {
			{
				{ '  ', hl = theme.head },
				line.sep('', theme.head, theme.fill),
			},
			line.tabs().foreach(function(tab)
				local hl = tab.is_current() and theme.current_tab or theme.tab
				return {
					line.sep('', hl, theme.fill),
					tab.is_current() and '' or '󰆣',
					tab.number(),
					tab.name(),
					tab.close_btn(''),
					line.sep('', hl, theme.fill),
					hl = hl,
					margin = ' ',
				}
			end),
			line.spacer(),
			line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
				return {
					line.sep('', theme.win, theme.fill),
					win.is_current() and '' or '',
					win.buf_name(),
					line.sep('', theme.win, theme.fill),
					hl = theme.win,
					margin = ' ',
				}
			end),
			{
				line.sep('', theme.tail, theme.fill),
				{ '  ', hl = theme.tail },
			},
			hl = theme.fill,
		}
	end,
	-- option = {}, -- setup modules' option,
}

---- KEYBINDINGS
local tabby_opts = { noremap = true, silent = true }
local nvim_map = vim.api.nvim_set_keymap
---- Move to previous/next
nvim_map('n', '<A-Left>', '<Cmd>-tabnext<CR>', tabby_opts)
nvim_map('n', '<A-Right>', '<Cmd>+tabnext<CR>', tabby_opts)
---- Re-order to previous/next
nvim_map('n', '<A-PageUp>', '<Cmd>-tabmove<CR>', tabby_opts)
nvim_map('n', '<A-PageDown>', '<Cmd>+tabmove<CR>', tabby_opts)
---- Close tab
nvim_map('n', '<A-w>', '<Cmd>tabclose<CR>', tabby_opts)
---- New tab
nvim_map('n', '<A-t>', '<Cmd>tabnew<CR>', tabby_opts)
