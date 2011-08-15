screenX,screenY=guiGetScreenSize()

function loadStreamAndSoundList()
	local streams = xmlLoadFile("streams.xml")
	if not streams then
		streams = xmlCreateFile("streams.xml","streams")
		xmlSaveFile(streams)
	end
	local sounds = xmlLoadFile("sounds.xml")
	if not sounds then
		sounds = xmlCreateFile("sounds.xml","sounds")
		xmlSaveFile(sounds)
	end
	local streamNodes = xmlNodeGetChildren(streams)
	local soundNodes = xmlNodeGetChildren(sounds)
	for i,v in ipairs(streamNodes) do
		local row = guiGridListAddRow(GUIEditor_Grid[1])
		guiGridListSetItemText(GUIEditor_Grid[1],row,streamColumn,xmlNodeGetValue(v),false,false)
	end
	for i,v in ipairs(soundNodes) do
		local row = guiGridListAddRow(GUIEditor_Grid[2])
		guiGridListSetItemText(GUIEditor_Grid[2],row,soundColumn,xmlNodeGetValue(v),false,false)
	end
	xmlUnloadFile(streams)
	xmlUnloadFile(sounds)
end

function updateStreamAndSoundList()
	local streams = xmlCreateFile("streams.xml","streams")
	xmlSaveFile(streams)
	local sounds = xmlCreateFile("sounds.xml","sounds")
	xmlSaveFile(sounds)
	local totalStreams = guiGridListGetRowCount(GUIEditor_Grid[1])
	local totalSounds = guiGridListGetRowCount(GUIEditor_Grid[2])
	for i=0,totalStreams-1 do
		xmlNodeSetValue(xmlCreateChild(streams,"url"),guiGridListGetItemText(GUIEditor_Grid[1],i,streamColumn))
	end
	for i=0,totalSounds-1 do
		xmlNodeSetValue(xmlCreateChild(sounds,"url"),guiGridListGetItemText(GUIEditor_Grid[2],i,soundColumn))
	end
	xmlSaveFile(streams)
	xmlSaveFile(sounds)
	xmlUnloadFile(streams)
	xmlUnloadFile(sounds)
end

