local showed = true -- LOCALS are faster, according to PIL
local criticalHudComponents = {
  ammo = true,
  armour = true,
  clock = true,
  health = true,
  money = true,
  radar = true,
  weapon = true
}

function toggleAll(toggle)
  showChat(toggle)
  for i,v in pairs(criticalHudComponents) do
    showPlayerHudComponent(i,toggle)
  end
end

bindKey("F2","down",
function()
    showed = not showed 
    toggleAll(showed)
end)