--
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)

for _, folder in pairs({'Synthex', 'Synthex/Key'}) do
    if not isfolder(folder) then
        makefolder(folder)
    end
end

if table.find({92416421522960}, game.PlaceId) then -- SLIME RNG
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Synthex-ch/Synthex/refs/heads/main/Places/Slime%20RNG/init.lua"))()
elseif table.find({89469502395769}, game.PlaceId) then -- KICK A LUCKY BLOCK
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Synthex-ch/Synthex/refs/heads/main/Places/Kick%20A%20Lucky%20Block/init.lua"))()
end
