local python = {}

local is_windows = function()
    return vim.loop.os_uname().sysname:find("Windows", 1, true) and true
end

local get_python_path = function()
    local venv_path = os.getenv('VIRTUAL_ENV') or os.getenv('CONDA_PREFIX')
    if venv_path then
        if is_windows() then
            return venv_path .. '\\Scripts\\python.exe'
        end
        return venv_path .. '/bin/python'
    end
    -- if M.resolve_python then
    --     assert(type(M.resolve_python) == "function", "resolve_python must be a function")
    --     return M.resolve_python()
    -- end
    return nil
end

local enrich_config = function(config, on_config)
    if not config.pythonPath and not config.python then
        config.pythonPath = get_python_path()
    end
    if config.subProcess == nil then
        config.subProcess = false
    end
    on_config(config)
end

local adapter_factory = function(adapter_bin_path)
    return function(callback, config)
        print(vim.inspect(callback))
        if config.request == "attach" then
            local port = (config.connect or config).port
            callback({
                type = "server",
                host = (config.connect or config).host or "127.0.0.1",
                port = assert(port, "`connect.port` is required for a python `attach` configuration"),
                enrich_config = enrich_config,
                options = {
                    source_filetype = 'python',
                }
            })
        else
            callback({
                type = "executable",
                command = adapter_bin_path,
                -- args = { "-m", "debugpy.adapter" },
                enrich_config = enrich_config;
                options = {
                    source_filetype = 'python',
                }
            })
        end
    end
end

python.configurations = {
    {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
    },
    {
        type = "python",
        request = "launch",
        name = "Launch file with arguments",
        program = "${file}",
        args = function()
            local args_string = vim.fn.input("Arguments: ")
            return vim.split(args_string, " +")
        end,
    },
    {
        type = "python",
        request = "attach",
        name = "Attach remote",
        connect = function()
            local host = vim.fn.input("Host [127.0.0.1]: ")
            host = host ~= "" and host or "127.0.0.1"
            local port = tonumber(vim.fn.input("Port [5678]: ")) or 5678
            return { host = host, port = port }
        end,
    },
}

python.setup = function(dap)
    local register = require("mason-registry")
    if not register.is_installed("debugpy") then
        vim.notify("`debugpy` not installed. Install it by `:MasonInstall debugpy`", vim.log.levels.ERROR)
        return
    end
    local adapter_bin_path = require("mason-core.path").bin_prefix("debugpy-adapter")
    dap.adapters.python = adapter_factory(adapter_bin_path)
    dap.configurations.python = python.configurations
end

return python
