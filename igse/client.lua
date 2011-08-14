function loadEverything()

lastResource = ""
lastScript = ""
enabled = false

GUIEditor_Window = {}
GUIEditor_TabPanel = {}
GUIEditor_Tab = {}
GUIEditor_Button = {}
GUIEditor_Memo = {}
GUIEditor_Label = {}
GUIEditor_Edit = {}
GUIEditor_Radio = {}
GUIEditor_Grid = {}

GUIEditor_Window[1] = guiCreateWindow(0.0351,0.0326,0.96,0.9063,"In-game Script Editor by Crazy",true)
GUIEditor_TabPanel[1] = guiCreateTabPanel(0.0092,0.0345,0.9817,0.9526,true,GUIEditor_Window[1])
GUIEditor_Tab[1] = guiCreateTab("Resources",GUIEditor_TabPanel[1])
GUIEditor_Label[1] = guiCreateLabel(0.0187,0.0344,0.1389,0.0454,"Resources:",true,GUIEditor_Tab[1])
guiLabelSetColor(GUIEditor_Label[1],255,255,255)
guiLabelSetVerticalAlign(GUIEditor_Label[1],"top")
guiLabelSetHorizontalAlign(GUIEditor_Label[1],"left",false)
GUIEditor_Grid[1] = guiCreateGridList(0.0166,0.072,0.2943,0.9014,true,GUIEditor_Tab[1])
guiGridListSetSelectionMode(GUIEditor_Grid[1],2)
GUIEditor_Label[2] = guiCreateLabel(0.3181,0.0736,0.1513,0.0313,"Resource info",true,GUIEditor_Tab[1])
guiLabelSetColor(GUIEditor_Label[2],255,255,255)
guiLabelSetVerticalAlign(GUIEditor_Label[2],"top")
guiLabelSetHorizontalAlign(GUIEditor_Label[2],"left",false)
GUIEditor_Label[3] = guiCreateLabel(0.3927,0.1628,0.0052,0.0078,"",true,GUIEditor_Tab[1])
guiLabelSetColor(GUIEditor_Label[3],255,255,255)
guiLabelSetVerticalAlign(GUIEditor_Label[3],"top")
guiLabelSetHorizontalAlign(GUIEditor_Label[3],"left",false)
GUIEditor_Label[4] = guiCreateLabel(0.3181,0.1127,0.1451,0.0548,"Author: ",true,GUIEditor_Tab[1])
guiLabelSetColor(GUIEditor_Label[4],255,255,255)
guiLabelSetVerticalAlign(GUIEditor_Label[4],"top")
guiLabelSetHorizontalAlign(GUIEditor_Label[4],"left",false)
GUIEditor_Label[5] = guiCreateLabel(0.3181,0.1612,0.1451,0.0548,"Version: ",true,GUIEditor_Tab[1])
guiLabelSetColor(GUIEditor_Label[5],255,255,255)
guiLabelSetVerticalAlign(GUIEditor_Label[5],"top")
guiLabelSetHorizontalAlign(GUIEditor_Label[5],"left",false)
GUIEditor_Label[6] = guiCreateLabel(0.3181,0.2128,0.1451,0.0548,"Type: ",true,GUIEditor_Tab[1])
guiLabelSetColor(GUIEditor_Label[6],255,255,255)
guiLabelSetVerticalAlign(GUIEditor_Label[6],"top")
guiLabelSetHorizontalAlign(GUIEditor_Label[6],"left",false)
GUIEditor_Button[1] = guiCreateButton(0.3223,0.2676,0.1938,0.0782,"Load resource",true,GUIEditor_Tab[1])
GUIEditor_Tab[2] = guiCreateTab("Script Editing",GUIEditor_TabPanel[1])
GUIEditor_Grid[2] = guiCreateGridList(0.0166,0.0329,0.2021,0.2238,true,GUIEditor_Tab[2])
guiGridListSetSelectionMode(GUIEditor_Grid[2],2)
GUIEditor_Memo[1] = guiCreateMemo(0.0187,0.2676,0.9648,0.7089,"",true,GUIEditor_Tab[2])
GUIEditor_Button[2] = guiCreateButton(0.2249,0.036,0.1337,0.0376,"Load script",true,GUIEditor_Tab[2])
GUIEditor_Button[3] = guiCreateButton(0.2249,0.0861,0.1337,0.0376,"Save current script",true,GUIEditor_Tab[2])
GUIEditor_Button[4] = guiCreateButton(0.2249,0.1408,0.1337,0.036,"Start/Restart resource",true,GUIEditor_Tab[2])
GUIEditor_Label[7] = guiCreateLabel(0.401,0.0438,0.1161,0.0297,"Add script",true,GUIEditor_Tab[2])
guiLabelSetColor(GUIEditor_Label[7],255,255,255)
guiLabelSetVerticalAlign(GUIEditor_Label[7],"top")
guiLabelSetHorizontalAlign(GUIEditor_Label[7],"left",false)
GUIEditor_Label[8] = guiCreateLabel(0.3969,0.0892,0.1409,0.0313,"Script name (with .lua):",true,GUIEditor_Tab[2])
guiLabelSetColor(GUIEditor_Label[8],255,255,255)
guiLabelSetVerticalAlign(GUIEditor_Label[8],"top")
guiLabelSetHorizontalAlign(GUIEditor_Label[8],"left",false)
GUIEditor_Edit[1] = guiCreateEdit(0.3959,0.1252,0.1917,0.0344,"",true,GUIEditor_Tab[2])
add_script = guiCreateButton(0.3979,0.1706,0.1917,0.0532,"Add script",true,GUIEditor_Tab[2])
GUIEditor_Label[9] = guiCreateLabel(0.599,0.0892,0.1523,0.0313,"Script type:",true,GUIEditor_Tab[2])
guiLabelSetColor(GUIEditor_Label[9],255,255,255)
guiLabelSetVerticalAlign(GUIEditor_Label[9],"top")
guiLabelSetHorizontalAlign(GUIEditor_Label[9],"left",false)
GUIEditor_Radio[1] = guiCreateRadioButton(0.6,0.1283,0.0891,0.0266,"Server-side",true,GUIEditor_Tab[2])
GUIEditor_Radio[2] = guiCreateRadioButton(0.6,0.1674,0.0891,0.0266,"Client-side",true,GUIEditor_Tab[2])
guiRadioButtonSetSelected(GUIEditor_Radio[1],true)
GUIEditor_Button[5] = guiCreateButton(0.2249,0.1941,0.1337,0.036,"Delete script",true,GUIEditor_Tab[2])
guiSetEnabled(GUIEditor_Button[5],false)
GUIEditor_Tab[3] = guiCreateTab("Functions & Events",GUIEditor_TabPanel[1])
GUIEditor_Label[10] = guiCreateLabel(0.0187,0.0266,0.1627,0.0313,"Server-side functions:",true,GUIEditor_Tab[3])
guiLabelSetColor(GUIEditor_Label[10],255,255,255)
guiLabelSetVerticalAlign(GUIEditor_Label[10],"top")
guiLabelSetHorizontalAlign(GUIEditor_Label[10],"left",false)
GUIEditor_Grid[3] = guiCreateGridList(0.0166,0.0626,0.2342,0.3818,true,GUIEditor_Tab[3])
guiGridListSetSelectionMode(GUIEditor_Grid[3],2)
GUIEditor_Grid[4] = guiCreateGridList(0.0176,0.5352,0.2342,0.3818,true,GUIEditor_Tab[3])
guiGridListSetSelectionMode(GUIEditor_Grid[4],2)
GUIEditor_Label[11] = guiCreateLabel(0.0187,0.4773,0.1627,0.0313,"Client-side functions:",true,GUIEditor_Tab[3])
guiLabelSetColor(GUIEditor_Label[11],255,255,255)
guiLabelSetVerticalAlign(GUIEditor_Label[11],"top")
guiLabelSetHorizontalAlign(GUIEditor_Label[11],"left",false)
GUIEditor_Grid[5] = guiCreateGridList(0.2767,0.0626,0.2342,0.3818,true,GUIEditor_Tab[3])
guiGridListSetSelectionMode(GUIEditor_Grid[5],2)
GUIEditor_Grid[6] = guiCreateGridList(0.2767,0.5368,0.2342,0.3818,true,GUIEditor_Tab[3])
guiGridListSetSelectionMode(GUIEditor_Grid[6],2)
GUIEditor_Label[12] = guiCreateLabel(0.2746,0.0266,0.1627,0.0313,"Server-side events:",true,GUIEditor_Tab[3])
guiLabelSetColor(GUIEditor_Label[12],255,255,255)
guiLabelSetVerticalAlign(GUIEditor_Label[12],"top")
guiLabelSetHorizontalAlign(GUIEditor_Label[12],"left",false)
GUIEditor_Label[13] = guiCreateLabel(0.2746,0.4773,0.1627,0.0313,"Client-side events:",true,GUIEditor_Tab[3])
guiLabelSetColor(GUIEditor_Label[13],255,255,255)
guiLabelSetVerticalAlign(GUIEditor_Label[13],"top")
guiLabelSetHorizontalAlign(GUIEditor_Label[13],"left",false)
GUIEditor_Label[14] = guiCreateLabel(0.542,0.0282,0.1793,0.0376,"Description:",true,GUIEditor_Tab[3])
guiLabelSetColor(GUIEditor_Label[14],255,255,255)
guiLabelSetVerticalAlign(GUIEditor_Label[14],"top")
guiLabelSetHorizontalAlign(GUIEditor_Label[14],"left",false)
GUIEditor_Memo[2] = guiCreateMemo(0.5409,0.0673,0.372,0.144,"",true,GUIEditor_Tab[3])
GUIEditor_Label[15] = guiCreateLabel(0.5461,0.2379,0.2145,0.036,"Parameters:",true,GUIEditor_Tab[3])
guiLabelSetColor(GUIEditor_Label[15],255,255,255)
guiLabelSetVerticalAlign(GUIEditor_Label[15],"top")
guiLabelSetHorizontalAlign(GUIEditor_Label[15],"left",false)
GUIEditor_Edit[2] = guiCreateEdit(0.542,0.2801,0.372,0.0391,"",true,GUIEditor_Tab[3])
GUIEditor_Label[16] = guiCreateLabel(0.544,0.3505,0.3668,0.0329,"Returns: ",true,GUIEditor_Tab[3])
guiLabelSetColor(GUIEditor_Label[16],255,255,255)
guiLabelSetVerticalAlign(GUIEditor_Label[16],"top")
guiLabelSetHorizontalAlign(GUIEditor_Label[16],"left",false)
GUIEditor_Tab[4] = guiCreateTab("New resource",GUIEditor_TabPanel[1])
GUIEditor_Label[17] = guiCreateLabel(0.0228,0.061,0.1907,0.0297,"Name:",true,GUIEditor_Tab[4])
guiLabelSetColor(GUIEditor_Label[17],255,255,255)
guiLabelSetVerticalAlign(GUIEditor_Label[17],"top")
guiLabelSetHorizontalAlign(GUIEditor_Label[17],"left",false)
GUIEditor_Edit[3] = guiCreateEdit(0.0694,0.0548,0.1565,0.0391,"(resource folder name)",true,GUIEditor_Tab[4])
GUIEditor_Label[18] = guiCreateLabel(0.0207,0.1205,0.1907,0.0297,"Author:",true,GUIEditor_Tab[4])
guiLabelSetColor(GUIEditor_Label[18],255,255,255)
guiLabelSetVerticalAlign(GUIEditor_Label[18],"top")
guiLabelSetHorizontalAlign(GUIEditor_Label[18],"left",false)
GUIEditor_Edit[4] = guiCreateEdit(0.0694,0.1142,0.1565,0.0391,"",true,GUIEditor_Tab[4])
GUIEditor_Label[19] = guiCreateLabel(0.0207,0.1847,0.1907,0.0297,"Version:",true,GUIEditor_Tab[4])
guiLabelSetColor(GUIEditor_Label[19],255,255,255)
guiLabelSetVerticalAlign(GUIEditor_Label[19],"top")
guiLabelSetHorizontalAlign(GUIEditor_Label[19],"left",false)
GUIEditor_Edit[5] = guiCreateEdit(0.0694,0.1815,0.1565,0.0391,"",true,GUIEditor_Tab[4])
GUIEditor_Label[20] = guiCreateLabel(0.0207,0.2426,0.1907,0.0297,"Type:",true,GUIEditor_Tab[4])
guiLabelSetColor(GUIEditor_Label[20],255,255,255)
guiLabelSetVerticalAlign(GUIEditor_Label[20],"top")
guiLabelSetHorizontalAlign(GUIEditor_Label[20],"left",false)
GUIEditor_Edit[6] = guiCreateEdit(0.0694,0.2379,0.1565,0.0391,"",true,GUIEditor_Tab[4])
GUIEditor_Button[6] = guiCreateButton(0.0249,0.3005,0.2052,0.0689,"Create resource!",true,GUIEditor_Tab[4])
GUIEditor_Edit[7] = guiCreateEdit(0.2269,0.0548,0.1565,0.0391,"(full resource name)",true,GUIEditor_Tab[4])

