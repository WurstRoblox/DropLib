function requir(l)
	loadstring(game:HttpGet("https://github.com/WurstRoblox/DropLib/raw/main/"..l..".lua")
end
local BaseObject = requir("BaseObject")
local TypeEnum = requir("TypeEnum")

local BaseUiElement= {}
BaseUiElement.__index = BaseUiElement
setmetatable(BaseUiElement,BaseObject)

function BaseUiElement:New(size,position,title)
    local self = setmetatable(BaseObject:New(TypeEnum.UiElement), BaseUiElement)
    self.Value = nil
    self.Title = title
    self.Size = size
    self.Position = position
    return self
end

function BaseUiElement:SetValue()
    --supposed to be overwritten
end

function BaseUiElement:GetValue()
    return self.Value
end

return BaseUiElement
