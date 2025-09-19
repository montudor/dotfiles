local M = {}

function M.detect_jvm_target()
	local handle = io.popen("java -version 2>&1")
	if not handle then
		return "17"
	end
	local out = handle:read("*a") or ""
	handle:close()

	-- Try modern "version "21..." or legacy "1.8"
	local major = out:match('version "%s*(%d+)[%._]') or out:match('version "%s*1%.(%d+)')
	major = tonumber(major)

	if not major then
		return "17"
	elseif major >= 21 then
		return "21"
	elseif major >= 17 then
		return "17"
	elseif major >= 11 then
		return "11"
	else
		return "1.8"
	end
end

function M.settings()
	local target = M.detect_jvm_target()
	return {
		kotlin = {
			compiler = {
				jvm = {
					target = target,
				},
			},
		},
	}
end

return M
