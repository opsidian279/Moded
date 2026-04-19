--[[
Elements.lua
NeverLose UI Library - All UI Elements
--]]

local Elements = {}

-- =============================================================================
--                           ADD TITLE
-- =============================================================================
function Elements.AddTitle(self, Frame, Signel, LayerIndex, Config)
	Config = self:ProcessParams(Config , {
		Title = "Title",
		Content = nil,
		Warp = false
	})

	local BasedFrame = Instance.new("Frame")
	local TitleLabel = Instance.new("TextLabel")
	local ContentLabel = Instance.new("TextLabel")
	local LineFrame = Instance.new("Frame")
	local BasedHandler = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")
	local UICorner = Instance.new("UICorner")

	BasedFrame.Name = self._internal.RandomString()
	BasedFrame.Parent = Frame
	BasedFrame.BackgroundColor3 = Color3.fromRGB(25, 27, 33)
	BasedFrame.BackgroundTransparency = 1.000
	BasedFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	BasedFrame.BorderSizePixel = 0
	BasedFrame.Size = UDim2.new(1, 0, 0, 30)
	BasedFrame.ZIndex = LayerIndex + 8

	self._internal.AddQuery(BasedFrame, Config.Title)

	TitleLabel.Name = self._internal.RandomString()
	TitleLabel.Parent = BasedFrame
	TitleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TitleLabel.BackgroundTransparency = 1.000
	TitleLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TitleLabel.BorderSizePixel = 0
	TitleLabel.Position = UDim2.new(0, 11, 0, 6)
	TitleLabel.Size = UDim2.new(0, 1, 0, 15)
	TitleLabel.ZIndex = LayerIndex + 9
	TitleLabel.Font = Enum.Font.GothamMedium
	TitleLabel.Text = Config.Title
	TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TitleLabel.TextSize = 13.000
	TitleLabel.TextTransparency = 0.35
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

	if Config.Content and Config.Content ~= "" then
		ContentLabel.Name = self._internal.RandomString()
		ContentLabel.Parent = BasedFrame
		ContentLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ContentLabel.BackgroundTransparency = 1.000
		ContentLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ContentLabel.BorderSizePixel = 0
		ContentLabel.Position = UDim2.new(0, 11, 0, 22)
		ContentLabel.Size = UDim2.new(0, 1, 0, 12)
		ContentLabel.ZIndex = LayerIndex + 9
		ContentLabel.Font = Enum.Font.GothamMedium
		ContentLabel.Text = Config.Content
		ContentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		ContentLabel.TextSize = 10.000
		ContentLabel.TextTransparency = 0.5
		ContentLabel.TextXAlignment = Enum.TextXAlignment.Left
		ContentLabel.TextWrapped = Config.Warp
		ContentLabel.TextYAlignment = Enum.TextYAlignment.Top
	end

	LineFrame.Name = self._internal.RandomString()
	LineFrame.Parent = BasedFrame
	LineFrame.AnchorPoint = Vector2.new(0.5, 1)
	LineFrame.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
	LineFrame.BackgroundTransparency = 0.650
	LineFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LineFrame.BorderSizePixel = 0
	LineFrame.Position = UDim2.new(0.5, 0, 1, 0)
	LineFrame.Size = UDim2.new(1, -20, 0, 1)
	LineFrame.ZIndex = LayerIndex + 11

	BasedHandler.Name = self._internal.RandomString()
	BasedHandler.Parent = BasedFrame
	BasedHandler.AnchorPoint = Vector2.new(1, 0)
	BasedHandler.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	BasedHandler.BackgroundTransparency = 1.000
	BasedHandler.BorderColor3 = Color3.fromRGB(0, 0, 0)
	BasedHandler.BorderSizePixel = 0
	BasedHandler.Position = UDim2.new(1, -11, 0, 2)
	BasedHandler.Size = UDim2.new(1, -20, 0, 25)
	BasedHandler.ZIndex = LayerIndex + 12

	UIListLayout.Parent = BasedHandler
	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout.Padding = UDim.new(0, 5)

	UICorner.CornerRadius = UDim.new(0, 10)
	UICorner.Parent = BasedFrame

	local UpdateSize = self._internal.NeverLose.LPH_NO_VIRTUALIZE(function()
		local titleSize = self._internal.TextService:GetTextSize(TitleLabel.Text, TitleLabel.TextSize, TitleLabel.Font, Vector2.new(math.huge, math.huge))
		local totalHeight = titleSize.Y + 13
		
		if Config.Content and Config.Content ~= "" then
			local contentSize = self._internal.TextService:GetTextSize(ContentLabel.Text, ContentLabel.TextSize, ContentLabel.Font, Vector2.new(200, math.huge))
			totalHeight = totalHeight + contentSize.Y + 8
			ContentLabel.Size = UDim2.new(0, 200, 0, contentSize.Y)
		end
		
		self._internal.PlayAnimate(BasedFrame, self._internal.SlowyTween, {
			Size = UDim2.new(1, 0, 0, totalHeight)
		})
	end)

	if Config.Warp then
		UpdateSize()
	end

	local handle = self._internal.RegisiterHandler(BasedHandler, Signel)
	handle.Root = BasedFrame

	handle.SetRender = self._internal.NeverLose.LPH_NO_VIRTUALIZE(function(value)
		if value then
			self._internal.PlayAnimate(BasedFrame, self._internal.SlowyTween, { BackgroundTransparency = 1 })
			self._internal.PlayAnimate(TitleLabel, self._internal.SlowyTween, { TextTransparency = 0.35 })
			if ContentLabel then
				self._internal.PlayAnimate(ContentLabel, self._internal.SlowyTween, { TextTransparency = 0.5 })
			end
			self._internal.PlayAnimate(LineFrame, self._internal.SlowyTween, { BackgroundTransparency = 0.650 })
		else
			self._internal.PlayAnimate(BasedFrame, self._internal.SlowyTween, { BackgroundTransparency = 1 })
			self._internal.PlayAnimate(TitleLabel, self._internal.SlowyTween, { TextTransparency = 1 })
			if ContentLabel then
				self._internal.PlayAnimate(ContentLabel, self._internal.SlowyTween, { TextTransparency = 1 })
			end
			self._internal.PlayAnimate(LineFrame, self._internal.SlowyTween, { BackgroundTransparency = 1 })
		end
	end)

	function handle:SetTitle(t)
		TitleLabel.Text = t
		if Config.Warp then UpdateSize() end
	end

	function handle:SetContent(t)
		if ContentLabel then
			ContentLabel.Text = t
			if Config.Warp then UpdateSize() end
		end
	end

	function handle:SetVisible(val)
		BasedFrame.Visible = val
	end

	function handle:ToolTip(Content)
		handle.ToolTip = self._internal.CreateToolTips(BasedFrame, Config.Title, Content)
		return handle
	end

	handle.SetRender(Signel:GetValue())
	Signel:Connect(handle.SetRender)

	return handle
end

-- Backward compatibility
function Elements.AddLabel(self, Frame, Signel, LayerIndex, Name, Warp)
	return Elements.AddTitle(self, Frame, Signel, LayerIndex, {Title = Name, Warp = Warp or false})
end

-- =============================================================================
--                           ADD BUTTON
-- =============================================================================
function Elements.AddButton(self, Frame, Signel, LayerIndex, Config)
	Config = self:ProcessParams(Config, {
		Title = "Button",
		Content = nil,
		Icon = "chevron-large-left",
		Callback = self._internal.EmptyFunction,
		ToolTip = nil,
	})

	local Button = {}
	local ButtonFrame = Instance.new("Frame")
	local TitleLabel = Instance.new("TextLabel")
	local ContentLabel = Instance.new("TextLabel")
	local LineFrame = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local Icon = Instance.new("TextLabel")

	self._internal.AddQuery(ButtonFrame, Config.Title)

	ButtonFrame.Name = self._internal.RandomString()
	ButtonFrame.Parent = Frame
	ButtonFrame.BackgroundColor3 = Color3.fromRGB(25, 27, 33)
	ButtonFrame.BackgroundTransparency = 1.000
	ButtonFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ButtonFrame.BorderSizePixel = 0
	ButtonFrame.Size = UDim2.new(1, 0, 0, Config.Content and 45 or 30)
	ButtonFrame.ZIndex = LayerIndex + 8

	TitleLabel.Name = self._internal.RandomString()
	TitleLabel.Parent = ButtonFrame
	TitleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TitleLabel.BackgroundTransparency = 1.000
	TitleLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TitleLabel.BorderSizePixel = 0
	TitleLabel.Position = UDim2.new(0, 35, 0, 6)
	TitleLabel.Size = UDim2.new(0, 1, 0, 15)
	TitleLabel.ZIndex = LayerIndex + 9
	TitleLabel.Font = Enum.Font.GothamMedium
	TitleLabel.Text = Config.Title
	TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TitleLabel.TextSize = 13.000
	TitleLabel.TextTransparency = 0.200
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

	if Config.Content and Config.Content ~= "" then
		ContentLabel.Name = self._internal.RandomString()
		ContentLabel.Parent = ButtonFrame
		ContentLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ContentLabel.BackgroundTransparency = 1.000
		ContentLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ContentLabel.BorderSizePixel = 0
		ContentLabel.Position = UDim2.new(0, 35, 0, 24)
		ContentLabel.Size = UDim2.new(0, 1, 0, 12)
		ContentLabel.ZIndex = LayerIndex + 9
		ContentLabel.Font = Enum.Font.GothamMedium
		ContentLabel.Text = Config.Content
		ContentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		ContentLabel.TextSize = 10.000
		ContentLabel.TextTransparency = 0.5
		ContentLabel.TextXAlignment = Enum.TextXAlignment.Left
	end

	LineFrame.Name = self._internal.RandomString()
	LineFrame.Parent = ButtonFrame
	LineFrame.AnchorPoint = Vector2.new(0.5, 1)
	LineFrame.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
	LineFrame.BackgroundTransparency = 0.650
	LineFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LineFrame.BorderSizePixel = 0
	LineFrame.Position = UDim2.new(0.5, 0, 1, 0)
	LineFrame.Size = UDim2.new(1, -20, 0, 1)
	LineFrame.ZIndex = LayerIndex + 11

	UICorner.CornerRadius = UDim.new(0, 10)
	UICorner.Parent = ButtonFrame

	Icon.Name = self._internal.RandomString()
	Icon.Parent = ButtonFrame
	Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Icon.BackgroundTransparency = 1.000
	Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Icon.BorderSizePixel = 0
	Icon.Position = UDim2.new(0, 11, 0, 5)
	Icon.Size = UDim2.new(0, 18, 0, 18)
	Icon.ZIndex = LayerIndex + 9
	Icon.FontFace = self._internal.BuiltInBold
	Icon.Text = Config.Icon
	Icon.TextColor3 = Color3.fromRGB(223, 223, 223)
	Icon.TextSize = 16.000
	Icon.TextTransparency = 0.250
	Icon.TextWrapped = true

	function Button:SetTitle(t)
		TitleLabel.Text = t
	end

	function Button:SetContent(t)
		if ContentLabel then
			ContentLabel.Text = t
		end
	end

	function Button:SetIcon(t)
		Icon.Text = t
	end

	local bth = self._internal.CreateInput(ButtonFrame, self._internal.NeverLose.LPH_NO_VIRTUALIZE(function()
		Config.Callback()
	end))

	self:AddSignal(bth.MouseEnter:Connect(self._internal.NeverLose.LPH_NO_VIRTUALIZE(function()
		self._internal.PlayAnimate(ButtonFrame, self._internal.SlowyTween, { BackgroundTransparency = 0.35 })
	end)))

	self:AddSignal(bth.MouseLeave:Connect(self._internal.NeverLose.LPH_NO_VIRTUALIZE(function()
		self._internal.PlayAnimate(ButtonFrame, self._internal.SlowyTween, { BackgroundTransparency = 1 })
	end)))

	Button.SetRender = self._internal.NeverLose.LPH_NO_VIRTUALIZE(function(value)
		if value then
			self._internal.PlayAnimate(ButtonFrame, self._internal.SlowyTween, { BackgroundTransparency = 1 })
			self._internal.PlayAnimate(TitleLabel, self._internal.SlowyTween, { TextTransparency = 0.200 })
			if ContentLabel then
				self._internal.PlayAnimate(ContentLabel, self._internal.SlowyTween, { TextTransparency = 0.5 })
			end
			self._internal.PlayAnimate(LineFrame, self._internal.SlowyTween, { BackgroundTransparency = 0.650 })
			self._internal.PlayAnimate(Icon, self._internal.SlowyTween, { TextTransparency = 0.250 })
		else
			self._internal.PlayAnimate(ButtonFrame, self._internal.SlowyTween, { BackgroundTransparency = 1 })
			self._internal.PlayAnimate(TitleLabel, self._internal.SlowyTween, { TextTransparency = 1 })
			if ContentLabel then
				self._internal.PlayAnimate(ContentLabel, self._internal.SlowyTween, { TextTransparency = 1 })
			end
			self._internal.PlayAnimate(LineFrame, self._internal.SlowyTween, { BackgroundTransparency = 1 })
			self._internal.PlayAnimate(Icon, self._internal.SlowyTween, { TextTransparency = 1 })
		end
	end)

	if Config.ToolTip then
		Button.ToolTip = self._internal.CreateToolTips(ButtonFrame, Config.Title, Config.ToolTip)
	end

	Button.SetRender(Signel:GetValue())
	Signel:Connect(Button.SetRender)

	return Button
