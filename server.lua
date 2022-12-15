AyseCore = exports["Ayse_Core"]:GetCoreObject()

RegisterServerEvent('pay')
AddEventHandler('pay', function(price)
	local player = source 
	AyseCore.Functions.DeductMoney(price, player, "cash")
end)
