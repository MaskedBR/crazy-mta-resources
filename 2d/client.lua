rot = 0

function setCamera()
	if getPedOccupiedVehicle(getLocalPlayer()) == false then
		local x,y,z = getElementPosition(getLocalPlayer())
		if getKeyState("a") then
			rot = rot + 3
		elseif getKeyState("d") then
			rot = rot - 3
		end
		setPedRotation(getLocalPlayer(),rot)
		setCameraTarget(getLocalPlayer())
		if isLineOfSightClear(x,y,z,x,y,z+20,true,false,false,true,false) then
			setCameraMatrix(x,y,z+20,x,y,z,rot-1)
		else
			local _,cx,cy,cz = processLineOfSight(x,y,z,x,y,z+20,true,false,false,true,false)
			if getDistanceBetweenPoints3D(cx,cy,cz,x,y,z) < 8 then
				setCameraMatrix(x,y,z+50,x,y,z,rot-1)
				local dx,dy = getScreenFromWorldPosition(x,y,z)
				dxDrawRectangle(dx-25,dy-25,50,50,tocolor(0,255,0,255))
				dxDrawRectangle(dx-25,dy-25,50,20,tocolor(255,0,0,255))
			else
				setCameraMatrix(cx,cy,cz-3,x,y,z,rot-1)
			end
		end
	else
		
	end
end

addEventHandler("onClientPreRender",getRootElement(),setCamera)

toggleControl("left",false)
toggleControl("right",false)