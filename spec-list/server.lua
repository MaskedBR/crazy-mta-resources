function update()
	local players = getElementsByType("player")
	local list = {}
	for i,v in ipairs(players) do
		list[i] = {}
	end
	for i,v in ipairs(players) do
		if getCameraTarget(v) ~= v and getCameraTarget(v) ~= false then
			local spec = getCameraTarget(v)
			for g,m in ipairs(players) do
				if m == spec then
					f = g
				end
			end
			table.insert(list[f],v)
		end
	end
	for i,v in ipairs(players) do
		setElementData(v,"spec-list",list[i])
	end
end

setTimer(update,1000,0)