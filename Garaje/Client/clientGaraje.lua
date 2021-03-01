local marcadorGaraje1 = createMarker ( 901.642578125, -1204.2568359375, 15.983215332031, "cylinder", 2.0,  255, 0, 0, 255)
local marcadorGaraje1Salida = createMarker (934.66833496094, -1163.1904296875, -55.738311767578, "cylinder",2.0, 255,0,0,255)
local marcadorGuardarVehiculo1 = createMarker (893.7353515625, -1206.6376953125, 15.976562, "cylinder",4.0, 255,30,0,255)
local blipGaraje1 = createBlip ( 901.642578125, -1204.2568359375, 16.983215332031, 27, 2, 255,0,0, 255,0, 200)
pbx,pby,pbz = 926.55017089844, -1210.91796875, -56.881492614746
local colr,colg,colb = 255,255,255
local tablaGar = {}
local tablaFunc = {}

addEventHandler("onClientMarkerHit", marcadorGaraje1,
function ( hitPlayer )
	triggerServerEvent( "obtenerGarajesSql", localPlayer,localPlayer)
	triggerServerEvent( "obtenerCantMaxVehEnGarj", localPlayer,localPlayer)
	triggerServerEvent( "obtenerCantMaxVehSql", localPlayer,localPlayer)
	triggerServerEvent( "obtenerCantMaxVehComp", localPlayer,localPlayer)
	triggerServerEvent( "obtenerSerialUsuario", localPlayer,localPlayer)
	triggerServerEvent( "ReyenarTablaGara", localPlayer,localPlayer)
	x,y,z = getElementPosition(localPlayer)
	if (z < 30 and z > 14) then
	if ( getElementType ( hitPlayer ) == "player" ) and ( hitPlayer == localPlayer ) then
	cantidadGarajes = getElementData(localPlayer,"CantGaraje")
		if( cantidadGarajes > 0)then		
			if(isPedInVehicle (getLocalPlayer()))then
				outputChatBox("[Garaje]#ffffffNo puedes entrar si estas en un vehiculo", 227, 13, 13,true)
			else
			setTimer ( function()
				dimJuga = getElementData(localPlayer,"DimGaraje")
				setElementDimension(localPlayer,dimJuga)
				vehEnGara = getElementData(localPlayer,"CantVehEnGaraje")
				local cantG = 0
				local objj = vehEnGara
				for i, _ in ipairs( tablaGar ) do 
					if tablaGar[i].id_gara == 0 then
					else
					tablaFunc[i] = markerConDimension(pbx,pby +cantG-2,pbz,0,0,90)
					tablaFunc[objj+1] = vehiculoConDimension(tonumber(tablaGar[i].id_vehi),pbx,pby +cantG,pbz+0.1,0,0,90)
					colr = tablaGar[i].r
					colg = tablaGar[i].g
					colb = tablaGar[i].b
					setVehicleColor(tablaFunc[objj+1],colr,colg,colb)
					setElementData(tablaFunc[objj+1],"enParqueadero",true)
					setElementHealth(tablaFunc[objj+1],tablaGar[i].vida*10)
					cantG = cantG + 4
					objj = objj + 1
					setElementData(localPlayer,"ventAbiInfoVehicle", false)
					addEventHandler("onClientMarkerHit", tablaFunc[i],
					function ( hitPlayer )
						if(getElementData(localPlayer,"ventAbiInfoVehicle") == false)then
							ventVeh(tablaGar[i].id_vehi,tablaGar[i].r,tablaGar[i].g,tablaGar[i].b,tablaGar[i].vida,tablaGar[i].id,tablaGar[i].precio)
						end
					end)
					end
				end
				end, 1000, 1 )
				pickInfo = createPickup (  931.51306152344, -1170.9658203125, -55.87696456909, 3, 1239)
				setElementDimension(pickInfo,getElementData(localPlayer,"DimGaraje"))
				setElementData(localPlayer,"ventAbiInfoGara", false)
				addEventHandler("onClientPickupHit", pickInfo, function()
					if(getElementData(localPlayer,"ventAbiInfoGara") == false)then
						local cantidadVehInfo = getElementData(localPlayer,"CantVehGaraje")
						infoGaraFin(vehEnGara,cantidadVehInfo)
						setElementData(localPlayer,"ventAbiInfoGara", true)
					end
				end)
			addEventHandler("onClientRender",root,crearInfoVeh)
			outputChatBox("[Garaje]#ffffffEntraste a tu garaje principal",255, 13, 13,true)
			setElementPosition ( localPlayer,  931.66735839844, -1162.9892578125, -55.881248474121)
			end
		else
			outputChatBox("[Garaje]#ffffffNo tienes ningun Garaje a tu disposicion ahora",227, 13, 13)
		end	
	end
	end
end)

