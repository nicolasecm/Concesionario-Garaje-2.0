addEventHandler("onPlayerLogin", root, 
function ()
	setElementData (source, "Cuenta", getAccountName(getPlayerAccount(source)))
	setTimer (function (source)
		local se = getElementData(source, "DimGaraje")
		local cG = getElementData(source, "CantGaraje")
		local cvG = getElementData(source, "CantVehGaraje")
		local cvC = getElementData(source, "CantVehComprados")
		local cvEG = getElementData(source, "CantVehEnGaraje")
		local iDG = getElementData(source, "idGarajeP")
		local osj = getElementData(source, "SerialJugador")
		if se and tonumber(se) ~= nil then else
			setElementData  (source, "DimGaraje", 0)
		end
		if cG and tonumber(cG) ~= nil then else
			setElementData  (source, "CantGaraje", 0)
		end
		if cvG and tonumber(cvG) ~= nil then else
			setElementData  (source, "CantVehGaraje", 0)
		end
		if cvC and tonumber(cvC) ~= nil then else
			setElementData  (source, "CantVehComprados", 0)
		end
		if iDG and tonumber(iDG) ~= nil then else
			setElementData  (source, "idGarajeP", 0)
		end
		if osj and tonumber(osj) ~= nil then else
			setElementData  (source, "SerialJugador", "")
		end
		if cvEG and tonumber(cvEG) ~= nil then else
			setElementData  (source, "CantVehEnGaraje", 0)
		end
		triggerClientEvent (source, "iniciarPanelInfoVeh", source)
	end, 1000, 1, source)
end)

function playerLoginFre (thePreviousAccount, theCurrentAccount, autoLogin)
  if  not (isGuestAccount (getPlayerAccount (source))) then
    local accountData = getAccountData (theCurrentAccount, "funmodev2-money")
    if (accountData) then
		local DimGaraje = getAccountData(theCurrentAccount,"DimGaraje")
		setElementData(source,"DimGaraje",DimGaraje)
		local CantGaraje = getAccountData(theCurrentAccount,"CantGaraje")
		setElementData(source,"CantGaraje",CantGaraje)
		local CantVehGaraje = getAccountData(theCurrentAccount,"CantVehGaraje")
		setElementData(source,"CantVehGaraje",CantVehGaraje)
		local CantVehComprados = getAccountData(theCurrentAccount,"CantVehComprados")
		setElementData(source,"CantVehComprados",CantVehComprados)
		local idGarajeP = getAccountData(theCurrentAccount,"idGarajeP")
		setElementData(source,"idGarajeP",idGarajeP)
		local SerialJugador = getAccountData(theCurrentAccount,"SerialJugador")
		setElementData(source,"SerialJugador",SerialJugador)
		local CantVehEnGaraje = getAccountData(theCurrentAccount,"CantVehEnGaraje")
		setElementData(source,"CantVehEnGaraje",CantVehEnGaraje)
	else
    end   
  end
end
addEventHandler ("onPlayerLogin", getRootElement(), playerLoginFre)

function onLogout ()
	kickPlayer (source, nil, "Logging out is disallowed.")
end
addEventHandler ("onPlayerLogout", getRootElement(), onLogout)

function onQuitFre (quitType, reason, responsibleElement)
  if not (isGuestAccount (getPlayerAccount (source))) then
    account = getPlayerAccount (source)
    if (account) then
		setAccountData (account, "funmodev2-money", tostring (getPlayerMoney (source)))
		local DimGaraje = getElementData(source,"DimGaraje")
		setAccountData (account,"DimGaraje",DimGaraje)
		local CantGaraje = getElementData(source,"CantGaraje")
		setAccountData (account,"CantGaraje",CantGaraje)
		local CantVehGaraje = getElementData(source,"CantVehGaraje")
		setAccountData (account,"CantVehGaraje",CantVehGaraje)
		local CantVehComprados = getElementData(source,"CantVehComprados")
		setAccountData (account,"CantVehComprados",CantVehComprados)
		local idGarajeP = getElementData(source,"idGarajeP")
		setAccountData (account,"idGarajeP",idGarajeP)
		local SerialJugador = getElementData(source,"SerialJugador")
		setAccountData (account,"SerialJugador",SerialJugador)
		local CantVehEnGaraje = getElementData(source,"CantVehEnGaraje")
		setAccountData (account,"CantVehEnGaraje",CantVehEnGaraje)
	end
  end
end
addEventHandler ("onPlayerQuit", getRootElement(), onQuitFre)
