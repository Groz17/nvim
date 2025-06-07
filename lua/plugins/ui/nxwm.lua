return {
	'altermo/nwm',
	cond =false,
	branch = "x11",
	-- cond=false,
	opts = {
		--Window-opt: auto focus x-window when entering x-window-buffer
		autofocus = true,
		-- also esc/capslock would be nice
		-- kanata/?
		-- ^\^n like neovim terminal? (kanata)
		unfocus_map = "<M-ESC>",
		verbose = true,
		-- maps = { {
		-- 	{ mods = {}, key = "F2" },
		-- 	function()
		-- 		vim.system({ "scrot" })
		-- 	end,
		-- } },
	},
}
