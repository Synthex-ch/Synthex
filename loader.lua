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
end