end

-- =============================================================================
--                           ADD TOGGLE
-- =============================================================================
function Elements.AddToggle(self, Frame, Signel, LayerIndex, Config)
	Config = self:ProcessParams(Config, {
		Title = "Toggle",
		Content = nil,
		Default = false,
		Flag = nil,
		Callback = self._internal.EmptyFunction,
	})

	local ToggleFrame = Instance.new("Frame")
	local TitleLabel = Instance.new("TextLabel")
	local ContentLabel = Instance.new("TextLabel")
	local LineFrame = Instance.new("Frame")
	local Toggle = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local Circle = Instance.new("Frame")
	local UICorner_2 = Instance.new("UICorner")
	local UICorner_3 = Instance.new("UICorner")

	self._internal.AddQuery(ToggleFrame, Config.Title)

	ToggleFrame.Name = self._internal.RandomString()
	ToggleFrame.Parent = Frame
	ToggleFrame.BackgroundColor3 = Color3.fromRGB(25, 27, 33)
	ToggleFrame.BackgroundTransparency = 1.000
	ToggleFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ToggleFrame.BorderSizePixel = 0
	ToggleFrame.Size = UDim2.new(1, 0, 0, Config.Content and 45 or 30)
	ToggleFrame.ZIndex = LayerIndex + 8

	TitleLabel.Name = self._internal.RandomString()
	TitleLabel.Parent = ToggleFrame
	TitleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TitleLabel.BackgroundTransparency = 1.000
	TitleLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TitleLabel.BorderSizePixel = 0
	TitleLabel.Position = UDim2.new(0, 11, 0, 6)
	TitleLabel.Size = UDim2.new(0, 1, 0, 15)
	TitleLabel.ZIndex = LayerIndex + 9
	TitleLabel.Font = Enum.Font.GothamMedium
	TitleLabel.Text = Config.Title
	TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TitleLabel.TextSize = 13.000
	TitleLabel.TextTransparency = 0.35
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

	if Config.Content and Config.Content ~= "" then
		ContentLabel.Name = self._internal.RandomString()
		ContentLabel.Parent = ToggleFrame
		ContentLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ContentLabel.BackgroundTransparency = 1.000
		ContentLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ContentLabel.BorderSizePixel = 0
		ContentLabel.Position = UDim2.new(0, 11, 0, 24)
		ContentLabel.Size = UDim2.new(0, 1, 0, 12)
		ContentLabel.ZIndex = LayerIndex + 9
		ContentLabel.Font = Enum.Font.GothamMedium
		ContentLabel.Text = Config.Content
		ContentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		ContentLabel.TextSize = 10.000
		ContentLabel.TextTransparency = 0.5
		ContentLabel.TextXAlignment = Enum.TextXAlignment.Left
	end

	LineFrame.Name = self._internal.RandomString()
	LineFrame.Parent = ToggleFrame
	LineFrame.AnchorPoint = Vector2.new(0.5, 1)
	LineFrame.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
	LineFrame.BackgroundTransparency = 0.650
	LineFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LineFrame.BorderSizePixel = 0
	LineFrame.Position = UDim2.new(0.5, 0, 1, 0)
	LineFrame.Size = UDim2.new(1, -20, 0, 1)
	LineFrame.ZIndex = LayerIndex + 11

	Toggle.Name = self._internal.RandomString()
	Toggle.Parent = ToggleFrame
	Toggle.AnchorPoint = Vector2.new(1, 0.5)
	Toggle.BackgroundColor3 = Color3.fromRGB(10, 13, 21)
	Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Toggle.BorderSizePixel = 0
	Toggle.ClipsDescendants = true
	Toggle.Position = UDim2.new(1, -11, 0.5, 0)
	Toggle.Size = UDim2.new(0, 30, 0, 18)
	Toggle.ZIndex = LayerIndex + 13

	UICorner.CornerRadius = UDim.new(1, 0)
	UICorner.Parent = Toggle

	Circle.Name = self._internal.RandomString()
	Circle.Parent = Toggle
	Circle.AnchorPoint = Vector2.new(0.5, 0.5)
	Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Circle.BackgroundTransparency = 0.500
	Circle.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Circle.BorderSizePixel = 0
	Circle.Position = UDim2.new(0.3, 0, 0.5, 0)
	Circle.Size = UDim2.new(0, 16, 0, 16)
	Circle.ZIndex = LayerIndex + 14

	UICorner_2.CornerRadius = UDim.new(1, 0)
	UICorner_2.Parent = Circle

	UICorner_3.CornerRadius = UDim.new(0, 10)
	UICorner_3.Parent = ToggleFrame

	local ToggleLib = { Root = ToggleFrame }

	ToggleLib.SetUI = self._internal.NeverLose.LPH_NO_VIRTUALIZE(function(value)
		if value then
			self._internal.PlayAnimate(Toggle, self._internal.SlowyTween, {
				BackgroundTransparency = 0,
				BackgroundColor3 = self._internal.AccentColor
			})
			self._internal.PlayAnimate(Circle, self._internal.SlowyTween, {
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 0,
				Position = UDim2.new(0.7, 0, 0.5, 0)
			})
		else
			self._internal.PlayAnimate(Toggle, self._internal.SlowyTween, {
				BackgroundTransparency = 0,
				BackgroundColor3 = Color3.fromRGB(10, 13, 21)
			})
			self._internal.PlayAnimate(Circle, self._internal.SlowyTween, {
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 0.500,
				Position = UDim2.new(0.3, 0, 0.5, 0)
			})
		end
	end)

	ToggleLib.SetRender = self._internal.NeverLose.LPH_NO_VIRTUALIZE(function(value)
		if value then
			self._internal.PlayAnimate(ToggleFrame, self._internal.SlowyTween, { BackgroundTransparency = 1 })
			self._internal.PlayAnimate(TitleLabel, self._internal.SlowyTween, { TextTransparency = 0.35 })
			if ContentLabel then
				self._internal.PlayAnimate(ContentLabel, self._internal.SlowyTween, { TextTransparency = 0.5 })
			end
			self._internal.PlayAnimate(LineFrame, self._internal.SlowyTween, { BackgroundTransparency = 0.650 })
			ToggleLib.SetUI(Config.Default)
		else
			self._internal.PlayAnimate(ToggleFrame, self._internal.SlowyTween, { BackgroundTransparency = 1 })
			self._internal.PlayAnimate(TitleLabel, self._internal.SlowyTween, { TextTransparency = 1 })
			if ContentLabel then
				self._internal.PlayAnimate(ContentLabel, self._internal.SlowyTween, { TextTransparency = 1 })
			end
			self._internal.PlayAnimate(LineFrame, self._internal.SlowyTween, { BackgroundTransparency = 1 })
			self._internal.PlayAnimate(Toggle, self._internal.SlowyTween, {
				BackgroundTransparency = 1,
				BackgroundColor3 = Color3.fromRGB(10, 13, 21)
			})
			self._internal.PlayAnimate(Circle, self._internal.SlowyTween, {
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				Position = UDim2.new(0.3, 0, 0.5, 0)
			})
		end
	end)

	ToggleLib.SetRender(Signel:GetValue())
	Signel:Connect(ToggleLib.SetRender)

	self._internal.CreateInput(Toggle, self._internal.NeverLose.LPH_NO_VIRTUALIZE(function()
		Config.Default = not Config.Default
		ToggleLib.SetUI(Config.Default)
		Config.Callback(Config.Default)
	end))

	function ToggleLib:GetValue()
		return Config.Default
	end

	function ToggleLib:SetValue(v)
		Config.Default = v
		if Signel:GetValue() then
			ToggleLib.SetUI(Config.Default)
		end
		Config.Callback(Config.Default)
	end

	function ToggleLib:SetTitle(t)
		TitleLabel.Text = t
	end

	function ToggleLib:SetContent(t)
		if ContentLabel then
			ContentLabel.Text = t
		end
	end

	if Config.Flag then
		self.Flags[Config.Flag] = ToggleLib
	end

	return ToggleLib
end

