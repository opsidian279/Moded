--[[
    NeverLose Elements Module
    Komponen UI yang bisa di-load terpisah dari main library
    Cara penggunaan:
    local Elements = loadstring(game:HttpGet("https://raw.githubusercontent.com/opsidian279/Moded/refs/heads/main/elements/Elements.lua"))()
    Elements:Init(NeverLose)
]]

local Elements = {}

-- =============================================================================
--                               DEPENDENCIES
-- =============================================================================

local NeverLose = nil
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local TextService = game:GetService("TextService")

function Elements:Init(parentNeverLose)
    NeverLose = parentNeverLose
    return self
end

-- =============================================================================
--                                  TOGGLE
-- =============================================================================

function Elements:Toggle(Handler, Config)
    Config = Config or {}
    Config.Default = Config.Default or false
    Config.Flag = Config.Flag or nil
    Config.Callback = Config.Callback or function() end

    local ZIndex = Handler.ZIndex or Handler._ZIndex or 0
    local Signal = Handler._Signal or (Handler.Signal)

    local Toggle = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local Circle = Instance.new("Frame")
    local UICorner_2 = Instance.new("UICorner")

    Toggle.Name = NeverLose.RandomString()
    Toggle.Parent = Handler
    Toggle.BackgroundColor3 = Color3.fromRGB(10, 13, 21)
    Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Toggle.BorderSizePixel = 0
    Toggle.ClipsDescendants = true
    Toggle.Size = UDim2.new(0, 30, 0, 18)
    Toggle.ZIndex = ZIndex + 13
    Toggle.LayoutOrder = Handler.LayoutOrder and -(#Handler:GetChildren() + 5) or 0

    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = Toggle

    Circle.Name = NeverLose.RandomString()
    Circle.Parent = Toggle
    Circle.AnchorPoint = Vector2.new(0.5, 0.5)
    Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Circle.BackgroundTransparency = 0.5
    Circle.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Circle.BorderSizePixel = 0
    Circle.Position = UDim2.new(0.3, 0, 0.5, 0)
    Circle.Size = UDim2.new(0, 16, 0, 16)
    Circle.ZIndex = ZIndex + 14

    UICorner_2.CornerRadius = UDim.new(1, 0)
    UICorner_2.Parent = Circle

    local ToggleLib = { Root = Toggle }

    ToggleLib.SetUI = function(value)
        if value then
            NeverLose.PlayAnimate(Toggle, NeverLose.SlowyTween, {
                BackgroundTransparency = 0,
                BackgroundColor3 = NeverLose.AccentColor
            })
            NeverLose.PlayAnimate(Circle, NeverLose.SlowyTween, {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 0,
                Position = UDim2.new(0.7, 0, 0.5, 0)
            })
        else
            NeverLose.PlayAnimate(Toggle, NeverLose.SlowyTween, {
                BackgroundTransparency = 0,
                BackgroundColor3 = Color3.fromRGB(10, 13, 21)
            })
            NeverLose.PlayAnimate(Circle, NeverLose.SlowyTween, {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 0.5,
                Position = UDim2.new(0.3, 0, 0.5, 0)
            })
        end
    end

    ToggleLib.SetVisible = function(value)
        if value then
            ToggleLib.SetUI(Config.Default)
        else
            NeverLose.PlayAnimate(Toggle, NeverLose.SlowyTween, {
                BackgroundTransparency = 1,
                BackgroundColor3 = Color3.fromRGB(10, 13, 21)
            })
            NeverLose.PlayAnimate(Circle, NeverLose.SlowyTween, {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                Position = UDim2.new(0.3, 0, 0.5, 0)
            })
        end
    end

    ToggleLib.SetUI(Config.Default)
    ToggleLib.SetVisible(Signal and Signal:GetValue() or true)

    NeverLose:CreateInput(Toggle, function()
        Config.Default = not Config.Default
        ToggleLib.SetUI(Config.Default)
        Config.Callback(Config.Default)
    end)

    if Signal then
        ToggleLib.Signal = Signal:Connect(ToggleLib.SetVisible)
    end

    function ToggleLib:GetValue()
        return Config.Default
    end

    function ToggleLib:SetValue(v)
        Config.Default = v
        if Signal and Signal:GetValue() then
            ToggleLib.SetUI(Config.Default)
        end
        Config.Callback(Config.Default)
    end

    if Config.Flag and NeverLose.Flags then
        NeverLose.Flags[Config.Flag] = ToggleLib
    end

    return ToggleLib
end

-- =============================================================================
--                                  SLIDER
-- =============================================================================

function Elements:Slider(Handler, Config)
    Config = Config or {}
    Config.Default = Config.Default or 50
    Config.Min = Config.Min or 0
    Config.Max = Config.Max or 100
    Config.Type = Config.Type or ""
    Config.Rounding = Config.Rounding or 0
    Config.Nums = Config.Nums or {}
    Config.Flag = Config.Flag or nil
    Config.Size = Config.Size or 125
    Config.Callback = Config.Callback or function() end

    local ZIndex = Handler.ZIndex or Handler._ZIndex or 0
    local Signal = Handler._Signal or (Handler.Signal)

    local SliderLib = {}

    SliderLib.GetSize = function()
        return (Config.Default - Config.Min) / (Config.Max - Config.Min)
    end

    local FullNumSize = TextService:GetTextSize(string.rep("0", (Config.Rounding + #tostring(Config.Max)) + 1) .. tostring(Config.Type), 10, Enum.Font.GothamMedium, Vector2.new(math.huge, math.huge))
    SliderLib.MaximumSize = FullNumSize.X

    if Config.Nums then
        local nszie = 0
        for _, ns in next, Config.Nums do
            local size = TextService:GetTextSize(string.rep("m", string.len(tostring(ns))), 10, Enum.Font.GothamMedium, Vector2.new(math.huge, math.huge))
            if nszie < size.X then nszie = size.X end
        end
        if SliderLib.MaximumSize < nszie then SliderLib.MaximumSize = nszie end
    end

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
    local Frame = Instance.new("Frame")
    local UICorner_5 = Instance.new("UICorner")
    local boxSize = 2

    Slider.Name = NeverLose.RandomString()
    Slider.Parent = Handler
    Slider.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
    Slider.BackgroundTransparency = 1
    Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Slider.BorderSizePixel = 0
    Slider.ClipsDescendants = false
    Slider.Size = UDim2.new(0, Config.Size, 0, 18)
    Slider.ZIndex = ZIndex + 13
    Slider.LayoutOrder = Handler.LayoutOrder and -(#Handler:GetChildren() + 5) or 0

    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = Slider

    ValueFrame.Name = NeverLose.RandomString()
    ValueFrame.Parent = Slider
    ValueFrame.AnchorPoint = Vector2.new(1, 0)
    ValueFrame.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
    ValueFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ValueFrame.BorderSizePixel = 0
    ValueFrame.ClipsDescendants = true
    ValueFrame.Position = UDim2.new(1, 0, 0, 0)
    ValueFrame.Size = UDim2.new(0, SliderLib.MaximumSize + boxSize, 0, 18)
    ValueFrame.ZIndex = ZIndex + 13

    UICorner_2.CornerRadius = UDim.new(0, 4)
    UICorner_2.Parent = ValueFrame

    UIStroke.Transparency = 0.65
    UIStroke.Color = Color3.fromRGB(45, 48, 58)
    UIStroke.Parent = ValueFrame

    ValueLabel.Name = NeverLose.RandomString()
    ValueLabel.Parent = ValueFrame
    ValueLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    ValueLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ValueLabel.BorderSizePixel = 0
    ValueLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
    ValueLabel.Size = UDim2.new(1, 0, 1, 0)
    ValueLabel.ZIndex = ZIndex + 14
    ValueLabel.Font = Enum.Font.GothamMedium
    ValueLabel.Text = tostring(Config.Default) .. tostring(Config.Type)
    ValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ValueLabel.TextSize = 10
    ValueLabel.ClearTextOnFocus = false
    ValueLabel.TextTransparency = 0.35

    SlideMain.Name = NeverLose.RandomString()
    SlideMain.Parent = Slider
    SlideMain.AnchorPoint = Vector2.new(0, 0.5)
    SlideMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SlideMain.BackgroundTransparency = 1
    SlideMain.BorderColor3 = Color3.fromRGB(0, 0, 0)
    SlideMain.BorderSizePixel = 0
    SlideMain.Position = UDim2.new(0, 0, 0.5, 0)
    SlideMain.Size = UDim2.new(1, -((SliderLib.MaximumSize + 11)), 0, 18)
    SlideMain.ZIndex = ZIndex + 13

    SlideFrame.Name = NeverLose.RandomString()
    SlideFrame.Parent = SlideMain
    SlideFrame.AnchorPoint = Vector2.new(0, 0.5)
    SlideFrame.BackgroundColor3 = Color3.fromRGB(30, 29, 36)
    SlideFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    SlideFrame.BorderSizePixel = 0
    SlideFrame.Position = UDim2.new(0, 0, 0.5, 0)
    SlideFrame.Size = UDim2.new(1, 0, 0, 5)
    SlideFrame.ZIndex = ZIndex + 13

    UICorner_3.CornerRadius = UDim.new(1, 0)
    UICorner_3.Parent = SlideFrame

    SlideMoving.Name = NeverLose.RandomString()
    SlideMoving.Parent = SlideFrame
    SlideMoving.BackgroundColor3 = NeverLose.AccentColor
    SlideMoving.BorderColor3 = Color3.fromRGB(0, 0, 0)
    SlideMoving.BorderSizePixel = 0
    SlideMoving.Size = UDim2.new(SliderLib.GetSize(), 0, 1, 0)
    SlideMoving.ZIndex = ZIndex + 14

    UICorner_4.CornerRadius = UDim.new(1, 0)
    UICorner_4.Parent = SlideMoving

    Frame.Parent = SlideMoving
    Frame.AnchorPoint = Vector2.new(1, 0.5)
    Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BorderSizePixel = 0
    Frame.Position = UDim2.new(1, 5, 0.5, 0)
    Frame.Size = UDim2.new(0, 10, 0, 10)
    Frame.ZIndex = ZIndex + 15

    UICorner_5.CornerRadius = UDim.new(1, 0)
    UICorner_5.Parent = Frame

    local LoadText = function()
        if Config.Nums[Config.Default] then
            ValueLabel.Text = Config.Nums[Config.Default]
        else
            ValueLabel.Text = tostring(Config.Default) .. tostring(Config.Type)
        end
    end

    ValueLabel.FocusLost:Connect(function()
        local OutVal = NeverLose:ParseInput(ValueLabel.Text, true)
        if OutVal then
            local rx = math.clamp(OutVal, Config.Min, Config.Max)
            local Value = NeverLose.Rounding(rx, Config.Rounding)
            if Value then
                Config.Default = Value
                TweenService:Create(SlideMoving, NeverLose.ManualTween, { Size = UDim2.new(SliderLib.GetSize(), 0, 1, 0) }):Play()
                LoadText()
                Config.Callback(Config.Default)
            else
                LoadText()
            end
        else
            LoadText()
        end
    end)

    SliderLib.SetRender = function(value)
        if value then
            NeverLose.PlayAnimate(ValueFrame, NeverLose.SlowyTween, { BackgroundTransparency = 0, Size = UDim2.new(0, SliderLib.MaximumSize + boxSize, 0, 18) })
            NeverLose.PlayAnimate(UIStroke, NeverLose.SlowyTween, { Transparency = 0.65 })
            NeverLose.PlayAnimate(ValueLabel, NeverLose.SlowyTween, { TextTransparency = 0.35 })
            NeverLose.PlayAnimate(SlideFrame, NeverLose.SlowyTween, { BackgroundTransparency = 0 })
            NeverLose.PlayAnimate(SlideMoving, NeverLose.SlowyTween, { BackgroundTransparency = 0, Size = UDim2.new(SliderLib.GetSize(), 0, 1, 0) })
            NeverLose.PlayAnimate(Frame, NeverLose.SlowyTween, { BackgroundTransparency = 0 })
        else
            NeverLose.PlayAnimate(ValueFrame, NeverLose.SlowyTween, { BackgroundTransparency = 1 })
            NeverLose.PlayAnimate(UIStroke, NeverLose.SlowyTween, { Transparency = 1 })
            NeverLose.PlayAnimate(ValueLabel, NeverLose.SlowyTween, { TextTransparency = 1 })
            NeverLose.PlayAnimate(SlideFrame, NeverLose.SlowyTween, { BackgroundTransparency = 1 })
            NeverLose.PlayAnimate(SlideMoving, NeverLose.SlowyTween, { BackgroundTransparency = 1, Size = UDim2.new(0, 0, 1, 0) })
            NeverLose.PlayAnimate(Frame, NeverLose.SlowyTween, { BackgroundTransparency = 1 })
        end
    end

    SliderLib.SetRender(Signal and Signal:GetValue() or true)
    if Signal then
        SliderLib.Signal = Signal:Connect(SliderLib.SetRender)
    end

    local Update = function(Input)
        local SizeScale = math.clamp(((Input.Position.X - SlideMain.AbsolutePosition.X) / SlideMain.AbsoluteSize.X), 0, 1)
        local Main = ((Config.Max - Config.Min) * SizeScale) + Config.Min
        local Value = NeverLose.Rounding(Main, Config.Rounding)
        Config.Default = Value
        TweenService:Create(SlideMoving, NeverLose.ManualTween, { Size = UDim2.new(SliderLib.GetSize(), 0, 1, 0) }):Play()
        LoadText()
        Config.Callback(Value)
    end

    local IsHold = false

    SlideMain.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            IsHold = true
            Update(Input)
        end
    end)

    SlideMain.InputEnded:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            IsHold = false
        end
    end)

    UserInputService.InputChanged:Connect(function(Input)
        if IsHold then
            if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                Update(Input)
            end
        end
    end)

    function SliderLib:GetValue()
        return Config.Default
    end

    function SliderLib:SetValue(v)
        Config.Default = v
        if Signal and Signal:GetValue() then
            NeverLose.PlayAnimate(SlideMoving, NeverLose.SlowyTween, { BackgroundTransparency = 0, Size = UDim2.new(SliderLib.GetSize(), 0, 1, 0) })
        end
        LoadText()
        Config.Callback(Config.Default)
    end

    if Config.Flag and NeverLose.Flags then
        NeverLose.Flags[Config.Flag] = SliderLib
    end

    return SliderLib
end

-- =============================================================================
--                                  BUTTON
-- =============================================================================

function Elements:Button(Handler, Config)
    Config = Config or {}
    Config.Icon = Config.Icon or "chevron-large-left"
    Config.Name = Config.Name or "Button"
    Config.Callback = Config.Callback or function() end
    Config.ToolTip = Config.ToolTip or nil

    local ZIndex = Handler.ZIndex or Handler._ZIndex or 0
    local Signal = Handler._Signal or (Handler.Signal)
    local LayerIndex = Handler._LayerIndex or ZIndex

    local Button = {}
    local ButtonFrame = Instance.new("Frame")
    local BasedLabel = Instance.new("TextLabel")
    local LineFrame = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local Icon = Instance.new("TextLabel")

    if NeverLose.AddQuery then
        NeverLose:AddQuery(ButtonFrame, Config.Name)
    end

    ButtonFrame.Name = NeverLose.RandomString()
    ButtonFrame.Parent = Handler
    ButtonFrame.BackgroundColor3 = Color3.fromRGB(25, 27, 33)
    ButtonFrame.BackgroundTransparency = 1
    ButtonFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ButtonFrame.BorderSizePixel = 0
    ButtonFrame.Size = UDim2.new(1, 0, 0, 30)
    ButtonFrame.ZIndex = LayerIndex + 8

    BasedLabel.Name = NeverLose.RandomString()
    BasedLabel.Parent = ButtonFrame
    BasedLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    BasedLabel.BackgroundTransparency = 1
    BasedLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    BasedLabel.BorderSizePixel = 0
    BasedLabel.Position = UDim2.new(0, 35, 0, 6)
    BasedLabel.Size = UDim2.new(0, 1, 0, 15)
    BasedLabel.ZIndex = LayerIndex + 9
    BasedLabel.Font = Enum.Font.GothamMedium
    BasedLabel.Text = Config.Name
    BasedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    BasedLabel.TextSize = 13
    BasedLabel.TextTransparency = 0.2
    BasedLabel.TextXAlignment = Enum.TextXAlignment.Left

    LineFrame.Name = NeverLose.RandomString()
    LineFrame.Parent = ButtonFrame
    LineFrame.AnchorPoint = Vector2.new(0.5, 1)
    LineFrame.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
    LineFrame.BackgroundTransparency = 0.65
    LineFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    LineFrame.BorderSizePixel = 0
    LineFrame.Position = UDim2.new(0.5, 0, 1, 0)
    LineFrame.Size = UDim2.new(1, -20, 0, 1)
    LineFrame.ZIndex = LayerIndex + 11

    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = ButtonFrame

    Icon.Name = NeverLose.RandomString()
    Icon.Parent = ButtonFrame
    Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Icon.BackgroundTransparency = 1
    Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Icon.BorderSizePixel = 0
    Icon.Position = UDim2.new(0, 11, 0, 5)
    Icon.Size = UDim2.new(0, 18, 0, 18)
    Icon.ZIndex = LayerIndex + 9
    Icon.FontFace = NeverLose.BuiltInBold
    Icon.Text = Config.Icon
    Icon.TextColor3 = Color3.fromRGB(223, 223, 223)
    Icon.TextSize = 16
    Icon.TextTransparency = 0.25
    Icon.TextWrapped = true

    function Button:SetText(t)
        BasedLabel.Text = t
    end

    function Button:SetIcon(t)
        Icon.Text = t
    end

    local bth = NeverLose:CreateInput(ButtonFrame, function()
        Config.Callback()
    end)

    NeverLose:AddSignal(bth.MouseEnter:Connect(function()
        NeverLose.PlayAnimate(ButtonFrame, NeverLose.SlowyTween, { BackgroundTransparency = 0.35 })
    end))

    NeverLose:AddSignal(bth.MouseLeave:Connect(function()
        NeverLose.PlayAnimate(ButtonFrame, NeverLose.SlowyTween, { BackgroundTransparency = 1 })
    end))

    Button.SetRender = function(value)
        if value then
            NeverLose.PlayAnimate(ButtonFrame, NeverLose.SlowyTween, { BackgroundTransparency = 1 })
            NeverLose.PlayAnimate(BasedLabel, NeverLose.SlowyTween, { TextTransparency = 0.2 })
            NeverLose.PlayAnimate(LineFrame, NeverLose.SlowyTween, { BackgroundTransparency = 0.65 })
            NeverLose.PlayAnimate(Icon, NeverLose.SlowyTween, { TextTransparency = 0.25 })
        else
            NeverLose.PlayAnimate(ButtonFrame, NeverLose.SlowyTween, { BackgroundTransparency = 1 })
            NeverLose.PlayAnimate(BasedLabel, NeverLose.SlowyTween, { TextTransparency = 1 })
            NeverLose.PlayAnimate(LineFrame, NeverLose.SlowyTween, { BackgroundTransparency = 1 })
            NeverLose.PlayAnimate(Icon, NeverLose.SlowyTween, { TextTransparency = 1 })
        end
    end

    if Config.ToolTip and NeverLose.CreateToolTips then
        Button.ToolTip = NeverLose:CreateToolTips(ButtonFrame, Config.Name, Config.ToolTip)
    end

    Button.SetRender(Signal and Signal:GetValue() or true)
    if Signal then
        Signal:Connect(Button.SetRender)
    end

    return Button
end

-- =============================================================================
--                                DROPDOWN
-- =============================================================================

function Elements:Dropdown(Handler, Config)
    Config = Config or {}
    Config.Default = Config.Default or nil
    Config.Values = Config.Values or {}
    Config.Multi = Config.Multi or false
    Config.Callback = Config.Callback or function() end
    Config.AutoUpdate = Config.AutoUpdate or false
    Config.Flag = Config.Flag or nil
    Config.Size = Config.Size or 100

    local ZIndex = Handler.ZIndex or Handler._ZIndex or 0
    local Signal = Handler._Signal or (Handler.Signal)

    Config.Default = NeverLose.ProcessDropdown(Config.Default)

    local Dropdown = Instance.new("Frame")
    local DropdownIcon = Instance.new("TextLabel")
    local UICorner = Instance.new("UICorner")
    local UIStroke = Instance.new("UIStroke")
    local BasedLabel = Instance.new("TextLabel")

    Dropdown.Name = NeverLose.RandomString()
    Dropdown.Parent = Handler
    Dropdown.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
    Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Dropdown.BorderSizePixel = 0
    Dropdown.ClipsDescendants = true
    Dropdown.Size = UDim2.new(0, Config.Size, 0, 18)
    Dropdown.ZIndex = ZIndex + 13

    DropdownIcon.Name = NeverLose.RandomString()
    DropdownIcon.Parent = Dropdown
    DropdownIcon.AnchorPoint = Vector2.new(1, 0.5)
    DropdownIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    DropdownIcon.BackgroundTransparency = 1
    DropdownIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
    DropdownIcon.BorderSizePixel = 0
    DropdownIcon.Position = UDim2.new(1, -2, 0.5, 0)
    DropdownIcon.Size = UDim2.new(0, 18, 0, 18)
    DropdownIcon.ZIndex = ZIndex + 14
    DropdownIcon.FontFace = NeverLose.BuiltInBold
    DropdownIcon.Text = "chevron-small-down"
    DropdownIcon.TextColor3 = Color3.fromRGB(223, 223, 223)
    DropdownIcon.TextSize = 16
    DropdownIcon.TextTransparency = 0.25
    DropdownIcon.TextWrapped = true

    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = Dropdown

    UIStroke.Transparency = 0.65
    UIStroke.Color = Color3.fromRGB(45, 48, 58)
    UIStroke.Parent = Dropdown

    BasedLabel.Name = NeverLose.RandomString()
    BasedLabel.Parent = Dropdown
    BasedLabel.AnchorPoint = Vector2.new(0, 0.5)
    BasedLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    BasedLabel.BackgroundTransparency = 1
    BasedLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    BasedLabel.BorderSizePixel = 0
    BasedLabel.ClipsDescendants = true
    BasedLabel.Position = UDim2.new(0, 5, 0.5, 0)
    BasedLabel.Size = UDim2.new(1, -25, 0, 15)
    BasedLabel.ZIndex = ZIndex + 14
    BasedLabel.Font = Enum.Font.GothamMedium
    BasedLabel.Text = NeverLose.ParseDropdown(Config.Default)
    BasedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    BasedLabel.TextSize = 12
    BasedLabel.TextTransparency = 0.5
    BasedLabel.TextXAlignment = Enum.TextXAlignment.Left

    local UIGradient = Instance.new("UIGradient")
    UIGradient.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0.00, 0.00),
        NumberSequenceKeypoint.new(0.85, 0.23),
        NumberSequenceKeypoint.new(1.00, 1.00)
    }
    UIGradient.Parent = BasedLabel

    NeverLose:AddSignal(Dropdown.MouseEnter:Connect(function()
        NeverLose.PlayAnimate(BasedLabel, NeverLose.SlowyTween, { TextTransparency = 0.2 })
    end))

    NeverLose:AddSignal(Dropdown.MouseLeave:Connect(function()
        NeverLose.PlayAnimate(BasedLabel, NeverLose.SlowyTween, { TextTransparency = 0.5 })
    end))

    local DropdownLib = {
        OpenSignal = NeverLose:CreateSignal(false),
        Signals = {},
        Refuse = {},
    }

    DropdownLib.SetRender = function(value)
        if value then
            NeverLose.PlayAnimate(Dropdown, NeverLose.SlowyTween, { BackgroundTransparency = 0 })
            NeverLose.PlayAnimate(DropdownIcon, NeverLose.SlowyTween, { TextTransparency = 0.25 })
            NeverLose.PlayAnimate(UIStroke, NeverLose.SlowyTween, { Transparency = 0.65 })
            NeverLose.PlayAnimate(BasedLabel, NeverLose.SlowyTween, { TextTransparency = 0.5 })
        else
            NeverLose.PlayAnimate(Dropdown, NeverLose.SlowyTween, { BackgroundTransparency = 1 })
            NeverLose.PlayAnimate(DropdownIcon, NeverLose.SlowyTween, { TextTransparency = 1 })
            NeverLose.PlayAnimate(UIStroke, NeverLose.SlowyTween, { Transparency = 1 })
            NeverLose.PlayAnimate(BasedLabel, NeverLose.SlowyTween, { TextTransparency = 1 })
        end
    end

    DropdownLib.SetRender(Signal and Signal:GetValue() or true)
    if Signal then
        Signal:Connect(DropdownLib.SetRender)
    end
    DropdownLib.ExtentSize = 0

    do
        local DropdownHandler = Instance.new("Frame")
        local UICorner = Instance.new("UICorner")
        local UIStroke = Instance.new("UIStroke")
        local DropdownScrollFrame = Instance.new("ScrollingFrame")
        local UIListLayout = Instance.new("UIListLayout")
        local Shadow = NeverLose:CreateShadow(DropdownHandler)

        DropdownHandler.Name = NeverLose.RandomString()
        DropdownHandler.Parent = NeverLose.ScreenGui
        DropdownHandler.AnchorPoint = Vector2.new(0.5, 0)
        DropdownHandler.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
        DropdownHandler.BackgroundTransparency = 0.5
        DropdownHandler.BorderColor3 = Color3.fromRGB(0, 0, 0)
        DropdownHandler.BorderSizePixel = 0
        DropdownHandler.ClipsDescendants = true
        DropdownHandler.Position = UDim2.new(255, 255, 255, 255)
        DropdownHandler.Size = UDim2.new(0, 125, 0, 50)
        DropdownHandler.ZIndex = ZIndex + 125
        DropdownLib.BlockRoot = DropdownHandler

        NeverLose:AddSignal(DropdownHandler:GetPropertyChangedSignal("BackgroundTransparency"):Connect(function()
            if DropdownHandler.BackgroundTransparency > 0.9 then
                DropdownHandler.Visible = false
                DropdownHandler.Parent = nil
            else
                DropdownHandler.Visible = true
                if NeverLose.Global3DRenderMode then
                    DropdownHandler.Parent = NeverLose.GlobalSurfaceGui
                else
                    DropdownHandler.Parent = NeverLose.ScreenGui
                end
            end
        end))

        UICorner.CornerRadius = UDim.new(0, 10)
        UICorner.Parent = DropdownHandler

        UIStroke.Transparency = 0.65
        UIStroke.Color = Color3.fromRGB(45, 48, 58)
        UIStroke.Parent = DropdownHandler

        DropdownScrollFrame.Name = NeverLose.RandomString()
        DropdownScrollFrame.Parent = DropdownHandler
        DropdownScrollFrame.Active = true
        DropdownScrollFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        DropdownScrollFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        DropdownScrollFrame.BackgroundTransparency = 1
        DropdownScrollFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        DropdownScrollFrame.BorderSizePixel = 0
        DropdownScrollFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        DropdownScrollFrame.Size = UDim2.new(1, -5, 1, -5)
        DropdownScrollFrame.ZIndex = ZIndex + 127
        DropdownScrollFrame.ScrollBarThickness = 0

        DropdownLib.RootItem = DropdownScrollFrame

        UIListLayout.Parent = DropdownScrollFrame
        UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

        NeverLose:AddSignal(UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            DropdownScrollFrame.CanvasSize = UDim2.fromOffset(0, UIListLayout.AbsoluteContentSize.Y)
            NeverLose.PlayAnimate(DropdownHandler, NeverLose.SlowyTween, {
                Size = UDim2.new(0, (Dropdown.AbsoluteSize.X + 5) + DropdownLib.ExtentSize, 0, math.min(UIListLayout.AbsoluteContentSize.Y + 5, 250))
            })
        end))

        local SetPosition = function()
            if NeverLose:MoreThanHalfY(Dropdown.AbsolutePosition.Y + 85) then
                DropdownHandler.AnchorPoint = Vector2.new(0.5, 1)
            else
                DropdownHandler.AnchorPoint = Vector2.new(0.5, 0)
            end
            DropdownHandler.Position = UDim2.fromOffset(Dropdown.AbsolutePosition.X + (DropdownHandler.AbsoluteSize.X / 2), Dropdown.AbsolutePosition.Y + 85)
        end

        DropdownLib.SetFrameRender = function(value)
            DropdownLib.OpenSignal:SetValue(value)
            if value then
                Shadow:Render(true)
                DropdownHandler.Size = UDim2.new(0, (Dropdown.AbsoluteSize.X + 5) + DropdownLib.ExtentSize, 0, math.min(UIListLayout.AbsoluteContentSize.Y + 5, 250))
                SetPosition()
                NeverLose.PlayAnimate(DropdownHandler, NeverLose.SlowyTween, { BackgroundTransparency = 0.035 })
                if Config.AutoUpdate then
                    DropdownLib:Generate()
                end
            else
                NeverLose.PlayAnimate(DropdownHandler, NeverLose.SlowyTween, { BackgroundTransparency = 1 })
                Shadow:Render(false)
            end
        end

        DropdownLib.SetFrameRender(false)
    end

    local SecureSignal
    NeverLose:CreateInput(Dropdown, function()
        if SecureSignal then
            SecureSignal:Disconnect()
            SecureSignal = nil
        end
        DropdownLib.SetFrameRender(true)
        NeverLose.IsMosueOverOtherFrame = true
        SecureSignal = UserInputService.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                if not NeverLose:IsMouseOverFrame(DropdownLib.BlockRoot) and not NeverLose:IsMouseOverFrame(Dropdown) then
                    if SecureSignal then
                        SecureSignal:Disconnect()
                        SecureSignal = nil
                    end
                    NeverLose.IsMosueOverOtherFrame = false
                    DropdownLib.SetFrameRender(false)
                end
            end
        end)
    end)

    DropdownLib.IsMatch = function(v1)
        if type(Config.Default) == "table" then
            if Config.Default[v1] or table.find(Config.Default, v1) then
                return true
            end
        end
        if Config.Default == v1 then
            return true
        end
        return false
    end

    function DropdownLib:Generate()
        for _, v in next, DropdownLib.RootItem:GetChildren() do
            if v:IsA("Frame") then
                v:Destroy()
            end
        end

        for _, v in next, DropdownLib.Signals do
            v:Disconnect()
        end

        table.clear(DropdownLib.Signals)
        table.clear(DropdownLib.Refuse)

        for _, Value in next, Config.Values do
            local ItemFrame = Instance.new("Frame")
            local ItemLabel = Instance.new("TextLabel")
            local UICorner = Instance.new("UICorner")

            ItemFrame.Name = NeverLose.RandomString()
            ItemFrame.Parent = DropdownLib.RootItem
            ItemFrame.BackgroundColor3 = Color3.fromRGB(29, 31, 38)
            ItemFrame.BackgroundTransparency = 1
            ItemFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
            ItemFrame.BorderSizePixel = 0
            ItemFrame.Size = UDim2.new(1, 0, 0, 25)
            ItemFrame.ZIndex = ZIndex + 1258

            ItemLabel.Name = NeverLose.RandomString()
            ItemLabel.Parent = ItemFrame
            ItemLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ItemLabel.BackgroundTransparency = 1
            ItemLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
            ItemLabel.BorderSizePixel = 0
            ItemLabel.Position = UDim2.new(0, 15, 0, 4)
            ItemLabel.Size = UDim2.new(0, 1, 0, 15)
            ItemLabel.ZIndex = ZIndex + 1258
            ItemLabel.Font = Enum.Font.GothamMedium
            ItemLabel.Text = tostring(Value)
            ItemLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            ItemLabel.TextSize = 13
            ItemLabel.TextTransparency = 0.2
            ItemLabel.TextXAlignment = Enum.TextXAlignment.Left

            UICorner.CornerRadius = UDim.new(0, 10)
            UICorner.Parent = ItemFrame

            local sizetext = TextService:GetTextSize(ItemLabel.Text, ItemLabel.TextSize, ItemLabel.Font, Vector2.new(math.huge, math.huge))
            DropdownLib.ExtentSize = math.max(DropdownLib.ExtentSize, sizetext.X)

            local MIcon, MarkItem = nil, nil

            if Config.Multi then
                local Icon = Instance.new("TextLabel")
                Icon.Parent = ItemFrame
                Icon.AnchorPoint = Vector2.new(0, 0.5)
                Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Icon.BackgroundTransparency = 1
                Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Icon.BorderSizePixel = 0
                Icon.Position = UDim2.new(0, 5, 0.5, 0)
                Icon.Size = UDim2.new(0, 20, 0, 20)
                Icon.ZIndex = ZIndex + 1259
                Icon.FontFace = NeverLose.BuiltInBold
                Icon.Text = "check"
                Icon.TextColor3 = Color3.fromRGB(223, 223, 223)
                Icon.TextSize = 18
                Icon.TextTransparency = 1
                Icon.TextWrapped = true

                local VisiblewOfMult = function()
                    if DropdownLib.IsMatch(Value) then
                        NeverLose.PlayAnimate(ItemLabel, NeverLose.VSlowTween, { TextTransparency = 0.2, Position = UDim2.new(0, 30, 0, 4) })
                        NeverLose.PlayAnimate(Icon, NeverLose.VSlowTween, { TextTransparency = 0.25 })
                    else
                        NeverLose.PlayAnimate(Icon, NeverLose.SlowyTween, { TextTransparency = 1 })
                        NeverLose.PlayAnimate(ItemLabel, NeverLose.VSlowTween, { TextTransparency = 0.5, Position = UDim2.new(0, 15, 0, 4) })
                    end
                end

                MIcon = Icon
                MarkItem = VisiblewOfMult
            else
                local DefaultVisible = function()
                    if DropdownLib.IsMatch(Value) then
                        NeverLose.PlayAnimate(ItemLabel, NeverLose.SlowyTween, { TextTransparency = 0.2 })
                    else
                        NeverLose.PlayAnimate(ItemLabel, NeverLose.SlowyTween, { TextTransparency = 0.5 })
                    end
                end
                MarkItem = DefaultVisible
            end

            MarkItem()
            table.insert(DropdownLib.Refuse, MarkItem)

            table.insert(DropdownLib.Signals, ItemFrame.MouseEnter:Connect(function()
                NeverLose.PlayAnimate(ItemFrame, NeverLose.SlowyTween, { BackgroundTransparency = 0.1 })
            end))

            table.insert(DropdownLib.Signals, ItemFrame.MouseLeave:Connect(function()
                NeverLose.PlayAnimate(ItemFrame, NeverLose.SlowyTween, { BackgroundTransparency = 1 })
            end))

            table.insert(DropdownLib.Signals, DropdownLib.OpenSignal:Connect(function(val)
                if val then
                    MarkItem()
                else
                    NeverLose.PlayAnimate(ItemLabel, NeverLose.SlowyTween, { TextTransparency = 1 })
                    if MIcon then
                        NeverLose.PlayAnimate(MIcon, NeverLose.SlowyTween, { TextTransparency = 1 })
                    end
                end
            end))

            if Config.Multi then
                local _, bth_signal = NeverLose:CreateInput(ItemFrame, function()
                    Config.Default[Value] = not Config.Default[Value]
                    MarkItem()
                    BasedLabel.Text = NeverLose.ParseDropdown(Config.Default)
                    Config.Callback(Config.Default)
                end)
                table.insert(DropdownLib.Signals, bth_signal)
            else
                local _, bth_signal = NeverLose:CreateInput(ItemFrame, function()
                    Config.Default = Value
                    for _, v in next, DropdownLib.Refuse do
                        task.spawn(v)
                    end
                    BasedLabel.Text = NeverLose.ParseDropdown(Config.Default)
                    Config.Callback(Config.Default)
                end)
                table.insert(DropdownLib.Signals, bth_signal)
            end
        end
    end

    DropdownLib:Generate()

    function DropdownLib:GetValue()
        return Config.Default
    end

    function DropdownLib:SetValue(v)
        Config.Default = v
        BasedLabel.Text = NeverLose.ParseDropdown(Config.Default)
        for _, v in next, DropdownLib.Refuse do
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

    if Config.Flag and NeverLose.Flags then
        NeverLose.Flags[Config.Flag] = DropdownLib
    end

    return DropdownLib
