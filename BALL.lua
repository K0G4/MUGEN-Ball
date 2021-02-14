local cam = workspace.CurrentCamera
local plr = game.Players.LocalPlayer.Character
local plrm = game.Players.LocalPlayer:GetMouse()
--local hat = plr["SparkleWings"]
local hat = plr["Space Cop"]
local base = Instance.new("Part", plr)
--base.CanCollide = true
plr["Space Cop"].Handle.Mesh:Destroy()
base.Position = plr.HumanoidRootPart.Position
base.Shape = 0
base.Size = Vector3.new(1.65,1.65,1.65)
base.CustomPhysicalProperties = PhysicalProperties.new(100, 100, 0.7, 100, 100)  --3rd at 0.7 for bouncy
base.Anchored = true
base.Transparency = 1
base.Massless = true
hat.Handle.Massless = true
--hat.Handle.Mesh:Destroy()
hat.Handle.AccessoryWeld:Destroy()
local at1 = Instance.new("Attachment", base)
local at2 = Instance.new("Attachment", hat.Handle)

wait(0.3)
local plp = Instance.new("AlignPosition", base)
plp.Attachment0 = at2
plp.Attachment1 = at1
plp.Responsiveness = 999999999999
plp.MaxForce = 999999999999
local alp = Instance.new("AlignOrientation", base)
alp.Attachment0 = at2
alp.Attachment1 = at1
alp.Responsiveness = 999999999999
alp.MaxTorque = 999999999999


local bin = Instance.new("Tool")
bin.Name = "Roll"
bin.ToolTip = "FUCKING ROLL"
bin.TextureId = "http://www.roblox.com/asset/?id=5908531015"
bin.RequiresHandle = false
bin.Parent = game.Players.LocalPlayer.Backpack

local LocalPlayer = game:GetService("Players").LocalPlayer
local waitplr = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local raycastpara = RaycastParams.new()
raycastpara.FilterType = Enum.RaycastFilterType.Blacklist
raycastpara.FilterDescendantsInstances = { waitplr }
local Ball = base
local nil1 = nil
local RunService = game:GetService("RunService")
local Humanoid = waitplr:WaitForChild("Humanoid")
local UserInputService = game:GetService("UserInputService")
local nil2 = nil
bin.Equipped:Connect(function()
	if not nil1 then
	    cam.CameraSubject = base
	    base.Anchored = false
	    for _,v in pairs(plr:GetChildren()) do
	        if v.ClassName == "Part" or v.ClassName == "MeshPart" then
	            if v.Name == "Part" == false then
	                v.Anchored = true
	            end
	        end
	    end
	   hat.Handle.Position = base.Position
		nil1 = RunService.RenderStepped:Connect(function(val)
			if UserInputService:GetFocusedTextBox() then
				return
			end
			if UserInputService:IsKeyDown("W") then
				base.RotVelocity = base.RotVelocity - cam.CFrame.RightVector*val*55
			end
			if UserInputService:IsKeyDown("A") then
				base.RotVelocity = base.RotVelocity - cam.CFrame.LookVector*val*55
			end
			if UserInputService:IsKeyDown("S") then
				base.RotVelocity = base.RotVelocity + cam.CFrame.RightVector*val*55
			end
			if UserInputService:IsKeyDown("D") then
				base.RotVelocity = base.RotVelocity + cam.CFrame.LookVector*val*55
			end
			base.RotVelocity = base.RotVelocity - Vector3.new(0, base.RotVelocity.Y/100,0)
		end)
	end
	if not nil2 then
		nil2 = UserInputService.JumpRequest:Connect(function()
			if workspace:Raycast(Ball.Position, Vector3.new(0,-(Ball.Size.Y/2+0.3),0),raycastpara) then
				base.Velocity = base.Velocity+Vector3.new(0,35,0) --60
			end
		end)
	end
	Ball.CFrame = base.CFrame
	Ball.RotVelocity = Vector3.new(0,0,0)
	Ball.Orientation = base.Orientation
end)
bin.Unequipped:Connect(function()
	cam.CameraSubject = Humanoid
	for _,v in pairs(plr:GetChildren()) do
	        if v.ClassName == "Part" or v.ClassName == "MeshPart" then
	           v.Anchored = false
	        end
	end
    base.Anchored = true
	if nil1 then
		nil1:Disconnect()
		nil1 = nil
	end
	if nil2 then
		nil2:Disconnect()
		nil2 = nil
	end
	Ball.Velocity = Vector3.new(0,0,0)
	Ball.RotVelocity = Vector3.new(0,0,0)
end)
Humanoid.Died:Connect(function()
	if nil1 then
		nil1:Disconnect()
	end
	if nil2 then
		nil2:Disconnect()
	end
end)

plrm.KeyDown:Connect(function(key)
    if key == "e" then
        base.Anchored = true
        Ball.Velocity = Vector3.new(0,0,0)
	    Ball.RotVelocity = Vector3.new(0,0,0)
    elseif key == "q" then
        base.Anchored = false
    end
end)