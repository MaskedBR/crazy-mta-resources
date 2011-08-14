elementsToSync = {}

function findRotation(x1,y1,x2,y2)
	local t = -math.deg(math.atan2(x2-x1,y2-y1))
	if t < 0 then t = t + 360 end
	return t
end

function addSync()
	table.insert(elementsToSync,source)
end

function removeSync()
	for i,v in ipairs(elementsToSync) do
		if v == source then
			table.remove(elementsToSync,i)
		end
	end
end

addEvent("addPedToSync",true)
addEvent("removePedToSync",true)
addEventHandler("addPedToSync",getRootElement(),addSync)
addEventHandler("removePedToSync",getRootElement(),removeSync)

function string.count(theString)
	if #theString ~= 0 then
	local count = 0
	while string.find(theString,",") do
		count = count + 1
		theString = string.sub(theString,string.find(theString,",")+1)
	end
	return count + 1
	else
	return 0
	end
end

function syncPeds()
	for i,v in ipairs(elementsToSync) do
		local currentPoint = getElementData(v,"currentPoint")
		local x,y,z = getElementPosition(currentPoint)
		local x2,y2,z2 = getElementPosition(v)
		local dis = getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
		setPedControlState(v,"forwards",true)
		setPedControlState(v,"walk",true)
		setPedRotation(v,findRotation(x2,y2,x,y))
		if dis < 1.5 then
			local attaches = getElementData(currentPoint,"attaches")
			math.randomseed(getTickCount())
			local nextPointID = gettok(attaches,math.random(1,string.count(attaches)),string.byte(","))
			local nextPoint = getElementByID(nextPointID)
			setElementData(v,"currentPoint",nextPoint)
		end
	end
end

addEventHandler("onClientRender",getRootElement(),syncPeds)

function onStreamIn()
	if getElementType(source) == "ped" then
		outputChatBox("Stream IN!")
	end
end


function onStreamOut()
	if getElementType(source) == "ped" then
		outputChatBox("Stream OUT!")
	end
end

addEventHandler("onClientElementStreamIn",getRootElement(),onStreamIn)
addEventHandler("onClientElementStreamOut",getRootElement(),onStreamOut)