-- ReplicatedDestroy.lua

local RunService = game:GetService("RunService")
local IsServer: boolean = RunService:IsServer()
local IsClient: boolean = not IsServer

local Remote: RemoteEvent do
	if IsClient then
		Remote = script:WaitForChild("Replicator")

		Remote.OnClientEvent:Connect(function(instance: Instance)
			if instance == nil then
				return
			end

			instance:Destroy()
		end)
	else
		Remote = Instance.new("RemoteEvent")
		Remote.Name = "Replicator"

		Remote.Parent = script
	end
end

-- Destroys an instance, replicating such destroy to the client,
-- telling such client that that instance must be destroyed on the
-- client side as well, helps with memory leaks when using replicated Instances
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