function infoGaraFin(vGara,vvecagara)
        ventGaraje = guiCreateWindow(537, 214, 287, 217, "Informacion Garaje", false)
        guiWindowSetSizable(ventGaraje, false)

        botonSalirInfoGara = guiCreateButton(93, 155, 107, 54, "Salir", false, ventGaraje)
        labelCapacidad = guiCreateLabel(15, 26, 264, 23, "Capacidad Garaje: "..vvecagara, false, ventGaraje)
        labelCantveh = guiCreateLabel(15, 49, 264, 23, "Vehiculos en Garaje: "..vGara, false, ventGaraje)
        labelDueno = guiCreateLabel(15, 72, 264, 23, "Nombre Dueño: nicolasecm", false, ventGaraje)
        labelMejoras = guiCreateLabel(15, 95, 264, 23, "Mejoras adquiridas: 0", false, ventGaraje)
		showCursor(true)
		addEventHandler("onClientGUIClick", botonSalirInfoGara, salirInforGara, false)	
end

function salirInforGara()
	showCursor(false)
	destroyElement(ventGaraje)
	setElementData(localPlayer,"ventAbiInfoGara", false)
end

function ventVeh(idveh,cr,cg,cb,hvehi,idVehTa,prevehi)
	setElementData(localPlayer,"ventAbiInfoVehicle", true)
    ventVehGar = guiCreateWindow(522, 222, 372, 265, "Informacion Vehiculo", false)
    guiWindowSetSizable(ventVehGar, false)

    BotonAceptarVehGar = guiCreateButton(30, 192, 112, 57, "Usar Este Vehiculo", false, ventVehGar)
	BotonSalirVehGar = guiCreateButton(199, 192, 112, 57, "Salir", false, ventVehGar)    
	labelIdInfoVeh = guiCreateLabel(30, 31, 156, 24, "ID Vehiculo:"..idVehTa, false, ventVehGar)
    labelPrecioInfoVeh = guiCreateLabel(30, 55, 156, 24, "Precio Vehiculo:"..prevehi, false, ventVehGar)
    labelMejoInfoVeh = guiCreateLabel(30, 79, 156, 24, "Mejoras Vehiculo: 0", false, ventVehGar)
    BotonVenderVehserver = guiCreateButton(211, 32, 144, 33, "Vender vehiculo al servidor", false, ventVehGar)    
	
	showCursor(true)
	addEventHandler("onClientGUIClick", BotonAceptarVehGar, function()
		triggerServerEvent( "crearVehiculoExterior", localPlayer,idveh,cr,cg,cb,hvehi,idVehTa)
		setTimer ( modoFantasma, 500, 1, true)
	end, false)
	addEventHandler("onClientGUIClick", BotonAceptarVehGar, function()
		showCursor(false)
		destroyElement(ventVehGar)
		setElementData(localPlayer,"ventAbiInfoVehicle", false)
	end, false)	
	addEventHandler("onClientGUIClick", BotonSalirVehGar, function()
		showCursor(false)
		destroyElement(ventVehGar)
		setElementData(localPlayer,"ventAbiInfoVehicle", false)
	end, false) 
end

addEventHandler("onClientMarkerHit", marcadorGaraje1Salida,
function (hitPlayer)
x,y,z = getElementPosition(localPlayer)
if(z > -57 and z < -49)then
	SalirGarajeConVehiculo()
	setElementPosition ( localPlayer, 900.7666015625, -1210.0263671875, 16.983215332031)
	setElementDimension( localPlayer, 0)
end
end)

addEventHandler("onClientMarkerHit", marcadorGuardarVehiculo1,
function (hitPlayer)
x,y,z = getElementPosition(localPlayer)
	if (z < 30 and z > 14) then
	if ( getElementType ( hitPlayer ) == "player" ) and ( hitPlayer == localPlayer ) then
	cantidadGarajes = getElementData(localPlayer,"CantGaraje")
	if( cantidadGarajes > 0)then		
	if(isPedInVehicle (getLocalPlayer()))then
		local ju = getElementData(localPlayer,"SerialJugador")
		local vehEntra = getPedOccupiedVehicle(localPlayer)
		local duen = getElementData(vehEntra,"dueno")
		local idvCam = getElementData(vehEntra,"idAsigBase")
		local vidaVeh = getElementHealth(vehEntra)
		if (ju == duen)then
			outputChatBox("[Garaje]#ffffffQuedate 3 segundos en el marcador para guardar tu vehiculo",227, 13, 13,true)
			setTimer ( function ()
				triggerServerEvent("actualizarListaVehiculoEntradaGaraje",localPlayer,localPlayer,idvCam,math.floor(vidaVeh/10))
				triggerServerEvent("destruirVeh",localPlayer,localPlayer)
				outputChatBox("[Garaje]#ffffffVehiculo Guardado Correctamente en tu garaje",227, 13, 13,true)
			end, 3000,1)
		else
			outputChatBox("[Garaje]#ffffffNo eres el propietario de este vehiculo y no puedes guardarlo",227, 13, 13,true)
		end
	else
		outputChatBox("[Garaje]#ffffffEste Marcador es para guardar tus vehiculos, ingresa con un vehiculo propio", 227, 13, 13,true)
	end
	else
		outputChatBox("[Garaje]#ffffffNo tienes ningun Garaje a tu disposicion ahora",227, 13, 13,true)
	end
	end
	end
end)

