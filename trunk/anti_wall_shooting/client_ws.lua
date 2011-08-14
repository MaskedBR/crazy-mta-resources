function callServerfunction(funcname, ...)
    local arg = { ... }
    if (arg[1]) then
        for key, value in next, arg do
            if (type(value) == "number") then arg[key] = tostring(value) end
        end
    end
    triggerServerEvent("onClientCallsServerFunction", getRootElement(), funcname, unpack(arg))
end

function callClientfunction(funcname, ...)
    local arg = { ... }
    if (arg[1]) then
        for key, value in next, arg do arg[key] = tonumber(value) or value end
    end
    loadstring("return "..funcname)()(unpack(arg))
end
addEvent("onServerCallsClientFunction", true)
addEventHandler("onServerCallsClientFunction", getRootElement(), callClientfunction)

NO = {16,17,18,35,36,37,39,52,53,54}

function checking(hitElement,weapon,bd,loss)
	cancelEvent()
	lol = false
	for i,v in ipairs(NO) do
		if weapon == v then
			lol = true
		end
	end
	if lol == true then
		callServerfunction("lossHp",getLocalPlayer(),hitElement,weapon,bd,loss)
	end
	if hitElement and lol == false then
		if getElementType(hitElement) == "player" then
			x,y,z = getPedBonePosition(getLocalPlayer(),bd)
			x2,y2,z2 = getPedBonePosition(hitElement,24)
			local result = isLineOfSightClear(x,y,z,x2,y2,z2,true,false,false,true,false)
			if result == true then
				callServerfunction("lossHp",getLocalPlayer(),hitElement,weapon,bd,loss)
			end
		end
	end
end

addEventHandler("onClientPlayerDamage",getLocalPlayer(),checking)