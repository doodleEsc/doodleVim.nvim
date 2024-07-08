local lsp = {}

function lsp.mason()
	require("doodleVim.extend.lazy").register_defer_load("DeferStart", 100, "mason", function()
		local ok, _ = pcall(require, "mason")
		if not ok then
			vim.notify("mason load failed", vim.log.levels.ERROR)
			return
		end
	end)

	require("doodleVim.extend.lazy").register_post_install("mason", function()
		local binaries = {
			"clangd",
			"codespell",
			"debugpy",
			"delve",
			"gomodifytags",
			"gopls",
			"impl",
			"java-debug-adapter",
			"java-test",
			"jdtls",
			"lua-language-server",
			"python-lsp-server",
			"ruff",
			"stylua",
		}
		local register = require("mason-registry")
		local bins = ""
		for _, bin in ipairs(binaries) do
			if not register.is_installed(bin) then
				bins = bins .. " " .. bin
			end
		end
		if #bins > 0 then
			vim.cmd("MasonInstall" .. bins)
		end

		-- local jdtls_path = require("mason-core.path").package_prefix("jdtls")
		-- local lombok_jar = jdtls_path .. "/plugins/" .. "lombok.jar"
		--
		-- -- check lombok and install
		-- if not vim.loop.fs_stat(lombok_jar) then
		-- 	vim.schedule(function()
		-- 		vim.fn.system({
		-- 			"wget",
		-- 			"https://projectlombok.org/downloads/lombok.jar",
		-- 			"-O",
		-- 			lombok_jar,
		-- 		})
		-- 		vim.fn.system({
		-- 			"chmod",
		-- 			"755",
		-- 			lombok_jar,
		-- 		})
		-- 	end)
		-- end

		local jdtls_path = require("mason-core.path").package_prefix("jdtls")
		local lombok_jar = jdtls_path .. "/plugins/" .. "lombok.jar"

		-- 检查 lombok.jar 是否存在，如果不存在则下载并设置权限
		if not vim.loop.fs_stat(lombok_jar) then
			vim.notify("adfasdfasdf")
			vim.schedule(function()
				local handle
				local function on_exit()
					vim.loop.spawn("chmod", {
						args = { "755", lombok_jar },
					}, function()
						print("lombok.jar 下载并设置权限成功")
					end)
				end

				handle = vim.loop.spawn("wget", {
					args = { "https://projectlombok.org/downloads/lombok.jar", "-O", lombok_jar },
				}, function()
					handle:close()
					on_exit()
				end)
			end)
		end
	end)
end

function lsp.lsp_signature(plugin)
	require("doodleVim.extend.lsp").register_on_attach(function(client, bufnr)
		require("lsp_signature").on_attach({
			bind = true, -- This is mandatory, otherwise border config won't get registered.
			hint_enable = false,
			handler_opts = {
				border = "rounded",
			},
		}, bufnr)
	end)
end

return lsp
