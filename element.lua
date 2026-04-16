--[[
    element.lua
    NeverLose UI Elements Module
    Berisi: Toggle, Button, Slider, Input, Keybind, Dropdown, Paragraph, ColorPicker
]]

local Elements = {}

-- ============================================
-- TOGGLE
-- ============================================
function Elements.CreateToggle(parent, config, accentColor, signal)
    config = config or {}
    config.Default = config.Default or false
    config.Callback = config.Callback or function() end
    config.Flag = config.Flag or nil
    
    local ZIndex = parent.ZIndex or 0
    
    local Toggle = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local Circle = Instance.new("Frame")
    local UICorner_2 = Instance.new("UICorner")
    
    Toggle.Name = "Toggle_" .. (config.Flag or tostring(math.random(1000,9999)))
    Toggle.Parent = parent
    Toggle.BackgroundColor3 = Color3.fromRGB(10, 13, 21)
    Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Toggle.BorderSizePixel = 0
    Toggle.ClipsDescendants = true
    Toggle.Size = UDim2.new(0, 30, 0, 18)
    Toggle.ZIndex = ZIndex + 13
    
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = Toggle
    
    Circle.Name = "Circle"
    Circle.Parent = Toggle
    Circle.AnchorPoint = Vector2.new(0.5, 0.5)
    Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Circle.BackgroundTransparency = 0.500
    Circle.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Circle.BorderSizePixel = 0
    Circle.Position = UDim2.new(0.300000012, 0, 0.5, 0)
    Circle.Size = UDim2.new(0, 16, 0, 16)
    Circle.ZIndex = ZIndex + 14
    
    UICorner_2.CornerRadius = UDim.new(1, 0)
    UICorner_2.Parent = Circle
    
    local ToggleLib = {
        Root = Toggle,
        Value = config.Default
    }
    
    local function SetUI(value)
        if value then
            local tween1 = game:GetService("TweenService"):Create(Toggle, TweenInfo.new(0.175), {
                BackgroundTransparency = 0,
                BackgroundColor3 = accentColor
            })
            local tween2 = game:GetService("TweenService"):Create(Circle, TweenInfo.new(0.175), {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 0,
                Position = UDim2.new(0.7, 0, 0.5, 0)
            })
            tween1:Play()
            tween2:Play()
        else
            local tween1 = game:GetService("TweenService"):Create(Toggle, TweenInfo.new(0.175), {
                BackgroundTransparency = 0,
                BackgroundColor3 = Color3.fromRGB(10, 13, 21)
            })
            local tween2 = game:GetService("TweenService"):Create(Circle, TweenInfo.new(0.175), {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 0.500,
                Position = UDim2.new(0.300000012, 0, 0.5, 0)
            })
            tween1:Play()
            tween2:Play()
        end
    end
    
    SetUI(config.Default)
    
    local function onToggle()
        config.Default = not config.Default
        ToggleLib.Value = config.Default
        SetUI(config.Default)
        config.Callback(config.Default)
    end
    
    -- Create input button
    local Button = Instance.new("ImageButton", Toggle)
    Button.ZIndex = Toggle.ZIndex + 10
    Button.Size = UDim2.fromScale(1,1)
    Button.BackgroundTransparency = 1
    Button.ImageTransparency = 1
    Button.MouseButton1Click:Connect(onToggle)
    
    function ToggleLib:GetValue()
        return config.Default
    end
    
    function ToggleLib:SetValue(v)
        config.Default = v
        ToggleLib.Value = v
        SetUI(v)
        config.Callback(v)
    end
    
    return ToggleLib
end

