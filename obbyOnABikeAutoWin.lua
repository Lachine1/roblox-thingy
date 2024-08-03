local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local AutoWin = true -- will become false
local Delay = 0.12
local Key = "hi this is the key"
local EnteredKey = ""
local function GetCharacter()
    while not game.Players.LocalPlayer.Character do
        task.wait()
    end
    return game.Players.LocalPlayer.Character
end
local Root = GetCharacter().PrimaryPart
local RestartPortal = workspace.WorldMap.RestartPortal.Teleport
local Checkpoints = workspace.WorldMap.Checkpoints
local Window = Fluent:CreateWindow({
    Title = "Auto win",
    SubTitle = "by @gfhy",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.O -- Used when theres no MinimizeKeybind
})
local AutoWinTab = Window:AddTab({ Title = "Auto-win (TYPE KEY HERE)", Icon = "crown" })
local MiscTab = Window:AddTab({ Title = "Misc", Icon = "settings-2" })
AutoWinTab:AddParagraph({
        Title = "Press O to close",
        Content = ""
    })
local AutoWinToggle = AutoWinTab:AddToggle("AutoWinToggle", {Title = "Toggle", Default = false })
AutoWinToggle:OnChanged(function()
    AutoWin = not AutoWin
end)
local KeyInput = AutoWinTab:AddInput("KeyInput", {
    Title = "Key",
    Default = "",
    Placeholder = "Enter key",
    Numeric = false, -- Only allows numbers
    Finished = false, -- Only calls callback when you press enter
    Callback = function(Value)
        EnteredKey = Value
    end
})
MiscTab:AddButton({
    Title = "Remove all annoyances (REJOIN TO UNDO)",
    Description = "This includes knives, kill bricks, balls and bouncers",
    Callback = function()
        if Key == EnteredKey then
        workspace.WorldMap.MapInteractables.KillBricks:Destroy()
        workspace.WorldMap.MapInteractables.KillSwings:Destroy()
        workspace.WorldMap.MapInteractables.Knives:Destroy()
        workspace.WorldMap.MapInteractables.MovingKillBricks:Destroy()
        workspace.WorldMap.MapInteractables.BoxingGloves:Destroy()
        workspace.WorldMap.MapInteractables.SpinningKillBricks:Destroy()
        workspace.WorldMap.MapInteractables.SwingingBalls:Destroy()
        workspace.WorldMap.MapInteractables.SwingingBalls:Destroy()
        workspace.WorldMap.MapInteractables.Bouncers:Destroy()
        end
    end
})
MiscTab:AddButton({
    Title = "Insta-win",
    Description = "Teleports you to the last checkpoint",
    Callback = function()
        if Key == EnteredKey then
        local Root = GetCharacter().PrimaryPart
        Root.CFrame = Checkpoints[#Checkpoints:GetChildren()].Base.CFrame
        end
    end
})
while true do
    for CheckpointNum=1,#Checkpoints:GetChildren() do
		local Root = GetCharacter().PrimaryPart
        if AutoWin and Root and EnteredKey == Key then
            local checkpointBase = Checkpoints[CheckpointNum].Hitbox
            if checkpointBase then
                Root.CFrame = checkpointBase.CFrame
                task.wait(Delay)
            end
        end
    end
    if RestartPortal and Root and AutoWin and EnteredKey == Key then
		local Root = GetCharacter().PrimaryPart
		task.wait(0.5)
        Root.CFrame = RestartPortal.CFrame
		task.wait(2)
    end
    task.wait()
end