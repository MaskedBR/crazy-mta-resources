ids = {}

function setIDOnStartup()
	local players = getElementsByType("player")
	for i,v in ipairs(players) do
		ids[i]=v
	end
end

function setIDOnJoin()
	local index = 0
	repeat
		index = index + 1
	until ids[index] == nil
	ids[index] = source
end

function removeIdOnExit()
	for i,v in ipairs(ids) do
		if ids[i] == source then
			ids[i] = nil
			break
		end
	end
end

function sendMessage(thePlayer, commandname, id, ...)
	if ids[tonumber(id)] ~= nil then
		local message = ""
		for i,v in ipairs(arg) do
			message = message.." "..v
		end
		outputChatBox("*PM Sent!",thePlayer,0,255,0)
		outputChatBox("*PM from "..getPlayerName(thePlayer)..":"..message,ids[tonumber(id)],255,255,0)
	else
		outputChatBox("*Wrong ID!",thePlayer,255,0,0)
	end
end

function getID(thePlayer,cmd,name)
	for i,v in ipairs(ids) do
	if name ~= nil then
		local result = string.find(getPlayerName(v),name)
		if result ~= nil then
			outputChatBox("*"..getPlayerName(v).."'s id is "..i,thePlayer,0,255,0)
		end
	else
		outputChatBox("*"..getPlayerName(v).."'s id is "..i,thePlayer,0,255,0)
	end
	end
end

addCommandHandler("pm",sendMessage)
addCommandHandler("getid",getID)
addEventHandler("onResourceStart",getResourceRootElement(),setIDOnStartup)
addEventHandler("onPlayerJoin",getRootElement(),setIDOnJoin)
addEventHandler("onPlayerExit",getRootElement(),removeIdOnExit)