local python = {}

local is_windows = function()
    return vim.loop.os_uname().sysname:find("Windows", 1, true) and true
end

local adapter_python_path = vim.g.python3_host_prog

python.adapters = function(callback, config)
    if config.request == 'attach' then
        local port = (config.connect or config).port
        callback({
            type = 'server',
            port = assert(port, '`connect.port` is required for a python `attach` configuration'),
            host = (config.connect or config).host or '127.0.0.1',
        })
    else
        callback({
            type = 'executable';
            command = adapter_python_path;
            args = { '-m', 'debugpy.adapter' };
        })
    end
end

python.configurations = {
    {
        type = 'python';
        request = 'launch';
        name = 'Launch file';
        program = '${file}';
        pythonPath = function()
            local venv_path = os.getenv("VIRTUAL_ENV")
            if venv_path then
                if is_windows() then
                    return venv_path .. "\\Scripts\\python.exe"
                end
                return venv_path .. "/bin/python"
            end
            return vim.g.python3_host_prog
        end
    },
    {
        type = 'python';
        request = 'launch';
        name = 'Launch file with arguments';
        program = '${file}';
        args = function()
            local args_string = vim.fn.input('Arguments: ')
            return vim.split(args_string, " +")
        end;
        pythonPath = function()
            local venv_path = os.getenv("VIRTUAL_ENV")
            if venv_path then
                if is_windows() then
                    return venv_path .. "\\Scripts\\python.exe"
                end
                return venv_path .. "/bin/python"
            end
            return vim.g.python3_host_prog
        end
    },
    {
        type = 'python';
        request = 'attach';
        name = 'Attach remote';
        connect = function()
            local host = vim.fn.input('Host [127.0.0.1]: ')
            host = host ~= '' and host or '127.0.0.1'
            local port = tonumber(vim.fn.input('Port [5678]: ')) or 5678
            return { host = host, port = port }
        end;
    }
}

python.setup = function(dap)
    -- TODO: check debugpy installed, otherwise install it
    dap.adapters.python = python.adapters
    dap.configurations.python = python.configurations
end

return python
