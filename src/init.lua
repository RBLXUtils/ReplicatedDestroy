-- ReplicatedDestroy.lua

local RunService = game:GetService("RunService")
local IsServer: boolean = RunService:IsServer()
local IsClient: boolean = not IsServer


local Remote: RemoteEvent do
	if IsClient then
		Remote = script:WaitForChild("Replicator")

		Remote.OnClientEvent:Connect(game.Destroy)
	else
		Remote = Instance.new("RemoteEvent")
		Remote.Name = "Replicator"

		Remote.Parent = script
	end
end


return function(instance: Instance)
	assert(
		typeof(instance) == 'Instance',
		"Must be instance"
	)

	instance:Destroy()
	if IsServer then
		Remote:FireAllClients(instance)
	end
end
