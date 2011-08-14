thePlayer = getLocalPlayer()
screenX,screenY = guiGetScreenSize()
size = (screenX/1024)*64
x,y,z = 0

function getPositionInFrontOfElement(element,x,y,z)
	local matrix = getElementMatrix ( element )
	local offX = x * matrix[1][1] + y * matrix[2][1] + z * matrix[3][1] + matrix[4][1]
	local offY = x * matrix[1][2] + y * matrix[2][2] + z * matrix[3][2] + matrix[4][2]
	local offZ = x * matrix[1][3] + y * matrix[2][3] + z * matrix[3][3] + matrix[4][3]
	return offX, offY, offZ
end

function getCoords( cursorX, cursorY, absoluteX, absoluteY, worldX, worldY, worldZ)
	x = worldX
	y = worldY
	z = worldZ
end

function setCoords()
	pX,pY,pZ = getPositionInFrontOfElement(thePlayer,1,0,.5)
	setElementPosition(object,pX,pY,pZ)
	setCameraMatrix(pX,pY,pZ,x,y,z)
end

function drawCur()
    dxDrawLine((screenX/2),(screenY/2)-size/2,(screenX/2),(screenY/2)+size/2,tocolor(255,0,0,200),3)
	dxDrawLine((screenX/2)-size/2,(screenY/2),(screenX/2)+size/2,(screenY/2),tocolor(255,0,0,200),3)
end

function activate(theCar,seat)
if getElementModel(theCar) == 469 and seat > 0 then
	addEventHandler("onClientCursorMove",getRootElement(),getCoords)
	addEventHandler("onClientPreRender",getRootElement(),setCoords)
	addEventHandler("onClientRender",getRootElement(),drawCur)
	object = createObject(362,0,0,0)
	timer = setTimer(shoot,100,0)
end
end

function deActivate(theCar,seat)
if getElementModel(theCar) == 469 and seat > 0 then
	removeEventHandler("onClientCursorMove",getRootElement(),getCoords)
	removeEventHandler("onClientPreRender",getRootElement(),setCoords)
	removeEventHandler("onClientRender",getRootElement(),drawCur)
	destroyElement(object)
	setCameraTarget(thePlayer)
	killTimer(timer)
end
end

function shoot()
if getControlState("fire") then
	hit,hitX,hitY,hitZ,hitElement = processLineOfSight(pX,pY,pZ,x,y,z)
	fxAddBulletImpact(hitX,hitY,hitZ,0,0,1,3,5)
	if hitElement then
		triggerServerEvent("setHp",hitElement,hitElement)
	end
end
end

addEventHandler("onClientPlayerVehicleEnter",getRootElement(),activate)
addEventHandler("onClientPlayerVehicleExit",getRootElement(),deActivate)