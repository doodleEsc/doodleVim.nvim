local M = {}

local DEFAULT = {
	name = "command",
	cwd = "<root>",
	title = "Floaterm",
	width = 0.95,
	height = 0.95,
}

M.new = function(dir)
	dir = dir or "<buffer>"
	vim.cmd("FloatermHide")
	vim.cmd("FloatermNew --cwd=" .. dir)
end

M.kill = function(all)
	all = all or false
	if all then
		vim.cmd("FloatermKill!")
		return
	end

	local term_count = vim.api.nvim_exec(
		[[
        let buffers = floaterm#buflist#gather()
        echo len(buffers)
    ]],
		true
	)

	vim.cmd("FloatermKill")
	if tonumber(term_count) > 1 then
		vim.cmd("FloatermShow")
	end
end

M.run = function(cmd, opts)
	local cmd_opts = vim.tbl_deep_extend("force", DEFAULT, opts or {})

	if cmd == nil then
		return vim.notify("No Command to Run", vim.log.levels.ERROR)
	end

	local command = ":FloatermNew "
	local args = ""
	for k, v in pairs(cmd_opts) do
		args = args .. "--" .. k .. "=" .. v .. " "
	end
	vim.cmd(command .. args .. cmd)
end

return M