end

-- =============================================================================
--                               COLOR PICKER
-- =============================================================================

function Elements:ColorPicker(Handler, Config)
    Config = Config or {}
    Config.Default = Config.Default or Color3.fromRGB(255, 255, 255)
    Config.Callback = Config.Callback or function() end
    Config.Flag = Config.Flag or nil

    local ZIndex = Handler.ZIndex or Handler._ZIndex or 0
    local Signal = Handler._Signal or (Handler.Signal)

    if type(Config.Default) == "string" then
        Config.Default = Color3.fromHex(Config.Default:gsub("#", ""))
    end

    local ColorPickerLib = {}
    local ColorPicker = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local UIStroke = Instance.new("UIStroke")
    local ImageLabel = Instance.new("ImageLabel")
    local UICorner_2 = Instance.new("UICorner")

    ColorPicker.Name = NeverLose.RandomString()
    ColorPicker.Parent = Handler
    ColorPicker.BackgroundColor3 = Config.Default
    ColorPicker.BackgroundTransparency = 0
    ColorPicker.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ColorPicker.BorderSizePixel = 0
    ColorPicker.ClipsDescendants = true
    ColorPicker.Size = UDim2.new(0, 18, 0, 18)
    ColorPicker.ZIndex = ZIndex + 13

    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = ColorPicker

    UIStroke.Transparency = 0.65
    UIStroke.Color = Color3.fromRGB(45, 48, 58)
    UIStroke.Parent = ColorPicker

    ImageLabel.Parent = ColorPicker
    ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ImageLabel.BorderSizePixel = 0
    ImageLabel.Size = UDim2.new(1, 0, 1, 0)
    ImageLabel.ZIndex = ZIndex + 11
    ImageLabel.Image = "rbxasset://textures/meshPartFallback.png"
    ImageLabel.ImageTransparency = 0.9
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.ScaleType = Enum.ScaleType.Crop

    UICorner_2.CornerRadius = UDim.new(0, 4)
    UICorner_2.Parent = ImageLabel

    local BackendM = NeverLose:CreateColorPicker(ColorPicker)

    BackendM:SetValue(Config.Default)
    BackendM.Callback = function(color)
        ColorPicker.BackgroundColor3 = color
        Config.Default = color
        Config.Callback(Config.Default)
    end

    local signal
    NeverLose:CreateInput(ColorPicker, function()
        if signal then
            signal:Disconnect()
            signal = nil
        end
        BackendM.SetRender(true)
        signal = UserInputService.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                if not NeverLose:IsMouseOverFrame(ColorPicker) and not NeverLose:IsMouseOverFrame(BackendM.Root) then
                    if signal then
                        signal:Disconnect()
                        signal = nil
                    end
                    BackendM.SetRender(false)
                end
            end
        end)
    end)

    ColorPickerLib.SetRender = function(value)
        if value then
            NeverLose.PlayAnimate(ColorPicker, NeverLose.SlowyTween, { BackgroundTransparency = 0 })
            NeverLose.PlayAnimate(UIStroke, NeverLose.SlowyTween, { Transparency = 0.65 })
            NeverLose.PlayAnimate(ImageLabel, NeverLose.SlowyTween, { ImageTransparency = 0.9 })
        else
            NeverLose.PlayAnimate(ColorPicker, NeverLose.SlowyTween, { BackgroundTransparency = 1 })
            NeverLose.PlayAnimate(UIStroke, NeverLose.SlowyTween, { Transparency = 1 })
            NeverLose.PlayAnimate(ImageLabel, NeverLose.SlowyTween, { ImageTransparency = 1 })
        end
    end

    ColorPickerLib.SetRender(Signal and Signal:GetValue() or true)
    if Signal then
        Signal:Connect(ColorPickerLib.SetRender)
    end

    function ColorPickerLib:GetValue()
        return Config.Default
    end

    function ColorPickerLib:SetValue(v)
        Config.Default = v
        BackendM:SetValue(Config.Default)
    end

    if Config.Flag and NeverLose.Flags then
        NeverLose.Flags[Config.Flag] = ColorPickerLib
    end

    return ColorPickerLib
