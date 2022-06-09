local drawMemoryStats = false

Console:Register('DrawMemoryStats', 'Draw VeniceEXT memory stats for all loaded mods.', function(args)
	if #args == 0 then
		return tostring(drawMemoryStats)
	end

	if #args ~= 1 then
		return 'Usage: _vu.DrawMemoryStats_ <*true* | *false*>'
	end

	local firstArg = args[1]:lower()

	if firstArg == '1' or firstArg == 'y' or firstArg == 'true' or firstArg == 'on' then
		drawMemoryStats = true
		return 'true'
	elseif firstArg == '0' or firstArg == 'n' or firstArg == 'false' or firstArg == 'off' then
		drawMemoryStats = false
		return 'false'
	else
		return 'Usage: _vu.DrawMemoryStats_ <*true* | *false*>'
	end
end)

local color = Vec4(0, 1, 0, 1)

Events:Subscribe('UI:DrawHud', function()
	if drawMemoryStats then
		local stats = BuiltinUtils:GetTotalMemoryUsage()

		local currentX = 20
		local currentY = 20
		local scale = 1.0

		DebugRenderer:DrawText2D(currentX, currentY, '[Mod memory usage]', color, scale)

		for mod, usage in pairs(stats) do
			currentY = currentY + 20
			local usageMb = string.format('%.2f', usage / 1024.0 / 1024.0)
			DebugRenderer:DrawText2D(currentX, currentY, mod .. ' => ' .. usageMb .. 'MB (' .. tostring(usage) .. ')', color, scale)
		end
	end
end)
