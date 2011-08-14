showed = true

function hideAll()
	showChat(false)
	showPlayerHudComponent("ammo",false)
	showPlayerHudComponent("armour",false)
	showPlayerHudComponent("clock",false)
	showPlayerHudComponent("health",false)
	showPlayerHudComponent("money",false)
	showPlayerHudComponent("radar",false)
	showPlayerHudComponent("weapon",false)
end

function showAll()
	showChat(true)
	showPlayerHudComponent("ammo",true)
	showPlayerHudComponent("armour",true)
	showPlayerHudComponent("clock",true)
	showPlayerHudComponent("health",true)
	showPlayerHudComponent("money",true)
	showPlayerHudComponent("radar",true)
	showPlayerHudComponent("weapon",true)
end

bindKey("F2","down",
function()
	if showed == true then
		showed = false
		hideAll()
	else
		showed = true
		showAll()
	end
end)