-- ============================================
-- BUTTON
-- ============================================
function Elements.CreateButton(parent, config, accentColor, signal)
    config = config or {}
    config.Icon = config.Icon or "chevron-large-left"
    config.Name = config.Name or "Button"
    config.Callback = config.Callback or function() end
    config.ToolTip = config.ToolTip or nil
    
    local ZIndex = parent.ZIndex or 0
    
    local ButtonFrame = Instance.new("Frame")
    local BasedLabel = Instance.new("TextLabel")
    local LineFrame = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local Icon = Instance.new("TextLabel")
    
    ButtonFrame.Name = "Button_" .. string.gsub(config.Name, "%s+", "_")
    ButtonFrame.Parent = parent
    ButtonFrame.BackgroundColor3 = Color3.fromRGB(25, 27, 33)
    ButtonFrame.BackgroundTransparency = 1.000
    ButtonFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ButtonFrame.BorderSizePixel = 0
    ButtonFrame.Size = UDim2.new(1, 0, 0, 30)
    ButtonFrame.ZIndex = ZIndex + 8
    
    BasedLabel.Name = "Label"
    BasedLabel.Parent = ButtonFrame
    BasedLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    BasedLabel.BackgroundTransparency = 1.000
    BasedLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    BasedLabel.BorderSizePixel = 0
    BasedLabel.Position = UDim2.new(0, 35, 0, 6)
    BasedLabel.Size = UDim2.new(0,1, 0, 15)
    BasedLabel.ZIndex = ZIndex + 9
    BasedLabel.Font = Enum.Font.GothamMedium
    BasedLabel.Text = config.Name
    BasedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    BasedLabel.TextSize = 13.000
    BasedLabel.TextTransparency = 0.200
    BasedLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    LineFrame.Name = "Line"
    LineFrame.Parent = ButtonFrame
    LineFrame.AnchorPoint = Vector2.new(0.5, 1)
    LineFrame.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
    LineFrame.BackgroundTransparency = 0.650
    LineFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    LineFrame.BorderSizePixel = 0
    LineFrame.Position = UDim2.new(0.5, 0, 1, 0)
    LineFrame.Size = UDim2.new(1, -20, 0, 1)
    LineFrame.ZIndex = ZIndex + 11
    
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = ButtonFrame
    
    Icon.Name = "Icon"
    Icon.Parent = ButtonFrame
    Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Icon.BackgroundTransparency = 1.000
    Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Icon.BorderSizePixel = 0
    Icon.Position = UDim2.new(0, 11, 0, 5)
    Icon.Size = UDim2.new(0, 18, 0, 18)
    Icon.ZIndex = ZIndex + 9
    Icon.FontFace = Font.new('rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json',Enum.FontWeight.Bold,Enum.FontStyle.Normal)
    Icon.Text = config.Icon
    Icon.TextColor3 = Color3.fromRGB(223, 223, 223)
    Icon.TextSize = 16.000
    Icon.TextTransparency = 0.250
    Icon.TextWrapped = true
    
    local ButtonLib = {}
    
    local ClickButton = Instance.new("ImageButton", ButtonFrame)
    ClickButton.ZIndex = ButtonFrame.ZIndex + 10
    ClickButton.Size = UDim2.fromScale(1,1)
    ClickButton.BackgroundTransparency = 1
    ClickButton.ImageTransparency = 1
    ClickButton.MouseButton1Click:Connect(config.Callback)
    
    ClickButton.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(ButtonFrame, TweenInfo.new(0.175), {
            BackgroundTransparency = 0.35
        }):Play()
    end)
    
    ClickButton.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(ButtonFrame, TweenInfo.new(0.175), {
            BackgroundTransparency = 1
        }):Play()
    end)
    
    function ButtonLib:SetText(t)
        BasedLabel.Text = t
    end
    
    function ButtonLib:SetIcon(t)
        Icon.Text = t
    end
    
    return ButtonLib
end

