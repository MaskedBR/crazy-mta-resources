addEvent("setHp",true)
addEventHandler("setHp",getRootElement(),function (theElement)
	local hp = getElementHealth(theElement)
	hp = hp - 40
	if getElementType(theElement) == "ped" or "player" then
		if hp < 1 then
			killPed(theElement)
		else
			setElementHealth(theElement,hp)
		end
	else
		setElementHealth(theElement,hp)
	end
end)