column = guiGridListAddColumn(GUIEditor_Grid[1],"Resources",0.8)
column2 = guiGridListAddColumn(GUIEditor_Grid[2],"Scripts",0.8)
func_s = guiGridListAddColumn(GUIEditor_Grid[3],"Functions",0.8)
func_c = guiGridListAddColumn(GUIEditor_Grid[4],"Functions",0.8)
event_s = guiGridListAddColumn(GUIEditor_Grid[5],"Events",0.8)
event_c = guiGridListAddColumn(GUIEditor_Grid[6],"Events",0.8)

guiSetVisible(GUIEditor_Window[1],false)

callServerFunction("loadServerFunctions",getLocalPlayer())
callServerFunction("loadClientFunctions",getLocalPlayer())
callServerFunction("loadServerEvents",getLocalPlayer())
callServerFunction("loadClientEvents",getLocalPlayer())

function showMenu()
if enabled == false then
	guiSetVisible(GUIEditor_Window[1],true)
	guiGridListClear(GUIEditor_Grid[1])
	callServerFunction("getRes",getLocalPlayer())
	showCursor(true,true)
	enabled = true
else
	guiSetVisible(GUIEditor_Window[1],false)
	showCursor(false,false)
	enabled = false
end
end

function temp()
	callServerFunction("checkAdmin",getLocalPlayer())
