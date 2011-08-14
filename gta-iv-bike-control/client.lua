inertiaX = 0
--inertiaY = 0
inertiaZ = 0

setPedCanBeKnockedOffBike(getLocalPlayer(),false)

setTimer(
function ()
	if isPedInVehicle(getLocalPlayer()) then
		if getVehicleType(getPedOccupiedVehicle(getLocalPlayer())) == "Bike" then
			if not isVehicleOnGround(getPedOccupiedVehicle(getLocalPlayer())) then
				if getControlState("vehicle_left") == true then
					inertiaZ = inertiaZ + 0.25
				elseif getControlState("vehicle_right") == true then
					inertiaZ = inertiaZ - 0.25
				else
					inertiaZ = inertiaZ / 2
				end
				if getControlState("steer_back") == true then
					inertiaX = inertiaX + 0.25
				elseif getControlState("steer_forward") == true then
					inertiaX = inertiaX - 0.25
				else
					inertiaX = inertiaX / 2
				end
			else
				if getControlState("vehicle_left") == true then
					inertiaZ = 3
				elseif getControlState("vehicle_right") == true then
					inertiaZ = -3
				else
					inertiaZ = 0
				end
				if getControlState("steer_back") == true then
					inertiaX = 3
				elseif getControlState("steer_forward") == true then
					inertiaX = -3
				else
					inertiaX = 0
				end
			end
		end
	end
end,50,0)

addEventHandler("onClientPreRender",getRootElement(),
function ()
	if isPedInVehicle(getLocalPlayer()) then
		if getVehicleType(getPedOccupiedVehicle(getLocalPlayer())) == "Bike" then
			dxDrawText("inertiaZ="..inertiaZ,1920/4,1080/4)
			dxDrawText("inertiaX="..inertiaX,1920/4,1080/4+12)
			if not isVehicleOnGround(getPedOccupiedVehicle(getLocalPlayer())) then
				local x,y,z = getVehicleRotation(getPedOccupiedVehicle(getLocalPlayer()))
				setVehicleRotation(getPedOccupiedVehicle(getLocalPlayer()),x+inertiaX,y,z+inertiaZ)
			end
		end
	end
end)