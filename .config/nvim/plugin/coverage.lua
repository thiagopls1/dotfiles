require("coverage").setup({
	auto_reload = true,
})

vim.keymap.set("n", "mc", "<Cmd>CoverageSummary<CR>", { desc = "Open coverage summary" })