end

-- =============================================================================
--                                KEYBIND
-- =============================================================================

function Elements:Keybind(Handler, Config)
    Config = Config or {}
    Config.Default = Config.Default or nil
    Config.Blacklist = Config.Blacklist or {}
    Config.Callback = Config.Callback or function() end
    Config.Flag = Config.Flag or nil

    local ZIndex = Handler.ZIndex or Handler._ZIndex or 0
    local Signal = Handler._Signal or (Handler.Signal)

    local KeybindLib = {}

    local Keybind = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local UIStroke = Instance.new("UIStroke")
    local ValueLabel = Instance.new("TextLabel")

    Keybind.Name = NeverLose.RandomString()
    Keybind.Parent = Handler
    Keybind.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
    Keybind.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Keybind.BorderSizePixel = 0
    Keybind.ClipsDescendants = true
    Keybind.Size = UDim2.new(0, 45, 0, 18)
    Keybind.ZIndex = ZIndex + 13

    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = Keybind

    UIStroke.Transparency = 0.65
    UIStroke.Color = Color3.fromRGB(45, 48, 58)
    UIStroke.Parent = Keybind

    ValueLabel.Name = NeverLose.RandomString()
    ValueLabel.Parent = Keybind
    ValueLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    ValueLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ValueLabel.BorderSizePixel = 0
    ValueLabel.ClipsDescendants = true
    ValueLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
    ValueLabel.Size = UDim2.new(1, 0, 1, 0)
    ValueLabel.ZIndex = ZIndex + 14
    ValueLabel.Font = Enum.Font.GothamMedium
    ValueLabel.Text = NeverLose:KeyCodeToStr(Config.Default or "None")
    ValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ValueLabel.TextSize = 10
    ValueLabel.TextTransparency = 0.5

    KeybindLib.SetRender = function(value)
        if value then
            NeverLose.PlayAnimate(Keybind, NeverLose.SlowyTween, { BackgroundTransparency = 0 })
            NeverLose.PlayAnimate(UIStroke, NeverLose.SlowyTween, { Transparency = 0.65 })
            NeverLose.PlayAnimate(ValueLabel, NeverLose.SlowyTween, { TextTransparency = 0.5 })
        else
            NeverLose.PlayAnimate(Keybind, NeverLose.SlowyTween, { BackgroundTransparency = 1 })
            NeverLose.PlayAnimate(UIStroke, NeverLose.SlowyTween, { Transparency = 1 })
            NeverLose.PlayAnimate(ValueLabel, NeverLose.SlowyTween, { TextTransparency = 1 })
        end
    end

    function KeybindLib:Update()
        local size = TextService:GetTextSize(ValueLabel.Text, ValueLabel.TextSize, ValueLabel.Font, Vector2.new(math.huge, math.huge))
        NeverLose.PlayAnimate(Keybind, NeverLose.SlowyTween, { Size = UDim2.new(0, size.X + 7, 0, 18) })
    end

    local IsBlacklist = function(v)
        return Config.Blacklist and (Config.Blacklist[v] or table.find(Config.Blacklist, v))
    end

    KeybindLib:Update()
    KeybindLib.SetRender(Signal and Signal:GetValue() or true)
    if Signal then
        Signal:Connect(KeybindLib.SetRender)
    end

    local IsBinding = false
    NeverLose:CreateInput(Keybind, function()
        if IsBinding then return end
        IsBinding = true
        ValueLabel.Text = "..."
        KeybindLib:Update()
        local Selected = nil
        while not Selected do
            local Key = UserInputService.InputBegan:Wait()
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
        local KeyName = type(Selected) == "string" and Selected or Selected.Name
        Config.Default = KeyName
        ValueLabel.Text = NeverLose:KeyCodeToStr(KeyName)
        KeybindLib:Update()
        Config.Callback(KeyName)
    end)

    function KeybindLib:GetValue()
        return Config.Default
    end

    function KeybindLib:SetValue(v)
        Config.Default = v
        ValueLabel.Text = NeverLose:KeyCodeToStr(v)
        KeybindLib:Update()
        Config.Callback(Config.Default)
    end

    if Config.Flag and NeverLose.Flags then
        NeverLose.Flags[Config.Flag] = KeybindLib
    end

    return KeybindLib
