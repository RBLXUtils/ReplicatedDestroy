-- ReplicatedDestroy.lua

local RunService = game:GetService("RunService")
local IsClient: boolean = RunService:IsClient()

local Remote: RemoteEvent do
	if IsClient then
		Remote = script:WaitForChild("Replicator") :: RemoteEvent

		Remote.OnClientEvent:Connect(game.Destroy)
	else
		Remote = Instance.new("RemoteEvent")
		Remote.Name = "Replicator"

		Remote.Parent = script
	end
end

if IsClient == false then
	return function(instance: Instance)
		assert(
			typeof(instance) == 'Instance',
			"Must be instance"
		)

		instance:Destroy()
		Remote:FireAllClients(instance)
	end
else
	return game.Destroy
end