-- ============================================
-- SLIDER
-- ============================================
function Elements.CreateSlider(parent, config, accentColor, signal)
    config = config or {}
    config.Default = config.Default or 50
    config.Min = config.Min or 0
    config.Max = config.Max or 10
    config.Type = config.Type or ""
    config.Rounding = config.Rounding or 0
    config.Nums = config.Nums or {}
    config.Flag = config.Flag or nil
    config.Size = config.Size or 125
    config.Callback = config.Callback or function() end
    
    local ZIndex = parent.ZIndex or 0
    local UserInputService = game:GetService("UserInputService")
    local TextService = game:GetService("TextService")
    local TweenService = game:GetService("TweenService")
    local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
    
    local SliderLib = {}
    
    local function GetSize()
        return (config.Default - config.Min) / (config.Max - config.Min)
    end
    
    local FullNumSize = TextService:GetTextSize(string.rep("0",(config.Rounding + #tostring(config.Max))+1)..tostring(config.Type),10,Enum.Font.GothamMedium,Vector2.new(math.huge,math.huge))
    SliderLib.MaximumSize = FullNumSize.X
    
    if config.Nums then
        local nszie = 0
        for i,ns in next, config.Nums do
            local size = TextService:GetTextSize(string.rep("m",string.len(tostring(ns))),10,Enum.Font.GothamMedium,Vector2.new(math.huge,math.huge))
            if nszie < size.X then
                nszie = size.X
            end
        end
        if SliderLib.MaximumSize < nszie then
            SliderLib.MaximumSize = nszie
        end
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
    
    Slider.Name = "Slider_" .. (config.Flag or tostring(math.random(1000,9999)))
    Slider.Parent = parent
    Slider.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
    Slider.BackgroundTransparency = 1.000
    Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Slider.BorderSizePixel = 0
    Slider.ClipsDescendants = false
    Slider.Size = UDim2.new(0, config.Size, 0, 18)
    Slider.ZIndex = ZIndex + 13
    
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = Slider
    
    ValueFrame.Name = "ValueFrame"
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
    
    UIStroke.Transparency = 0.650
    UIStroke.Color = Color3.fromRGB(45, 48, 58)
    UIStroke.Parent = ValueFrame
    
    ValueLabel.Name = "ValueLabel"
    ValueLabel.Parent = ValueFrame
    ValueLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    ValueLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ValueLabel.BackgroundTransparency = 1.000
    ValueLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ValueLabel.BorderSizePixel = 0
    ValueLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
    ValueLabel.Size = UDim2.new(1, 0, 1, 0)
    ValueLabel.ZIndex = ZIndex + 14
    ValueLabel.Font = Enum.Font.GothamMedium
    ValueLabel.Text = tostring(config.Default)..tostring(config.Type)
    ValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ValueLabel.TextSize = 10.000
    ValueLabel.ClearTextOnFocus = false
    ValueLabel.TextTransparency = 0.350
    
    SlideMain.Name = "SlideMain"
    SlideMain.Parent = Slider
    SlideMain.AnchorPoint = Vector2.new(0, 0.5)
    SlideMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SlideMain.BackgroundTransparency = 1.000
    SlideMain.BorderColor3 = Color3.fromRGB(0, 0, 0)
    SlideMain.BorderSizePixel = 0
    SlideMain.Position = UDim2.new(0, 0, 0.5, 0)
    SlideMain.Size = UDim2.new(1, -((SliderLib.MaximumSize + 11)), 0, 18)
    SlideMain.ZIndex = ZIndex + 13
    
    SlideFrame.Name = "SlideFrame"
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
    
    SlideMoving.Name = "SlideMoving"
    SlideMoving.Parent = SlideFrame
    SlideMoving.BackgroundColor3 = accentColor
    SlideMoving.BorderColor3 = Color3.fromRGB(0, 0, 0)
    SlideMoving.BorderSizePixel = 0
    SlideMoving.Size = UDim2.new(GetSize(), 0, 1, 0)
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
    
    local function LoadText()
        if config.Nums[config.Default] then
            ValueLabel.Text = config.Nums[config.Default]
        else
            ValueLabel.Text = tostring(config.Default)..tostring(config.Type)
        end
    end
    
    ValueLabel.FocusLost:Connect(function()
        local function ParseInput(Value)
            if not Value then return nil end
            local out = string.gsub(tostring(Value), '[^0-9.%-]', '')
            if tonumber(out) then
                return tonumber(out)
            end
            return nil
        end
        
        local OutVal = ParseInput(ValueLabel.Text)
        if OutVal then
            local rx = math.clamp(OutVal, config.Min, config.Max)
            local function Rounding(num, numDecimalPlaces)
                local mult = 10 ^ (numDecimalPlaces or 0)
                return math.floor(num * mult + 0.5) / mult
            end
            local Value = Rounding(rx, config.Rounding)
            if Value then
                config.Default = Value
                TweenService:Create(SlideMoving, TweenInfo.new(0.1), {
                    Size = UDim2.new(GetSize(), 0, 1, 0)
                }):Play()
                LoadText()
                config.Callback(config.Default)
            else
                LoadText()
            end
        else
            LoadText()
        end
    end)
    
    local Update = function(Input)
        local SizeScale = math.clamp(((Input.Position.X - SlideMain.AbsolutePosition.X) / SlideMain.AbsoluteSize.X), 0, 1)
        local Main = ((config.Max - config.Min) * SizeScale) + config.Min
        local function Rounding(num, numDecimalPlaces)
            local mult = 10 ^ (numDecimalPlaces or 0)
            return math.floor(num * mult + 0.5) / mult
        end
        local Value = Rounding(Main, config.Rounding)
        
        config.Default = Value
        TweenService:Create(SlideMoving, TweenInfo.new(0.1), {
            Size = UDim2.new(GetSize(), 0, 1, 0)
        }):Play()
        LoadText()
        config.Callback(Value)
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
            if (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
                Update(Input)
            end
        end
    end)
    
    function SliderLib:GetValue()
        return config.Default
    end
    
    function SliderLib:SetValue(v)
        config.Default = v
        TweenService:Create(SlideMoving, TweenInfo.new(0.175), {
            Size = UDim2.new(GetSize(), 0, 1, 0)
        }):Play()
        LoadText()
        config.Callback(config.Default)
    end
    
    return SliderLib
end

-- ============================================
-- INPUT (TextBox)
-- ============================================
function Elements.CreateInput(parent, config, accentColor, signal)
    config = config or {}
    config.Default = config.Default or ""
    config.Placeholder = config.Placeholder or "Placeholder"
    config.Callback = config.Callback or function() end
    config.Flag = config.Flag or nil
    config.Size = config.Size or 100
    config.Numeric = config.Numeric or false
    
    local ZIndex = parent.ZIndex or 0
    
    local TextInput = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local UIStroke = Instance.new("UIStroke")
    local TextBox = Instance.new("TextBox")
    
    TextInput.Name = "Input_" .. (config.Flag or tostring(math.random(1000,9999)))
    TextInput.Parent = parent
    TextInput.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
    TextInput.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextInput.BorderSizePixel = 0
    TextInput.ClipsDescendants = true
    TextInput.Size = UDim2.new(0, config.Size, 0, 18)
    TextInput.ZIndex = ZIndex + 13
    
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
    TextBox.ZIndex = ZIndex + 14
    TextBox.ClearTextOnFocus = false
    TextBox.Font = Enum.Font.GothamMedium
    TextBox.PlaceholderText = config.Placeholder
    TextBox.Text = tostring(config.Default)
    TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextBox.TextSize = 11.000
    TextBox.TextTransparency = 0.350
    TextBox.TextXAlignment = Enum.TextXAlignment.Left
    
    local InputLib = {}
    
    TextBox:GetPropertyChangedSignal('Text'):Connect(function()
        local function ParseInput(Value, Numeric)
            if not Value then
                return (Numeric and nil) or ""
            end
            if Numeric then
                local out = string.gsub(tostring(Value), '[^0-9.%-]', '')
                if tonumber(out) then
                    return tonumber(out)
                end
                return nil
            end
            return Value
        end
        
        local valout = ParseInput(TextBox.Text, config.Numeric)
        if config.Numeric then
            TextBox.Text = string.gsub(TextBox.Text, '[^0-9.]', '')
        end
        if valout then
            config.Default = valout
            config.Callback(valout)
        end
    end)
    
    function InputLib:GetValue()
        return config.Default
    end
    
    function InputLib:SetValue(v)
        config.Default = v
        TextBox.Text = tostring(v)
        config.Callback(config.Default)
    end
    
    return InputLib
end

-- ============================================
-- KEYBIND
-- ============================================
function Elements.CreateKeybind(parent, config, accentColor, signal)
    config = config or {}
    config.Default = config.Default or nil
    config.Blacklist = config.Blacklist or {}
    config.Callback = config.Callback or function() end
    config.Flag = config.Flag or nil
    
    local ZIndex = parent.ZIndex or 0
    local UserInputService = game:GetService("UserInputService")
    local TextService = game:GetService("TextService")
    local TweenService = game:GetService("TweenService")
    
    local KeyEnum = {
        One = '1', Two = '2', Three = '3', Four = '4', Five = '5',
        Six = '6', Seven = '7', Eight = '8', Nine = '9', Zero = '0',
        ['Minus'] = "-", ['Plus'] = "+", BackSlash = "\\", Slash = "/",
        Period = '.', Semicolon = ';', Colon = ":", LeftControl = "LCtrl",
        RightControl = "RCtrl", LeftShift = "LShift", RightShift = "RShift",
        Return = "Enter", LeftBracket = "[", RightBracket = "]",
        Quote = "'", Comma = ",", Equals = "=", LeftSuper = "Super",
        RightSuper = "Super", LeftAlt = "LAlt", RightAlt = "RAlt", Escape = "Esc",
    }
    
    local function KeyCodeToStr(K)
        if typeof(K) == 'string' then
            if KeyEnum[K] then return KeyEnum[K] end
            return K
        end
        return (KeyEnum[K.Name] or K.Name)
    end
    
    local Keybind = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local UIStroke = Instance.new("UIStroke")
    local ValueLabel = Instance.new("TextLabel")
    
    Keybind.Name = "Keybind_" .. (config.Flag or tostring(math.random(1000,9999)))
    Keybind.Parent = parent
    Keybind.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
    Keybind.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Keybind.BorderSizePixel = 0
    Keybind.ClipsDescendants = true
    Keybind.Size = UDim2.new(0, 45, 0, 18)
    Keybind.ZIndex = ZIndex + 13
    
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = Keybind
    
    UIStroke.Transparency = 0.650
    UIStroke.Color = Color3.fromRGB(45, 48, 58)
    UIStroke.Parent = Keybind
    
    ValueLabel.Name = "ValueLabel"
    ValueLabel.Parent = Keybind
    ValueLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    ValueLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ValueLabel.BackgroundTransparency = 1.000
    ValueLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ValueLabel.BorderSizePixel = 0
    ValueLabel.ClipsDescendants = true
    ValueLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
    ValueLabel.Size = UDim2.new(1, 0, 1, 0)
    ValueLabel.ZIndex = ZIndex + 14
    ValueLabel.Font = Enum.Font.GothamMedium
    ValueLabel.Text = KeyCodeToStr(config.Default or "None")
    ValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ValueLabel.TextSize = 10.000
    ValueLabel.TextTransparency = 0.500
    
    local KeybindLib = {}
    
    function KeybindLib:Update()
        local size = TextService:GetTextSize(ValueLabel.Text, ValueLabel.TextSize, ValueLabel.Font, Vector2.new(math.huge, math.huge))
        TweenService:Create(Keybind, TweenInfo.new(0.175), {
            Size = UDim2.new(0, size.X + 7, 0, 18)
        }):Play()
    end
    
    local function IsBlacklist(v)
        return config.Blacklist and (config.Blacklist[v] or table.find(config.Blacklist, v))
    end
    
    KeybindLib:Update()
    
    local IsBinding = false
    local ClickButton = Instance.new("ImageButton", Keybind)
    ClickButton.ZIndex = Keybind.ZIndex + 10
    ClickButton.Size = UDim2.fromScale(1,1)
    ClickButton.BackgroundTransparency = 1
    ClickButton.ImageTransparency = 1
    
    ClickButton.MouseButton1Click:Connect(function()
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
        local KeyName = typeof(Selected) == "string" and Selected or Selected.Name
        config.Default = KeyName
        ValueLabel.Text = KeyCodeToStr(KeyName)
        KeybindLib:Update()
        config.Callback(KeyName)
    end)
    
    function KeybindLib:GetValue()
        return config.Default
    end
    
    function KeybindLib:SetValue(v)
        config.Default = v
        ValueLabel.Text = KeyCodeToStr(v)
        KeybindLib:Update()
        config.Callback(config.Default)
    end
    
    return KeybindLib
end

-- ============================================
-- DROPDOWN
-- ============================================
function Elements.CreateDropdown(parent, config, accentColor, signal)
    config = config or {}
    config.Default = config.Default or nil
    config.Values = config.Values or {}
    config.Multi = config.Multi or false
    config.Callback = config.Callback or function() end
    config.AutoUpdate = config.AutoUpdate or false
    config.Flag = config.Flag or nil
    config.Size = config.Size or 100
    
    local ZIndex = parent.ZIndex or 0
    local UserInputService = game:GetService("UserInputService")
    local TextService = game:GetService("TextService")
    local TweenService = game:GetService("TweenService")
    local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
    local CoreGui = game:GetService("CoreGui")
    
    local function ProcessDropdown(value)
        if typeof(value) == 'table' then
            local data = {}
            for i, v in next, value do
                if typeof(v) == 'boolean' and typeof(i) ~= 'number' then
                    data[i] = v
                else
                    data[v] = true
                end
            end
            return data
        else
            return value
        end
    end
    
    local function ParseDropdown(value)
        if not value then return 'Select' end
        local Out
        if typeof(value) == 'table' then
            if #value > 0 then
                local x = {}
                for i, v in next, value do
                    table.insert(x, tostring(v))
                end
                Out = table.concat(x, ' , ')
            else
                local x = {}
                for i, v in next, value do
                    if v == true then
                        table.insert(x, tostring(i))
                    end
                end
                Out = table.concat(x, ' , ')
                if not Out:byte() then
                    Out = 'Select'
                end
            end
        else
            Out = tostring(value or 'Select')
        end
        return Out
    end
    
    config.Default = ProcessDropdown(config.Default)
    
    local Dropdown = Instance.new("Frame")
    local DropdownIcon = Instance.new("TextLabel")
    local UICorner = Instance.new("UICorner")
    local UIStroke = Instance.new("UIStroke")
    local BasedLabel = Instance.new("TextLabel")
    
    Dropdown.Name = "Dropdown_" .. (config.Flag or tostring(math.random(1000,9999)))
    Dropdown.Parent = parent
    Dropdown.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
    Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Dropdown.BorderSizePixel = 0
    Dropdown.ClipsDescendants = true
    Dropdown.Size = UDim2.new(0, config.Size, 0, 18)
    Dropdown.ZIndex = ZIndex + 13
    
    DropdownIcon.Name = "Icon"
    DropdownIcon.Parent = Dropdown
    DropdownIcon.AnchorPoint = Vector2.new(1, 0.5)
    DropdownIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    DropdownIcon.BackgroundTransparency = 1.000
    DropdownIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
    DropdownIcon.BorderSizePixel = 0
    DropdownIcon.Position = UDim2.new(1, -2, 0.5, 0)
    DropdownIcon.Size = UDim2.new(0, 18, 0, 18)
    DropdownIcon.ZIndex = ZIndex + 14
    DropdownIcon.FontFace = Font.new('rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json',Enum.FontWeight.Bold,Enum.FontStyle.Normal)
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
    
    BasedLabel.Name = "BasedLabel"
    BasedLabel.Parent = Dropdown
    BasedLabel.AnchorPoint = Vector2.new(0, 0.5)
    BasedLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    BasedLabel.BackgroundTransparency = 1.000
    BasedLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    BasedLabel.BorderSizePixel = 0
    BasedLabel.ClipsDescendants = true
    BasedLabel.Position = UDim2.new(0, 5, 0.5, 0)
    BasedLabel.Size = UDim2.new(1, -25, 0, 15)
    BasedLabel.ZIndex = ZIndex + 14
    BasedLabel.Font = Enum.Font.GothamMedium
    BasedLabel.Text = ParseDropdown(config.Default)
    BasedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    BasedLabel.TextSize = 12.000
    BasedLabel.TextTransparency = 0.5
    BasedLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local DropdownLib = {
        OpenSignal = nil,
        Signals = {},
        Refuse = {},
        ExtentSize = 0,
        BlockRoot = nil,
        RootItem = nil,
    }
    
    -- Create dropdown menu
    local DropdownHandler = Instance.new("Frame")
    local UICorner2 = Instance.new("UICorner")
    local UIStroke2 = Instance.new("UIStroke")
    local DropdownScrollFrame = Instance.new("ScrollingFrame")
    local UIListLayout = Instance.new("UIListLayout")
    
    DropdownHandler.Name = "DropdownMenu"
    DropdownHandler.Parent = CoreGui:FindFirstChild("NeverLose_Root") or CoreGui
    DropdownHandler.AnchorPoint = Vector2.new(0.5, 0)
    DropdownHandler.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
    DropdownHandler.BackgroundTransparency = 1
    DropdownHandler.BorderColor3 = Color3.fromRGB(0, 0, 0)
    DropdownHandler.BorderSizePixel = 0
    DropdownHandler.ClipsDescendants = true
    DropdownHandler.Visible = false
    DropdownHandler.ZIndex = 999
    
    UICorner2.CornerRadius = UDim.new(0, 10)
    UICorner2.Parent = DropdownHandler
    
    UIStroke2.Transparency = 0.650
    UIStroke2.Color = Color3.fromRGB(45, 48, 58)
    UIStroke2.Parent = DropdownHandler
    
    DropdownScrollFrame.Parent = DropdownHandler
    DropdownScrollFrame.Active = true
    DropdownScrollFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    DropdownScrollFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    DropdownScrollFrame.BackgroundTransparency = 1.000
    DropdownScrollFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    DropdownScrollFrame.BorderSizePixel = 0
    DropdownScrollFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    DropdownScrollFrame.Size = UDim2.new(1, -5, 1, -5)
    DropdownScrollFrame.ScrollBarThickness = 0
    
    DropdownLib.RootItem = DropdownScrollFrame
    
    UIListLayout.Parent = DropdownScrollFrame
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    local function SetPosition()
        if (Dropdown.AbsolutePosition.Y + 85) > (CoreGui.AbsoluteSize.Y / 2) then
            DropdownHandler.AnchorPoint = Vector2.new(0.5, 1)
        else
            DropdownHandler.AnchorPoint = Vector2.new(0.5, 0)
        end
        DropdownHandler.Position = UDim2.fromOffset(Dropdown.AbsolutePosition.X + (DropdownHandler.AbsoluteSize.X / 2), Dropdown.AbsolutePosition.Y + 85)
    end
    
    function DropdownLib:Generate()
        for i, v in next, DropdownLib.RootItem:GetChildren() do
            if v:IsA('Frame') then
                v:Destroy()
            end
        end
        
        for i, v in next, DropdownLib.Signals do
            v:Disconnect()
        end
        
        table.clear(DropdownLib.Signals)
        table.clear(DropdownLib.Refuse)
        
        local function IsMatch(v1)
            if typeof(config.Default) == 'table' then
                if config.Default[v1] or table.find(config.Default, v1) then
                    return true
                end
            end
            if config.Default == v1 then
                return true
            end
            return false
        end
        
        for i, Value in next, config.Values do
            local ItemFrame = Instance.new("Frame")
            local ItemLabel = Instance.new("TextLabel")
            local UICornerItem = Instance.new("UICorner")
            
            ItemFrame.Parent = DropdownLib.RootItem
            ItemFrame.BackgroundColor3 = Color3.fromRGB(29, 31, 38)
            ItemFrame.BackgroundTransparency = 1.000
            ItemFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
            ItemFrame.BorderSizePixel = 0
            ItemFrame.Size = UDim2.new(1, 0, 0, 25)
            ItemFrame.ZIndex = 1258
            
            ItemLabel.Parent = ItemFrame
            ItemLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ItemLabel.BackgroundTransparency = 1.000
            ItemLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
            ItemLabel.BorderSizePixel = 0
            ItemLabel.Position = UDim2.new(0, 15, 0, 4)
            ItemLabel.Size = UDim2.new(0, 1, 0, 15)
            ItemLabel.ZIndex = 1258
            ItemLabel.Font = Enum.Font.GothamMedium
            ItemLabel.Text = tostring(Value)
            ItemLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            ItemLabel.TextSize = 13.000
            ItemLabel.TextTransparency = 0.200
            ItemLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            UICornerItem.CornerRadius = UDim.new(0, 10)
            UICornerItem.Parent = ItemFrame
            
            local sizetext = TextService:GetTextSize(ItemLabel.Text, ItemLabel.TextSize, ItemLabel.Font, Vector2.new(math.huge, math.huge))
            DropdownLib.ExtentSize = math.max(DropdownLib.ExtentSize, sizetext.X)
            
            local MIcon, MarkItem = nil, nil
            
            if config.Multi then
                local Icon = Instance.new("TextLabel")
                Icon.Parent = ItemFrame
                Icon.AnchorPoint = Vector2.new(0, 0.5)
                Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Icon.BackgroundTransparency = 1.000
                Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Icon.BorderSizePixel = 0
                Icon.Position = UDim2.new(0, 5, 0.5, 0)
                Icon.Size = UDim2.new(0, 20, 0, 20)
                Icon.ZIndex = 1259
                Icon.FontFace = Font.new('rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json',Enum.FontWeight.Bold,Enum.FontStyle.Normal)
                Icon.Text = "check"
                Icon.TextColor3 = Color3.fromRGB(223, 223, 223)
                Icon.TextSize = 18.000
                Icon.TextTransparency = 1
                Icon.TextWrapped = true
                
                local function VisiblewOfMult()
                    if IsMatch(Value) then
                        TweenService:Create(ItemLabel, TweenInfo.new(0.5), {
                            TextTransparency = 0.200,
                            Position = UDim2.new(0, 30, 0, 4)
                        }):Play()
                        TweenService:Create(Icon, TweenInfo.new(0.5), {
                            TextTransparency = 0.250
                        }):Play()
                    else
                        TweenService:Create(Icon, TweenInfo.new(0.175), {
                            TextTransparency = 1
                        }):Play()
                        TweenService:Create(ItemLabel, TweenInfo.new(0.5), {
                            TextTransparency = 0.5,
                            Position = UDim2.new(0, 15, 0, 4)
                        }):Play()
                    end
                end
                
                MIcon = Icon
                MarkItem = VisiblewOfMult
            else
                local function DefaultVisible()
                    if IsMatch(Value) then
                        TweenService:Create(ItemLabel, TweenInfo.new(0.175), {
                            TextTransparency = 0.200
                        }):Play()
                    else
                        TweenService:Create(ItemLabel, TweenInfo.new(0.175), {
                            TextTransparency = 0.5
                        }):Play()
                    end
                end
                MarkItem = DefaultVisible
            end
            
            MarkItem()
            table.insert(DropdownLib.Refuse, MarkItem)
            
            table.insert(DropdownLib.Signals, ItemFrame.MouseEnter:Connect(function()
                TweenService:Create(ItemFrame, TweenInfo.new(0.175), {
                    BackgroundTransparency = 0.1
                }):Play()
            end))
            
            table.insert(DropdownLib.Signals, ItemFrame.MouseLeave:Connect(function()
                TweenService:Create(ItemFrame, TweenInfo.new(0.175), {
                    BackgroundTransparency = 1
                }):Play()
            end))
            
            local ItemButton = Instance.new("ImageButton", ItemFrame)
            ItemButton.ZIndex = ItemFrame.ZIndex + 10
            ItemButton.Size = UDim2.fromScale(1,1)
            ItemButton.BackgroundTransparency = 1
            ItemButton.ImageTransparency = 1
            
            if config.Multi then
                ItemButton.MouseButton1Click:Connect(function()
                    config.Default[Value] = not config.Default[Value]
                    MarkItem()
                    BasedLabel.Text = ParseDropdown(config.Default)
                    config.Callback(config.Default)
                end)
            else
                ItemButton.MouseButton1Click:Connect(function()
                    config.Default = Value
                    for i, v in next, DropdownLib.Refuse do
                        task.spawn(v)
                    end
                    BasedLabel.Text = ParseDropdown(config.Default)
                    config.Callback(config.Default)
                end)
            end
        end
        
        DropdownHandler.Size = UDim2.new(0, (Dropdown.AbsoluteSize.X + 5) + DropdownLib.ExtentSize, 0, math.min(UIListLayout.AbsoluteContentSize.Y + 5, 250))
        SetPosition()
    end
    
    UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
        DropdownScrollFrame.CanvasSize = UDim2.fromOffset(0, UIListLayout.AbsoluteContentSize.Y)
        DropdownHandler.Size = UDim2.new(0, (Dropdown.AbsoluteSize.X + 5) + DropdownLib.ExtentSize, 0, math.min(UIListLayout.AbsoluteContentSize.Y + 5, 250))
        SetPosition()
    end)
    
    DropdownLib:Generate()
    
    local isOpen = false
    local ClickButton = Instance.new("ImageButton", Dropdown)
    ClickButton.ZIndex = Dropdown.ZIndex + 10
    ClickButton.Size = UDim2.fromScale(1,1)
    ClickButton.BackgroundTransparency = 1
    ClickButton.ImageTransparency = 1
    
    ClickButton.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        if isOpen then
            DropdownHandler.Visible = true
            TweenService:Create(DropdownHandler, TweenInfo.new(0.175), {
                BackgroundTransparency = 0.035
            }):Play()
            if config.AutoUpdate then
                DropdownLib:Generate()
            end
        else
            TweenService:Create(DropdownHandler, TweenInfo.new(0.175), {
                BackgroundTransparency = 1
            }):Play()
            task.wait(0.175)
            DropdownHandler.Visible = false
        end
    end)
    
    function DropdownLib:GetValue()
        return config.Default
    end
    
    function DropdownLib:SetValue(v)
        config.Default = v
        BasedLabel.Text = ParseDropdown(config.Default)
        for i, v in next, DropdownLib.Refuse do
            task.spawn(v)
        end
        config.Callback(config.Default)
    end
    
    function DropdownLib:SetValues(a)
        config.Values = a
        if not config.AutoUpdate then
            DropdownLib:Generate()
        end
    end
    
    return DropdownLib
end

-- ============================================
-- PARAGRAPH (Label with wrap support)
-- ============================================
function Elements.CreateParagraph(parent, config, accentColor, signal)
    config = config or {}
    config.Text = config.Text or "Paragraph"
    config.Wrap = config.Wrap or true
    config.Size = config.Size or UDim2.new(1, -20, 0, 30)
    
    local ZIndex = parent.ZIndex or 0
    
    local ParagraphFrame = Instance.new("Frame")
    local ParagraphLabel = Instance.new("TextLabel")
    local LineFrame = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    
    ParagraphFrame.Name = "Paragraph_" .. string.gsub(config.Text, "%s+", "_"):sub(1, 30)
    ParagraphFrame.Parent = parent
    ParagraphFrame.BackgroundColor3 = Color3.fromRGB(25, 27, 33)
    ParagraphFrame.BackgroundTransparency = 1.000
    ParagraphFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ParagraphFrame.BorderSizePixel = 0
    ParagraphFrame.Size = config.Size
    ParagraphFrame.ZIndex = ZIndex + 8
    
    ParagraphLabel.Name = "Label"
    ParagraphLabel.Parent = ParagraphFrame
    ParagraphLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ParagraphLabel.BackgroundTransparency = 1.000
    ParagraphLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ParagraphLabel.BorderSizePixel = 0
    ParagraphLabel.Position = UDim2.new(0, 11, 0, 6)
    ParagraphLabel.Size = UDim2.new(1, -22, 1, -12)
    ParagraphLabel.ZIndex = ZIndex + 9
    ParagraphLabel.Font = Enum.Font.GothamMedium
    ParagraphLabel.Text = config.Text
    ParagraphLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ParagraphLabel.TextSize = 12.000
    ParagraphLabel.TextTransparency = 0.35
    ParagraphLabel.TextXAlignment = Enum.TextXAlignment.Left
    ParagraphLabel.TextYAlignment = Enum.TextYAlignment.Top
    ParagraphLabel.TextWrapped = config.Wrap
    ParagraphLabel.RichText = true
    
    LineFrame.Name = "Line"
    LineFrame.Parent = ParagraphFrame
    LineFrame.AnchorPoint = Vector2.new(0.5, 1)
    LineFrame.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
    LineFrame.BackgroundTransparency = 0.650
    LineFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    LineFrame.BorderSizePixel = 0
    LineFrame.Position = UDim2.new(0.5, 0, 1, 0)
    LineFrame.Size = UDim2.new(1, -20, 0, 1)
    LineFrame.ZIndex = ZIndex + 11
    
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = ParagraphFrame
    
    local ParagraphLib = {}
    
    if config.Wrap then
        local function UpdateSize()
            local textBounds = ParagraphLabel.TextBounds
            local newHeight = math.max(textBounds.Y + 13, 30)
            TweenService:Create(ParagraphFrame, TweenInfo.new(0.175), {
                Size = UDim2.new(config.Size.X.Scale, config.Size.X.Offset, 0, newHeight)
            }):Play()
        end
        ParagraphLabel:GetPropertyChangedSignal("TextBounds"):Connect(UpdateSize)
        task.defer(UpdateSize)
    end
    
    function ParagraphLib:SetText(t)
        ParagraphLabel.Text = t
    end
    
    return ParagraphLib
end

-- ============================================
-- COLOR PICKER (Simple version)
-- ============================================
function Elements.CreateColorPicker(parent, config, accentColor, signal)
    config = config or {}
    config.Default = config.Default or Color3.fromRGB(255, 255, 255)
    config.Callback = config.Callback or function() end
    config.Flag = config.Flag or nil
    
    local ZIndex = parent.ZIndex or 0
    
    local ColorPickerLib = {}
    local ColorPicker = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local UIStroke = Instance.new("UIStroke")
    
    ColorPicker.Name = "ColorPicker_" .. (config.Flag or tostring(math.random(1000,9999)))
    ColorPicker.Parent = parent
    ColorPicker.BackgroundColor3 = config.Default
    ColorPicker.BackgroundTransparency = 0
    ColorPicker.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ColorPicker.BorderSizePixel = 0
    ColorPicker.ClipsDescendants = true
    ColorPicker.Size = UDim2.new(0, 18, 0, 18)
    ColorPicker.ZIndex = ZIndex + 13
    
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = ColorPicker
    
    UIStroke.Transparency = 0.650
    UIStroke.Color = Color3.fromRGB(45, 48, 58)
    UIStroke.Parent = ColorPicker
    
    local ClickButton = Instance.new("ImageButton", ColorPicker)
    ClickButton.ZIndex = ColorPicker.ZIndex + 10
    ClickButton.Size = UDim2.fromScale(1,1)
    ClickButton.BackgroundTransparency = 1
    ClickButton.ImageTransparency = 1
    
    -- Simple color picker dialog
    ClickButton.MouseButton1Click:Connect(function()
        -- Create a simple color selection dialog
        local dialog = Instance.new("Frame")
        dialog.Size = UDim2.new(0, 200, 0, 150)
        dialog.Position = UDim2.new(0.5, -100, 0.5, -75)
        dialog.AnchorPoint = Vector2.new(0.5, 0.5)
        dialog.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
        dialog.BorderSizePixel = 0
        dialog.Parent = game:GetService("CoreGui")
        
        local dialogCorner = Instance.new("UICorner", dialog)
        dialogCorner.CornerRadius = UDim.new(0, 8)
        
        local title = Instance.new("TextLabel", dialog)
        title.Size = UDim2.new(1, 0, 0, 30)
        title.Text = "Select Color"
        title.TextColor3 = Color3.fromRGB(255, 255, 255)
        title.BackgroundTransparency = 1
        title.Font = Enum.Font.GothamBold
        title.TextSize = 14
        
        local hueSlider = Instance.new("Frame", dialog)
        hueSlider.Size = UDim2.new(0.8, 0, 0, 20)
        hueSlider.Position = UDim2.new(0.1, 0, 0.3, 0)
        hueSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
        hueSlider.BorderSizePixel = 0
        
        local hueGradient = Instance.new("UIGradient", hueSlider)
        hueGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
            ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255, 255, 0)),
            ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
            ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 0, 255)),
            ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
        })
        
        local hueKnob = Instance.new("Frame", hueSlider)
        hueKnob.Size = UDim2.new(0, 10, 1, 0)
        hueKnob.Position = UDim2.new(0, 0, 0, 0)
        hueKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        hueKnob.BorderSizePixel = 0
        
        local satValFrame = Instance.new("Frame", dialog)
        satValFrame.Size = UDim2.new(0.8, 0, 0, 80)
        satValFrame.Position = UDim2.new(0.1, 0, 0.5, 0)
        satValFrame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        satValFrame.BorderSizePixel = 0
        
        local satValGradient = Instance.new("UIGradient", satValFrame)
        satValGradient.Rotation = 90
        satValGradient.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(1, 1)
        })
        
        local satValGradient2 = Instance.new("UIGradient", satValFrame)
        satValGradient2.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(1, 1)
        })
        
        local okButton = Instance.new("TextButton", dialog)
        okButton.Size = UDim2.new(0.3, 0, 0, 30)
        okButton.Position = UDim2.new(0.35, 0, 0.85, 0)
        okButton.Text = "OK"
        okButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        okButton.BackgroundColor3 = accentColor
        okButton.BorderSizePixel = 0
        okButton.Font = Enum.Font.GothamBold
        okButton.TextSize = 12
        
        local okCorner = Instance.new("UICorner", okButton)
        okCorner.CornerRadius = UDim.new(0, 4)
        
        local currentHue = 0
        local currentSat = 1
        local currentVal = 1
        
        local function updateColor()
            local color = Color3.fromHSV(currentHue, currentSat, currentVal)
            ColorPicker.BackgroundColor3 = color
            config.Default = color
            config.Callback(color)
            satValFrame.BackgroundColor3 = Color3.fromHSV(currentHue, 1, 1)
        end
        
        hueSlider.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                local x = math.clamp((input.Position.X - hueSlider.AbsolutePosition.X) / hueSlider.AbsoluteSize.X, 0, 1)
                currentHue = x
                hueKnob.Position = UDim2.new(x, -5, 0, 0)
                updateColor()
            end
        end)
        
        satValFrame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                local x = math.clamp((input.Position.X - satValFrame.AbsolutePosition.X) / satValFrame.AbsoluteSize.X, 0, 1)
                local y = math.clamp((input.Position.Y - satValFrame.AbsolutePosition.Y) / satValFrame.AbsoluteSize.Y, 0, 1)
                currentSat = x
                currentVal = 1 - y
                updateColor()
            end
        end)
        
        okButton.MouseButton1Click:Connect(function()
            dialog:Destroy()
        end)
        
        updateColor()
    end)
    
    function ColorPickerLib:GetValue()
        return config.Default
    end
    
    function ColorPickerLib:SetValue(v)
        config.Default = v
        ColorPicker.BackgroundColor3 = v
        config.Callback(v)
    end
    
    return ColorPickerLib
end

return Elements
