local rhs_options = {}

function rhs_options:new()
    local instance = {
        cmd = '',
        label = '',
        mode = '',
        options = {
            --noremap = false,
            --silent = false,
            --expr = false,
            --nowait = false,
        }
    }
    setmetatable(instance, self)
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

function rhs_options:map_args(cmd_string)
    self.cmd = (":%s<Space>"):format(cmd_string)
    return self
end

function rhs_options:map_cu(cmd_string)
    self.cmd = (":<C-u>%s<CR>"):format(cmd_string)
    return self
end

function rhs_options:with_label(label)
    self.label = label
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

-- function rhs_options:with_nowait()
--     self.options.nowait = true
--     return self
-- end

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
        if type(value) == 'table' then
            local rhs = value.cmd
            local options = value.options
            vim.api.nvim_set_keymap(mode, keymap, rhs, options)
        end
    end
end

function pbind.convert_wk_format(value)
    local wkitem = {}
    if type(value) == 'table' then
        local rhs = value.cmd
        local label = value.label
        local mode = value.mode
        local options = value.options
        table.insert(wkitem, 1, rhs)
        if label ~= "" then
            table.insert(wkitem, 2, label)
        end
        if mode == "" then
            mode = "n"
        end
        wkitem["mode"] = mode

        if options.silent ~= nil then
            wkitem["silent"] = options.silent
        end

        if options.noremap ~= nil then
            wkitem["noremap"] = options.noremap
        end

        if options.nowait ~= nil then
            wkitem["nowait"] = options.nowait
        end

        if options.expr ~= nil then
            wkitem["expr"] = options.expr
        end

    end
    return wkitem
end

return pbind
