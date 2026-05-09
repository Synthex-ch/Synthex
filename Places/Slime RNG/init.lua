--[[ 
@Synthex.ch Key System
Wrote by pharmakatussin 08/05/2026
Yes, i write code like shakespear.
]]

-- Cleanup
if getgenv().Library then
    getgenv().Library:Unload()
end

-- Imports 
local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/Synthex-ch/Synthex/refs/heads/main/Storage/Ui.lua'))()
local SDK = loadstring(game:HttpGet('https://sdkapi-public.luarmor.net/library.lua'))()

-- Variables 
SDK.script_id = 'aa097397d3d5792d31a20bdc2fe71cc2'
local RememberKey

-- UI Init
local Window = Library:CreateWindow({
    Title = "Synthex.ch",
    Footer = "Key System",
    Icon = 89357023912063,
    NotifySide = "Right",
    ShowCustomCursor = true,
})

local Tabs = {
    Key_Tab = Window:AddTab("Key", "key", "Key System Tab"),
}


-- Cute Loading UI ( thats why im forcing the task.wait :p)
do
    local Loading = Library:CreateLoading({
        Title = "Synthex",
        Icon = 89357023912063,
        TotalSteps = 3
    })
    
    Loading:SetCurrentStep(1)
    Loading:SetMessage('Initializing...')
    Loading:SetDescription('Waiting for game to load...')
    task.wait(.4)
    if game:GetService('ContentProvider').RequestQueueSize > 10 then repeat task.wait(.5) until game:GetService('ContentProvider').RequestQueueSize <= 15 end -- thx xander

    Loading:SetCurrentStep(2) -- slime rng specific 
    Loading:SetMessage('Verifying Compatibility')
    Loading:SetDescription('')
    task.wait(.4)
    if identifyexecutor():lower():find('solara') or identifyexecutor():lower():find('xeno') then Loading:ShowErrorPage(true) Loading:SetErrorMessage('Incompatible executor, please try switching to another executor!') Loading:SetErrorButtons({ Retry = { Title = 'Unload', Variant = 'Primary', Callback = function() Library:Unload() end } }) return end    

    Loading:SetCurrentStep(3)
    Loading:SetMessage('Verifying files')
    Loading:SetDescription("")
    task.wait(.4)
    if not isfolder('Synthex') then makefolder('Synthex') if not isfolder('Synthex/Key') then makefolder('Synthex/Key') end end

    Loading:Continue()
end

-- UI Layout
do
    Tabs.Key_Tab:UpdateWarningBox({
        Title = '<font size="15"><b>Hello!</b></font>',
        Text = "Thanks for using synthex.ch",
        IsNormal = true,
        Visible = true,
        LockSize = true,
    }) 

    Key_Section = Tabs.Key_Tab:AddLeftGroupbox('License', 'key')

    local KeyInput = Key_Section:AddInput('Key Input', {
        Finished = false,
        ClearTextOnFocus = true,
        Text = 'Key Input',
        Placeholder = 'Key Goes Here!',
    })

    local RememberMe = Key_Section:AddCheckbox('RememberMe', {
        Text = 'Remember Me',
        Default = false,
    })

    RememberMe:OnChanged(function(boolean)
        RememberKey = boolean
    end)

    Key_Section:AddButton('Check Key', function()
        print(KeyInput.Value)
        local status = SDK.check_key(KeyInput.Value)
        if status.code == 'KEY_VALID' then
            Library:Notify({ Title = 'Synthex', Description = 'Valid Key!', Time = 5 })
            if RememberKey then writefile("Synthex/Key/Key.json", game:GetService("HttpService"):JSONEncode({Key = KeyInput.Value})) end
            script_key = tostring(KeyInput.Value)
            SDK.load_script()
        else
            --print(status.code)
            Library:Notify({ Title = 'Synthex', Description = 'Invalid Key!', Time = 5 })
        end
    end)

    Key_Section:AddButton('Get Key', function()
        setclipboard('https://ads.luarmor.net/get_key?for=Synthex_Key_System-qTchAerHxthl')
        Library:Notify({ Title = 'Synthex', Description = 'Copied to clipboard!', Time = 5 })
    end)


    Info_Section = Tabs.Key_Tab:AddRightGroupbox("Informations", "badge-info")

    Info_Section:AddLabel({
        Text = "We use a 1-step <font color='#00c04b'>work.ink</font> checkpoint system to generate revenue and keep our script running", -- troll
        DoesWrap = true,
    })

    Info_Section:AddLabel({
        Text = "Your key is securely verified using <font color='#ffda35'>Luarmor</font>", -- troll
        DoesWrap = true,
    })

    Info_Section:AddLabel({
        Text = "Keys are tied to your <b>HWID</b> and cannot be shared or transferred",
        DoesWrap = true,
    })

    Info_Section:AddButton("Copy Discord Invite", function() setclipboard('https://discord.gg/UMcPHe7WXt') Library:Notify({ Title = "Synthex", Description = "Invite copied to clipboard", Time = 5 }) end)

    Info_Section:AddButton("Unload", function() Library:Unload() end)

end


if isfile('Synthex/Key/key.json') then
    local status = SDK.check_key(game:GetService("HttpService"):JSONDecode(readfile('Synthex/Key/key.json')).Key)
    
    if status.code == 'KEY_VALID' then
        script_key = game:GetService("HttpService"):JSONDecode(readfile('Synthex/Key/key.json')).Key
        Library:Notify({ Title = 'Synthex', Description = 'Loading script, dont touch anything..', Time = 5 })
        SDK.load_script()
        return
    else
        Library:Notify({ Title = 'Synthex', Description = 'Expired key, proceed to get a new key to continue using synthex!', Time = 5 })
        delfile('Synthex/Key/key.json')
    end
end