end

bindKey("o","down",temp)

addEventHandler("onClientGUIClick",getRootElement(),
function (button)
	if source == add_script then
		if lastResource ~= "" then 
			if guiGetText(GUIEditor_Edit[1]) ~= "" then
				if guiRadioButtonGetSelected(GUIEditor_Radio[1]) then
					callServerFunction("addScript",getLocalPlayer(),lastResource,guiGetText(GUIEditor_Edit[1]),"server")
				else
					callServerFunction("addScript",getLocalPlayer(),lastResource,guiGetText(GUIEditor_Edit[1]),"client")
				end
			else
				outputChatBox("*Enter script name!",255,0,0)
			end
		else
			outputChatBox("*Please, load resource first!",255,0,0)
		end
	end
end)


addEventHandler("onClientGUIClick",getRootElement(),
function (button)
	if source == GUIEditor_Memo[1] or source == GUIEditor_Edit[1] or source == GUIEditor_Memo[2] or source == GUIEditor_Edit[2] or source == GUIEditor_Edit[3] or source == GUIEditor_Edit[4] or source == GUIEditor_Edit[5] or source == GUIEditor_Edit[6] or source == GUIEditor_Edit[7] then
		guiSetInputEnabled(true)
	else
		guiSetInputEnabled(false)
	end
end)

