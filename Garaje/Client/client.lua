marcador1 = createMarker ( 548.576171875, -1291.8701171875, 16.248237609863, "cylinder", 2.0,  255, 0, 0, 255)
blip1 = createBlip ( 548.576171875, -1291.8701171875, 17.248237609863, 55, 2, 255,0,0, 255,0, 200)
local ComprobarUsuario = 0
local darDimensionCreada = 0
vehiclesTable = {
	{ "Super GT", 10000,506},
	{ "Windsor", 22200,555 },
	{ "Infernus", 80000,411},
	{ "Sanchez", 30000,468},
	{ "Phoenix", 90000,603}
}

local sx,sy = guiGetScreenSize()
local px,py = 1360,768
local x,y =  (sx/px), (sy/py)

function iniciarPanelInfoVeh()
setTimer ( function()
		panelVerInfoVehiculosFull()
		destruirPanelInfoVeh()
	end , 1000 , 1 )
end
addEvent( "iniciarPanelInfoVeh", true)
addEventHandler( "iniciarPanelInfoVeh", getRootElement(), iniciarPanelInfoVeh)

addCommandHandler("reipa",iniciarPanelInfoVeh)

function panelRegitroUsuario()
	triggerServerEvent( "obtenerDimensionSql", localPlayer,localPlayer)
	VentanaRegVeh = guiCreateWindow(x*520, y*195, x*295, y*277, "Registro de usuario", false)
    guiWindowSetSizable(VentanaRegVeh, false)

    BotonAceptar = guiCreateButton(x*35, y*192, x*100, y*52, "Aceptar", false, VentanaRegVeh)
    BotonSalir = guiCreateButton(x*162, y*192, x*100, y*52, "Salir", false, VentanaRegVeh)
	MemoVentReg = guiCreateMemo(x*36, y*37, x*226, y*133, "Hola Esta es la primera vez que vienes a comprar un vehiculo, registrate para obtener tus datos y asi poder hacer los papeles de los vehiculos que quieres a tu nombre", false, VentanaRegVeh)
    guiMemoSetReadOnly(MemoVentReg, true)
	
	showCursor(true)
	addEventHandler("onClientGUIClick", BotonAceptar, UsuarioRegistrado, false)
	addEventHandler("onClientGUIClick", BotonSalir, salirReg1, false)
end

function panelVerInfoVehiculosFull()
    panelVerInfoVehiculos = guiCreateWindow(x*336, y*172, x*621, y*358, "Informacion Vehiculos", false)
    guiWindowSetSizable(panelVerInfoVehiculos, false)

    gridInfoVehi = guiCreateGridList(x*20, y*39, x*477, y*301, false, panelVerInfoVehiculos)
    guiGridListAddColumn(gridInfoVehi, "ID", 0.1)
    guiGridListAddColumn(gridInfoVehi, "Nombre vehiculo", 0.2)
    guiGridListAddColumn(gridInfoVehi, "Estado Vehiculo", 0.2)
    guiGridListAddColumn(gridInfoVehi, "Precio", 0.2)
	guiGridListAddColumn(gridInfoVehi, "Vida Vehiculo", 0.2)
    BotonSalir = guiCreateButton(x*511, y*155, x*100, y*51, "Salir", false, panelVerInfoVehiculos)  
	triggerServerEvent( "listaVehiculos", localPlayer )
	
	addEventHandler("onClientGUIClick", BotonSalir, colorSito, false)
	
	repeat until bindKey("F4","down",function()
		togglePanel(not guiGetVisible(panelVerInfoVehiculos))
	end )
end

function colorSito()
	if (colorPicker.isSelectOpen) or not isElement(veh) then return end -- veh = veículo que vc quer pintar no seu script.
	colorPicker.openSelect()
end

