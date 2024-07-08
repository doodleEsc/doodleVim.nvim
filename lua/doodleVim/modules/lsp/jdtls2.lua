local jdtls = {}
local trim = require("doodleVim.utils.utils").trim

function jdtls.get_config()
	local mason_registry = require("mason-registry")
	local lombok_jar = mason_registry.get_package("jdtls"):get_install_path() .. "/lombok.jar"

	return {
		root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew" }),
		project_name = function(root_dir)
			return root_dir and vim.fs.basename(root_dir)
		end,
		-- Where are the config and workspace dirs for a project?
		jdtls_config_dir = function(project_name)
			return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/config"
		end,
		jdtls_workspace_dir = function(project_name)
			return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/workspace"
		end,
	}
end

return jdtls
