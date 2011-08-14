function loadTxd()
xml = xmlLoadFile("skins.xml")
nodes = xmlNodeGetChildren(xml)
for i,v in ipairs(nodes) do
	local id = xmlNodeGetAttribute(v,"id")
	local name = xmlNodeGetAttribute(v,"name")
	local txd = engineLoadTXD(name)
	if txd then
		local load = engineImportTXD(txd,tonumber(id))
		if load == false then
			outputChatBox(txd.." import failed to "..id)
		end
	else
		outputChatBox("Failed to load "..txd)
	end
end
xmlUnloadFile(xml)
end


addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),loadTxd)