function MostrarCarrosPanel( Table )
	guiGridListClear( gridInfoVehi )
		for i, _ in ipairs( Table ) do 
			local item = guiGridListAddRow( gridInfoVehi )
			guiGridListSetItemText( gridInfoVehi, item, 1, Table[i].id, false, false )
			guiGridListSetItemText( gridInfoVehi, item, 2, Table[i].nombre_veh, false, false )
			if Table[i].id_gara ~= 0 then
				guiGridListSetItemText( gridInfoVehi, item, 3, "En Garaje", false, false )
			else
				guiGridListSetItemText( gridInfoVehi, item, 3, "Sin Garaje", false, false )
			end
			guiGridListSetItemText( gridInfoVehi, item, 4, "$"..Table[i].precio, false, false )
			guiGridListSetItemText( gridInfoVehi, item, 5, Table[i].vida.."%", false, false )
		end
end
addEvent( "MostrarCarrosPanel", true )
addEventHandler( "MostrarCarrosPanel", root, MostrarCarrosPanel )

addEvent( "limpiarLista", true ) addEventHandler( "limpiarLista", root, function(  ) guiGridListClear( gridInfoVehi ) end )

function panelAgregarGaraje()
	triggerServerEvent( "obtenerDimensionSql", localPlayer,localPlayer)
	VentanaRegGara = guiCreateWindow(x*520, y*195, x*295, y*277, "Registrar Garaje", false)
    guiWindowSetSizable(VentanaRegGara, false)

    BotonAceptarGa = guiCreateButton(x*35, y*192, x*100, y*52, "Aceptar", false, VentanaRegGara)
	MemoVentReg = guiCreateMemo(x*36, y*37, x*226, y*133, "Ya que tenemos tus datos registrados, de parte del servidor te queremos regalar un garaje para que puedas guardar unos vehiculos, esperamos te sirvan", false, VentanaRegGara)
    guiMemoSetReadOnly(MemoVentReg, true)
	
	showCursor(true)
	addEventHandler("onClientGUIClick", BotonAceptarGa, GarajeRegistrado, false)
	addEventHandler("onClientGUIClick", BotonAceptarGa, salirReg2, false)	
end

function panelComprarVehiculo()
	triggerServerEvent( "obtenerDimensionSql", localPlayer,localPlayer)
	triggerServerEvent( "obtenerCantMaxVehSql", localPlayer,localPlayer)
	triggerServerEvent( "obtenerCantMaxVehComp", localPlayer,localPlayer)
	triggerServerEvent( "obtenerIdGarajeSql", localPlayer,localPlayer)
	
    VentanaComprarVeh = guiCreateWindow(x*31, y*106, x*243, y*503, "Compra de Vehiculos", false)
    guiWindowSetSizable(VentanaComprarVeh, false)

    BotonAceptarCompVeh = guiCreateButton(x*22, y*439, x*95, y*43, "Comprar", false, VentanaComprarVeh)
    BotonSalirCompVeh = guiCreateButton(x*127, y*439, x*95, y*43, "Salir", false, VentanaComprarVeh)
    gridListaCompVeh = guiCreateGridList(x*22, y*29, x*200, y*393, false, VentanaComprarVeh)
    guiGridListAddColumn(gridListaCompVeh, "id", 0.3)
    guiGridListAddColumn(gridListaCompVeh, "Nombre Veh", 0.3)
    guiGridListAddColumn(gridListaCompVeh, "Precio", 0.3)
	
    VentanaSeleccionColor = guiCreateWindow(1100, 550, 222, 120, "Seleccionar Color Vehiculo", false)
    guiWindowSetSizable(VentanaSeleccionColor, false)
    guiSetAlpha(VentanaSeleccionColor, 0.60)

    scolorAzul = guiCreateStaticImage(20, 33, 34, 32, ":Garaje/Img/pcompra/c_azul.png", false, VentanaSeleccionColor)
    scolorGris = guiCreateStaticImage(71, 34, 35, 32, ":Garaje/Img/pcompra/c_gris.png", false, VentanaSeleccionColor)
    scolorAguaM = guiCreateStaticImage(123, 35, 35, 31, ":Garaje/Img/pcompra/c_aguam.png", false, VentanaSeleccionColor)
    scolorNegro = guiCreateStaticImage(20, 76, 34, 31, ":Garaje/Img/pcompra/c_negro.png", false, VentanaSeleccionColor)
    scolorVerde = guiCreateStaticImage(123, 76, 36, 31, ":Garaje/Img/pcompra/c_verde.png", false, VentanaSeleccionColor)
    scolorRojo = guiCreateStaticImage(71, 76, 35, 30, ":Garaje/Img/pcompra/c_rojo.png", false, VentanaSeleccionColor)
    scolorBlanco = guiCreateStaticImage(176, 76, 36, 31, ":Garaje/Img/pcompra/c_blanco.png", false, VentanaSeleccionColor)
    scolorAmarillo = guiCreateStaticImage(176, 36, 36, 30, ":Garaje/Img/pcompra/c_amarillo.png", false, VentanaSeleccionColor)    

	cargarVehiculosVenta()
	
	setCameraMatrix(557.18255615234, -1280.8576660156, 18.220977783203, 630.66534423828, -1344.9049072266, -4.0998935699463)
	
	showCursor(true)
	addEventHandler("onClientGUIClick", BotonAceptarCompVeh, ComprarVehiculo, false)
	addEventHandler("onClientGUIClick", gridListaCompVeh, verVehiculo, false)
	addEventHandler("onClientGUIClick", BotonAceptarCompVeh, salirVentC1, false)
	addEventHandler("onClientGUIClick", BotonSalirCompVeh, salirVentC1, false)
	addEventHandler("onClientGUIClick", scolorAzul, colAzulMod, false)
	addEventHandler("onClientGUIClick", scolorGris, colGrisMod, false)
	addEventHandler("onClientGUIClick", scolorAguaM, colAguaMMod, false)
	addEventHandler("onClientGUIClick", scolorNegro, colNegroMod, false)
	addEventHandler("onClientGUIClick", scolorVerde, colVerdeMod, false)
	addEventHandler("onClientGUIClick", scolorRojo, colRojoMod, false)
	addEventHandler("onClientGUIClick", scolorBlanco, colBlancoMod, false)
	addEventHandler("onClientGUIClick", scolorAmarillo, colAmarilloMod, false)
