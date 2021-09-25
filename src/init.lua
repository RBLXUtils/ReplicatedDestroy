-- Destroy.lua

local RunService = game:GetService("RunService")
local IsClient: boolean = RunService:IsClient()

local Remote: RemoteEvent do
	if IsClient then
		Remote = script:WaitForChild("Replicator")

		Remote.OnClientEvent:Connect(function(instance: Instance)
			instance:Destroy()
		end)
	else
		Remote = Instance.new("RemoteEvent")
		Remote.Name = "Replicator"

		Remote.Parent = script
	end
end

if IsClient then
	return game.Destroy
end

return function(instance: Instance)
	assert(
		typeof(instance) == 'Instance',
		"Must be instance"
	)

	instance:Destroy()
	Remote:FireAllClients(instance)
end