end

-- =============================================================================
--                                 TEXT INPUT
-- =============================================================================

function Elements:TextInput(Handler, Config)
    Config = Config or {}
    Config.Default = Config.Default or ""
    Config.Placeholder = Config.Placeholder or "Placeholder"
    Config.Callback = Config.Callback or print
    Config.Flag = Config.Flag or nil
    Config.Size = Config.Size or 100
    Config.Numeric = Config.Numeric or false

    local ZIndex = Handler.ZIndex or Handler._ZIndex or 0
    local Signal = Handler._Signal or (Handler.Signal)

    local TextBoxLib = {}

    local TextInput = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local UIStroke = Instance.new("UIStroke")
    local TextBox = Instance.new("TextBox")

    TextInput.Name = NeverLose.RandomString()
    TextInput.Parent = Handler
    TextInput.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
    TextInput.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextInput.BorderSizePixel = 0
    TextInput.ClipsDescendants = true
    TextInput.Size = UDim2.new(0, Config.Size, 0, 18)
    TextInput.ZIndex = ZIndex + 13

    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = TextInput

    UIStroke.Transparency = 0.65
    UIStroke.Color = Color3.fromRGB(45, 48, 58)
    UIStroke.Parent = TextInput

    TextBox.Parent = TextInput
    TextBox.AnchorPoint = Vector2.new(0, 0.5)
    TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextBox.BackgroundTransparency = 1
    TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextBox.BorderSizePixel = 0
    TextBox.Position = UDim2.new(0, 5, 0.5, 0)
    TextBox.Size = UDim2.new(1, -5, 0, 17)
    TextBox.ZIndex = ZIndex + 14
    TextBox.ClearTextOnFocus = false
    TextBox.Font = Enum.Font.GothamMedium
    TextBox.PlaceholderText = Config.Placeholder
    TextBox.Text = tostring(Config.Default)
    TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextBox.TextSize = 11
    TextBox.TextTransparency = 0.35
    TextBox.TextXAlignment = Enum.TextXAlignment.Left

    TextBoxLib.SetRender = function(value)
        if value then
            NeverLose.PlayAnimate(TextInput, NeverLose.SlowyTween, { BackgroundTransparency = 0 })
            NeverLose.PlayAnimate(UIStroke, NeverLose.SlowyTween, { Transparency = 0.65 })
            NeverLose.PlayAnimate(TextBox, NeverLose.SlowyTween, { TextTransparency = 0.35 })
        else
            NeverLose.PlayAnimate(TextInput, NeverLose.SlowyTween, { BackgroundTransparency = 1 })
            NeverLose.PlayAnimate(UIStroke, NeverLose.SlowyTween, { Transparency = 1 })
            NeverLose.PlayAnimate(TextBox, NeverLose.SlowyTween, { TextTransparency = 1 })
        end
    end

    NeverLose:AddSignal(TextBox:GetPropertyChangedSignal("Text"):Connect(function()
        local valout = NeverLose:ParseInput(TextBox.Text, Config.Numeric)
        if Config.Numeric then
            TextBox.Text = string.gsub(TextBox.Text, "[^0-9.]", "")
        end
        if valout then
            Config.Default = valout
            Config.Callback(valout)
        end
    end))

    TextBoxLib.SetRender(Signal and Signal:GetValue() or true)
    if Signal then
        Signal:Connect(TextBoxLib.SetRender)
    end

    function TextBoxLib:GetValue()
        return Config.Default
    end

    function TextBoxLib:SetValue(v)
        Config.Default = v
        TextBox.Text = tostring(v)
        Config.Callback(Config.Default)
    end

    if Config.Flag and NeverLose.Flags then
        NeverLose.Flags[Config.Flag] = TextBoxLib
    end

    return TextBoxLib