end

function colAzulMod()
	triggerServerEvent( "cambiarColorVehVista", localPlayer,0,163,232 )
end
function colGrisMod()
	triggerServerEvent( "cambiarColorVehVista", localPlayer,127,127,127 )
end
function colAguaMMod()
	triggerServerEvent( "cambiarColorVehVista", localPlayer,66,247,250)
end
function colNegroMod()
	triggerServerEvent( "cambiarColorVehVista", localPlayer,0,0,0 )
end
function colVerdeMod()
	triggerServerEvent( "cambiarColorVehVista", localPlayer,35,177,77 )
end
function colRojoMod()
	triggerServerEvent( "cambiarColorVehVista", localPlayer,235,5,17 )
end
function colBlancoMod()
	triggerServerEvent( "cambiarColorVehVista", localPlayer,255,255,255 )
end
function colAmarilloMod()
	triggerServerEvent( "cambiarColorVehVista", localPlayer,255,242,0 )
end

function cargarVehiculosVenta()
guiGridListClear( gridListaCompVeh )
for _, vehiculo in ipairs( vehiclesTable ) do
	local item = guiGridListAddRow( gridListaCompVeh )
	local cI = guiGridListSetItemText( gridListaCompVeh, item, 1, vehiculo[3], false, false )
	local cN = guiGridListSetItemText( gridListaCompVeh, item, 2, vehiculo[1], false, false )
	local cP = guiGridListSetItemText( gridListaCompVeh, item, 3, vehiculo[2], false, false )
end
end

function GarajeRegistrado()
triggerServerEvent ( "AgregarGarajeNuevo", getLocalPlayer(),getLocalPlayer())
end

function verVehiculo()
	local row = guiGridListGetSelectedItem(gridListaCompVeh)
	if (not row or row == -1) then return end
	local id = guiGridListGetItemText(gridListaCompVeh, row, 1)
	id = tonumber(id)
	if (not id) then return end
	local dimensionfull = getElementData(localPlayer,"DimGaraje")
	triggerServerEvent( "verVehiculoComp", localPlayer,id, dimensionfull)
	setElementDimension(localPlayer,dimensionfull)
