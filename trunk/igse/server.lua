admins = {}
afile = xmlLoadFile("serial.xml")
anodes = xmlNodeGetChildren(afile)
for i,v in ipairs(anodes) do
	admins[i] = xmlNodeGetAttribute(v,"serial")
end

function getRes(thePlayer)
	local res = getResources()
	for i,v in ipairs(res) do
		local name = getResourceName(v)
		callClientFunction(thePlayer,"addResListRow",name)
	end
end

function getResInformation(thePlayer,theResName)
	if getResourceFromName(theResName) then
		local res = getResourceFromName(theResName)
		local author = getResourceInfo(res,"author")
		local version = getResourceInfo(res,"version")
		local rtype = getResourceInfo(res,"type")
		if author == false then 
			author = "unknown"
		end
		if version == false then 
			version = "unknown"
		end
		if rtype == false then 
			rtype = "unknown"
		end
		local param = author.."|"..version.."|"..rtype
		callClientFunction(thePlayer,"addInformation",param)
	end
end

function getScriptList(thePlayer,theResName)
	if getResourceFromName(theResName) then
		local file = xmlLoadFile(":"..theResName.."/meta.xml")
		local child = xmlNodeGetChildren(file)
		for i,v in ipairs(child) do
			if xmlNodeGetName(v) == "script" then
				local src = xmlNodeGetAttribute(v,"src")
				local sType = xmlNodeGetAttribute(v,"type")
				if src then
					if sType == false then sType = "server" end
					callClientFunction(thePlayer,"addScriptList",src.."|"..sType)
				end
			end
		end
		xmlUnloadFile(file)
		outputChatBox("*Resource "..theResName.." successfully loaded!",thePlayer,0,255,0)
	else
		outputChatBox("*There is no "..theResName.." resource",thePlayer,255,0,0)
	end
end

function readScriptFile(thePlayer,resName,scriptName)
	local file = fileOpen(":"..resName.."/"..scriptName,true)
	local data = ""
	while not fileIsEOF(file) do      
        data = data..fileRead(file, 500)
    end
    fileClose(file)
    callClientFunction(thePlayer,"loadScript",data,scriptName)
    outputChatBox("*Script "..scriptName.." loaded!",thePlayer,0,255,0)
end

function saveScriptFile(thePlayer,resName,scriptName,theScript)
	local state = getResourceState(getResourceFromName(resName))
	if state == "running" or state == "starting" then
		outputChatBox("*Stopping resource "..resName,thePlayer,0,255,0)
		stopResource(getResourceFromName(resName))
	end
	fileDelete ( ":"..resName.."/"..scriptName )
	local file = fileCreate(":"..resName.."/"..scriptName)
	fileWrite(file,theScript)
    fileClose(file)
    outputChatBox("*Script successfully saved!",thePlayer,0,255,0)
    startResource(getResourceFromName(resName))
end

function startRes(thePlayer,resName)
	local res = getResourceFromName(resName)
	local state = getResourceState(res)
	if state == "loaded" then startResource(res) end
	if state == "running" or state=="starting" then restartResource(res) end
	local reason = getResourceLoadFailureReason(res)
	if reason ~= "" then
		outputChatBox("*Failed to start/restart resource! Reason: "..reason,thePlayer,255,0,0)
	else
		outputChatBox("*Resource successfully started/restarted!",thePlayer,0,255,0)
	end
end

function checkAdmin(thePlayer)
	local admin = false
	for i,v in ipairs(admins) do
		if getPlayerSerial(thePlayer) == v then
			admin = true
		end
	end
	if admin == true then
    	callClientFunction(thePlayer,"showMenu")
    end
end

addCommandHandler("getserial",
function (thePlayer)
	outputChatBox("Your serial is: "..getPlayerSerial(thePlayer),thePlayer,255,255,0)
end)

function loadServerFunctions(thePlayer)
	local file = xmlLoadFile("s_fun.xml")
	local group = xmlNodeGetChildren(file)
	for i,v in ipairs(group) do
		local funcs = xmlNodeGetChildren(v)
		callClientFunction(thePlayer,"addServerFunc",xmlNodeGetAttribute(v,"name"),true)
		for i2,v2 in ipairs(funcs) do
			callClientFunction(thePlayer,"addServerFunc",xmlNodeGetAttribute(v2,"name"),false)
		end
	end
	xmlUnloadFile(file)
end

