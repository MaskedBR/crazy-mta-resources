firstPoint = nil
selectedPoint = nil
counter = 0

function nearestPoint(x,y,z)
	local points = getElementsByType("path-point")
	if #points ~= 0 then
		local nearest = points[1]
		for i,v in ipairs(points) do
			local nX,nY,nZ = getElementPosition(nearest)
			local vX,vY,vZ = getElementPosition(v)
			if getDistanceBetweenPoints3D(vX,vY,vZ,x,y,z) < getDistanceBetweenPoints3D(nX,nY,nZ,x,y,z) then
				nearest = v
			end
		end
		local nX,nY,nZ = getElementPosition(nearest)
		if getDistanceBetweenPoints3D(nX,nY,nZ,x,y,z) < 3 then
			return nearest
		else
			return false
		end
	else
		return false
	end
end

function isAttached(fP,sP)
	local fpData = getElementData(fP,"attaches")
	for i,v in ipairs(fpData) do
		if v == sP then
			return true
		end
	end
	return false
end

addEventHandler("onClientRender",getRootElement(),
function ()
	for i,v in ipairs(getElementsByType("path-point")) do
		local attached = getElementData(v,"attaches")
		for i2,v2 in ipairs(attached) do
			local x,y,z = getElementPosition(v)
			local x2,y2,z2 = getElementPosition(v2)
			dxDrawLine3D(x,y,z+1,x2,y2,z2+1,tocolor(0,255,0),3)
		end
	end
end)

bindKey("f","down",
function ()
	showCursor(true,true)
	outputChatBox("Click on the place, you wan't add a path point to",255,255,0)
	local function created(_,_,_,_,x,y,z)
		removeEventHandler("onClientClick",getRootElement(),created)
		showCursor(false)
		outputChatBox("Path point created!",0,255,0)
		local createdPathPoint = createElement("path-point","point"..tostring(counter))
		counter = counter + 1
		setElementPosition(createdPathPoint,x,y,z)
		local object = createObject(2993,x,y,z)
		setElementData(createdPathPoint,"obj",object)
		setElementData(createdPathPoint,"attaches",{})
	end
	addEventHandler("onClientClick",getRootElement(),created)
end)

			
function attachWut(_,state,_,_,x,y,z)
	if state == "down" then
		if firstPoint == nil then
			if nearestPoint(x,y,z) ~= false then
				firstPoint = nearestPoint(x,y,z)
				outputChatBox("Click on the other point, you wan't to attach it to",255,255,0)
			else
				outputChatBox("Point not found!",255,0,0)
				showCursor(false)
				removeEventHandler("onClientClick",getRootElement(),attachWut)
				removeEventHandler("onClientRender",getRootElement(),markCursor)
				destroyElement(marker)
			end
		else
			removeEventHandler("onClientRender",getRootElement(),markCursor)
			destroyElement(marker)
			if nearestPoint(x,y,z) ~= false then
				if firstPoint ~= nearestPoint(x,y,z) then
					if isAttached(firstPoint,nearestPoint(x,y,z)) == false then
						outputChatBox("Points attached!",0,255,0)
						showCursor(false)
						removeEventHandler("onClientClick",getRootElement(),attachWut)
						local fD = getElementData(firstPoint,"attaches")
						local nD = getElementData(nearestPoint(x,y,z),"attaches")
						table.insert(fD,nearestPoint(x,y,z))
						table.insert(nD,firstPoint)
						setElementData(firstPoint,"attaches",fD)
						setElementData(nearestPoint(x,y,z),"attaches",nD)
					else
						outputChatBox("Points already attached!",255,0,0)
						showCursor(false)
						removeEventHandler("onClientClick",getRootElement(),attachWut)
					end
				else
					outputChatBox("Point cannot be the same!",255,0,0)
					showCursor(false)
					removeEventHandler("onClientClick",getRootElement(),attachWut)
				end
			else
				outputChatBox("Point not found!",255,0,0)
				showCursor(false)
				removeEventHandler("onClientClick",getRootElement(),attachWut)
			end
		end
	end
end

function deleteWut(_,state,_,_,x,y,z)
	if state == "down" then
		if nearestPoint(x,y,z) ~= false then
			local data = getElementData(nearestPoint(x,y,z),"attaches")
			for i,v in ipairs(data) do
				local data2 = getElementData(v,"attaches")
				for i2,v2 in ipairs(data2) do
					if nearestPoint(x,y,z) == v2 then
						table.remove(data2,i2)
					end
				end
				setElementData(v,"attaches",data2)
			end
			destroyElement(getElementData(nearestPoint(x,y,z),"obj"))
			destroyElement(nearestPoint(x,y,z))
			outputChatBox("Point deleted!",0,255,0)
		else
			outputChatBox("Point not found!",255,0,0)
		end
		showCursor(false)
		destroyElement(marker)
		removeEventHandler("onClientClick",getRootElement(),deleteWut)
		removeEventHandler("onClientRender",getRootElement(),markCursor)
	end
