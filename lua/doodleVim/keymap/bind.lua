local rhs_options = {}

function rhs_options:new()
	local instance = {
		"",
		"",
		buffer = nil,
		silent = false,
		noremap = false,
		nowait = false,
		expr = false,
	}
	setmetatable(instance, self)
	self.__index = self
	return instance
end

function rhs_options:map_cmd(cmd_string)
	self[1] = cmd_string
	return self
end

function rhs_options:map_cr(cmd_string)
	self[1] = (":%s<cr>"):format(cmd_string)
	return self
end

function rhs_options:map_args(cmd_string)
	self[1] = (":%s<Space>"):format(cmd_string)
	return self
end

function rhs_options:map_cu(cmd_string)
	self[1] = (":<C-u>%s<cr>"):format(cmd_string)
	return self
end

function rhs_options:with_label(label)
	self[2] = label
	return self
end

function rhs_options:with_silent()
	self.silent = true
	return self
end

function rhs_options:with_noremap()
	self.noremap = true
	return self
end

function rhs_options:with_expr()
	self.expr = true
	return self
end

function rhs_options:with_nowait()
	self.nowait = true
	return self
end

function rhs_options:with_mode(mode)
	self.mode = mode
	return self
end

local pbind = {}

function pbind.map_cr(cmd_string)
	local ro = rhs_options:new()
	return ro:map_cr(cmd_string)
end

function pbind.map_cmd(cmd_string)
	local ro = rhs_options:new()
	return ro:map_cmd(cmd_string)
end

function pbind.map_cu(cmd_string)
	local ro = rhs_options:new()
	return ro:map_cu(cmd_string)
end

function pbind.map_args(cmd_string)
	local ro = rhs_options:new()
	return ro:map_args(cmd_string)
end

function pbind.nvim_load_mapping(mapping)
	for key, value in pairs(mapping) do
		local mode, keymap = key:match("([^|]*)|?(.*)")
		if type(value) == "table" then
			local rhs = value.cmd
			local options = value.options
			vim.api.nvim_set_keymap(mode, keymap, rhs, options)
		end
	end
end

function pbind.convert_wk_format(value)
	print(vim.inspect(value))
	return value
end

return pbind
