function createGUI()
	streams = xmlLoadFile("streams.xml")
	if not streams then
		streams = xmlCreateFile("streams.xml","streams")
	end
	sounds = xmlLoadFile("sounds.xml")
	if not sounds then
		sounds = xmlCreateFile("sounds.xml","sounds")
	end
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

	guiGridListAddColumn(GUIEditor_Grid[1],"URL",0.9)
	GUIEditor_Label[1] = guiCreateLabel(0.4806,0.0572,0.2799,0.0693,"Add stream",true,GUIEditor_Tab[1])
	GUIEditor_Label[2] = guiCreateLabel(0.4774,0.1386,0.1711,0.0542,"Stream URL:",true,GUIEditor_Tab[1])
	GUIEditor_Edit[1] = guiCreateEdit(0.5879,0.1295,0.3919,0.0693,"",true,GUIEditor_Tab[1])
	GUIEditor_Button[1] = guiCreateButton(0.591,0.2319,0.3872,0.0753,"Add stream",true,GUIEditor_Tab[1])
	GUIEditor_Label[3] = guiCreateLabel(0.4759,0.3584,0.1322,0.0542,"Remove stream",true,GUIEditor_Tab[1])
	GUIEditor_Button[2] = guiCreateButton(0.591,0.4277,0.3872,0.0753,"Remove stream",true,GUIEditor_Tab[1])
	GUIEditor_Tab[2] = guiCreateTab("Sounds",GUIEditor_TabPanel[1])
	GUIEditor_Grid[2] = guiCreateGridList(0.0078,0.0241,0.4619,0.9578,true,GUIEditor_Tab[2])
	guiGridListSetSelectionMode(GUIEditor_Grid[2],2)

	guiGridListAddColumn(GUIEditor_Grid[2],"URL",0.9)
	GUIEditor_Checkbox[1] = guiCreateCheckBox(0.4821,0.1386,0.3157,0.0633,"Radio mode",false,true,GUIEditor_Tab[2])
	GUIEditor_Label[4] = guiCreateLabel(0.4821,0.0693,0.1851,0.0542,"Settings",true,GUIEditor_Tab[2])
	GUIEditor_Checkbox[2] = guiCreateCheckBox(0.4821,0.2139,0.1882,0.0602,"Repeat sound",false,true,GUIEditor_Tab[2])
	GUIEditor_Label[5] = guiCreateLabel(0.4883,0.3072,0.1649,0.0512,"Add sound",true,GUIEditor_Tab[2])
	GUIEditor_Label[6] = guiCreateLabel(0.4883,0.3976,0.1477,0.0753,"Sound URL:",true,GUIEditor_Tab[2])
	GUIEditor_Edit[2] = guiCreateEdit(0.591,0.3916,0.3919,0.0753,"",true,GUIEditor_Tab[2])
	GUIEditor_Button[3] = guiCreateButton(0.591,0.488,0.395,0.0723,"Add sound",true,GUIEditor_Tab[2])
	GUIEditor_Label[7] = guiCreateLabel(0.4899,0.6024,0.1337,0.0602,"Remove sound",true,GUIEditor_Tab[2])
	GUIEditor_Button[4] = guiCreateButton(0.591,0.6657,0.395,0.0723,"Remove sound",true,GUIEditor_Tab[2])
	addEventHandler("onClientGUIClick",GUIEditor_Button[1],
	function ()
		
	end)
end

createGUI()
screenX,screenY=guiGetScreenSize()

currentSound = {
	["meta"] = {},
	["length"] = 0,
	["pointer"] = nil,
	["stream_title"] = nil
}

function soundStarted(success,length,streamName)
	if success then
		currentSound.pointer = source
		currentSound.meta = getSoundMetaTags(source)
		currentSound.length = length
		if length == 0 then
			outputChatBox('#FFFF00RADIO: #FFFFFF"'..streamName..'" stream started.',255,0,0,true)
			if currentSound.meta.title then
				outputChatBox('#FFFF00*Title: #FFFFFF"'..currentSound.meta.title,255,0,0,true)
			end
			if currentSound.meta.artist then
				outputChatBox('#FFFF00*Artist: #FFFFFF"'..currentSound.meta.artist,255,0,0,true)
			end
			if currentSound.meta.stream_name then
				outputChatBox('#FFFF00*Stream name: #FFFFFF"'..currentSound.meta.stream_name,255,0,0,true)
			end
			if currentSound.meta.stream_title then
				outputChatBox('#FFFF00*Stream title: #FFFFFF"'..currentSound.meta.stream_title,255,0,0,true)
			elseif currentSound.stream_title then
				outputChatBox('#FFFF00*Stream title: #FFFFFF"'..currentSound.stream_title,255,0,0,true)
			end
		else
			if currentSound.meta.title then
				outputChatBox('#FFFF00RADIO: #FFFFFF"'..currentSound.meta.title..'" sound started.',255,0,0,true)
			else
				outputChatBox('#FFFF00RADIO: #FFFFFFSound started.',255,0,0,true)
			end
			if currentSound.meta.title then
				outputChatBox('#000000*#FFFF00Title: #FFFFFF'..currentSound.meta.title,255,0,0,true)
			end
			if currentSound.meta.artist then
				outputChatBox('#000000*#FFFF00Artist: #FFFFFF'..currentSound.meta.artist,255,0,0,true)
			end
			outputChatBox('#000000*#FFFF00Length: #FFFFFF'..tostring(getRealTime(length/1000).minute)..":"..tostring(getRealTime(length/1000).second),255,0,0,true)
		end
	else
		outputChatBox("#FFFF00RADIO: #FFFFFFFailed to play sound/stream.",255,0,0,true)
	end
end

addEventHandler("onClientSoundStream",getRootElement(),soundStarted)

function startSound(_,url)
	if currentSound.pointer then
		stopSound(currentSound.pointer)
	end
	currentSound = {
		["meta"] = {},
		["length"] = 0,
		["pointer"] = nil,
	}
	local tempSound = playSound(url)
end

addCommandHandler("play",startSound)

addEvent("onClientSoundStop",false)
setTimer(
function ()
	if currentSound.pointer then
		if currentSound.length ~= 0 then
			if getSoundPosition(currentSound.pointer) == 0 then
				triggerEvent("onClientSoundStop",currentSound.pointer)
			end
		else
			if not getSoundPosition(currentSound.pointer) then
				triggerEvent("onClientSoundStop",currentSound.pointer)
			end
		end
	end
end,1000,0)

function onSoundStop()
	if currentSound.length ~= 0 then
		
	end
end