local rhs_options = {}

function rhs_options:new()
  local instance = {
    cmd = '',
    options = {
      noremap = false,
      silent = false,
      expr = false,
      nowait = false,
    }
  }
  setmetatable(instance,self)
  self.__index = self
  return instance
end

function rhs_options:map_cmd(cmd_string)
  self.cmd = cmd_string
  return self
end

function rhs_options:map_cr(cmd_string)
  self.cmd = (":%s<CR>"):format(cmd_string)
  return self
end

function  rhs_options:map_args(cmd_string)
  self.cmd = (":%s<Space>"):format(cmd_string)
  return self
end

function rhs_options:map_cu(cmd_string)
  self.cmd = (":<C-u>%s<CR>"):format(cmd_string)
  return self
end

function rhs_options:with_silent()
  self.options.silent = true
  return self
end

function rhs_options:with_noremap()
  self.options.noremap = true
  return self
end

function rhs_options:with_expr()
  self.options.expr = true
  return self
end

function rhs_options:with_nowait()
  self.options.nowait = true
  return self
end

local utils = {}

function utils.map_cr(cmd_string)
  local ro = rhs_options:new()
  return ro:map_cr(cmd_string)
end

function utils.map_cmd(cmd_string)
  local ro = rhs_options:new()
  return ro:map_cmd(cmd_string)
end

function utils.map_cu(cmd_string)
  local ro = rhs_options:new()
  return ro:map_cu(cmd_string)
end

function utils.map_args(cmd_string)
  local ro = rhs_options:new()
  return ro:map_args(cmd_string)
end

function utils.nvim_load_mapping(mapping)
    for key,value in pairs(mapping) do
      local mode,keymap = key:match("([^|]*)|?(.*)")
      if type(value) == 'table' then
        local rhs = value.cmd
        local options = value.options
        vim.api.nvim_set_keymap(mode,keymap,rhs,options)
      end
    end
end

function utils.packer_defer_load(plugin, timer)
	if plugin then
		timer = timer or 0
		vim.defer_fn(function()
			require("packer").loader(plugin)
		end, timer)
	end
end

return utils
