local M = {}

M.packer_defer_load = function(plugin, timer)
   if plugin then
      timer = timer or 0
      vim.defer_fn(function()
         require("packer").loader(plugin)
      end, timer)
   end
end

M.packer_defer_load_with_config = function(plugin, config, timer)
   if plugin then
      timer = timer or 0
      vim.defer_fn(function()
         require("packer").loader(plugin)
	 config()
      end, timer)
   end
end

return M