function crearInfoVeh()
cars = getElementsByType("vehicle",root,true)
for num, car in ipairs(cars) do
	if(getElementData(car,"enParqueadero") == true)then
		local carPosX, carPosY, carPosZ = getElementPosition(car)
		local cx, cy, cz = getCameraMatrix( )
		carLocationX, carLocationY = getScreenFromWorldPosition(carPosX,carPosY,carPosZ,100)
		local min_distance = getDistanceBetweenPoints3D( cx, cy, cz, carPosX, carPosY, carPosZ )
		dividedCarHealth = getElementHealth(car)
		dividedCarHealth = math.floor(dividedCarHealth)/10
		if min_distance < 16 then
			if carLocationX then
				rect1 = dxDrawRectangle(carLocationX-102.5,carLocationY-100-52.5,1025/4,25,tocolor(0,0,0,127.5))
				dxDrawText("Nombre Vehiculo : "..getVehicleName(car), carLocationX-50-35, carLocationY-100-50, 0, 0, tocolor(255,255,255,127.5), 1, "default-bold")
				rect2 = dxDrawRectangle(carLocationX-102.5,carLocationY-50-52.5,1025/4,25,tocolor(0,0,0,127.5))
				dxDrawRectangle(carLocationX-100,carLocationY-50-50,dividedCarHealth* 2.5,20,tocolor(0,127.5,0,127.5))
				dxDrawText("Vida : "..dividedCarHealth.."%", carLocationX-50-35, carLocationY-50-50, 0, 0, tocolor(255,255,255,127.5), 1, "default-bold")
				local col = getVehicleColor(car)
				local color = ""
				if col == 1 then color = "Blanco" elseif col == 0 then color = "Negro" elseif col == 2 then color = "Azul" elseif col == 33 then color = "Gris"
				elseif col == 118 then color = "Azul Aguamarina" elseif col == 16 then color = "Verde" elseif col == 3 then color = "Rojo" elseif col == 6 then color = "Amarillo" end
				rect3 = dxDrawRectangle(carLocationX-102.5,carLocationY-75-52.5,1025/4,25,tocolor(0,0,0,127.5))
				dxDrawText("Color: "..color, carLocationX-50-35, carLocationY-75-50, 0, 0, tocolor(255,255,255,127.5), 1, "default-bold")
			end
		end
	end
end
end

function SalirGarajeConVehiculo()
	for i, _ in ipairs( tablaFunc ) do
		el1 = tablaFunc[i]
		if isElement(el1)then
		destroyElement(el1)
		else
		end
	end
	removeEventHandler("onClientRender",root,crearInfoVeh)
end
addEvent( "SalirGarajeConVehiculo", true )
addEventHandler( "SalirGarajeConVehiculo", root, SalirGarajeConVehiculo )

function completarTablaGar(Tabla)
tablaGar = Tabla
end
addEvent( "completarTablaGar", true )
addEventHandler( "completarTablaGar", root, completarTablaGar )

function modoFantasma(activado)
	local playerVehicle = getPedOccupiedVehicle(localPlayer)
	if(playerVehicle and activado == true) then
		for i,v in pairs(getElementsByType("vehicle")) do
			setElementCollidableWith(v, playerVehicle, false)
		end
	end
end

function objetoConDimension(idObj,Pox,Poy,Poz,Rox,Roy,Roz)
local dimJugObj = getElementData(localPlayer,"DimGaraje")
local devolObj = createObject(idObj,Pox,Poy,Poz,Rox,Roy,Roz)
setElementDimension(devolObj,dimJugObj)
return devolObj
end

function vehiculoConDimension(idVeh,Pox,Poy,Poz,Rox,Roy,Roz)
local dimJugObj = getElementData(localPlayer,"DimGaraje")
local devolVeh = createVehicle(idVeh,Pox,Poy,Poz,Rox,Roy,Roz)
setElementDimension(devolVeh,dimJugObj)
return devolVeh
end

function pedConDimension(idSkin,Psx,Psy,Psz,rotP)
local dimJugObj = getElementData(localPlayer,"DimGaraje")
local devolPed = createPed(idSkin,Psx,Psy,Psz,rotP)
setElementDimension(devolPed,dimJugObj)
return devolPed
end

function markerConDimension(Pmx, Pmy, Pmz)
local dimJugObj = getElementData(localPlayer,"DimGaraje")
local devolMark = createMarker (Pmx, Pmy, Pmz, "cylinder",1, 227, 13, 13, 255 )
setElementDimension(devolMark,dimJugObj)
return devolMark
end

function replaceModel() 
  txd = engineLoadTXD("supergt.txd", 506 )
  engineImportTXD(txd, 506)
  dff = engineLoadDFF("supergt.dff", 506 )
  engineReplaceModel(dff, 506)
end
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), replaceModel)

