local db = dbConnect("sqlite", "BaseDatos/datosVehiculos.db")
local VehiculoVista = si;
local r,g,b = 255,255,255

vehiculoPropio = {}

function ComprobarUsuarioVeh(sourcePlayer)
serial = getPlayerSerial (sourcePlayer)
local resultado = dbPoll(dbQuery(db, "SELECT * FROM Usuarios WHERE serial=?", serial),-1)
valorCompro = 0
if #resultado == 0 then
	valorCompro = 1
else
	valorCompro = 0
end
setElementData(sourcePlayer,"valUsuVehiculp",valorCompro)
end
addEvent( "ComprobarUsuarioVeh", true)
addEventHandler( "ComprobarUsuarioVeh", getRootElement(), ComprobarUsuarioVeh)

function verVehiculoComp(ID, dimensionVehCl)
	if(isElement(VehiculoVista))then
		destroyElement(VehiculoVista)
		VehiculoVista = createVehicle( ID, 561.9169921875, -1285.306640625, 17.248237609863, 0, 0, 0 )
		setElementDimension(VehiculoVista, dimensionVehCl)
	else
		VehiculoVista = createVehicle( ID, 561.9169921875, -1285.306640625, 17.248237609863, 0, 0, 0 )
		setElementDimension(VehiculoVista, dimensionVehCl)
	end
end
addEvent( "verVehiculoComp", true )
addEventHandler( "verVehiculoComp", root, verVehiculoComp )

function crearVehiculoExterior(idVeh,cr,cg,cb,vidaVeh,idTablaVeh)
	if (isElement(vehiculoPropio[source])) then 
		outputChatBox("[Garaje]#ffffffSolo puedes tener un vehiculo afuera", source,255,13,13,true)
    return end 
	vehiculoPropio[source] = createVehicle(idVeh,908.4443359375, -1210.7724609375, 16.9765625)
	setVehicleColor(vehiculoPropio[source],cr,cg,cb)
	setElementHealth(vehiculoPropio[source],vidaVeh*10)
	serial = getPlayerSerial ( source )
	setElementData(vehiculoPropio[source],"dueno",serial)
	setElementData(vehiculoPropio[source],"idAsigBase",idTablaVeh)
	warpPedIntoVehicle(source,vehiculoPropio[source],0)
	setElementDimension(source, 0)
	actualizarListaVehiculoSalidaGaraje(idTablaVeh)
	triggerClientEvent("SalirGarajeConVehiculo",source,source)
end
addEvent( "crearVehiculoExterior", true )
addEventHandler( "crearVehiculoExterior", root, crearVehiculoExterior )

function obtenerSerialUsuario(sourcePlayer)
 	local serial = getPlayerSerial ( sourcePlayer )
	setElementData(sourcePlayer,"SerialJugador",serial)
end
addEvent( "obtenerSerialUsuario", true )
addEventHandler( "obtenerSerialUsuario", root, obtenerSerialUsuario )

function actualizarListaVehiculoSalidaGaraje(idVehi)
dbExec (db,"UPDATE Vehiculos set id_gara = 0 where id=?",idVehi )
end
addEvent( "actualizarListaVehiculoSalidaGaraje", true )
addEventHandler( "actualizarListaVehiculoSalidaGaraje", root, actualizarListaVehiculoSalidaGaraje )

function actualizarListaVehiculoEntradaGaraje(sourcePlayer,idVehi,cantVid)
local idGar = getElementData(sourcePlayer,"idGarajeP")
dbExec (db,"UPDATE Vehiculos set id_gara = ?, vida = ? where id=?",idGar,cantVid, idVehi)
end
addEvent( "actualizarListaVehiculoEntradaGaraje", true )
addEventHandler( "actualizarListaVehiculoEntradaGaraje", root, actualizarListaVehiculoEntradaGaraje )

function cambiarColorVehVista(zr,zg,zb)
	if(isElement(VehiculoVista))then
		r,g,b = zr,zg,zb
		setVehicleColor(VehiculoVista,r,g,b)
	else
	end
end
addEvent( "cambiarColorVehVista", true )
addEventHandler( "cambiarColorVehVista", root, cambiarColorVehVista )

function quitarPlataServerVeh (total)
	takePlayerMoney ( source,total )