addEventHandler("onClientGUIClick",getRootElement(),
function (button)
	if button == "left" then
		if source == GUIEditor_Grid[3] then
			local row, column = guiGridListGetSelectedItem(GUIEditor_Grid[3])
			if row ~= -1 and column ~= -1 then
				local funcName = guiGridListGetItemText(GUIEditor_Grid[3],row,column)
				callServerFunction("addDescription",getLocalPlayer(),funcName,"sf")
			end
		elseif source == GUIEditor_Grid[4] then
			local row, column = guiGridListGetSelectedItem(GUIEditor_Grid[4])
			if row ~= -1 and column ~= -1 then
				local funcName = guiGridListGetItemText(GUIEditor_Grid[4],row,column)
				callServerFunction("addDescription",getLocalPlayer(),funcName,"cf")
			end
		elseif source == GUIEditor_Grid[5] then
			local row, column = guiGridListGetSelectedItem(GUIEditor_Grid[5])
			if row ~= -1 and column ~= -1 then
				local funcName = guiGridListGetItemText(GUIEditor_Grid[5],row,column)
				callServerFunction("addDescription",getLocalPlayer(),funcName,"se")
			end
		elseif source == GUIEditor_Grid[6] then
			local row, column = guiGridListGetSelectedItem(GUIEditor_Grid[6])
			if row ~= -1 and column ~= -1 then
				local funcName = guiGridListGetItemText(GUIEditor_Grid[6],row,column)
				callServerFunction("addDescription",getLocalPlayer(),funcName,"ce")
			end
		end
	end
end)

addEventHandler("onClientGUIClick",GUIEditor_Grid[1],
function (button)
	if button == "left" then
		local row, column = guiGridListGetSelectedItem(GUIEditor_Grid[1])
		if row ~= -1 and column ~= -1 then
			local resName = guiGridListGetItemText(GUIEditor_Grid[1],row,column)
			callServerFunction("getResInformation",getLocalPlayer(),resName)
		end
	end
end)