function loadClientFunctions(thePlayer)
	local file = xmlLoadFile("c_fun.xml")
	local group = xmlNodeGetChildren(file)
	for i,v in ipairs(group) do
		local funcs = xmlNodeGetChildren(v)
		callClientFunction(thePlayer,"addClientFunc",xmlNodeGetAttribute(v,"name"),true)
		for i2,v2 in ipairs(funcs) do
			callClientFunction(thePlayer,"addClientFunc",xmlNodeGetAttribute(v2,"name"),false)
		end
	end
	xmlUnloadFile(file)
end

function loadServerEvents(thePlayer)
	local file = xmlLoadFile("s_event.xml")
	local group = xmlNodeGetChildren(file)
	for i,v in ipairs(group) do
		local Event = xmlNodeGetChildren(v)
		callClientFunction(thePlayer,"addServerEvent",xmlNodeGetAttribute(v,"name"),true)
		for i2,v2 in ipairs(Event) do
			callClientFunction(thePlayer,"addServerEvent",xmlNodeGetAttribute(v2,"name"),false)
		end
	end
	xmlUnloadFile(file)
end

function loadClientEvents(thePlayer)
	local file = xmlLoadFile("c_event.xml")
	local group = xmlNodeGetChildren(file)
	for i,v in ipairs(group) do
		local Event = xmlNodeGetChildren(v)
		callClientFunction(thePlayer,"addClientEvent",xmlNodeGetAttribute(v,"name"),true)
		for i2,v2 in ipairs(Event) do
			callClientFunction(thePlayer,"addClientEvent",xmlNodeGetAttribute(v2,"name"),false)
		end
	end
	xmlUnloadFile(file)
end

function createResourceA(thePlayer,theName,theAuthor,theVersion,theType,theFullName)
	if theName ~= "" then
		if getResourceFromName(theName) then
			outputChatBox("*Error! Resource with that name already exists!",thePlayer,255,0,0)
		else
			local res = createResource(theName)
			if res then
				outputChatBox("*Resource succesfully created!",thePlayer,0,255,0)
				local xmlFile = xmlLoadFile(":"..theName.."/meta.xml")
				local infoNode = xmlCreateChild(xmlFile,"info")
				if theAuthor ~= "" then
					lol = xmlNodeSetAttribute(infoNode,"author",theAuthor)
				end
				if theVersion ~= "" then
					xmlNodeSetAttribute(infoNode,"version",theVersion)
				end
				if theType ~= "" then
					xmlNodeSetAttribute(infoNode,"type",theType)
				end
				if theFullName ~= "" then
					xmlNodeSetAttribute(infoNode,"name",theFullName)
				end
				xmlSaveFile(xmlFile)
				xmlUnloadFile(xmlFile)
			else
				outputChatBox("*Error! An un-expected error occured.",thePlayer,255,0,0)
			end
		end
	else
		outputChatBox("*Error! Please, specify resource folder name",thePlayer,255,0,0)
	end
end

function addScript(thePlayer,resName,sName,sType)
	if getResourceFromName(resName) then
		local xmlFile = xmlLoadFile(":"..resName.."/meta.xml")
		local lol = xmlNodeGetChildren(xmlFile)
		local check = false
		for i,v in ipairs(lol) do
			if xmlNodeGetName(v) == "script" then
				if xmlNodeGetAttribute(v,"src") == sName then
					check = true
				end
			end
		end
		if check == false then
			local scrNode = xmlCreateChild(xmlFile,"script")
			xmlNodeSetAttribute(scrNode,"src",sName)
			xmlNodeSetAttribute(scrNode,"type",sName)
			xmlNodeSetAttribute(scrNode,"type",sType)
			xmlSaveFile(xmlFile)
			xmlUnloadFile(xmlFile)
			local file = fileCreate(":"..resName.."/"..sName)
			fileClose(file)
			outputChatBox("*Script "..sName.." successfully added to "..resName,thePlayer,0,255,0)
			callClientFunction(thePlayer,"addScriptList",sName.."|"..sType)
		else
			outputChatBox("*There is already script with this name!",thePlayer,255,0,0)
		end
	end
end