end
addEvent( "quitarPlataServerVeh", true)
addEventHandler( "quitarPlataServerVeh", getRootElement(), quitarPlataServerVeh)

function obtenerDimensionSql(source)
	serial = getPlayerSerial (source)
	identificador_usu = 0
	local dimensionVeh = dbPoll(dbQuery(db, "SELECT id_usu FROM Usuarios WHERE serial=?", serial),-1)
	for sid, statementResult in ipairs ( dimensionVeh ) do
    local resultRows, num_affected_rows, last_insert_id =  unpack(statementResult) 
    for rid, row in ipairs ( dimensionVeh ) do 
	 for column, value in pairs ( row ) do
	      identificador_usu = value
	end
    end			
	end
	setElementData(source,"DimGaraje", identificador_usu)
end
addEvent( "obtenerDimensionSql", true )
addEventHandler( "obtenerDimensionSql", root, obtenerDimensionSql )

function obtenerIdGarajeSql(source)
	dimGarCa = getElementData(source,"DimGaraje")
	identificador_garS = 0
	local idGaraje = dbPoll(dbQuery(db, "SELECT id_gara FROM Garaje WHERE id_usu=?", dimGarCa),-1)
	for sid, statementResult in ipairs ( idGaraje ) do
    local resultRows, num_affected_rows, last_insert_id =  unpack(statementResult) 
    for rid, row in ipairs ( idGaraje ) do 
	 for column, value in pairs ( row ) do
	      identificador_garS = value
	end
    end			
	end
	setElementData(source,"idGarajeP", identificador_garS)
end
addEvent( "obtenerIdGarajeSql", true )
addEventHandler( "obtenerIdGarajeSql", root, obtenerIdGarajeSql )

function obtenerGarajesSql(source)
	identificador_gara = 0
	odF = obtenerDimensionFunc(source)
	local dimensionGaraj = dbPoll(dbQuery(db, "SELECT count (*) FROM Garaje WHERE id_usu=?", odF),-1)
	for sid, statementResultg in ipairs ( dimensionGaraj ) do
    local resultRows, num_affected_rows, last_insert_id =  unpack(statementResultg) 
    for rid, row in ipairs ( dimensionGaraj ) do 
	 for column, value in pairs ( row ) do
	    identificador_gara = value
	end
    end			
	end
	setElementData(source,"CantGaraje", identificador_gara)
end
addEvent( "obtenerGarajesSql", true )
addEventHandler( "obtenerGarajesSql", root, obtenerGarajesSql )

function obtenerCantMaxVehSql(source)
	identificador_obtGara = 0
	odF = obtenerDimensionFunc(source)
	local dimensionGaraj = dbPoll(dbQuery(db, "SELECT campos_veh FROM Garaje WHERE id_usu=?", odF),-1)
	for sid, statementResultg in ipairs ( dimensionGaraj ) do
    local resultRows, num_affected_rows, last_insert_id =  unpack(statementResultg) 
    for rid, row in ipairs ( dimensionGaraj ) do 
	 for column, value in pairs ( row ) do
	    identificador_obtGara = value
	end
    end			
	end
	setElementData(source,"CantVehGaraje", identificador_obtGara)
end
addEvent( "obtenerCantMaxVehSql", true )
addEventHandler( "obtenerCantMaxVehSql", root, obtenerCantMaxVehSql )

function obtenerCantMaxVehComp(source)
	identificador_obtComprados = 0
	odF = obtenerDimensionFunc(source)
	local dimensionGaraj = dbPoll(dbQuery(db, "SELECT count(*) FROM Vehiculos WHERE id_usua=?", odF),-1)
	for sid, statementResultg in ipairs ( dimensionGaraj ) do
    local resultRows, num_affected_rows, last_insert_id =  unpack(statementResultg) 
    for rid, row in ipairs ( dimensionGaraj ) do 
	 for column, value in pairs ( row ) do
	    identificador_obtComprados = value
	end
    end			
	end
	setElementData(source,"CantVehComprados", identificador_obtComprados)
end
addEvent( "obtenerCantMaxVehComp", true )
addEventHandler( "obtenerCantMaxVehComp", root, obtenerCantMaxVehComp )

