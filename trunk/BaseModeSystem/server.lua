mapStarted = false

function system(sResource)
	if getResourceInfo(sResource,"type") == "map" then
	mapStarted = true
		local players = getElementsByType("player")
		if get(usefreeze) == true then
			for index,value in ipairs(players) do
				setTimer(setPedFrozen,1000,get(freezetime)-1,value,true)
				setTimer(setPedFrozen,1000*get(freezetime),1,value,false)
			end
			end
			area = nil
			if arena then
				destroyElement(arena)
				arena = nil
			end
		if get(showarea) == true then
			local area = getElementsByType("Anti_Rush_Point")
			if area then
				local x = {}
				local y = {}
				local count = 0
				for i,v in ipairs(area) do
					local tx,ty = getElementPosition(v)
					table.insert(x,tx)
					table.insert(y,ty)
					count = count + 1
				end
				table.sort(x)
				table.sort(y)
				arena = createRadarArea(x[1],y[1],math.abs(x[count]-x[1]),math.abs(y[count]-y[1]),255,0,0,100)
			end
		end
	end 
end

function onStop(sresource)
	if getResourceInfo(sresource,"type") == "map" then
		mapStarted = false
	end
end

addEventHandler("onResourceStart",getRootElement(),system)

function swapAll(thePlayer)
        local playerName = getPlayerName ( thePlayer )
        if isObjectInACLGroup ( "user." .. playerName, aclGetGroup ( "Admin" ) ) then
        end

end

function greetPlayer ( )
	outputChatBox ( "#00FF00BaseMode System made by #FF0000XtremeX.Crazy. #00FF00Sponsored by #FF0000[TSA]Richmond", source, 255, 255, 255, true )
end
addEventHandler ( "onPlayerJoin", getRootElement(), greetPlayer )