end

function ComprarVehiculo()
	local row = guiGridListGetSelectedItem(gridListaCompVeh)
	if (not row or row == -1) then return end
	local id = guiGridListGetItemText(gridListaCompVeh, row, 1)
	id = tonumber(id)
	local nombre = guiGridListGetItemText(gridListaCompVeh, row, 2)
	local precio = guiGridListGetItemText(gridListaCompVeh, row, 3)
	precio = tonumber(precio)
	local cantidadDinero = getPlayerMoney()
	local mayorCantGaraje = getElementData(getLocalPlayer(),"CantVehGaraje")
	local cantComprados = getElementData(getLocalPlayer(),"CantVehComprados")
	if (cantComprados < mayorCantGaraje)then
		if (cantidadDinero>=precio) then
			triggerServerEvent ( "quitarPlataServerVeh", getLocalPlayer(),precio)
			triggerServerEvent( "comprarVehiculoAg", getLocalPlayer(),id, nombre,precio)
			outputChatBox("[Consecionario]#ffffffFelicitaciones Compraste un Vehiculo Nuevo, lo encontraras en tu garaje", 227, 13, 13,true)	
		else
			outputChatBox("[Consecionario]#ffffffNo tienes la cantidad de dinero suficiente para comprar este vehiculo", 227, 13, 13,true)	
		end
	else
		outputChatBox("[Consecionario]#ffffffMejora tu Garaje para poder comprar mas vehiculos", 227, 13, 13,true)	
	end
	showCursor(false)
end

function UsuarioRegistrado ()
	triggerServerEvent ( "AgregarUsuarioVeh", getLocalPlayer(),getLocalPlayer())
	destroyElement(VentanaRegVeh)
	panelAgregarGaraje()
end

function getAccountName(p)
	return getElementData(p,"Cuenta") or false
end

function togglePanel(Vis)
		if Vis == false then
			guiSetVisible(panelVerInfoVehiculos,false)
			showCursor(false)
			guiSetInputMode("allow_binds")
		else
			if getAccountName(localPlayer) ~= false then
				guiSetVisible(panelVerInfoVehiculos,true)
				showCursor(true)
				guiSetInputMode("no_binds_when_editing")
			else
				outputChatBox("Usted debe estar logueado para abrir el panel!")
			end
		end
end

function destruirPanelInfoVeh()
	showCursor(false)
	guiSetVisible(panelVerInfoVehiculos,false)
end

function salirVentC1()
	showCursor(false)
	destroyElement(VentanaComprarVeh)
	destroyElement(VentanaSeleccionColor)
	setCameraTarget (getLocalPlayer())
	setElementDimension(localPlayer,0)
	triggerServerEvent ( "eliminarVehiculoSalir", getLocalPlayer()) 
end

function salirReg1()
	showCursor(false)
	destroyElement(VentanaRegVeh)
end

function salirReg2()
	showCursor(false)
	destroyElement(VentanaRegGara)
end

function entrarMarcadorVeh(hitElement)
triggerServerEvent ( "ComprobarUsuarioVeh", getLocalPlayer(),getLocalPlayer())
	setTimer ( function()
		ComprobarUsuario = getElementData(hitElement,"valUsuVehiculp")
		if(isPedInVehicle (getLocalPlayer()))then
			outputChatBox("[Consecionario]#ffffffEstas en un vehiculo no puedes entrar", 227, 13, 13,true)	
		else
		if(ComprobarUsuario == 1)then
			panelRegitroUsuario()
		else
			panelComprarVehiculo()
		end
		end
	end, 500, 1 )
end
addEventHandler("onClientMarkerHit", marcador1, entrarMarcadorVeh)

function getOptCameraMatrix()
	local x, y, z, lx, ly, lz = getCameraMatrix ()
    outputChatBox(x..", "..y..", "..z..", "..lx..", "..ly..", "..lz..", ")
end

addCommandHandler("obtam", getOptCameraMatrix)
