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



function startSound(url)
	outputChatBox("#FFFF00RADIO: #FFFFFFTrying to play "..url,255,0,0,true)
	if currentSound.pointer then
		stopSound(currentSound.pointer)
	end
	currentSound = {
		["meta"] = {},
		["length"] = 0,
		["pointer"] = nil,
	}
	playSound(url)
end

function onSoundStop()
	outputChatBox("Stopped!")
	if currentSound.length ~= 0 then
		
	end
end

--Controls start
addCommandHandler("vol_up",
function ()
	if currentSound.pointer then
		local curVolume = getSoundVolume(currentSound.pointer)
		if curVolume < 1 then
			setSoundVolume(currentSound.pointer,curVolume+0.1)
		end
	end
end)

addCommandHandler("vol_down",
function ()
	if currentSound.pointer then
		local curVolume = getSoundVolume(currentSound.pointer)
		if curVolume > 0 then
			setSoundVolume(currentSound.pointer,curVolume-0.1)
		end
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
			if not getSoundPosition(currentSound.pointer) then
				triggerEvent("onClientSoundStop",currentSound.pointer)
			end
		end
	end
end,1000,0)
--Events end