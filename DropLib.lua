function requir(l)
	loadstring(game:HttpGet("https://github.com/WurstRoblox/DropLib/raw/main/"..l..".lua")
end
local TypeEnum = requir("TypeEnum")
local BaseObject = requir("BaseObject")
local BaseContainer = requir("BaseContainer")
local Section = requir("Section")
local Category = requir("Category")

--All required, comment them out if you dont want them!
local BaseEntry = requir("UIElements/BaseEntry")
local BaseUiElement = requir("UIElements/BaseUiElement")
local Button = requir("UIElements/Button")
local ColorPicker = requir("UIElements/ColorPicker")
local Selector = requir("UIElements/Selector")
local Slider = requir("UIElements/Slider")
local Switch = requir("UIElements/Switch")
local TextBox = requir("UIElements/TextBox")
local TextLabel = requir("UIElements/TextLabel")
local KeyDetector = requir("UIElements/KeyDetector")

local Gui = {}
Gui.__index = Gui
setmetatable(Gui,BaseObject)

function Gui:New(screenGuiParent)
    local self = setmetatable(BaseObject:New(TypeEnum.Root),Gui)
	self.ScreenGui = Instance.new("ScreenGui",screenGuiParent or game.Players.LocalPlayer.PlayerGui)
    self.GuiObject = Instance.new("Frame",self.ScreenGui)
    return self
end

function Gui:UpdateGui()
    self.ScreenGui.ResetOnSpawn = false
    self.ScreenGui.IgnoreGuiInset = true
    self.GuiObject.Size = UDim2.new(1,0,1,0)
	self.GuiObject.BackgroundTransparency = 1
end

function Gui:Hide()
    self.ScreenGui.Enabled = false
end

function Gui:Show()
    self.ScreenGui.Enabled = true
end

function Gui:CleanUp()
    self.ScreenGui:Destroy()
    self = nil
end

function Gui:CreateCategory(name,position)
    local cat = Category:New(name,position)
    self:AddChild(cat)
    if position then
        cat:MoveTo(position)
    else
        cat:AutoMove()
    end
    cat:RecursiveUpdateGui()
    return cat
end

function Gui:LoadConfig(userConfig)
    for i,v in pairs(userConfig) do
        Config[i] = v
    end
end

function Gui:Init(userConfig,screenGuiParent)
    local droplib = Gui:New(screenGuiParent)
    droplib:LoadConfig(userConfig or {})
    droplib:RecursiveUpdateGui()
    return droplib
end

return Gui