end

-- =============================================================================
--                                  LABEL
-- =============================================================================

function Elements:Label(Handler, Config)
    Config = Config or {}
    Config.Name = Config.Name or "Label"
    Config.Warp = Config.Warp or false

    local ZIndex = Handler.ZIndex or Handler._ZIndex or 0
    local Signal = Handler._Signal or (Handler.Signal)
    local LayerIndex = Handler._LayerIndex or ZIndex

    local BasedFrame = Instance.new("Frame")
    local BasedLabel = Instance.new("TextLabel")
    local LineFrame = Instance.new("Frame")
    local BasedHandler = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")
    local UICorner = Instance.new("UICorner")

    BasedFrame.Name = NeverLose.RandomString()
    BasedFrame.Parent = Handler
    BasedFrame.BackgroundColor3 = Color3.fromRGB(25, 27, 33)
    BasedFrame.BackgroundTransparency = 1
    BasedFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    BasedFrame.BorderSizePixel = 0
    BasedFrame.Size = UDim2.new(1, 0, 0, 30)
    BasedFrame.ZIndex = LayerIndex + 8

    if NeverLose.AddQuery then
        NeverLose:AddQuery(BasedFrame, Config.Name)
    end

    BasedLabel.Name = NeverLose.RandomString()
    BasedLabel.Parent = BasedFrame
    BasedLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    BasedLabel.BackgroundTransparency = 1
    BasedLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    BasedLabel.BorderSizePixel = 0
    BasedLabel.Position = UDim2.new(0, 11, 0, 6)
    BasedLabel.Size = UDim2.new(0, 1, 0, 15)
    BasedLabel.ZIndex = LayerIndex + 9
    BasedLabel.Font = Enum.Font.GothamMedium
    BasedLabel.Text = Config.Name
    BasedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    BasedLabel.TextSize = 13
    BasedLabel.TextTransparency = 0.35
    BasedLabel.TextXAlignment = Enum.TextXAlignment.Left

    LineFrame.Name = NeverLose.RandomString()
    LineFrame.Parent = BasedFrame
    LineFrame.AnchorPoint = Vector2.new(0.5, 1)
    LineFrame.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
    LineFrame.BackgroundTransparency = 0.65
    LineFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    LineFrame.BorderSizePixel = 0
    LineFrame.Position = UDim2.new(0.5, 0, 1, 0)
    LineFrame.Size = UDim2.new(1, -20, 0, 1)
    LineFrame.ZIndex = LayerIndex + 11

    BasedHandler.Name = NeverLose.RandomString()
    BasedHandler.Parent = BasedFrame
    BasedHandler.AnchorPoint = Vector2.new(1, 0)
    BasedHandler.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    BasedHandler.BackgroundTransparency = 1
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

    local UpdateWarp = function()
        local size = TextService:GetTextSize(BasedLabel.Text, BasedLabel.TextSize, BasedLabel.Font, Vector2.new(math.huge, math.huge))
        NeverLose.PlayAnimate(BasedFrame, NeverLose.SlowyTween, { Size = UDim2.new(1, 0, 0, size.Y + 13) })
        BasedLabel.Size = UDim2.new(1, -35, 1, 0)
        BasedLabel.TextYAlignment = Enum.TextYAlignment.Top
    end

    if Config.Warp then
        UpdateWarp()
    end

    local handle = NeverLose:RegisiterHandler(BasedHandler, Signal)

    handle.Root = BasedFrame

    handle.SetRender = function(value)
        if value then
            NeverLose.PlayAnimate(BasedFrame, NeverLose.SlowyTween, { BackgroundTransparency = 1 })
            NeverLose.PlayAnimate(BasedLabel, NeverLose.SlowyTween, { TextTransparency = 0.35 })
            NeverLose.PlayAnimate(LineFrame, NeverLose.SlowyTween, { BackgroundTransparency = 0.65 })
        else
            NeverLose.PlayAnimate(BasedFrame, NeverLose.SlowyTween, { BackgroundTransparency = 1 })
            NeverLose.PlayAnimate(BasedLabel, NeverLose.SlowyTween, { TextTransparency = 1 })
            NeverLose.PlayAnimate(LineFrame, NeverLose.SlowyTween, { BackgroundTransparency = 1 })
        end
    end

    function handle:SetVisible(val)
        BasedFrame.Visible = val
    end

    NeverLose:AddSignal(BasedFrame.MouseEnter:Connect(function()
        NeverLose.PlayAnimate(BasedFrame, NeverLose.SlowyTween, { BackgroundTransparency = 0.35 })
        NeverLose.PlayAnimate(BasedLabel, NeverLose.SlowyTween, { TextTransparency = 0.25 })
    end))

    NeverLose:AddSignal(BasedFrame.MouseLeave:Connect(function()
        NeverLose.PlayAnimate(BasedFrame, NeverLose.SlowyTween, { BackgroundTransparency = 1 })
        NeverLose.PlayAnimate(BasedLabel, NeverLose.SlowyTween, { TextTransparency = 0.35 })
    end))

    function handle:SetText(t)
        local oldtxt = BasedLabel.Text
        BasedLabel.Text = t
        if Config.Warp and oldtxt ~= t then
            UpdateWarp()
        end
    end

    function handle:ToolTip(Content)
        if NeverLose.CreateToolTips then
            handle.ToolTip = NeverLose:CreateToolTips(BasedFrame, Config.Name, Content)
        end
        return handle
    end

    handle.SetRender(Signal and Signal:GetValue() or true)
    if Signal then
        Signal:Connect(handle.SetRender)
    end

    return handle
end

return Elements