end

bindKey("h","down",
function ()
	showCursor(true,true)
	firstPoint = nil
	outputChatBox("Click on the point, you wan't to delete",255,255,0)
	addEventHandler("onClientClick",getRootElement(),deleteWut)
	marker = createMarker(0,0,3,"corona",.5,255,0,0,0)
	function markCursor()
		local _,_,x,y,z = getCursorPosition()
		local pX,pY,pZ = getCameraMatrix()
		local collided,x,y,z = processLineOfSight(pX,pY,pZ,x,y,z)
		setElementAlpha(marker,0)
		if collided then
			if nearestPoint(x,y,z) ~= false then
				local x,y,z = getElementPosition(nearestPoint(x,y,z))
				setElementAlpha(marker,255)
				setElementPosition(marker,x,y,z)
			end
		end
	end
	addEventHandler("onClientRender",getRootElement(),markCursor)
end)

bindKey("g","down",
function ()
	showCursor(true,true)
	firstPoint = nil
	outputChatBox("Click on the point, you wan't to attach",255,255,0)
	addEventHandler("onClientClick",getRootElement(),attachWut)
	marker = createMarker(0,0,3,"corona",.5,255,0,0,0)
	function markCursor()
		local _,_,x,y,z = getCursorPosition()
		local pX,pY,pZ = getCameraMatrix()
		local collided,x,y,z = processLineOfSight(pX,pY,pZ,x,y,z)
		setElementAlpha(marker,0)
		if collided then
			if nearestPoint(x,y,z) ~= false then
				local x,y,z = getElementPosition(nearestPoint(x,y,z))
				setElementAlpha(marker,255)
				setElementPosition(marker,x,y,z)
			end
		end
	end
	addEventHandler("onClientRender",getRootElement(),markCursor)
end)

function moveWut(_,state,_,_,x,y,z)
	if state == "down" then
		if selectedPoint == nil then
			if nearestPoint(x,y,z) ~= false then
				outputChatBox("Point selected, now you can move it",255,255,0)
				selectedPoint = nearestPoint(x,y,z)
				function moveIt()
					local _,_,x,y,z = getCursorPosition()
					local pX,pY,pZ = getCameraMatrix()
					local collided,x,y,z = processLineOfSight(pX,pY,pZ,x,y,z)
					if collided then
						setElementPosition(selectedPoint,x,y,z)
						setElementPosition(getElementData(selectedPoint,"obj"),x,y,z)
					end
				end
				addEventHandler("onClientRender",getRootElement(),moveIt)
			else
				outputChatBox("Point not found!",255,0,0)
				showCursor(false)
				removeEventHandler("onClientClick",getRootElement(),moveWut)
			end
			removeEventHandler("onClientRender",getRootElement(),markCursor)
			destroyElement(marker)
		else
			removeEventHandler("onClientClick",getRootElement(),moveWut)
			removeEventHandler("onClientRender",getRootElement(),moveIt)
			showCursor(false)
			outputChatBox("Point moved!",0,255,0)
		end
	end
end

bindKey("m","down",
function ()
	showCursor(true,true)
	selectedPoint = nil
	outputChatBox("Click on the point, you wan't to move",255,255,0)
	addEventHandler("onClientClick",getRootElement(),moveWut)
	marker = createMarker(0,0,3,"corona",.5,255,0,0,0)
	function markCursor()
		local _,_,x,y,z = getCursorPosition()
		local pX,pY,pZ = getCameraMatrix()
		local collided,x,y,z = processLineOfSight(pX,pY,pZ,x,y,z)
		setElementAlpha(marker,0)
		if collided then
			if nearestPoint(x,y,z) ~= false then
				local x,y,z = getElementPosition(nearestPoint(x,y,z))
				setElementAlpha(marker,255)
				setElementPosition(marker,x,y,z)
			end
		end
	end
	addEventHandler("onClientRender",getRootElement(),markCursor)
end)

addCommandHandler("save",function (_,theName)
	local file = xmlCreateFile(tostring(theName)..".map","path-points")
	for i,v in ipairs(getElementsByType("path-point")) do
		local node = xmlCreateChild(file,"path-point")
		local x,y,z = getElementPosition(v)
		xmlNodeSetAttribute(node,"id",getElementID(v))
		xmlNodeSetAttribute(node,"posX",x)
		xmlNodeSetAttribute(node,"posY",y)
		xmlNodeSetAttribute(node,"posZ",z)
		local attaches = ""
		for i2,v2 in ipairs(getElementData(v,"attaches")) do
			attaches = attaches..getElementID(v2)
			if i2 ~= #getElementData(v,"attaches") then
				attaches = attaches .. ","
			end
		end
		xmlNodeSetAttribute(node,"attaches",attaches)
	end
	xmlSaveFile(file)
	xmlUnloadFile(file)
end)