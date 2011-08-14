outputChatBox("#00FF00>>#FFFF00This server using#FF0000 Gore Mod#FFFF00 made by #00FF00Crazy",255,0,0,true)
--[[
for i,v in ipairs(getElementsByType("player")) do
	setElementData(source,"last_damage",0,false)
end
for i,v in ipairs(getElementsByType("ped")) do
	setElementData(source,"last_damage",0,false)
end]]

--Structure=ID,X rotation,Z rotation,boneID

parts = {
	{2908,-90,-90,6}, --head
	{2907,-90,0,3}, --torso
	{2906,-90,-180,33}, --lA
	{2906,-90,0,23}, --rA
	{2905,-90,-90,42}, --lL
	{2905,-90,-90,52} --rL
}

koef = {[0]=1,
		[1]=1,
		[2]=2,
		[3]=2,
		[4]=2,
		[5]=2,
		[6]=2,
		[7]=2,
		[8]=2,
		[9]=2,
		[22]=3,
		[23]=3,
		[24]=3,
		[25]=5,
		[26]=5,
		[27]=5,
		[28]=4,
		[29]=4,
		[32]=4,
		[30]=4,
		[31]=4,
		[33]=5,
		[34]=5,
		[35]=7,
		[36]=7,
		[37]=0,
		[38]=7,
		[16]=7,
		[17]=0,
		[18]=0,
		[39]=6,
		[41]=0,
		[42]=0,
		[43]=0,
		[10]=1,
		[11]=1,
		[12]=1,
		[13]=1,
		[14]=1,
		[15]=1,
		[44]=0,
		[45]=0,
		[46]=0,
		[40]=0,
		[19]=7,
		[37]=0,
		[50]=8,
		[51]=7,
		[53]=0,
		[54]=0,
		[59]=7}


function createBloodAtPos(theElement)
	local x,y,z = getElementPosition(theElement)
	fxAddBlood(x,y,z,0,0,3,100)
end
--[[
function onDamage(attacker,weapon,part,loss)
	if not loss then loss = 0 end
	setElementData(source,"last_damage",loss,false)
end]]

function onRender()
	for i,v in ipairs(getElementsByType("object",getResourceRootElement(getThisResource()))) do
		if math.random(1,5) == 1 then
			createBloodAtPos(v)
		end
	end
	for i,v in ipairs(getElementsByType("sound",getResourceRootElement(getThisResource()))) do
		setSoundSpeed(v,getGameSpeed())
	end
end


function onPlayerWasted(theKiller,theReason)
		setElementAlpha(source,0)
		math.randomseed(getTickCount())
		local x,y,z = getElementPosition(source)
		local theBlood = createObject(2000,x,y,z)
		setElementCollisionsEnabled(theBlood,false)
		setTimer(destroyElement,100,1,theBlood)
		local x2,y2,z2
		if theKiller then
			x2,y2,z2 = getElementPosition(theKiller)
		else
			x2,y2,z2 = getElementPosition(source)
			x2 = x2 + math.random(-1,1)
			y2 = y2 + math.random(-1,1)
			z2 = z2 + math.random(-1,1)
		end
		local x1,y1,z1 = getElementPosition(getLocalPlayer())
	--Sound play
		local theSound = playSound("sounds/hit"..tostring(math.random(1,6))..".wav")
		local dis = getDistanceBetweenPoints3D(x1,y1,z1,x,y,z)
		setSoundVolume(theSound,1/(dis/10))
		setSoundSpeed(theSound,getGameSpeed())
	--Meat creating
		for i,v in ipairs(parts) do
			local bX,bY,bZ = getPedBonePosition(source,v[4])
			local thePart = createObject(v[1],x,y,z,v[2],0,getPedRotation(source)-v[3])
			setElementCollisionsEnabled(thePart,false)
			setElementInterior(thePart,getElementInterior(source))
			local oX = x-x2
			local oY = y-y2
			local vecLength = math.sqrt((oX * oX) + (oY * oY))
			oX = oX/vecLength
			oY = oY/vecLength
			local k = 1
			if theReason ~= 49 then
				if theReason then
					k = koef[theReason]
				end
			else
				local vX,vY,vZ = getElementVelocity(theKiller)
				local actualspeed = (vX^2 + vY^2 + vZ^2)^(0.5)
				k = actualspeed*20
			end
			oX = x+(oX*k)
			oY = y+(oY*k)
			oX = oX + math.random(-1,1)
			oY = oY + math.random(-1,1)
			local oZ = getGroundPosition(oX,oY,z)
			local is,x3,y3,z3 = processLineOfSight(x,y,z,oX,oY,oZ,true,false,false,true,false)
			if is == true then
				oX = x3
				oY = y3
				oZ = z3
			end
			moveObject(thePart,400/getGameSpeed(),oX,oY,oZ,math.random(360),math.random(360),math.random(360))
			setTimer(destroyElement,20000,1,thePart)
		end
end

function onSpawn()
	setElementAlpha(source,255)
end

addEventHandler("onClientPedWasted",getRootElement(),onPlayerWasted)
addEventHandler("onClientPlayerWasted",getRootElement(),onPlayerWasted)
addEventHandler("onClientPlayerSpawn",getRootElement(),onSpawn)
addEventHandler("onClientRender",getRootElement(),onRender)
--[[
addEventHandler("onClientPedDamage",getRootElement(),onDamage)
addEventHandler("onClientPlayerDamage",getRootElement(),onDamage)]]