function addDescription(thePlayer,funcn,ftype)
	if ftype == "sf" then
		local file = xmlLoadFile("s_fun.xml")
		local group = xmlNodeGetChildren(file)
		for i,v in ipairs(group) do
			local func = xmlNodeGetChildren(v)
			for i2,v2 in ipairs(func) do
				if xmlNodeGetAttribute(v2,"name") == funcn then
					local descN = xmlFindChild ( v2, "description", 0 )
					local desc = xmlNodeGetValue(descN)
					local params = xmlNodeGetChildren(v2)
					local fParam = funcn.."("
					local first = true
					for i3,v3 in ipairs(params) do
						if xmlNodeGetName(v3) == "param" then
							if xmlNodeGetAttribute(v3,"type") == "required" then
								if first then
									fParam = fParam..xmlNodeGetAttribute(v3,"name")
								else
									fParam = fParam..","..xmlNodeGetAttribute(v3,"name")
								end
							else
								if first then
									fParam = fParam.."[ "..xmlNodeGetAttribute(v3,"name").." ]"
								else
									fParam = fParam..",[ "..xmlNodeGetAttribute(v3,"name").." ]"
								end
							end
							if first == true then first = false end
						end
					end
					fParam = fParam .. ")"
					callClientFunction(thePlayer,"setDescription",desc,xmlNodeGetAttribute(v2,"ret"),fParam)
				end
			end
		end
		xmlUnloadFile(file)
	end
	if ftype == "cf" then
		local file = xmlLoadFile("c_fun.xml")
		local group = xmlNodeGetChildren(file)
		for i,v in ipairs(group) do
			local func = xmlNodeGetChildren(v)
			for i2,v2 in ipairs(func) do
				if xmlNodeGetAttribute(v2,"name") == funcn then
					local descN = xmlFindChild ( v2, "description", 0 )
					local desc = xmlNodeGetValue(descN)
					local params = xmlNodeGetChildren(v2)
					local fParam = funcn.."("
					local first = true
					for i3,v3 in ipairs(params) do
						if xmlNodeGetName(v3) == "param" then
							if xmlNodeGetAttribute(v3,"type") == "required" then
								if first then
									fParam = fParam..xmlNodeGetAttribute(v3,"name")
								else
									fParam = fParam..","..xmlNodeGetAttribute(v3,"name")
								end
							else
								if first then
									fParam = fParam.."[ "..xmlNodeGetAttribute(v3,"name").." ]"
								else
									fParam = fParam..",[ "..xmlNodeGetAttribute(v3,"name").." ]"
								end
							end
							if first == true then first = false end
						end
					end
					fParam = fParam .. ")"
					callClientFunction(thePlayer,"setDescription",desc,xmlNodeGetAttribute(v2,"ret"),fParam)
				end
			end
		end
		xmlUnloadFile(file)
	end
	if ftype == "se" then
		local file = xmlLoadFile("s_event.xml")
		local group = xmlNodeGetChildren(file)
		for i,v in ipairs(group) do
			local func = xmlNodeGetChildren(v)
			for i2,v2 in ipairs(func) do
				if xmlNodeGetAttribute(v2,"name") == funcn then
					local descN = xmlFindChild ( v2, "description", 0 )
					local desc = xmlNodeGetValue(descN)
					local params = xmlNodeGetChildren(v2)
					local fParam = ""
					local first = true
					for i3,v3 in ipairs(params) do
						if xmlNodeGetName(v3) == "param" then
							if first then
								fParam = fParam..xmlNodeGetAttribute(v3,"name")
							else
								fParam = fParam..", "..xmlNodeGetAttribute(v3,"name")
							end
							if first == true then first = false end
						end
					end
					callClientFunction(thePlayer,"setDescription",desc,"",fParam)
				end
			end
		end
		xmlUnloadFile(file)
	end
	if ftype == "ce" then
		local file = xmlLoadFile("c_event.xml")
		local group = xmlNodeGetChildren(file)
		for i,v in ipairs(group) do
			local func = xmlNodeGetChildren(v)
			for i2,v2 in ipairs(func) do
				if xmlNodeGetAttribute(v2,"name") == funcn then
					local descN = xmlFindChild ( v2, "description", 0 )
					local desc = xmlNodeGetValue(descN)
					local params = xmlNodeGetChildren(v2)
					local fParam = ""
					local first = true
					for i3,v3 in ipairs(params) do
						if xmlNodeGetName(v3) == "param" then
							if first then
								fParam = fParam..xmlNodeGetAttribute(v3,"name")
							else
								fParam = fParam..", "..xmlNodeGetAttribute(v3,"name")
							end
							if first == true then first = false end
						end
					end
					callClientFunction(thePlayer,"setDescription",desc,"",fParam)
				end
			end
		end
		xmlUnloadFile(file)
	end
end