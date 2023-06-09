function requir(l)
	loadstring(game:HttpGet("https://github.com/WurstRoblox/DropLib/raw/main/"..l..".lua")
end
local TypeEnum = requir("TypeEnum")
local BaseObject = requir("BaseObject")
local Header = requir("Header")
local Config = requir("Config")

local BaseEntry = requir("UIElements/BaseEntry")

local BaseContainer = {}
BaseContainer.__index = BaseContainer
setmetatable(BaseContainer,BaseObject)

function BaseContainer:New(title,type)
    local self = setmetatable(BaseObject:New(type),BaseContainer)
    self.Collapsed = false
    self.Height = 0 --dynamically set
    self.GuiObject = Instance.new("Frame")  
    self.Header = Header:New()
    self.Title = title or ""
    self:AddChild(self.Header)
      
    return self
end

function BaseContainer:UpdateGui()
    self.GuiObject.Size = UDim2.new(0,Config.HeaderWidth,0,0)
	self.GuiObject.BackgroundColor3 = Config.SecondaryColor
	self.GuiObject.BorderSizePixel = 0
    self.GuiObject.ClipsDescendants = true
    self:ReorderGui(true)
end

function BaseContainer:ReorderGui(instant)
	instant = instant or false
	local deltaTime = Config.AnimationDuration
	if instant then
		deltaTime = 0
	end
	self.Height = Config.HeaderHeight --reserve height for the header
	if not self.Collapsed then
		for _,child in pairs(self.Children)do
			if child.Type ~= TypeEnum.Header then
				child.GuiObject:TweenPosition(UDim2.new(0,0,0,self.Height),Enum.EasingDirection.InOut,Config.AnimationEasingStyle,deltaTime,true)
				self.Height = self.Height+child.Height+Config.EntryMargin
			end
		end
		self.Height = self.Height-Config.EntryMargin --removes wasted space on the bottom
	end
    self.GuiObject:TweenSize(UDim2.new(0,Config.HeaderWidth,0,self.Height),Enum.EasingDirection.InOut,Config.AnimationEasingStyle,deltaTime,true)
    if self.Parent.Type ~= TypeEnum.Root then
        self.Parent:ReorderGui(instant)
    end
end

function BaseContainer:Collapse()
    self.Collapsed = true
    self.Header.CollapseButton:Collapse()
    self:ReorderGui()
end

function BaseContainer:Expand()
    self.Collapsed = false
    self.Header.CollapseButton:Expand()
    self:ReorderGui()
end

function BaseContainer:AddEntry(entry)
    self:AddChild(entry)
    entry:RecursiveUpdateGui()
    self:ReorderGui(true)
end

--The methods for creating the ui elements, like CreateButton and such,
--are defined in their respective file, e.g. UIElements/Button.lua

return BaseContainer
