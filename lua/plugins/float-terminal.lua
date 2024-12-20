local state = {
	floating = {
		buf = -1,
		win = -1,
	},
}

local function open_floating_terminal(opts)
	opts = opts or {}
	local width = opts.width or math.floor(vim.o.columns * 0.7)
	local height = opts.height or math.floor(vim.o.lines * 0.7)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	local buf = nil
	if vim.api.nvim_buf_is_valid(opts.buf) then
		buf = opts.buf
	else
		buf = vim.api.nvim_create_buf(false, true)
	end

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		row = row,
		col = col,
		width = width,
		height = height,
		style = "minimal",
		border = "rounded",
	})

	return { buf = buf, win = win }
end

local toggle_terminal = function()
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		state.floating = open_floating_terminal({ buf = state.floating.buf })
		if vim.bo[state.floating.buf].buftype ~= "terminal" then
			vim.cmd.terminal()
		end
	else
		vim.api.nvim_win_hide(state.floating.win)
	end
end

vim.api.nvim_create_user_command("FloatTerminal", toggle_terminal, {})
vim.keymap.set({ "n", "t" }, "<leader>tt", toggle_terminal, { desc = "Toggle Terminal" })

-- local resize_terminal = function(args)
-- 	local size = args.args
-- 	if size then
-- 		state.floating.width = size.width or state.floating.width
-- 		state.floating.height = size.height or state.floating.height
-- 	end
-- 	state.floating = open_floating_terminal(state.floating)
-- 	vim.api.nvim_win_set_width(state.floating.win, state.floating.width)
-- 	vim.api.nvim_win_set_height(state.floating.win, state.floating.height)
-- end

-- vim.api.nvim_create_user_command("FloatTerminalResize", resize_terminal, { nargs = "?" })
