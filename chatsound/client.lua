theRoot = xmlLoadFile("set.xml")
theVolume = 100

if theRoot then
	volume = xmlFindChild(theRoot,"volume",0)
	theVolume = tonumber(xmlNodeGetValue ( volume ))
	xmlUnloadFile(theRoot)
else
	theRoot = xmlCreateFile("set.xml","options")
	volume = xmlCreateChild(theRoot,"volume")
	xmlNodeSetValue(volume,"100")
	xmlSaveFile(theRoot)
	xmlUnloadFile(theRoot)
end

function onChat()
end

addEventHandler()