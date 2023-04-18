function requir(l)
	loadstring(game:HttpGet("https://github.com/WurstRoblox/DropLib/raw/main/"..l..".lua")
end
local TypeEnum = requir("TypeEnum")
local BaseContainer = requir("BaseContainer")
local Config = requir("Config")

local Section = {}
Section.__index = Section
setmetatable(Section,BaseContainer)

function Section:New(title)
    local self = setmetatable(BaseContainer:New(title,TypeEnum.Section), Section)
    return self
end

function BaseContainer:CreateSection(title)
    local sec = Section:New(title)
    self:AddChild(sec)
    sec:RecursiveUpdateGui()
    return sec
end

return Section
