thePlayer = getLocalPlayer()
screenX,screenY = guiGetScreenSize()

function drawList()
	local list = getElementData(thePlayer,"spec-list")
	if list ~= false then
		if #list ~= 0 then
			dxDrawText("Spectators:",screenX*.85,screenY*.3,0,0,tocolor(255,0,0,255))
			for i,v in ipairs(list) do
				if isElement(v) then
					dxDrawText(getPlayerName(v),screenX*.85,screenY*.3+(i*(screenY*0.02)),0,0,tocolor(0,255,0,255))
				end
			end
		end
	end
end

addEventHandler("onClientRender",getRootElement(),drawList)