dontUse = {0,1,2,3,4,5,6,8,42,65,74,86,119,149,208,265,266,267,268,269,270,271,272,273}

function getRandomPedId()
	local g
	local id
	repeat
		g = false
		id = math.random(1,288)
		for i,v in ipairs(dontUse) do
			if v == id then
				g = true
			end
		end
	until g == false
	return id
end

function load()
	local file = xmlLoadFile("spawnpoints.map")
	local children = xmlNodeGetChildren(file)
	math.randomseed(getTickCount())
	for i,v in ipairs(children) do
		local x = xmlNodeGetAttribute(v,"posX")
		local y = xmlNodeGetAttribute(v,"posY")
		local z = xmlNodeGetAttribute(v,"posZ")
		local id = xmlNodeGetAttribute(v,"id")
		local attaches = xmlNodeGetAttribute(v,"attaches")
		local p = createElement("path-point",id)
		setElementPosition(p,x,y,z)
		setElementData(p,"attaches",attaches)
		local ped = createPed(getRandomPedId(),x,y,z+1)
		setElementData(ped,"currentPoint",p)
	end
end

load()

function tellToSync(thePlayer)
	if getElementType(source) == "ped" then
		triggerClientEvent("addPedToSync",source,thePlayer)
	end
end

function tellToStopSync(thePlayer)
	if getElementType(source) == "ped" then
		triggerClientEvent("removePedToSync",source,thePlayer)
	end
end

addEventHandler("onElementStartSync",getRootElement(),tellToSync)
addEventHandler("onElementStopSync",getRootElement(),tellToStopSync)