-- =============================================================================
--                           ADD SLIDER
-- =============================================================================
function Elements.AddSlider(self, Frame, Signel, LayerIndex, Config)
	Config = self:ProcessParams(Config, {
		Title = "Slider",
		Content = nil,
		Default = 50,
		Min = 0,
		Max = 100,
		Type = "",
		Rounding = 0,
		Nums = {},
		Flag = nil,
		Size = 125,
		Callback = self._internal.EmptyFunction,
	})

	local SliderLib = {}

	SliderLib.GetSize = self._internal.NeverLose.LPH_NO_VIRTUALIZE(function()
		return (Config.Default - Config.Min) / (Config.Max - Config.Min)
	end)

	local FullNumSize = self._internal.TextService:GetTextSize(string.rep("0", (Config.Rounding + #tostring(Config.Max)) + 1) .. tostring(Config.Type), 10, Enum.Font.GothamMedium, Vector2.new(math.huge, math.huge))
	SliderLib.MaximumSize = FullNumSize.X

	if Config.Nums then
		local nszie = 0
		for i, ns in next, Config.Nums do
			local size = self._internal.TextService:GetTextSize(string.rep("m", string.len(tostring(ns))), 10, Enum.Font.GothamMedium, Vector2.new(math.huge, math.huge))
			if nszie < size.X then nszie = size.X end
		end
		if SliderLib.MaximumSize < nszie then SliderLib.MaximumSize = nszie end
	end

	local SliderFrame = Instance.new("Frame")
	local TitleLabel = Instance.new("TextLabel")
	local ContentLabel = Instance.new("TextLabel")
	local LineFrame = Instance.new("Frame")
	local Slider = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local ValueFrame = Instance.new("Frame")
	local UICorner_2 = Instance.new("UICorner")
	local UIStroke = Instance.new("UIStroke")
	local ValueLabel = Instance.new("TextBox")
	local SlideMain = Instance.new("Frame")
	local SlideFrame = Instance.new("Frame")
	local UICorner_3 = Instance.new("UICorner")
	local SlideMoving = Instance.new("Frame")
	local UICorner_4 = Instance.new("UICorner")
	local DotFrame = Instance.new("Frame")
	local UICorner_5 = Instance.new("UICorner")
	local boxSize = 2

	self._internal.AddQuery(SliderFrame, Config.Title)

	SliderFrame.Name = self._internal.RandomString()
	SliderFrame.Parent = Frame
	SliderFrame.BackgroundColor3 = Color3.fromRGB(25, 27, 33)
	SliderFrame.BackgroundTransparency = 1.000
	SliderFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SliderFrame.BorderSizePixel = 0
	SliderFrame.Size = UDim2.new(1, 0, 0, Config.Content and 65 or 50)
	SliderFrame.ZIndex = LayerIndex + 8

	TitleLabel.Name = self._internal.RandomString()
	TitleLabel.Parent = SliderFrame
	TitleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TitleLabel.BackgroundTransparency = 1.000
	TitleLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TitleLabel.BorderSizePixel = 0
	TitleLabel.Position = UDim2.new(0, 11, 0, 6)
	TitleLabel.Size = UDim2.new(0, 1, 0, 15)
	TitleLabel.ZIndex = LayerIndex + 9
	TitleLabel.Font = Enum.Font.GothamMedium
	TitleLabel.Text = Config.Title
	TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TitleLabel.TextSize = 13.000
	TitleLabel.TextTransparency = 0.35
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

	if Config.Content and Config.Content ~= "" then
		ContentLabel.Name = self._internal.RandomString()
		ContentLabel.Parent = SliderFrame
		ContentLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ContentLabel.BackgroundTransparency = 1.000
		ContentLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ContentLabel.BorderSizePixel = 0
		ContentLabel.Position = UDim2.new(0, 11, 0, 24)
		ContentLabel.Size = UDim2.new(0, 1, 0, 12)
		ContentLabel.ZIndex = LayerIndex + 9
		ContentLabel.Font = Enum.Font.GothamMedium
		ContentLabel.Text = Config.Content
		ContentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		ContentLabel.TextSize = 10.000
		ContentLabel.TextTransparency = 0.5
		ContentLabel.TextXAlignment = Enum.TextXAlignment.Left
	end

	LineFrame.Name = self._internal.RandomString()
	LineFrame.Parent = SliderFrame
	LineFrame.AnchorPoint = Vector2.new(0.5, 1)
	LineFrame.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
	LineFrame.BackgroundTransparency = 0.650
	LineFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LineFrame.BorderSizePixel = 0
	LineFrame.Position = UDim2.new(0.5, 0, 1, 0)
	LineFrame.Size = UDim2.new(1, -20, 0, 1)
	LineFrame.ZIndex = LayerIndex + 11

	Slider.Name = self._internal.RandomString()
	Slider.Parent = SliderFrame
	Slider.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
	Slider.BackgroundTransparency = 1.000
	Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Slider.BorderSizePixel = 0
	Slider.ClipsDescendants = false
	Slider.Size = UDim2.new(1, -22, 0, 18)
	Slider.Position = UDim2.new(0, 11, 0, Config.Content and 38 or 23)
	Slider.ZIndex = LayerIndex + 13

	UICorner.CornerRadius = UDim.new(0, 4)
	UICorner.Parent = Slider

	ValueFrame.Name = self._internal.RandomString()
	ValueFrame.Parent = Slider
	ValueFrame.AnchorPoint = Vector2.new(1, 0)
	ValueFrame.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
	ValueFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ValueFrame.BorderSizePixel = 0
	ValueFrame.ClipsDescendants = true
	ValueFrame.Position = UDim2.new(1, 0, 0, 0)
	ValueFrame.Size = UDim2.new(0, SliderLib.MaximumSize + boxSize, 0, 18)
	ValueFrame.ZIndex = LayerIndex + 13

	UICorner_2.CornerRadius = UDim.new(0, 4)
	UICorner_2.Parent = ValueFrame

	UIStroke.Transparency = 0.650
	UIStroke.Color = Color3.fromRGB(45, 48, 58)
	UIStroke.Parent = ValueFrame

	ValueLabel.Name = self._internal.RandomString()
	ValueLabel.Parent = ValueFrame
	ValueLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	ValueLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ValueLabel.BackgroundTransparency = 1.000
	ValueLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ValueLabel.BorderSizePixel = 0
	ValueLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	ValueLabel.Size = UDim2.new(1, 0, 1, 0)
	ValueLabel.ZIndex = LayerIndex + 14
	ValueLabel.Font = Enum.Font.GothamMedium
	ValueLabel.Text = tostring(Config.Default) .. tostring(Config.Type)
	ValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	ValueLabel.TextSize = 10.000
	ValueLabel.ClearTextOnFocus = false
	ValueLabel.TextTransparency = 0.350

	SlideMain.Name = self._internal.RandomString()
	SlideMain.Parent = Slider
	SlideMain.AnchorPoint = Vector2.new(0, 0.5)
	SlideMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SlideMain.BackgroundTransparency = 1.000
	SlideMain.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SlideMain.BorderSizePixel = 0
	SlideMain.Position = UDim2.new(0, 0, 0.5, 0)
	SlideMain.Size = UDim2.new(1, -((SliderLib.MaximumSize + 11)), 0, 18)
	SlideMain.ZIndex = LayerIndex + 13

	SlideFrame.Name = self._internal.RandomString()
	SlideFrame.Parent = SlideMain
	SlideFrame.AnchorPoint = Vector2.new(0, 0.5)
	SlideFrame.BackgroundColor3 = Color3.fromRGB(30, 29, 36)
	SlideFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SlideFrame.BorderSizePixel = 0
	SlideFrame.Position = UDim2.new(0, 0, 0.5, 0)
	SlideFrame.Size = UDim2.new(1, 0, 0, 5)
	SlideFrame.ZIndex = LayerIndex + 13

	UICorner_3.CornerRadius = UDim.new(1, 0)
	UICorner_3.Parent = SlideFrame

	SlideMoving.Name = self._internal.RandomString()
	SlideMoving.Parent = SlideFrame
	SlideMoving.BackgroundColor3 = self._internal.AccentColor
	SlideMoving.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SlideMoving.BorderSizePixel = 0
	SlideMoving.Size = UDim2.new(SliderLib.GetSize(), 0, 1, 0)
	SlideMoving.ZIndex = LayerIndex + 14

	UICorner_4.CornerRadius = UDim.new(1, 0)
	UICorner_4.Parent = SlideMoving

	DotFrame.Parent = SlideMoving
	DotFrame.AnchorPoint = Vector2.new(1, 0.5)
	DotFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	DotFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	DotFrame.BorderSizePixel = 0
	DotFrame.Position = UDim2.new(1, 5, 0.5, 0)
	DotFrame.Size = UDim2.new(0, 10, 0, 10)
	DotFrame.ZIndex = LayerIndex + 15

	UICorner_5.CornerRadius = UDim.new(1, 0)
	UICorner_5.Parent = DotFrame

	local LoadText = self._internal.NeverLose.LPH_NO_VIRTUALIZE(function()
		if Config.Nums[Config.Default] then
			ValueLabel.Text = Config.Nums[Config.Default]
		else
			ValueLabel.Text = tostring(Config.Default) .. tostring(Config.Type)
		end
	end)

	ValueLabel.FocusLost:Connect(self._internal.NeverLose.LPH_NO_VIRTUALIZE(function()
		local OutVal = self._internal.ParseInput(ValueLabel.Text, true)
		if OutVal then
			local rx = math.clamp(OutVal, Config.Min, Config.Max)
			local Value = self._internal.Rounding(rx, Config.Rounding)
			if Value then
				Config.Default = Value
				self._internal.TweenService:Create(SlideMoving, self._internal.ManualTween, { Size = UDim2.new(SliderLib.GetSize(), 0, 1, 0) }):Play()
				LoadText()
				Config.Callback(Config.Default)
			else
				LoadText()
			end
		else
			LoadText()
		end
	end))

	SliderLib.SetRender = self._internal.NeverLose.LPH_NO_VIRTUALIZE(function(value)
		if value then
			self._internal.PlayAnimate(SliderFrame, self._internal.SlowyTween, { BackgroundTransparency = 1 })
			self._internal.PlayAnimate(TitleLabel, self._internal.SlowyTween, { TextTransparency = 0.35 })
			if ContentLabel then
				self._internal.PlayAnimate(ContentLabel, self._internal.SlowyTween, { TextTransparency = 0.5 })
			end
			self._internal.PlayAnimate(LineFrame, self._internal.SlowyTween, { BackgroundTransparency = 0.650 })
			self._internal.PlayAnimate(ValueFrame, self._internal.SlowyTween, { BackgroundTransparency = 0, Size = UDim2.new(0, SliderLib.MaximumSize + boxSize, 0, 18) })
			self._internal.PlayAnimate(UIStroke, self._internal.SlowyTween, { Transparency = 0.650 })
			self._internal.PlayAnimate(ValueLabel, self._internal.SlowyTween, { TextTransparency = 0.350 })
			self._internal.PlayAnimate(SlideFrame, self._internal.SlowyTween, { BackgroundTransparency = 0 })
			self._internal.PlayAnimate(SlideMoving, self._internal.SlowyTween, { BackgroundTransparency = 0, Size = UDim2.new(SliderLib.GetSize(), 0, 1, 0) })
			self._internal.PlayAnimate(DotFrame, self._internal.SlowyTween, { BackgroundTransparency = 0 })
		else
			self._internal.PlayAnimate(SliderFrame, self._internal.SlowyTween, { BackgroundTransparency = 1 })
			self._internal.PlayAnimate(TitleLabel, self._internal.SlowyTween, { TextTransparency = 1 })
			if ContentLabel then
				self._internal.PlayAnimate(ContentLabel, self._internal.SlowyTween, { TextTransparency = 1 })
			end
			self._internal.PlayAnimate(LineFrame, self._internal.SlowyTween, { BackgroundTransparency = 1 })
			self._internal.PlayAnimate(ValueFrame, self._internal.SlowyTween, { BackgroundTransparency = 1 })
			self._internal.PlayAnimate(UIStroke, self._internal.SlowyTween, { Transparency = 1 })
			self._internal.PlayAnimate(ValueLabel, self._internal.SlowyTween, { TextTransparency = 1 })
			self._internal.PlayAnimate(SlideFrame, self._internal.SlowyTween, { BackgroundTransparency = 1 })
			self._internal.PlayAnimate(SlideMoving, self._internal.SlowyTween, { BackgroundTransparency = 1, Size = UDim2.new(0, 0, 1, 0) })
			self._internal.PlayAnimate(DotFrame, self._internal.SlowyTween, { BackgroundTransparency = 1 })
		end
	end)

	SliderLib.SetRender(Signel:GetValue())
	SliderLib.Signal = Signel:Connect(SliderLib.SetRender)

	local Update = function(Input)
		local SizeScale = math.clamp(((Input.Position.X - SlideMain.AbsolutePosition.X) / SlideMain.AbsoluteSize.X), 0, 1)
		local Main = ((Config.Max - Config.Min) * SizeScale) + Config.Min
		local Value = self._internal.Rounding(Main, Config.Rounding)
		Config.Default = Value
		self._internal.TweenService:Create(SlideMoving, self._internal.ManualTween, { Size = UDim2.new(SliderLib.GetSize(), 0, 1, 0) }):Play()
		LoadText()
		Config.Callback(Value)
	end

	local IsHold = false

	do
		SlideMain.InputBegan:Connect(self._internal.NeverLose.LPH_NO_VIRTUALIZE(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				IsHold = true
				Update(Input)
			end
		end))

		SlideMain.InputEnded:Connect(self._internal.NeverLose.LPH_NO_VIRTUALIZE(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				if self._internal.UserInputService.TouchEnabled then
					if not self._internal.IsMouseOverFrame(SlideMain) then
						IsHold = false
					end
				else
					IsHold = false
				end
			end
		end))

		self._internal.UserInputService.InputChanged:Connect(self._internal.NeverLose.LPH_NO_VIRTUALIZE(function(Input)
			if IsHold then
				if (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
					if self._internal.UserInputService.TouchEnabled then
						if not self._internal.IsMouseOverFrame(SlideMain) then
							IsHold = false
						else
							Update(Input)
						end
					else
						Update(Input)
					end
				end
			end
		end))
	end

	function SliderLib:GetValue()
		return Config.Default
	end

	function SliderLib:SetValue(v)
		Config.Default = v
		if Signel:GetValue() then
			self._internal.PlayAnimate(SlideMoving, self._internal.SlowyTween, { BackgroundTransparency = 0, Size = UDim2.new(SliderLib.GetSize(), 0, 1, 0) })
		end
		LoadText()
		Config.Callback(Config.Default)
	end

	function SliderLib:SetTitle(t)
		TitleLabel.Text = t
	end

	function SliderLib:SetContent(t)
		if ContentLabel then
			ContentLabel.Text = t
		end
	end

	if Config.Flag then
		self.Flags[Config.Flag] = SliderLib
	end

	return SliderLib
end

-- =============================================================================
--                           ADD DROPDOWN
-- =============================================================================
function Elements.AddDropdown(self, Frame, Signel, LayerIndex, Config)
	Config = self:ProcessParams(Config , {
		Title = "Dropdown",
		Content = nil,
		Default = nil,
		Values = {},
		Multi = false,
		Callback = self._internal.EmptyFunction,
		AutoUpdate = false,
		Flag = nil,
		Size = 100
	})

	Config.Default = self._internal.ProcessDropdown(Config.Default)

	local DropdownFrame = Instance.new("Frame")
	local TitleLabel = Instance.new("TextLabel")
	local ContentLabel = Instance.new("TextLabel")
	local LineFrame = Instance.new("Frame")
	local Dropdown = Instance.new("Frame")
	local DropdownIcon = Instance.new("TextLabel")
	local UICorner = Instance.new("UICorner")
	local UIStroke = Instance.new("UIStroke")
	local BasedLabel = Instance.new("TextLabel")
	local UICorner_2 = Instance.new("UICorner")

	self._internal.AddQuery(DropdownFrame, Config.Title)

	DropdownFrame.Name = self._internal.RandomString()
	DropdownFrame.Parent = Frame
	DropdownFrame.BackgroundColor3 = Color3.fromRGB(25, 27, 33)
	DropdownFrame.BackgroundTransparency = 1.000
	DropdownFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	DropdownFrame.BorderSizePixel = 0
	DropdownFrame.Size = UDim2.new(1, 0, 0, Config.Content and 50 or 35)
	DropdownFrame.ZIndex = LayerIndex + 8

	TitleLabel.Name = self._internal.RandomString()
	TitleLabel.Parent = DropdownFrame
	TitleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TitleLabel.BackgroundTransparency = 1.000
	TitleLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TitleLabel.BorderSizePixel = 0
	TitleLabel.Position = UDim2.new(0, 11, 0, 6)
	TitleLabel.Size = UDim2.new(0, 1, 0, 15)
	TitleLabel.ZIndex = LayerIndex + 9
	TitleLabel.Font = Enum.Font.GothamMedium
	TitleLabel.Text = Config.Title
	TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TitleLabel.TextSize = 13.000
	TitleLabel.TextTransparency = 0.35
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

	if Config.Content and Config.Content ~= "" then
		ContentLabel.Name = self._internal.RandomString()
		ContentLabel.Parent = DropdownFrame
		ContentLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ContentLabel.BackgroundTransparency = 1.000
		ContentLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ContentLabel.BorderSizePixel = 0
		ContentLabel.Position = UDim2.new(0, 11, 0, 24)
		ContentLabel.Size = UDim2.new(0, 1, 0, 12)
		ContentLabel.ZIndex = LayerIndex + 9
		ContentLabel.Font = Enum.Font.GothamMedium
		ContentLabel.Text = Config.Content
		ContentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		ContentLabel.TextSize = 10.000
		ContentLabel.TextTransparency = 0.5
		ContentLabel.TextXAlignment = Enum.TextXAlignment.Left
	end

	LineFrame.Name = self._internal.RandomString()
	LineFrame.Parent = DropdownFrame
	LineFrame.AnchorPoint = Vector2.new(0.5, 1)
	LineFrame.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
	LineFrame.BackgroundTransparency = 0.650
	LineFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LineFrame.BorderSizePixel = 0
	LineFrame.Position = UDim2.new(0.5, 0, 1, 0)
	LineFrame.Size = UDim2.new(1, -20, 0, 1)
	LineFrame.ZIndex = LayerIndex + 11

	Dropdown.Name = self._internal.RandomString()
	Dropdown.Parent = DropdownFrame
	Dropdown.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
	Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Dropdown.BorderSizePixel = 0
	Dropdown.ClipsDescendants = true
	Dropdown.Size = UDim2.new(0, Config.Size, 0, 18)
	Dropdown.Position = UDim2.new(1, -11, Config.Content and 0.65 or 0.45, -9)
	Dropdown.ZIndex = LayerIndex + 13

	DropdownIcon.Name = self._internal.RandomString()
	DropdownIcon.Parent = Dropdown
	DropdownIcon.AnchorPoint = Vector2.new(1, 0.5)
	DropdownIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	DropdownIcon.BackgroundTransparency = 1.000
	DropdownIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
	DropdownIcon.BorderSizePixel = 0
	DropdownIcon.Position = UDim2.new(1, -2, 0.5, 0)
	DropdownIcon.Size = UDim2.new(0, 18, 0, 18)
	DropdownIcon.ZIndex = LayerIndex + 14
	DropdownIcon.FontFace = self._internal.BuiltInBold
	DropdownIcon.Text = "chevron-small-down"
	DropdownIcon.TextColor3 = Color3.fromRGB(223, 223, 223)
	DropdownIcon.TextSize = 16.000
	DropdownIcon.TextTransparency = 0.250
	DropdownIcon.TextWrapped = true

	UICorner.CornerRadius = UDim.new(0, 4)
	UICorner.Parent = Dropdown

	UIStroke.Transparency = 0.650
	UIStroke.Color = Color3.fromRGB(45, 48, 58)
	UIStroke.Parent = Dropdown

	BasedLabel.Name = self._internal.RandomString()
	BasedLabel.Parent = Dropdown
	BasedLabel.AnchorPoint = Vector2.new(0, 0.5)
	BasedLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	BasedLabel.BackgroundTransparency = 1.000
	BasedLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	BasedLabel.BorderSizePixel = 0
	BasedLabel.ClipsDescendants = true
	BasedLabel.Position = UDim2.new(0, 5, 0.5, 0)
	BasedLabel.Size = UDim2.new(1, -25, 0, 15)
	BasedLabel.ZIndex = LayerIndex + 14
	BasedLabel.Font = Enum.Font.GothamMedium
	BasedLabel.Text = self._internal.ParseDropdown(Config.Default)
	BasedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	BasedLabel.TextSize = 12.000
	BasedLabel.TextTransparency = 0.5
	BasedLabel.TextXAlignment = Enum.TextXAlignment.Left

	UICorner_2.CornerRadius = UDim.new(0, 10)
	UICorner_2.Parent = DropdownFrame

	do
		local UIGradient = Instance.new("UIGradient")
		UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(0.85, 0.23), NumberSequenceKeypoint.new(1.00, 1.00)}
		UIGradient.Parent = BasedLabel
	end

	self:AddSignal(Dropdown.MouseEnter:Connect(self._internal.NeverLose.LPH_NO_VIRTUALIZE(function()
		self._internal.PlayAnimate(BasedLabel , self._internal.SlowyTween , { TextTransparency = 0.200 })
	end)))

	self:AddSignal(Dropdown.MouseLeave:Connect(self._internal.NeverLose.LPH_NO_VIRTUALIZE(function()
		self._internal.PlayAnimate(BasedLabel , self._internal.SlowyTween , { TextTransparency = 0.5 })
	end)))

	local DropdownLib = {
		OpenSignal = self:CreateSignal(false),
		Signals = {},
		Refuse = {},
	}

	DropdownLib.SetRender = self._internal.NeverLose.LPH_NO_VIRTUALIZE(function(value)
		if value then
			self._internal.PlayAnimate(DropdownFrame, self._internal.SlowyTween, { BackgroundTransparency = 1 })
			self._internal.PlayAnimate(TitleLabel, self._internal.SlowyTween, { TextTransparency = 0.35 })
			if ContentLabel then
				self._internal.PlayAnimate(ContentLabel, self._internal.SlowyTween, { TextTransparency = 0.5 })
			end
			self._internal.PlayAnimate(LineFrame, self._internal.SlowyTween, { BackgroundTransparency = 0.650 })
			self._internal.PlayAnimate(Dropdown , self._internal.SlowyTween , { BackgroundTransparency = 0 })
			self._internal.PlayAnimate(DropdownIcon , self._internal.SlowyTween , { TextTransparency = 0.250 })
			self._internal.PlayAnimate(UIStroke , self._internal.SlowyTween , { Transparency = 0.650 })
			self._internal.PlayAnimate(BasedLabel , self._internal.SlowyTween , { TextTransparency = 0.5 })
		else
			self._internal.PlayAnimate(DropdownFrame, self._internal.SlowyTween, { BackgroundTransparency = 1 })
			self._internal.PlayAnimate(TitleLabel, self._internal.SlowyTween, { TextTransparency = 1 })
			if ContentLabel then
				self._internal.PlayAnimate(ContentLabel, self._internal.SlowyTween, { TextTransparency = 1 })
			end
			self._internal.PlayAnimate(LineFrame, self._internal.SlowyTween, { BackgroundTransparency = 1 })
			self._internal.PlayAnimate(Dropdown , self._internal.SlowyTween , { BackgroundTransparency = 1 })
			self._internal.PlayAnimate(DropdownIcon , self._internal.SlowyTween , { TextTransparency = 1 })
			self._internal.PlayAnimate(UIStroke , self._internal.SlowyTween , { Transparency = 1 })
			self._internal.PlayAnimate(BasedLabel , self._internal.SlowyTween , { TextTransparency = 1 })
		end
	end)

	DropdownLib.SetRender(Signel:GetValue())
	Signel:Connect(DropdownLib.SetRender)
	DropdownLib.ExtentSize = 0

	do
		local DropdownHandler = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local DropdownScrollFrame = Instance.new("ScrollingFrame")
		local UIListLayout = Instance.new("UIListLayout")
		local Shadow = self:CreateShadow(DropdownHandler)

		DropdownHandler.Name = self._internal.RandomString()
		DropdownHandler.Parent = self.ScreenGui
		DropdownHandler.AnchorPoint = Vector2.new(0.5, 0)
		DropdownHandler.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
		DropdownHandler.BackgroundTransparency = 0.5
		DropdownHandler.BorderColor3 = Color3.fromRGB(0, 0, 0)
		DropdownHandler.BorderSizePixel = 0
		DropdownHandler.ClipsDescendants = true
		DropdownHandler.Position = UDim2.new(255,255,255,255)
		DropdownHandler.Size = UDim2.new(0, 125, 0, 50)
		DropdownHandler.ZIndex = LayerIndex + 125
		DropdownLib.BlockRoot = DropdownHandler

		self:AddSignal(DropdownHandler:GetPropertyChangedSignal('BackgroundTransparency'):Connect(function()
			if DropdownHandler.BackgroundTransparency > 0.9 then
				DropdownHandler.Visible = false
				DropdownHandler.Parent = nil
			else
				DropdownHandler.Visible = true
				if self.Global3DRenderMode then
					DropdownHandler.Parent = self.GlobalSurfaceGui
				else
					DropdownHandler.Parent = self.ScreenGui
				end
			end
		end))

		UICorner.CornerRadius = UDim.new(0, 10)
		UICorner.Parent = DropdownHandler

		UIStroke.Transparency = 0.650
		UIStroke.Color = Color3.fromRGB(45, 48, 58)
		UIStroke.Parent = DropdownHandler

		DropdownScrollFrame.Name = self._internal.RandomString()
		DropdownScrollFrame.Parent = DropdownHandler
		DropdownScrollFrame.Active = true
		DropdownScrollFrame.AnchorPoint = Vector2.new(0.5, 0.5)
		DropdownScrollFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		DropdownScrollFrame.BackgroundTransparency = 1.000
		DropdownScrollFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		DropdownScrollFrame.BorderSizePixel = 0
		DropdownScrollFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
		DropdownScrollFrame.Size = UDim2.new(1, -5, 1, -5)
		DropdownScrollFrame.ZIndex = LayerIndex + 127
		DropdownScrollFrame.ScrollBarThickness = 0

		DropdownLib.RootItem = DropdownScrollFrame

		UIListLayout.Parent = DropdownScrollFrame
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

		self:AddSignal(UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(self._internal.NeverLose.LPH_NO_VIRTUALIZE(function()
			DropdownScrollFrame.CanvasSize = UDim2.fromOffset(0,UIListLayout.AbsoluteContentSize.Y)
			self._internal.PlayAnimate(DropdownHandler , self._internal.SlowyTween , {
				Size = UDim2.new(0, (Dropdown.AbsoluteSize.X + 5) + DropdownLib.ExtentSize, 0, math.min(UIListLayout.AbsoluteContentSize.Y + 5, 250))
			})
		end)))

		local SetPosition = self._internal.NeverLose.LPH_NO_VIRTUALIZE(function()
			if self._internal.MoreThanHalfY(Dropdown.AbsolutePosition.Y + 85) then
				DropdownHandler.AnchorPoint = Vector2.new(0.5,1)
			else
				DropdownHandler.AnchorPoint = Vector2.new(0.5,0)
			end
			DropdownHandler.Position = UDim2.fromOffset(Dropdown.AbsolutePosition.X + (DropdownHandler.AbsoluteSize.X / 2), Dropdown.AbsolutePosition.Y + 85)
		end)

		DropdownLib.SetFrameRender = self._internal.NeverLose.LPH_NO_VIRTUALIZE(function(value)
			DropdownLib.OpenSignal:SetValue(value)
			if value then
				Shadow:Render(true)
				DropdownHandler.Size = UDim2.new(0, (Dropdown.AbsoluteSize.X + 5) + DropdownLib.ExtentSize, 0, math.min(UIListLayout.AbsoluteContentSize.Y + 5, 250))
				SetPosition()
				self._internal.PlayAnimate(DropdownHandler , self._internal.SlowyTween , { BackgroundTransparency = 0.035 })
				if Config.AutoUpdate then
					DropdownLib:Generate()
				end
			else
				self._internal.PlayAnimate(DropdownHandler , self._internal.SlowyTween , { BackgroundTransparency = 1 })
				Shadow:Render(false)
			end
		end)

		DropdownLib.SetFrameRender(false)
	end

	local SecureSignal
	self._internal.CreateInput(Dropdown , self._internal.NeverLose.LPH_NO_VIRTUALIZE(function()
		if SecureSignal then
			SecureSignal:Disconnect()
			SecureSignal = nil
		end
		DropdownLib.SetFrameRender(true)
		self.IsMosueOverOtherFrame = true
		SecureSignal = self._internal.UserInputService.InputBegan:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				if not self._internal.IsMouseOverFrame(DropdownLib.BlockRoot) and not self._internal.IsMouseOverFrame(Dropdown) then
					if SecureSignal then
						SecureSignal:Disconnect()
						SecureSignal = nil
					end
					self.IsMosueOverOtherFrame = false
					DropdownLib.SetFrameRender(false)
				end
			end
		end)
	end))

	DropdownLib.IsMatch = self._internal.NeverLose.LPH_NO_VIRTUALIZE(function(v1)
		if typeof(Config.Default) == 'table' then
			if Config.Default[v1] or table.find(Config.Default , v1) then
				return true
			end
		end
		if Config.Default == v1 then
			return true
		end
	end)

	function DropdownLib:Generate()
		for i,v in next , DropdownLib.RootItem:GetChildren() do
			if v:IsA('Frame') then
				v:Destroy()
			end
		end

		for i,v in next , DropdownLib.Signals do
			v:Disconnect()
		end

		table.clear(DropdownLib.Signals)
		table.clear(DropdownLib.Refuse)

		local Lastone
		for i,Value in next , Config.Values do
			local ItemFrame = Instance.new("Frame")
			local ItemLabel = Instance.new("TextLabel")
			local UICorner = Instance.new("UICorner")

			ItemFrame.Name = self._internal.RandomString()
			ItemFrame.Parent = DropdownLib.RootItem
			ItemFrame.BackgroundColor3 = Color3.fromRGB(29, 31, 38)
			ItemFrame.BackgroundTransparency = 1.000
			ItemFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ItemFrame.BorderSizePixel = 0
			ItemFrame.Size = UDim2.new(1, 0, 0, 25)
			ItemFrame.ZIndex = LayerIndex + 1258

			ItemLabel.Name = self._internal.RandomString()
			ItemLabel.Parent = ItemFrame
			ItemLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ItemLabel.BackgroundTransparency = 1.000
			ItemLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ItemLabel.BorderSizePixel = 0
			ItemLabel.Position = UDim2.new(0, 15, 0, 4)
			ItemLabel.Size = UDim2.new(0, 1, 0, 15)
			ItemLabel.ZIndex = LayerIndex + 1258
			ItemLabel.Font = Enum.Font.GothamMedium
			ItemLabel.Text = tostring(Value)
			ItemLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			ItemLabel.TextSize = 13.000
			ItemLabel.TextTransparency = 0.200
			ItemLabel.TextXAlignment = Enum.TextXAlignment.Left

			UICorner.CornerRadius = UDim.new(0, 10)
			UICorner.Parent = ItemFrame
			local sizetext = self._internal.TextService:GetTextSize(ItemLabel.Text , ItemLabel.TextSize,ItemLabel.Font,Vector2.new(math.huge,math.huge))
			DropdownLib.ExtentSize = math.max(DropdownLib.ExtentSize , sizetext.X)

			local MIcon , MarkItem = nil , nil

			if Config.Multi then
				local Icon = Instance.new("TextLabel")
				Icon.Parent = ItemFrame
				Icon.AnchorPoint = Vector2.new(0, 0.5)
				Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Icon.BackgroundTransparency = 1.000
				Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Icon.BorderSizePixel = 0
				Icon.Position = UDim2.new(0, 5, 0.5, 0)
				Icon.Size = UDim2.new(0, 20, 0, 20)
				Icon.ZIndex = LayerIndex + 1259
				Icon.FontFace = self._internal.BuiltInBold
				Icon.Text = "check"
				Icon.TextColor3 = Color3.fromRGB(223, 223, 223)
				Icon.TextSize = 18.000
				Icon.TextTransparency = 1
				Icon.TextWrapped = true

				local VisiblewOfMult = self._internal.NeverLose.LPH_NO_VIRTUALIZE(function()
					if DropdownLib.IsMatch(Value) then
						self._internal.PlayAnimate(ItemLabel , self._internal.VSlowTween , { TextTransparency = 0.200, Position = UDim2.new(0, 30, 0, 4) })
						self._internal.PlayAnimate(Icon , self._internal.VSlowTween , { TextTransparency = 0.250 })
						Lastone = ItemLabel
					else
						self._internal.PlayAnimate(Icon , self._internal.SlowyTween , { TextTransparency = 1 })
						self._internal.PlayAnimate(ItemLabel , self._internal.VSlowTween , { TextTransparency = 0.5, Position = UDim2.new(0, 15, 0, 4) })
					end
				end)

				MIcon = Icon
				MarkItem = VisiblewOfMult
			else
				local DefaultVisible = self._internal.NeverLose.LPH_NO_VIRTUALIZE(function()
					if DropdownLib.IsMatch(Value) then
						self._internal.PlayAnimate(ItemLabel , self._internal.SlowyTween , { TextTransparency = 0.200 })
						Lastone = ItemLabel
					else
						self._internal.PlayAnimate(ItemLabel , self._internal.SlowyTween , { TextTransparency = 0.5 })
					end
				end)
				MarkItem = DefaultVisible
			end

			MarkItem()
			table.insert(DropdownLib.Refuse , MarkItem)

			table.insert(DropdownLib.Signals,ItemFrame.MouseEnter:Connect(self._internal.NeverLose.LPH_NO_VIRTUALIZE(function()
				self._internal.PlayAnimate(ItemFrame , self._internal.SlowyTween , { BackgroundTransparency = 0.1 })
			end)))

			table.insert(DropdownLib.Signals,ItemFrame.MouseLeave:Connect(self._internal.NeverLose.LPH_NO_VIRTUALIZE(function()
				self._internal.PlayAnimate(ItemFrame , self._internal.SlowyTween , { BackgroundTransparency = 1 })
			end)))

			table.insert(DropdownLib.Signals , DropdownLib.OpenSignal:Connect(self._internal.NeverLose.LPH_NO_VIRTUALIZE(function(val)
				if val then
					MarkItem()
				else
					self._internal.PlayAnimate(ItemLabel , self._internal.SlowyTween , { TextTransparency = 1 })
					if MIcon then
						self._internal.PlayAnimate(MIcon , self._internal.SlowyTween , { TextTransparency = 1 })
					end
				end
			end)))

			if Config.Multi then
				local _,bth_signal = self._internal.CreateInput(ItemFrame , self._internal.NeverLose.LPH_NO_VIRTUALIZE(function()
					Config.Default[Value] = not Config.Default[Value]
					MarkItem()
					BasedLabel.Text = self._internal.ParseDropdown(Config.Default)
					Config.Callback(Config.Default)
				end))
				table.insert(DropdownLib.Signals , bth_signal)
			else
				local _,bth_signal = self._internal.CreateInput(ItemFrame , self._internal.NeverLose.LPH_NO_VIRTUALIZE(function()
					Config.Default = Value
					for i,v in next , DropdownLib.Refuse do
						task.spawn(v)
					end
					BasedLabel.Text = self._internal.ParseDropdown(Config.Default)
					Config.Callback(Config.Default)
				end))
				table.insert(DropdownLib.Signals , bth_signal)
			end
		end
	end

	DropdownLib:Generate()

	function DropdownLib:GetValue()
		return Config.Default
	end

	function DropdownLib:SetValue(v)
		Config.Default = v
		BasedLabel.Text = self._internal.ParseDropdown(Config.Default)
		for i,v in next , DropdownLib.Refuse do
			task.spawn(v)
		end
		Config.Callback(Config.Default)
	end

	function DropdownLib:SetValues(a)
		Config.Values = a
		if not Config.AutoUpdate then
			DropdownLib:Generate()
		end
	end

	function DropdownLib:SetTitle(t)
		TitleLabel.Text = t
	end

	function DropdownLib:SetContent(t)
		if ContentLabel then
			ContentLabel.Text = t
		end
	end

	if Config.Flag then
		self.Flags[Config.Flag] = DropdownLib
	end

	return DropdownLib
end

-- =============================================================================
--                           ADD COLOR PICKER
-- =============================================================================
function Elements.AddColorPicker(self, Frame, Signel, LayerIndex, Config)
	Config = self:ProcessParams(Config , {
		Title = "Color Picker",
		Content = nil,
		Default = Color3.fromRGB(255, 255, 255),
		Callback = self._internal.EmptyFunction,
		Flag = nil
	})

	if typeof(Config.Default) == 'string' then
		Config.Default = Color3.fromHex(Config.Default:gsub('#',''))
	end

	local ColorPickerLib = {}
	local ColorFrame = Instance.new("Frame")
	local TitleLabel = Instance.new("TextLabel")
	local ContentLabel = Instance.new("TextLabel")
	local LineFrame = Instance.new("Frame")
	local ColorPicker = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local UIStroke = Instance.new("UIStroke")
	local ImageLabel = Instance.new("ImageLabel")
	local UICorner_2 = Instance.new("UICorner")
	local UICorner_3 = Instance.new("UICorner")

	self._internal.AddQuery(ColorFrame, Config.Title)

	ColorFrame.Name = self._internal.RandomString()
	ColorFrame.Parent = Frame
	ColorFrame.BackgroundColor3 = Color3.fromRGB(25, 27, 33)
	ColorFrame.BackgroundTransparency = 1.000
	ColorFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ColorFrame.BorderSizePixel = 0
	ColorFrame.Size = UDim2.new(1, 0, 0, Config.Content and 45 or 30)
	ColorFrame.ZIndex = LayerIndex + 8

	TitleLabel.Name = self._internal.RandomString()
	TitleLabel.Parent = ColorFrame
	TitleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TitleLabel.BackgroundTransparency = 1.000
	TitleLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TitleLabel.BorderSizePixel = 0
	TitleLabel.Position = UDim2.new(0, 11, 0, 6)
	TitleLabel.Size = UDim2.new(0, 1, 0, 15)
	TitleLabel.ZIndex = LayerIndex + 9
	TitleLabel.Font = Enum.Font.GothamMedium
	TitleLabel.Text = Config.Title
	TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TitleLabel.TextSize = 13.000
	TitleLabel.TextTransparency = 0.35
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

	if Config.Content and Config.Content ~= "" then
		ContentLabel.Name = self._internal.RandomString()
		ContentLabel.Parent = ColorFrame
		ContentLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ContentLabel.BackgroundTransparency = 1.000
		ContentLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ContentLabel.BorderSizePixel = 0
		ContentLabel.Position = UDim2.new(0, 11, 0, 24)
		ContentLabel.Size = UDim2.new(0, 1, 0, 12)
		ContentLabel.ZIndex = LayerIndex + 9
		ContentLabel.Font = Enum.Font.GothamMedium
		ContentLabel.Text = Config.Content
		ContentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		ContentLabel.TextSize = 10.000
		ContentLabel.TextTransparency = 0.5
		ContentLabel.TextXAlignment = Enum.TextXAlignment.Left
	end

	LineFrame.Name = self._internal.RandomString()
	LineFrame.Parent = ColorFrame
	LineFrame.AnchorPoint = Vector2.new(0.5, 1)
	LineFrame.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
	LineFrame.BackgroundTransparency = 0.650
	LineFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LineFrame.BorderSizePixel = 0
	LineFrame.Position = UDim2.new(0.5, 0, 1, 0)
	LineFrame.Size = UDim2.new(1, -20, 0, 1)
	LineFrame.ZIndex = LayerIndex + 11

	ColorPicker.Name = self._internal.RandomString()
	ColorPicker.Parent = ColorFrame
	ColorPicker.AnchorPoint = Vector2.new(1, 0.5)
	ColorPicker.BackgroundColor3 = Config.Default
	ColorPicker.BackgroundTransparency = 0
	ColorPicker.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ColorPicker.BorderSizePixel = 0
	ColorPicker.ClipsDescendants = true
	ColorPicker.Position = UDim2.new(1, -11, 0.5, 0)
	ColorPicker.Size = UDim2.new(0, 18, 0, 18)
	ColorPicker.ZIndex = LayerIndex + 13

	UICorner.CornerRadius = UDim.new(0, 4)
	UICorner.Parent = ColorPicker

	UIStroke.Transparency = 0.650
	UIStroke.Color = Color3.fromRGB(45, 48, 58)
	UIStroke.Parent = ColorPicker

	ImageLabel.Parent = ColorPicker
	ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ImageLabel.BorderSizePixel = 0
	ImageLabel.Size = UDim2.new(1, 0, 1, 0)
	ImageLabel.ZIndex = LayerIndex + 11
	ImageLabel.Image = "rbxasset://textures/meshPartFallback.png"
	ImageLabel.ImageTransparency = 0.9
	ImageLabel.BackgroundTransparency = 1
	ImageLabel.ScaleType = Enum.ScaleType.Crop

	UICorner_2.CornerRadius = UDim.new(0, 4)
	UICorner_2.Parent = ImageLabel

	UICorner_3.CornerRadius = UDim.new(0, 10)
	UICorner_3.Parent = ColorFrame

	local BackendM = self._internal.CreateColorPicker(ColorPicker)

	BackendM:SetValue(Config.Default)
	BackendM.Callback = function(color)
		ColorPicker.BackgroundColor3 = color
		Config.Default = color
		Config.Callback(Config.Default)
	end

	local signal
	self._internal.CreateInput(ColorPicker , self._internal.NeverLose.LPH_NO_VIRTUALIZE(function()
		if signal then
			signal:Disconnect()
			signal = nil
		end
		BackendM.SetRender(true)
		signal = self._internal.UserInputService.InputBegan:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				if not self._internal.IsMouseOverFrame(ColorPicker) and not self._internal.IsMouseOverFrame(BackendM.Root) then
					if signal then
						signal:Disconnect()
						signal = nil
					end
					BackendM.SetRender(false)
				end
			end
		end)
	end))

	ColorPickerLib.SetRender = self._internal.NeverLose.LPH_NO_VIRTUALIZE(function(value)
		if value then
			self._internal.PlayAnimate(ColorFrame, self._internal.SlowyTween, { BackgroundTransparency = 1 })
			self._internal.PlayAnimate(TitleLabel, self._internal.SlowyTween, { TextTransparency = 0.35 })
			if ContentLabel then
				self._internal.PlayAnimate(ContentLabel, self._internal.SlowyTween, { TextTransparency = 0.5 })
			end
			self._internal.PlayAnimate(LineFrame, self._internal.SlowyTween, { BackgroundTransparency = 0.650 })
			self._internal.PlayAnimate(ColorPicker , self._internal.SlowyTween , { BackgroundTransparency = 0 })
			self._internal.PlayAnimate(UIStroke , self._internal.SlowyTween , { Transparency = 0.650 })
			self._internal.PlayAnimate(ImageLabel , self._internal.SlowyTween , { ImageTransparency = 0.9 })
		else
			self._internal.PlayAnimate(ColorFrame, self._internal.SlowyTween, { BackgroundTransparency = 1 })
			self._internal.PlayAnimate(TitleLabel, self._internal.SlowyTween, { TextTransparency = 1 })
			if ContentLabel then
				self._internal.PlayAnimate(ContentLabel, self._internal.SlowyTween, { TextTransparency = 1 })
			end
			self._internal.PlayAnimate(LineFrame, self._internal.SlowyTween, { BackgroundTransparency = 1 })
			self._internal.PlayAnimate(ColorPicker , self._internal.SlowyTween , { BackgroundTransparency = 1 })
			self._internal.PlayAnimate(UIStroke , self._internal.SlowyTween , { Transparency = 1 })
			self._internal.PlayAnimate(ImageLabel , self._internal.SlowyTween , { ImageTransparency = 1 })
		end
	end)

	ColorPickerLib.SetRender(Signel:GetValue())
	Signel:Connect(ColorPickerLib.SetRender)

	function ColorPickerLib:GetValue()
		return Config.Default
	end

	function ColorPickerLib:SetValue(v)
		Config.Default = v
		BackendM:SetValue(Config.Default)
	end

	function ColorPickerLib:SetTitle(t)
		TitleLabel.Text = t
	end

	function ColorPickerLib:SetContent(t)
		if ContentLabel then
			ContentLabel.Text = t
		end
	end

	if Config.Flag then
		self.Flags[Config.Flag] = ColorPickerLib
	end

	return ColorPickerLib
end

-- =============================================================================
--                           ADD KEYBIND
-- =============================================================================
function Elements.AddKeybind(self, Frame, Signel, LayerIndex, Config)
	Config = self:ProcessParams(Config,{
		Title = "Keybind",
		Content = nil,
		Default = nil,
		Blacklist = {},
		Callback = self._internal.EmptyFunction,
		Flag = nil
	})

	local KeybindLib = {}
	local KeyFrame = Instance.new("Frame")
	local TitleLabel = Instance.new("TextLabel")
	local ContentLabel = Instance.new("TextLabel")
	local LineFrame = Instance.new("Frame")
	local Keybind = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local UIStroke = Instance.new("UIStroke")
	local ValueLabel = Instance.new("TextLabel")
	local UICorner_2 = Instance.new("UICorner")

	self._internal.AddQuery(KeyFrame, Config.Title)

	KeyFrame.Name = self._internal.RandomString()
	KeyFrame.Parent = Frame
	KeyFrame.BackgroundColor3 = Color3.fromRGB(25, 27, 33)
	KeyFrame.BackgroundTransparency = 1.000
	KeyFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	KeyFrame.BorderSizePixel = 0
	KeyFrame.Size = UDim2.new(1, 0, 0, Config.Content and 45 or 30)
	KeyFrame.ZIndex = LayerIndex + 8

	TitleLabel.Name = self._internal.RandomString()
	TitleLabel.Parent = KeyFrame
	TitleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TitleLabel.BackgroundTransparency = 1.000
	TitleLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TitleLabel.BorderSizePixel = 0
	TitleLabel.Position = UDim2.new(0, 11, 0, 6)
	TitleLabel.Size = UDim2.new(0, 1, 0, 15)
	TitleLabel.ZIndex = LayerIndex + 9
	TitleLabel.Font = Enum.Font.GothamMedium
	TitleLabel.Text = Config.Title
	TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TitleLabel.TextSize = 13.000
	TitleLabel.TextTransparency = 0.35
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

	if Config.Content and Config.Content ~= "" then
		ContentLabel.Name = self._internal.RandomString()
		ContentLabel.Parent = KeyFrame
		ContentLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ContentLabel.BackgroundTransparency = 1.000
		ContentLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ContentLabel.BorderSizePixel = 0
		ContentLabel.Position = UDim2.new(0, 11, 0, 24)
		ContentLabel.Size = UDim2.new(0, 1, 0, 12)
		ContentLabel.ZIndex = LayerIndex + 9
		ContentLabel.Font = Enum.Font.GothamMedium
		ContentLabel.Text = Config.Content
		ContentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		ContentLabel.TextSize = 10.000
		ContentLabel.TextTransparency = 0.5
		ContentLabel.TextXAlignment = Enum.TextXAlignment.Left
	end

	LineFrame.Name = self._internal.RandomString()
	LineFrame.Parent = KeyFrame
	LineFrame.AnchorPoint = Vector2.new(0.5, 1)
	LineFrame.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
	LineFrame.BackgroundTransparency = 0.650
	LineFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LineFrame.BorderSizePixel = 0
	LineFrame.Position = UDim2.new(0.5, 0, 1, 0)
	LineFrame.Size = UDim2.new(1, -20, 0, 1)
	LineFrame.ZIndex = LayerIndex + 11

	Keybind.Name = self._internal.RandomString()
	Keybind.Parent = KeyFrame
	Keybind.AnchorPoint = Vector2.new(1, 0.5)
	Keybind.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
	Keybind.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Keybind.BorderSizePixel = 0
	Keybind.ClipsDescendants = true
	Keybind.Position = UDim2.new(1, -11, 0.5, 0)
	Keybind.Size = UDim2.new(0, 45, 0, 18)
	Keybind.ZIndex = LayerIndex + 13

	UICorner.CornerRadius = UDim.new(0, 4)
	UICorner.Parent = Keybind

	UIStroke.Transparency = 0.650
	UIStroke.Color = Color3.fromRGB(45, 48, 58)
	UIStroke.Parent = Keybind

	ValueLabel.Name = self._internal.RandomString()
	ValueLabel.Parent = Keybind
	ValueLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	ValueLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ValueLabel.BackgroundTransparency = 1.000
	ValueLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ValueLabel.BorderSizePixel = 0
	ValueLabel.ClipsDescendants = true
	ValueLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	ValueLabel.Size = UDim2.new(1, 0, 1, 0)
	ValueLabel.ZIndex = LayerIndex + 14
	ValueLabel.Font = Enum.Font.GothamMedium
	ValueLabel.Text = self._internal.KeyCodeToStr(Config.Default or "None")
	ValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	ValueLabel.TextSize = 10.000
	ValueLabel.TextTransparency = 0.500

	UICorner_2.CornerRadius = UDim.new(0, 10)
	UICorner_2.Parent = KeyFrame

	KeybindLib.SetRender = self._internal.NeverLose.LPH_NO_VIRTUALIZE(function(value)
		if value then
			self._internal.PlayAnimate(KeyFrame, self._internal.SlowyTween, { BackgroundTransparency = 1 })
			self._internal.PlayAnimate(TitleLabel, self._internal.SlowyTween, { TextTransparency = 0.35 })
			if ContentLabel then
				self._internal.PlayAnimate(ContentLabel, self._internal.SlowyTween, { TextTransparency = 0.5 })
			end
			self._internal.PlayAnimate(LineFrame, self._internal.SlowyTween, { BackgroundTransparency = 0.650 })
			self._internal.PlayAnimate(Keybind, self._internal.SlowyTween, { BackgroundTransparency = 0 })
			self._internal.PlayAnimate(UIStroke, self._internal.SlowyTween, { Transparency = 0.650 })
			self._internal.PlayAnimate(ValueLabel, self._internal.SlowyTween, { TextTransparency = 0.500 })
		else
			self._internal.PlayAnimate(KeyFrame, self._internal.SlowyTween, { BackgroundTransparency = 1 })
			self._internal.PlayAnimate(TitleLabel, self._internal.SlowyTween, { TextTransparency = 1 })
			if ContentLabel then
				self._internal.PlayAnimate(ContentLabel, self._internal.SlowyTween, { TextTransparency = 1 })
			end
			self._internal.PlayAnimate(LineFrame, self._internal.SlowyTween, { BackgroundTransparency = 1 })
			self._internal.PlayAnimate(Keybind, self._internal.SlowyTween, { BackgroundTransparency = 1 })
			self._internal.PlayAnimate(UIStroke, self._internal.SlowyTween, { Transparency = 1 })
			self._internal.PlayAnimate(ValueLabel, self._internal.SlowyTween, { TextTransparency = 1 })
		end
	end)

	function KeybindLib:Update()
		local size = self._internal.TextService:GetTextSize(ValueLabel.Text, ValueLabel.TextSize, ValueLabel.Font, Vector2.new(math.huge, math.huge))
		self._internal.PlayAnimate(Keybind , self._internal.SlowyTween , { Size = UDim2.new(0, size.X + 7, 0, 18) })
	end

	local IsBlacklist = self._internal.NeverLose.LPH_NO_VIRTUALIZE(function(v)
		return Config.Blacklist and (Config.Blacklist[v] or table.find(Config.Blacklist,v))
	end)

	KeybindLib:Update()
	KeybindLib.SetRender(Signel:GetValue())
	Signel:Connect(KeybindLib.SetRender)

	local IsBinding = false
	self._internal.CreateInput(Keybind , function()
		if IsBinding then return end
		IsBinding = true
		ValueLabel.Text = "..."
		KeybindLib:Update()
		local Selected = nil
		while not Selected do
			local Key = self._internal.UserInputService.InputBegan:Wait()
			if Key.KeyCode ~= Enum.KeyCode.Unknown and not IsBlacklist(Key.KeyCode) and not IsBlacklist(Key.KeyCode.Name) then
				Selected = Key.KeyCode
			else
				if Key.UserInputType == Enum.UserInputType.MouseButton1 and not IsBlacklist(Enum.UserInputType.MouseButton1) and not IsBlacklist("M1B") then
					Selected = "M1B"
				elseif Key.UserInputType == Enum.UserInputType.MouseButton2 and not IsBlacklist(Enum.UserInputType.MouseButton2) and not IsBlacklist("M2B") then
					Selected = "M2B"
				end
			end
		end
		IsBinding = false
		local KeyName = typeof(Selected) == "string" and Selected or Selected.Name
		Config.Default = KeyName
		ValueLabel.Text = self._internal.KeyCodeToStr(KeyName)
		KeybindLib:Update()
		Config.Callback(KeyName)
	end)

	function KeybindLib:GetValue()
		return Config.Default
	end

	function KeybindLib:SetValue(v)
		Config.Default = v
		ValueLabel.Text = self._internal.KeyCodeToStr(v)
		KeybindLib:Update()
		Config.Callback(Config.Default)
	end

	function KeybindLib:SetTitle(t)
		TitleLabel.Text = t
	end

	function KeybindLib:SetContent(t)
		if ContentLabel then
			ContentLabel.Text = t
		end
	end

	if Config.Flag then
		self.Flags[Config.Flag] = KeybindLib
	end

	return KeybindLib
end

-- =============================================================================
--                           ADD TEXT INPUT
-- =============================================================================
function Elements.AddTextInput(self, Frame, Signel, LayerIndex, Config)
	Config = self:ProcessParams(Config , {
		Title = "Text Input",
		Content = nil,
		Default = "",
		Placeholder = "Placeholder",
		Callback = print,
		Flag = nil,
		Size = 100,
		Numeric = false,
	})

	local TextBoxLib = {}
	local TextFrame = Instance.new("Frame")
	local TitleLabel = Instance.new("TextLabel")
	local ContentLabel = Instance.new("TextLabel")
	local LineFrame = Instance.new("Frame")
	local TextInput = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local UIStroke = Instance.new("UIStroke")
	local TextBox = Instance.new("TextBox")
	local UICorner_2 = Instance.new("UICorner")

	self._internal.AddQuery(TextFrame, Config.Title)

	TextFrame.Name = self._internal.RandomString()
	TextFrame.Parent = Frame
	TextFrame.BackgroundColor3 = Color3.fromRGB(25, 27, 33)
	TextFrame.BackgroundTransparency = 1.000
	TextFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextFrame.BorderSizePixel = 0
	TextFrame.Size = UDim2.new(1, 0, 0, Config.Content and 50 or 35)
	TextFrame.ZIndex = LayerIndex + 8

	TitleLabel.Name = self._internal.RandomString()
	TitleLabel.Parent = TextFrame
	TitleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TitleLabel.BackgroundTransparency = 1.000
	TitleLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TitleLabel.BorderSizePixel = 0
	TitleLabel.Position = UDim2.new(0, 11, 0, 6)
	TitleLabel.Size = UDim2.new(0, 1, 0, 15)
	TitleLabel.ZIndex = LayerIndex + 9
	TitleLabel.Font = Enum.Font.GothamMedium
	TitleLabel.Text = Config.Title
	TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TitleLabel.TextSize = 13.000
	TitleLabel.TextTransparency = 0.35
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

	if Config.Content and Config.Content ~= "" then
		ContentLabel.Name = self._internal.RandomString()
		ContentLabel.Parent = TextFrame
		ContentLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ContentLabel.BackgroundTransparency = 1.000
		ContentLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ContentLabel.BorderSizePixel = 0
		ContentLabel.Position = UDim2.new(0, 11, 0, 24)
		ContentLabel.Size = UDim2.new(0, 1, 0, 12)
		ContentLabel.ZIndex = LayerIndex + 9
		ContentLabel.Font = Enum.Font.GothamMedium
		ContentLabel.Text = Config.Content
		ContentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		ContentLabel.TextSize = 10.000
		ContentLabel.TextTransparency = 0.5
		ContentLabel.TextXAlignment = Enum.TextXAlignment.Left
	end

	LineFrame.Name = self._internal.RandomString()
	LineFrame.Parent = TextFrame
	LineFrame.AnchorPoint = Vector2.new(0.5, 1)
	LineFrame.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
	LineFrame.BackgroundTransparency = 0.650
	LineFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LineFrame.BorderSizePixel = 0
	LineFrame.Position = UDim2.new(0.5, 0, 1, 0)
	LineFrame.Size = UDim2.new(1, -20, 0, 1)
	LineFrame.ZIndex = LayerIndex + 11

	TextInput.Name = self._internal.RandomString()
	TextInput.Parent = TextFrame
	TextInput.AnchorPoint = Vector2.new(1, 0.5)
	TextInput.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
	TextInput.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextInput.BorderSizePixel = 0
	TextInput.ClipsDescendants = true
	TextInput.Position = UDim2.new(1, -11, 0.5, 0)
	TextInput.Size = UDim2.new(0, Config.Size, 0, 18)
	TextInput.ZIndex = LayerIndex + 13

	UICorner.CornerRadius = UDim.new(0, 4)
	UICorner.Parent = TextInput

	UIStroke.Transparency = 0.650
	UIStroke.Color = Color3.fromRGB(45, 48, 58)
	UIStroke.Parent = TextInput

	TextBox.Parent = TextInput
	TextBox.AnchorPoint = Vector2.new(0, 0.5)
	TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextBox.BackgroundTransparency = 1.000
	TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextBox.BorderSizePixel = 0
	TextBox.Position = UDim2.new(0, 5, 0.5, 0)
	TextBox.Size = UDim2.new(1, -5, 0, 17)
	TextBox.ZIndex = LayerIndex + 14
	TextBox.ClearTextOnFocus = false
	TextBox.Font = Enum.Font.GothamMedium
	TextBox.PlaceholderText = Config.Placeholder
	TextBox.Text = tostring(Config.Default)
	TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextBox.TextSize = 11.000
	TextBox.TextTransparency = 0.350
	TextBox.TextXAlignment = Enum.TextXAlignment.Left

	UICorner_2.CornerRadius = UDim.new(0, 10)
	UICorner_2.Parent = TextFrame

	TextBoxLib.SetRender = self._internal.NeverLose.LPH_NO_VIRTUALIZE(function(value)
		if value then
			self._internal.PlayAnimate(TextFrame, self._internal.SlowyTween, { BackgroundTransparency = 1 })
			self._internal.PlayAnimate(TitleLabel, self._internal.SlowyTween, { TextTransparency = 0.35 })
			if ContentLabel then
				self._internal.PlayAnimate(ContentLabel, self._internal.SlowyTween, { TextTransparency = 0.5 })
			end
			self._internal.PlayAnimate(LineFrame, self._internal.SlowyTween, { BackgroundTransparency = 0.650 })
			self._internal.PlayAnimate(TextInput , self._internal.SlowyTween ,{ BackgroundTransparency = 0 })	
			self._internal.PlayAnimate(UIStroke , self._internal.SlowyTween ,{ Transparency = 0.650 })	
			self._internal.PlayAnimate(TextBox , self._internal.SlowyTween ,{ TextTransparency = 0.350 })	
		else
			self._internal.PlayAnimate(TextFrame, self._internal.SlowyTween, { BackgroundTransparency = 1 })
			self._internal.PlayAnimate(TitleLabel, self._internal.SlowyTween, { TextTransparency = 1 })
			if ContentLabel then
				self._internal.PlayAnimate(ContentLabel, self._internal.SlowyTween, { TextTransparency = 1 })
			end
			self._internal.PlayAnimate(LineFrame, self._internal.SlowyTween, { BackgroundTransparency = 1 })
			self._internal.PlayAnimate(TextInput , self._internal.SlowyTween ,{ BackgroundTransparency = 1 })	
			self._internal.PlayAnimate(UIStroke , self._internal.SlowyTween ,{ Transparency = 1 })	
			self._internal.PlayAnimate(TextBox , self._internal.SlowyTween ,{ TextTransparency = 1 })
		end
	end)

	self:AddSignal(TextBox:GetPropertyChangedSignal('Text'):Connect(self._internal.NeverLose.LPH_NO_VIRTUALIZE(function()
		local valout = self._internal.ParseInput(TextBox.Text , Config.Numeric)
		if Config.Numeric then
			TextBox.Text = string.gsub(TextBox.Text , '[^0-9.]','')
		end
		if valout then
			Config.Default = valout
			Config.Callback(valout)
		end
	end)))

	TextBoxLib.SetRender(Signel:GetValue())
	Signel:Connect(TextBoxLib.SetRender)

	function TextBoxLib:GetValue()
		return Config.Default
	end

	function TextBoxLib:SetValue(v)
		Config.Default = v
		TextBox.Text = tostring(v)
		Config.Callback(Config.Default)
	end

	function TextBoxLib:SetTitle(t)
		TitleLabel.Text = t
	end

	function TextBoxLib:SetContent(t)
		if ContentLabel then
			ContentLabel.Text = t
		end
	end

	if Config.Flag then
		self.Flags[Config.Flag] = TextBoxLib
	end

	return TextBoxLib
end

-- =============================================================================
--                           ADD OPTION (backward compatibility)
-- =============================================================================
function Elements.AddOption(self, Frame, Signel, LayerIndex, GearIcon)
	local Option = Instance.new("Frame")
	local Icon = Instance.new("TextLabel")
	local UICorner = Instance.new("UICorner")

	Option.Name = self._internal.RandomString()
	Option.Parent = Frame
	Option.BackgroundColor3 = Color3.fromRGB(39, 40, 49)
	Option.BackgroundTransparency = 1.000
	Option.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Option.BorderSizePixel = 0
	Option.ClipsDescendants = true
	Option.Size = UDim2.new(0, 20, 0, 18)
	Option.ZIndex = LayerIndex + 13
	Option.LayoutOrder = -(#Frame:GetChildren() + 5)

	Icon.Name = self._internal.RandomString()
	Icon.Parent = Option
	Icon.AnchorPoint = Vector2.new(0.5, 0.5)
	Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Icon.BackgroundTransparency = 1.000
	Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Icon.BorderSizePixel = 0
	Icon.Position = UDim2.new(0.5, 0, 0.5, 0)
	Icon.Size = UDim2.new(1, 0, 1, 0)
	Icon.ZIndex = LayerIndex + 14
	Icon.FontFace = self._internal.BuiltInBold
	Icon.Text = (GearIcon == 1 and 'gear') or (GearIcon == 2 and 'chevron-large-right') or "three-dots-horizontal"
	Icon.TextColor3 = Color3.fromRGB(223, 223, 223)
	Icon.TextSize = 16.000
	Icon.TextTransparency = 0.400
	Icon.TextWrapped = true

	UICorner.CornerRadius = UDim.new(0, 4)
	UICorner.Parent = Option

	local Window = self._internal.CreateOptionWindow(Option , LayerIndex + 13)
	local reciveSignal

	Window.SetRender = self._internal.NeverLose.LPH_NO_VIRTUALIZE(function(value)
		if value then
			self._internal.PlayAnimate(Icon , self._internal.SlowyTween , { TextTransparency = 0.400 })
		else
			self._internal.PlayAnimate(Icon , self._internal.SlowyTween , { TextTransparency = 1 })
		end
	end)

	Window.SetRender(Signel:GetValue())
	Signel:Connect(Window.SetRender)

	local bthg = self._internal.CreateInput(Option , self._internal.NeverLose.LPH_NO_VIRTUALIZE(function()
		if reciveSignal then
			reciveSignal:Disconnect()
			reciveSignal = nil	
		end
		Window.Signal:SetValue(true)
		reciveSignal = self._internal.UserInputService.InputBegan:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				if not self._internal.IsMouseOverFrame(Window.Root) and not self._internal.IsMouseOverFrame(Option) then
					if reciveSignal then
						reciveSignal:Disconnect()
						reciveSignal = nil	
					end
					Window.Signal:SetValue(false)
				end
			end
		end)
	end))

	self:AddSignal(bthg.MouseEnter:Connect(self._internal.NeverLose.LPH_NO_VIRTUALIZE(function()
		self._internal.PlayAnimate(Option , self._internal.SlowyTween , { BackgroundTransparency = 0.5 })
		self._internal.PlayAnimate(Icon , self._internal.SlowyTween , { TextTransparency = 0.25 })
	end)))

	self:AddSignal(bthg.MouseLeave:Connect(self._internal.NeverLose.LPH_NO_VIRTUALIZE(function()
		self._internal.PlayAnimate(Option , self._internal.SlowyTween , { BackgroundTransparency = 1.000 })
		self._internal.PlayAnimate(Icon , self._internal.SlowyTween , { TextTransparency = 0.400 })
	end)))

	return Window
end

-- =============================================================================
--                           ADD USER FRAME
-- =============================================================================
function Elements.AddUserFrame(self, Frame, Signel, LayerIndex, Name, Profile, Expires)
	local UserFrame = Instance.new("Frame")
	local UserLabel = Instance.new("TextLabel")
	local LineFrame = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local LogoImage = Instance.new("ImageLabel")
	local UICorner_2 = Instance.new("UICorner")
	local UserStatusLabel = Instance.new("TextLabel")

	UserFrame.Name = self._internal.RandomString()
	UserFrame.Parent = Frame
	UserFrame.BackgroundColor3 = Color3.fromRGB(25, 27, 33)
	UserFrame.BackgroundTransparency = 1.000
	UserFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	UserFrame.BorderSizePixel = 0
	UserFrame.Size = UDim2.new(1, 0, 0, 60)
	UserFrame.ZIndex = LayerIndex + 8

	UserLabel.Name = self._internal.RandomString()
	UserLabel.Parent = UserFrame
	UserLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	UserLabel.BackgroundTransparency = 1.000
	UserLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	UserLabel.BorderSizePixel = 0
	UserLabel.Position = UDim2.new(0, 65, 0, 10)
	UserLabel.Size = UDim2.new(1, -35, 0, 15)
	UserLabel.ZIndex = LayerIndex + 9
	UserLabel.Font = Enum.Font.GothamMedium
	UserLabel.Text = Name or 'User'
	UserLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	UserLabel.TextSize = 13.000
	UserLabel.TextTransparency = 0.200
	UserLabel.TextXAlignment = Enum.TextXAlignment.Left

	LineFrame.Name = self._internal.RandomString()
	LineFrame.Parent = UserFrame
	LineFrame.AnchorPoint = Vector2.new(0.5, 1)
	LineFrame.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
	LineFrame.BackgroundTransparency = 0.650
	LineFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LineFrame.BorderSizePixel = 0
	LineFrame.Position = UDim2.new(0.5, 0, 1, 0)
	LineFrame.Size = UDim2.new(1, -20, 0, 1)
	LineFrame.ZIndex = LayerIndex + 11

	UICorner.CornerRadius = UDim.new(0, 10)
	UICorner.Parent = UserFrame

	LogoImage.Name = self._internal.RandomString()
	LogoImage.Parent = UserFrame
	LogoImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LogoImage.BackgroundTransparency = 1.000
	LogoImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LogoImage.BorderSizePixel = 0
	LogoImage.Position = UDim2.new(0, 10, 0, 5)
	LogoImage.Size = UDim2.new(0, 45, 0, 45)
	LogoImage.ZIndex = LayerIndex + 9
	LogoImage.Image = Profile or "rbxasset://textures/ui/clb_robux_20@3x.png"

	UICorner_2.CornerRadius = UDim.new(1, 0)
	UICorner_2.Parent = LogoImage

	UserStatusLabel.Name = self._internal.RandomString()
	UserStatusLabel.Parent = UserFrame
	UserStatusLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	UserStatusLabel.BackgroundTransparency = 1.000
	UserStatusLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	UserStatusLabel.BorderSizePixel = 0
	UserStatusLabel.Position = UDim2.new(0, 65, 0, 25)
	UserStatusLabel.Size = UDim2.new(1, -35, 0, 15)
	UserStatusLabel.ZIndex = LayerIndex + 9
	UserStatusLabel.Font = Enum.Font.GothamMedium
	UserStatusLabel.Text = Expires or 'Never'
	UserStatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	UserStatusLabel.TextSize = 13.000
	UserStatusLabel.TextTransparency = 0.200
	UserStatusLabel.TextXAlignment = Enum.TextXAlignment.Left

	local UserFrameItem = {}

	UserFrameItem.SetRender = self._internal.NeverLose.LPH_NO_VIRTUALIZE(function(value)
		if value then
			self._internal.PlayAnimate(UserFrame, self._internal.SlowyTween, { BackgroundTransparency = 1 })
			self._internal.PlayAnimate(UserLabel, self._internal.SlowyTween, { TextTransparency = 0.200 })
			self._internal.PlayAnimate(LineFrame, self._internal.SlowyTween, { BackgroundTransparency = 0.650 })
			self._internal.PlayAnimate(LogoImage, self._internal.SlowyTween, { ImageTransparency = 0 })
			self._internal.PlayAnimate(UserStatusLabel, self._internal.SlowyTween, { TextTransparency = 0.200 })
		else
			self._internal.PlayAnimate(UserFrame, self._internal.SlowyTween, { BackgroundTransparency = 1 })
			self._internal.PlayAnimate(UserLabel, self._internal.SlowyTween, { TextTransparency = 1 })
			self._internal.PlayAnimate(LineFrame, self._internal.SlowyTween, { BackgroundTransparency = 1 })
			self._internal.PlayAnimate(LogoImage, self._internal.SlowyTween, { ImageTransparency = 1 })
			self._internal.PlayAnimate(UserStatusLabel, self._internal.SlowyTween, { TextTransparency = 1 })
		end
	end)

	UserFrameItem.SetRender(Signel:GetValue())
	Signel:Connect(UserFrameItem.SetRender)

	function UserFrameItem:SetUsername(name)
		UserLabel.Text = name or 'User'
	end

	function UserFrameItem:SetProfile(Profile)
		LogoImage.Image = Profile or "rbxasset://textures/ui/clb_robux_20@3x.png"
	end

	function UserFrameItem:SetExpires(Exp)
		UserStatusLabel.Text = Exp or 'Never'
	end

	return UserFrameItem
end

return Elements