addEventHandler("onClientGUIClick",GUIEditor_Button[1],
function (button)
	if button == "left" then
		local row, column = guiGridListGetSelectedItem(GUIEditor_Grid[1])
		if row ~= -1 and column ~= -1 then
			local resName = guiGridListGetItemText(GUIEditor_Grid[1],row,column)
			lastResource = resName
			lastScript = ""
			guiGridListClear(GUIEditor_Grid[2])
			callServerFunction("getScriptList",getLocalPlayer(),resName)
		end
	end
end)


addEventHandler("onClientGUIClick",GUIEditor_Button[2],
function (button)
	if button == "left" then
		local row1, column1 = guiGridListGetSelectedItem(GUIEditor_Grid[2])
		if row1 ~= -1 and column1 ~= -1 then
			local scriptName = guiGridListGetItemText(GUIEditor_Grid[2],row1,column1)
			callServerFunction("readScriptFile",getLocalPlayer(),lastResource,scriptName)
		end
	end
end)

addEventHandler("onClientGUIClick",GUIEditor_Button[3],
function (button)
	if button == "left" then
	if lastScript ~= "" then
		callServerFunction("saveScriptFile",getLocalPlayer(),lastResource,lastScript,guiGetText(GUIEditor_Memo[1]))
	else
		outputChatBox("*Please, load script first!",255,0,0)
	end
	end
end)

addEventHandler("onClientGUIClick",GUIEditor_Button[6],
function (button)
	if button == "left" then
		callServerFunction("createResourceA",getLocalPlayer(),guiGetText(GUIEditor_Edit[3]),guiGetText(GUIEditor_Edit[4]),guiGetText(GUIEditor_Edit[5]),guiGetText(GUIEditor_Edit[6]),guiGetText(GUIEditor_Edit[7]))
	end
end)

addEventHandler("onClientGUIClick",GUIEditor_Button[4],
function (button)
	if button == "left" then
	if lastResource ~= "" then
		callServerFunction("startRes",getLocalPlayer(),lastResource)
	else
		outputChatBox("*Please, load resource first!",255,0,0)
	end
	end
end)
end

addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),loadEverything)

function addResListRow(resName)
	local row = guiGridListAddRow ( GUIEditor_Grid[1] )
	guiGridListSetItemText ( GUIEditor_Grid[1], row, column, resName, false, false )
end

function addInformation(theParams)
	local params = string.explode(theParams,"|")
	guiSetText(GUIEditor_Label[4],"Author: "..params[1])
	guiSetText(GUIEditor_Label[5],"Version: "..params[2])
	guiSetText(GUIEditor_Label[6],"Type: "..params[3])
end

function addScriptList(theParams)
	local params = string.explode(theParams,"|")
	local row = guiGridListAddRow ( GUIEditor_Grid[2] )
	guiGridListSetItemText ( GUIEditor_Grid[2], row, column2, params[1], false, false )
end

function loadScript(theScript,scriptName)
	lastScript = scriptName
	guiSetText(GUIEditor_Memo[1],theScript)
end

function addServerFunc(theName,group)
	local row = guiGridListAddRow ( GUIEditor_Grid[3] )
	if group then
		guiGridListSetItemText ( GUIEditor_Grid[3], row, func_s, theName, true, false )
	else
		guiGridListSetItemText ( GUIEditor_Grid[3], row, func_s, theName, false, false )
	end
end

function addClientFunc(theName,group)
	local row = guiGridListAddRow ( GUIEditor_Grid[4] )
	if group then
		guiGridListSetItemText ( GUIEditor_Grid[4], row, func_c, theName, true, false )
	else
		guiGridListSetItemText ( GUIEditor_Grid[4], row, func_c, theName, false, false )
	end
end

function addServerEvent(theName,group)
	local row = guiGridListAddRow ( GUIEditor_Grid[5] )
	if group then
		guiGridListSetItemText ( GUIEditor_Grid[5], row, event_s, theName, true, false )
	else
		guiGridListSetItemText ( GUIEditor_Grid[5], row, event_s, theName, false, false )
	end
end

function addClientEvent(theName,group)
	local row = guiGridListAddRow ( GUIEditor_Grid[6] )
	if group then
		guiGridListSetItemText ( GUIEditor_Grid[6], row, event_c, theName, true, false )
	else
		guiGridListSetItemText ( GUIEditor_Grid[6], row, event_c, theName, false, false )
	end
end

function setDescription(desc,ret,params)
if desc then
	guiSetText(GUIEditor_Memo[2],desc)
end
if ret then
	guiSetText(GUIEditor_Label[13],"Returns: " .. ret)
end
if params then
	guiSetText(GUIEditor_Edit[1],params)
end
end