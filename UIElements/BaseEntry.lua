function requir(l)
	loadstring(game:HttpGet("https://github.com/WurstRoblox/DropLib/raw/main/"..l..".lua")
end
local BaseObject = requir("BaseObject")
local TypeEnum = requir("TypeEnum")
local Config = requir("Config")

local BaseEntry= {}
BaseEntry.__index = BaseEntry
setmetatable(BaseEntry,BaseObject)

function BaseEntry:New(height)
    local self = setmetatable(BaseObject:New(TypeEnum.Entry), BaseEntry)
    self.Value = nil
    self.Height = height or Config.DefaultEntryHeight
    self.GuiObject = Instance.new("Frame")
    return self
end

function BaseEntry:SetValue()
    --supposed to be overwritten
end

function BaseEntry:GetValue()
    --supposed to be overwritten
end

function BaseEntry:UpdateGui()
    self.GuiObject.BackgroundColor3 = Config.PrimaryColor
    self.GuiObject.BorderSizePixel = 0
    self.GuiObject.Size = UDim2.new(1,0,0,self.Height)
end

return BaseEntry
