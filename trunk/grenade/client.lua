thePlayer = getLocalPlayer()
handling = false
dist = 0

function getPositionInFrontOfElement(element,x,y,z)
	-- Get the matrix
	local matrix = getElementMatrix ( element )
	-- Get the transformation of a point 5 units in front of the element
	local offX = x * matrix[1][1] + y * matrix[2][1] + z * matrix[3][1] + matrix[4][1]
	local offY = x * matrix[1][2] + y * matrix[2][2] + z * matrix[3][2] + matrix[4][2]
	local offZ = x * matrix[1][3] + y * matrix[2][3] + z * matrix[3][3] + matrix[4][3]
	--Return the transformed point
	return offX, offY, offZ
end

function drawGrenadePlace()
	local x1,y1,z1 = getPositionInFrontOfElement(thePlayer,2,dist,0)
	local x2,y2,z2 = getPositionInFrontOfElement(thePlayer,2,dist+3,0)
	local x3,y3,z3 = getPositionInFrontOfElement(thePlayer,-2,dist,0)
	local x4,y4,z4 = getPositionInFrontOfElement(thePlayer,-2,dist+3,0)
	local xx,yy,zz = getElementPosition(thePlayer)
	z1 = getGroundPosition(x1,y1,z1)+0.2
	z2 = getGroundPosition(x2,y2,z2)+0.2
	z3 = getGroundPosition(x3,y3,z3)+0.2
	z4 = getGroundPosition(x4,y4,z4)+0.2
	dxDrawLine3D(x1,y1,z1,x2,y2,z2,tocolor(255,0,0,255),10)
	dxDrawLine3D(x2,y2,z2,x4,y4,z4,tocolor(255,0,0,255),10)
	dxDrawLine3D(x3,y3,z3,x1,y1,z1,tocolor(255,0,0,255),10)
	dxDrawLine3D(x4,y4,z4,x3,y3,z3,tocolor(255,0,0,255),10)
end


function checkPressedFire()
	if getControlState("fire") then
	if handling == false then
		addEventHandler("onClientPreRender",getRootElement(),drawGrenadePlace)
		handling = true
	else
		dist = dist + 2
	end
	else
		if handling then
			dist = dist + 2
			timer = setTimer(function () removeEventHandler("onClientPreRender",getRootElement(),drawGrenadePlace) dist = 5 end,2000,1)
			handling = false
		end
	end
end
setTimer(checkPressedFire,50,0)