function obtenerCantMaxVehEnGarj(source)
	identificador_obtVehEnGarj = 0
	odF = obtenerDimensionFunc(source)
	igM = obtenerIdGarFunc(source)
	local dimensionGaraj = dbPoll(dbQuery(db, "SELECT count(*) FROM Vehiculos WHERE id_usua=? and id_gara=?", odF,igM),-1)
	for sid, statementResultg in ipairs ( dimensionGaraj ) do
    local resultRows, num_affected_rows, last_insert_id =  unpack(statementResultg) 
    for rid, row in ipairs ( dimensionGaraj ) do 
	 for column, value in pairs ( row ) do
	    identificador_obtVehEnGarj = value
	end
    end			
	end
	setElementData(source,"CantVehEnGaraje", identificador_obtVehEnGarj)
end
addEvent( "obtenerCantMaxVehEnGarj", true )
addEventHandler( "obtenerCantMaxVehEnGarj", root, obtenerCantMaxVehEnGarj )

function listaVehiculos()
	obtdimas = obtenerDimensionFunc(source)
	local check = dbQuery( db, "SELECT * FROM Vehiculos where id_usua=?",obtdimas )
	local results = dbPoll( check, -1 )
	if ( type( results ) == "table" and #results == 0 or not results ) then triggerClientEvent( root, "limpiarLista", root ) return end
	triggerClientEvent( root, "MostrarCarrosPanel", root, results )
end
addEvent( "listaVehiculos", true ) 
addEventHandler( "listaVehiculos", root, listaVehiculos )

function ReyenarTablaGara()
	obtdimas = obtenerDimensionFunc(source)
	igMt = obtenerIdGarFunc(source)
	local check = dbQuery( db, "SELECT * FROM Vehiculos where id_usua=? and id_gara=?",obtdimas,igMt )
	local results = dbPoll( check, -1 )
	if ( type( results ) == "table" and #results == 0 or not results ) then triggerClientEvent( root, "limpiarLista", root ) return end
	triggerClientEvent( root, "completarTablaGar", root, results )
end
addEvent( "ReyenarTablaGara", true ) 
addEventHandler( "ReyenarTablaGara", root, ReyenarTablaGara )

function eliminarVehiculoSalir()
	if(isElement(VehiculoVista))then
		destroyElement(VehiculoVista)
	end
end
addEvent( "eliminarVehiculoSalir", true )
addEventHandler( "eliminarVehiculoSalir", root, eliminarVehiculoSalir )

function AgregarUsuarioVeh(sourcePlayer)
serial = getPlayerSerial ( sourcePlayer )
dbExec (db,"INSERT INTO Usuarios(serial) VALUES(?)",serial )
end
addEvent( "AgregarUsuarioVeh", true)
addEventHandler( "AgregarUsuarioVeh", getRootElement(), AgregarUsuarioVeh)

function AgregarGarajeNuevo(source)
local dimganu = obtenerDimensionFunc(source)
dbExec (db,"INSERT INTO Garaje(nombre_gara,id_usu,campos_veh) VALUES(?,?,?)","Garaje Basico Server", dimganu, 4)
end
addEvent( "AgregarGarajeNuevo", true)
addEventHandler( "AgregarGarajeNuevo", getRootElement(), AgregarGarajeNuevo)

function comprarVehiculoAg(idd, nombrev, preciov)
	local dimganu = obtenerDimensionFunc(source)
	local dimGara = obtenerIdGarFunc(source)
	dbExec (db,"INSERT INTO Vehiculos(id_usua,id_vehi,id_gara,nombre_veh,precio,r,g,b,vida) VALUES(?,?,?,?,?,?,?,?,?)", dimganu, idd, dimGara, nombrev, preciov,r,g,b, 100)
	listaVehiculos()
end
addEvent( "comprarVehiculoAg", true )
addEventHandler( "comprarVehiculoAg", root, comprarVehiculoAg )

function destruirVeh(sourcePlayer)
	local vehiculo = getPedOccupiedVehicle(sourcePlayer)
	destroyElement(vehiculo)
end
addEvent( "destruirVeh", true )
addEventHandler( "destruirVeh", root, destruirVeh )

function obtenerDimensionFunc(source)
ve = getElementData(source,"DimGaraje")
return ve
end

function obtenerIdGarFunc(source)
ve = getElementData(source,"idGarajeP")
return ve
end
