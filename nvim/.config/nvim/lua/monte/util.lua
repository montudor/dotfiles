local M = {}

function M.has(name)
	local plugin = require("lazy.core.config").spec.plugins[name]
	return plugin ~= nil
end

return M
