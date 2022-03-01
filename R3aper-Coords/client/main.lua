ESX = nil
local display = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		local playerPed = PlayerPedId()
		local playerX, playerY, playerZ = table.unpack(GetEntityCoords(playerPed))
		local playerH = GetEntityHeading(playerPed)

		SendNUIMessage({
			action = 'updateCoords',

			x = round(playerX, 3),
			y = round(playerY, 3),
			z = round(playerZ, 3),
			h = round(playerH, 3)
		})
	end
end)

RegisterCommand("cm", function()
	Citizen.CreateThread(function()
		ToggleMenu()
	end)
end)

RegisterNUICallback("close", function(data)
	ToggleMenu()
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(300)

		if IsPauseMenuActive() and not IsPaused then
			IsPaused = true
			SendNUIMessage({
				action  = 'close'
			})
		elseif not IsPauseMenuActive() and IsPaused then
			IsPaused = false
		end
	end
end)

function ToggleMenu()
	display = not display
	SetNuiFocus(display, display)
	SendNUIMessage({
		action = 'toggle'
	})
end

function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end