---------------------------------------------
--MTA:SA Radio Player mady by Crazy (community - crazyserega1994, forum CrazyDude, irc CrazyDude)
--Commands:
--/radio - shows/hides radio controls
--/vol_up,/vol_down - volume control
--/stopsound - stops the sound
----------------------------------------------

nilSound = {
	["meta"] = {},
	["length"] = 0,
	["pointer"] = nil,
	["stream_title"] = nil,
	["url"] = nil,
	["row"] = nil
}

currentSound = nilSound

function soundStarted(success,length,streamName)
	if success then
		currentSound.pointer = source
		currentSound.meta = getSoundMetaTags(source)
		currentSound.length = length
		if length == 0 then
			outputChatBox('#FFFF00RADIO: #FFFFFF"'..streamName..'" stream started.',255,0,0,true)
			if currentSound.meta.title then
				outputChatBox('#000000*#FFFF00Title: #FFFFFF"'..currentSound.meta.title,255,0,0,true)
			end
			if currentSound.meta.artist then
				outputChatBox('#000000*#FFFF00Artist: #FFFFFF"'..currentSound.meta.artist,255,0,0,true)
			end
			if currentSound.meta.stream_name then
				outputChatBox('#000000*#FFFF00Stream name: #FFFFFF"'..currentSound.meta.stream_name,255,0,0,true)
			end
			if currentSound.meta.stream_title then
				outputChatBox('#000000*#FFFF00Stream title: #FFFFFF"'..currentSound.meta.stream_title,255,0,0,true)
			elseif currentSound.stream_title then
				outputChatBox('#000000*#FFFF00Stream title: #FFFFFF"'..currentSound.stream_title,255,0,0,true)
			end
		else
			outputChatBox("*********************************",0,0,0)
			--[[if currentSound.meta.title then
				outputChatBox('#FFFF00RADIO: #FFFFFF"'..currentSound.meta.title..'" sound started.',255,0,0,true)
			else
				outputChatBox('#FFFF00RADIO: #FFFFFFSound started.',255,0,0,true)
			end]]--
			if currentSound.meta.title then
				outputChatBox('#000000*#FFFF00Title: #FFFFFF'..currentSound.meta.title,255,0,0,true)
			end
			if currentSound.meta.artist then
				outputChatBox('#000000*#FFFF00Artist: #FFFFFF'..currentSound.meta.artist,255,0,0,true)
			end
			outputChatBox('#000000*#FFFF00Length: #FFFFFF'..tostring(getRealTime(length/1000).minute)..":"..tostring(getRealTime(length/1000).second),255,0,0,true)
			outputChatBox("*********************************",0,0,0)
		end
	else
		outputChatBox("#FFFF00RADIO: #FFFFFFFailed to play sound/stream.",255,0,0,true)
	end
end


function startSound(url,row)
	outputChatBox("#FFFF00RADIO: #FFFFFFTrying to play "..url,255,0,0,true)
	if currentSound.pointer then
		stopSound(currentSound.pointer)
	end
	currentSound = nilSound
	currentSound.url = url
	if row then
		currentSound.row = row
	end
	playSound(url)
end

function onSoundStop()
	if currentSound.length ~= 0 then
		if guiCheckBoxGetSelected(GUIEditor_Checkbox[2]) == true then
			startSound(currentSound.url)
		else
			if guiCheckBoxGetSelected(GUIEditor_Checkbox[1]) == true then
				local totalSounds = guiGridListGetRowCount(GUIEditor_Grid[2]) - 1
				if currentSound.row + 1 > totalSounds then
					startSound(guiGridListGetItemText(GUIEditor_Grid[2],0,soundColumn),0)
				else
					startSound(guiGridListGetItemText(GUIEditor_Grid[2],totalSounds,soundColumn),currentSound.row + 1)
				end
			else
				currentSound = nilSound
			end
		end
	else
		currentSound = nilSound
		outputChatBox("#FFFF00RADIO: #FFFFFFStream stopped.",255,0,0,true)
	end
end

function onSoundChange(title)
	currentSound.meta = getSoundMetaTags(source)
	currentSound.stream_title = title
	if currentSound.stream_title then
		outputChatBox("#FFFF00RADIO: #FFFFFFNow playing "..currentSound.stream_title,255,0,0,true)
	else
		outputChatBox("#FFFF00RADIO: #FFFFFFNow playing "..currentSound.url,255,0,0,true)
	end
	outputChatBox("*********************************",0,0,0)
	if currentSound.meta.title then
		outputChatBox('#000000*#FFFF00Title: #FFFFFF"'..currentSound.meta.title,255,0,0,true)
	end
	if currentSound.meta.artist then
		outputChatBox('#000000*#FFFF00Artist: #FFFFFF"'..currentSound.meta.artist,255,0,0,true)
	end
	if currentSound.meta.stream_name then
		outputChatBox('#000000*#FFFF00Stream name: #FFFFFF"'..currentSound.meta.stream_name,255,0,0,true)
	end
	if currentSound.meta.stream_title then
		outputChatBox('#000000*#FFFF00Stream title: #FFFFFF"'..currentSound.meta.stream_title,255,0,0,true)
	elseif currentSound.stream_title then
		outputChatBox('#000000*#FFFF00Stream title: #FFFFFF"'..currentSound.stream_title,255,0,0,true)
	end
	outputChatBox("*********************************",0,0,0)
end

--Controls start
addCommandHandler("vol_up",
function ()
	if currentSound.pointer then
		local curVolume = getSoundVolume(currentSound.pointer)
		if curVolume < 1 then
			setSoundVolume(currentSound.pointer,curVolume+0.1)
		else
			setSoundVolume(currentSound.pointer,1)
		end
	end
end)

addCommandHandler("vol_down",
function ()
	if currentSound.pointer then
		local curVolume = getSoundVolume(currentSound.pointer)
		if curVolume > 0 then
			setSoundVolume(currentSound.pointer,curVolume-0.1)
		else
			setSoundVolume(currentSound.pointer,0)
		end
	end
end)

addCommandHandler("stopsound",
function ()
	if currentSound.pointer then
		stopSound(currentSound.pointer)
		currentSound = nilSound
		outputChatBox("#FFFF00RADIO: #FFFFFFSound stopped ",255,0,0,true)
	end
end)
--Controls end

--Events start
addEventHandler("onClientSoundStream",getResourceRootElement(getThisResource()),soundStarted)
addEvent("onClientSoundStop",false)
setTimer(
function ()
	if currentSound.pointer then
		if currentSound.length ~= 0 then
			if getSoundPosition(currentSound.pointer) == 0 then
				triggerEvent("onClientSoundStop",currentSound.pointer)
			end
		else
			if getSoundPosition(currentSound.pointer) == 0 then
				triggerEvent("onClientSoundStop",currentSound.pointer)
			end
		end
	end
end,1000,0)
addEventHandler("onClientSoundStop",getResourceRootElement(getThisResource()),onSoundStop)
addEventHandler("onClientSoundChangedMeta",getResourceRootElement(getThisResource()),onSoundChange)
--Events end