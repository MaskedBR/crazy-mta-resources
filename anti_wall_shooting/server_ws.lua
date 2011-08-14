function callServerfunction(funcname, ...)
    local arg = { ... }
    if (arg[1]) then
        for key, value in next, arg do arg[key] = tonumber(value) or value end
    end
    loadstring("return "..funcname)()(unpack(arg))
end
addEvent("onClientCallsServerFunction", true)
addEventHandler("onClientCallsServerFunction", getRootElement(), callServerfunction)

function callClientfunction(client, funcname, ...)
    local arg = { ... }
    if (arg[1]) then
        for key, value in next, arg do
            if (type(value) == "number") then arg[key] = tostring(value) end
        end
    end
    triggerClientEvent(client, "onServerCallsClientFunction", getRootElement(), funcname, unpack(arg or {}))
end

function onJoin()
	outputChatBox("#FF0000>>#00FF00This server using Anti Wall Shooting Bug Script by #00FFFFCrazy#FF0000<<",source,255,0,0,true)
end

function lossHp(thePlayer,killer,wp,bd,loss)
	local hp = getElementHealth(thePlayer)
	local res = hp - loss
	if res <= 0 then
		killPed(thePlayer,killer,wp,bd)
	else
		setElementHealth(thePlayer,res)
	end
end

addEventHandler("onPlayerJoin",getRootElement(),onJoin)