function loadGUI()
	GUIEditor_Window = {}
	GUIEditor_TabPanel = {}
	GUIEditor_Tab = {}
	GUIEditor_Button = {}
	GUIEditor_Checkbox = {}
	GUIEditor_Label = {}
	GUIEditor_Edit = {}
	GUIEditor_Grid = {}

	GUIEditor_Window[1] = guiCreateWindow(0.1895,0.2396,0.6455,0.5078,"MTA:SA Sound & Radio Player",true)
	guiWindowSetSizable(GUIEditor_Window[1],false)
	GUIEditor_TabPanel[1] = guiCreateTabPanel(0.0136,0.0641,0.9728,0.9128,true,GUIEditor_Window[1])
	GUIEditor_Tab[1] = guiCreateTab("Streams",GUIEditor_TabPanel[1])
	GUIEditor_Grid[1] = guiCreateGridList(0.0124,0.0361,0.4557,0.9367,true,GUIEditor_Tab[1])
	guiGridListSetSelectionMode(GUIEditor_Grid[1],2)

	streamColumn = guiGridListAddColumn(GUIEditor_Grid[1],"URL",0.9)
	GUIEditor_Label[1] = guiCreateLabel(0.4806,0.0572,0.2799,0.0693,"Add stream",true,GUIEditor_Tab[1])
	GUIEditor_Label[2] = guiCreateLabel(0.4774,0.1386,0.1711,0.0542,"Stream URL:",true,GUIEditor_Tab[1])
	GUIEditor_Edit[1] = guiCreateEdit(0.5879,0.1295,0.3919,0.0693,"",true,GUIEditor_Tab[1])
	GUIEditor_Button[1] = guiCreateButton(0.591,0.2319,0.3872,0.0753,"Add stream",true,GUIEditor_Tab[1])
	GUIEditor_Label[3] = guiCreateLabel(0.4759,0.3584,0.1322,0.0542,"Remove stream",true,GUIEditor_Tab[1])
	GUIEditor_Button[2] = guiCreateButton(0.591,0.4277,0.3872,0.0753,"Remove stream",true,GUIEditor_Tab[1])
	GUIEditor_Tab[2] = guiCreateTab("Sounds",GUIEditor_TabPanel[1])
	GUIEditor_Grid[2] = guiCreateGridList(0.0124,0.0361,0.4557,0.9367,true,GUIEditor_Tab[2])
	guiGridListSetSelectionMode(GUIEditor_Grid[2],2)

	soundColumn = guiGridListAddColumn(GUIEditor_Grid[2],"URL",0.9)
	GUIEditor_Checkbox[1] = guiCreateCheckBox(0.4821,0.1386,0.3157,0.0633,"Radio mode",false,true,GUIEditor_Tab[2])
	GUIEditor_Label[4] = guiCreateLabel(0.4821,0.0693,0.1851,0.0542,"Settings",true,GUIEditor_Tab[2])
	GUIEditor_Checkbox[2] = guiCreateCheckBox(0.4821,0.2139,0.1882,0.0602,"Repeat sound",false,true,GUIEditor_Tab[2])
	GUIEditor_Label[5] = guiCreateLabel(0.4883,0.3072,0.1649,0.0512,"Add sound",true,GUIEditor_Tab[2])
	GUIEditor_Label[6] = guiCreateLabel(0.4883,0.3976,0.1477,0.0753,"Sound URL:",true,GUIEditor_Tab[2])
	GUIEditor_Edit[2] = guiCreateEdit(0.591,0.3916,0.3919,0.0753,"",true,GUIEditor_Tab[2])
	GUIEditor_Button[3] = guiCreateButton(0.591,0.488,0.395,0.0723,"Add sound",true,GUIEditor_Tab[2])
	GUIEditor_Label[7] = guiCreateLabel(0.4899,0.6024,0.1337,0.0602,"Remove sound",true,GUIEditor_Tab[2])
	GUIEditor_Button[4] = guiCreateButton(0.591,0.6657,0.395,0.0723,"Remove sound",true,GUIEditor_Tab[2])
	guiSetVisible(GUIEditor_Window[1],false)
	loadStreamAndSoundList()
	--Add Stream
	addEventHandler("onClientGUIClick",GUIEditor_Button[1],
	function ()
		if guiGetText(GUIEditor_Edit[1]) ~= "" then
			local row = guiGridListAddRow(GUIEditor_Grid[1])
			guiGridListSetItemText(GUIEditor_Grid[1],row,streamColumn,guiGetText(GUIEditor_Edit[1]),false,false)
			guiSetText(GUIEditor_Edit[1],"")
			updateStreamAndSoundList()
		end
	end)
	--Add Sound
	addEventHandler("onClientGUIClick",GUIEditor_Button[3],
	function ()
		if guiGetText(GUIEditor_Edit[2]) ~= "" then
			local row = guiGridListAddRow(GUIEditor_Grid[2])
			guiGridListSetItemText(GUIEditor_Grid[2],row,streamColumn,guiGetText(GUIEditor_Edit[2]),false,false)
			guiSetText(GUIEditor_Edit[2],"")
			updateStreamAndSoundList()
		end
	end)
	--Remove stream
	addEventHandler("onClientGUIClick",GUIEditor_Button[2],
	function ()
		if guiGridListGetSelectedItem(GUIEditor_Grid[1]) ~= -1 then
			local row, column = guiGridListGetSelectedItem(GUIEditor_Grid[1])
			guiGridListRemoveRow(GUIEditor_Grid[1],row)
			updateStreamAndSoundList()
		end
	end)
	--Remove sound
	addEventHandler("onClientGUIClick",GUIEditor_Button[4],
	function ()
		if guiGridListGetSelectedItem(GUIEditor_Grid[2]) ~= -1 then
			local row, column = guiGridListGetSelectedItem(GUIEditor_Grid[2])
			guiGridListRemoveRow(GUIEditor_Grid[2],row)
			updateStreamAndSoundList()
		end
	end)
	addEventHandler("onClientGUIClick",getResourceRootElement(getThisResource()),
	function ()
		if getElementType(source) == "gui-edit" then
			guiSetInputEnabled(true)
		else
			guiSetInputEnabled(false)
		end
	end)
	--Play Stream
	addEventHandler("onClientGUIDoubleClick",GUIEditor_Grid[1],
	function ()
		if guiGridListGetSelectedItem(GUIEditor_Grid[1]) ~= -1 then
			local row, column = guiGridListGetSelectedItem(GUIEditor_Grid[1])
			startSound(guiGridListGetItemText(GUIEditor_Grid[1],row,column))
		end
	end)
	--Play Sound
	addEventHandler("onClientGUIDoubleClick",GUIEditor_Grid[2],
	function ()
		if guiGridListGetSelectedItem(GUIEditor_Grid[2]) ~= -1 then
			local row, column = guiGridListGetSelectedItem(GUIEditor_Grid[2])
			startSound(guiGridListGetItemText(GUIEditor_Grid[2],row,column),row)
		end
	end)
	addCommandHandler("radio",
	function ()
		showCursor(not guiGetVisible(GUIEditor_Window[1]))
		guiSetVisible(GUIEditor_Window[1],not guiGetVisible(GUIEditor_Window[1]))
	end)
end

addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),loadGUI)