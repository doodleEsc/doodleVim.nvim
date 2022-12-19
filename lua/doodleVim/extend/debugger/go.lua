local go = {}

local adapter_factory = function(adapter_bin_path)
    adapter_bin_path = "dlv" or adapter_bin_path
    return function(callback, config)
        local stdout = vim.loop.new_pipe(false)
        local handle
        local pid_or_err
        local host = config.host or "127.0.0.1"
        local port = config.port or "38697"
        local addr = string.format("%s:%s", host, port)
        local opts = {
            stdio = { nil, stdout },
            args = { "dap", "-l", addr },
            detached = true,
        }
        handle, pid_or_err = vim.loop.spawn(adapter_bin_path, opts, function(code)
            stdout:close()
            handle:close()
            if code ~= 0 then
                vim.nofity("dlv exited with code: " .. code)
            end
        end)
        assert(handle, "Error running dlv: " .. tostring(pid_or_err))
        stdout:read_start(function(err, chunk)
            assert(not err, err)
            if chunk then
                vim.schedule(function()
                    require("dap.repl").append(chunk)
                end)
            end
        end)
        -- Wait for delve to start
        vim.defer_fn(function()
            callback({ type = "server", host = "127.0.0.1", port = port })
        end, 100)
    end
end

go.configurations = {
    {
        type = "go",
        name = "Debug",
        request = "launch",
        program = "${file}",
    },
    {
        type = "go",
        name = "Debug Package",
        request = "launch",
        program = "${fileDirname}",
    },
    {
        type = "go",
        name = "Attach",
        mode = "local",
        request = "attach",
        processId = require("dap.utils").pick_process,
    },
    {
        type = "go",
        name = "Debug test",
        request = "launch",
        mode = "test",
        program = "${file}",
    },
    {
        type = "go",
        name = "Debug test (go.mod)",
        request = "launch",
        mode = "test",
        program = "./${relativeFileDirname}",
    },
}

go.setup = function(dap)
    local register = require("mason-registry")
    if not register.is_installed("delve") then
        vim.notify("`delve` not installed. Install it by `:MasonInstall delve`", vim.log.levels.ERROR)
        return
    end

    local adapter_bin_path = require("mason-core.path").bin_prefix("dlv")
    dap.adapters.go = adapter_factory(adapter_bin_path)
    dap.configurations.go = go.configurations
end

return go
