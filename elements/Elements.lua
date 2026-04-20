-- test

-- Elements.lua
-- Berisi semua elemen UI yang dipisahkan dari Library utama
-- Created for Balright UI Library

local Elements = {}

-- ===============================
-- HELPER FUNCTIONS
-- ===============================

local function TableInsert(tbl, value)
    table.insert(tbl, value)
end

local function TableFind(tbl, value)
    for i, v in pairs(tbl) do
        if v == value then
            return i
        end
    end
    return nil
end

local function TableRemove(tbl, index)
    table.remove(tbl, index)
end

local function TableConcat(tbl, sep)
    return table.concat(tbl, sep)
end

local function StringFormat(fmt, ...)
    return string.format(fmt, ...)
end

local function StringGSub(str, pattern, replacement)
    return string.gsub(str, pattern, replacement)
end

local function StringLen(str)
    return string.len(str)
end

-- ===============================
-- 1. COLORPICKER
-- ===============================
function Elements.CreateColorpicker(Data, Library, Instances, Tween, UserInputService, RunService)
    local Colorpicker = {
        Hue = 0,
        Saturation = 0,
        Value = 0,
        Color = Color3.fromRGB(0, 0, 0),
        HexValue = "000000",
        Flag = Data.Flag,
        IsOpen = false
    }

    local Items = { }
    
    Items["ColorpickerButton"] = Instances:Create("TextButton", {
        Parent = Data.Parent.Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Color3.fromRGB(0, 0, 0),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Text = "",
        AutoButtonColor = false,
        Size = UDim2.new(0, 14, 0, 14),
        BorderSizePixel = 0,
        TextSize = 14,
        BackgroundColor3 = Color3.fromRGB(164, 229, 255)
    })
    
    Instances:Create("UIStroke", {
        Parent = Items["ColorpickerButton"].Instance,
        Name = "\0",
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Color = Color3.fromRGB(56, 62, 62),
        Thickness = 1.5
    }):AddToTheme({Color = "Border 2"})
    
    Instances:Create("UICorner", {
        Parent = Items["ColorpickerButton"].Instance,
        Name = "\0",
        CornerRadius = UDim.new(0, 4)
    })
    
    Items["ColorpickerWindow"] = Instances:Create("Frame", {
        Parent = Library.UnusedHolder.Instance,
        Name = "\0",
        Visible = false,
        Position = UDim2.new(0, 115, 0, 102),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(0, 183, 0, 201),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(16, 18, 18)
    })  
    Items["ColorpickerWindow"]:AddToTheme({BackgroundColor3 = "Background"})
    
    Instances:Create("UICorner", {
        Parent = Items["ColorpickerWindow"].Instance,
        Name = "\0",
        CornerRadius = UDim.new(0, 7)
    })
    
    Items["Inline"] = Instances:Create("Frame", {
        Parent = Items["ColorpickerWindow"].Instance,
        Name = "\0",
        Position = UDim2.new(0, 6, 0, 6),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(1, -12, 1, -12),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(21, 24, 24)
    })  
    Items["Inline"]:AddToTheme({BackgroundColor3 = "Inline"})
    
    Instances:Create("UIStroke", {
        Parent = Items["Inline"].Instance,
        Name = "\0",
        Color = Color3.fromRGB(30, 33, 33),
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    }):AddToTheme({Color = "Border"})
    
    Instances:Create("UICorner", {
        Parent = Items["Inline"].Instance,
        Name = "\0",
        CornerRadius = UDim.new(0, 7)
    })
    
    Items["Palette"] = Instances:Create("TextButton", {
        Parent = Items["Inline"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Color3.fromRGB(0, 0, 0),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Text = "-,",
        AutoButtonColor = false,
        Position = UDim2.new(0, 6, 0, 6),
        Size = UDim2.new(1, -12, 1, -40),
        BorderSizePixel = 0,
        TextSize = 14,
        BackgroundColor3 = Color3.fromRGB(164, 229, 255)
    })
    
    Instances:Create("UICorner", {
        Parent = Items["Palette"].Instance,
        Name = "\0",
        CornerRadius = UDim.new(0, 7)
    })
    
    Instances:Create("UIStroke", {
        Parent = Items["Palette"].Instance,
        Name = "\0",
        Color = Color3.fromRGB(30, 33, 33),
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    }):AddToTheme({Color = "Border"})
    
    Items["Saturation"] = Instances:Create("ImageLabel", {
        Parent = Items["Palette"].Instance,
        Name = "\0",
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Image = "rbxassetid://130624743341203",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        ZIndex = 2,
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })
    
    Instances:Create("UICorner", {
        Parent = Items["Saturation"].Instance,
        Name = "\0",
        CornerRadius = UDim.new(0, 7)
    })
    
    Items["Value"] = Instances:Create("ImageLabel", {
        Parent = Items["Palette"].Instance,
        Name = "\0",
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(1, 2, 1, 0),
        Image = "rbxassetid://96192970265863",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, -1, 0, 0),
        ZIndex = 3,
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })
    
    Instances:Create("UICorner", {
        Parent = Items["Value"].Instance,
        Name = "\0",
        CornerRadius = UDim.new(0, 7)
    })
    
    Items["PaletteDragger"] = Instances:Create("Frame", {
        Parent = Items["Palette"].Instance,
        Name = "\0",
        Size = UDim2.new(0, 3, 0, 3),
        Position = UDim2.new(0, 5, 0, 5),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        ZIndex = 3,
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })
    
    Instances:Create("UICorner", {
        Parent = Items["PaletteDragger"].Instance,
        Name = "\0",
        CornerRadius = UDim.new(1, 0)
    })
    
    Instances:Create("UIStroke", {
        Parent = Items["PaletteDragger"].Instance,
        Name = "\0",
        Color = Color3.fromRGB(120, 120, 120),
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    })
    
    Items["Hue"] = Instances:Create("TextButton", {
        Parent = Items["Inline"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Color3.fromRGB(0, 0, 0),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Text = "",
        AutoButtonColor = false,
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.new(0, 6, 1, -6),
        Size = UDim2.new(1, -12, 0, 18),
        BorderSizePixel = 0,
        TextSize = 14,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })
    
    Instances:Create("UICorner", {
        Parent = Items["Hue"].Instance,
        Name = "\0",
        CornerRadius = UDim.new(0, 7)
    })
    
    Instances:Create("UIStroke", {
        Parent = Items["Hue"].Instance,
        Name = "\0",
        Color = Color3.fromRGB(30, 33, 33),
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    }):AddToTheme({Color = "Border"})
    
    Instances:Create("UIGradient", {
        Parent = Items["Hue"].Instance,
        Name = "\0",
        Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
            ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
            ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
            ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
            ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
        }
    })
    
    Items["HueDragger"] = Instances:Create("Frame", {
        Parent = Items["Hue"].Instance,
        Name = "\0",
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(0, 2, 1, 0),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })
    
    Instances:Create("UIStroke", {
        Parent = Items["HueDragger"].Instance,
        Name = "\0",
        Color = Color3.fromRGB(30, 33, 33),
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    }):AddToTheme({Color = "Border"})

    local Debounce = false
    local RenderStepped  

    function Colorpicker:Get()
        return Colorpicker.Color
    end

    function Colorpicker:SetVisibility(Bool)
        Items["ColorpickerButton"].Instance.Visible = Bool
    end

    function Colorpicker:SetOpen(Bool)
        if Debounce then 
            return
        end

        Colorpicker.IsOpen = Bool
        Debounce = true 

        if Colorpicker.IsOpen then 
            Items["ColorpickerWindow"].Instance.Visible = true
            Items["ColorpickerWindow"].Instance.Parent = Library.Holder.Instance
            
            RenderStepped = RunService.RenderStepped:Connect(function()
                Items["ColorpickerWindow"].Instance.Position = UDim2.new(0, Items["ColorpickerButton"].Instance.AbsolutePosition.X + 18, 0, Items["ColorpickerButton"].Instance.AbsolutePosition.Y - 25)
            end)

            for Index, Value in Library.OpenFrames do 
                if not Data.Section.IsSettings then
                    Value:SetOpen(false)
                end
            end

            Library.OpenFrames[Colorpicker] = Colorpicker 
        else
            if Library.OpenFrames[Colorpicker] then 
                Library.OpenFrames[Colorpicker] = nil
            end

            if RenderStepped then 
                RenderStepped:Disconnect()
                RenderStepped = nil
            end
        end

        local Descendants = Items["ColorpickerWindow"].Instance:GetDescendants()
        TableInsert(Descendants, Items["ColorpickerWindow"].Instance)

        local NewTween

        for Index, Value in Descendants do 
            local TransparencyProperty = Tween:GetProperty(Value)

            if not TransparencyProperty then
                continue 
            end

            if not Value.ClassName:find("UI") then 
                Value.ZIndex = Colorpicker.IsOpen and 4 or 1
            end

            if type(TransparencyProperty) == "table" then 
                for _, Property in TransparencyProperty do 
                    NewTween = Tween:FadeItem(Value, Property, Bool, Library.FadeSpeed)
                end
            else
                NewTween = Tween:FadeItem(Value, TransparencyProperty, Bool, Library.FadeSpeed)
            end
        end
        
        NewTween.Tween.Completed:Connect(function()
            Debounce = false 
            Items["ColorpickerWindow"].Instance.Visible = Colorpicker.IsOpen
            task.wait(0.2)
            Items["ColorpickerWindow"].Instance.Parent = not Colorpicker.IsOpen and Library.UnusedHolder.Instance or Library.Holder.Instance
        end)
    end

    function Colorpicker:Update()
        local Hue, Saturation, Value = Colorpicker.Hue, Colorpicker.Saturation, Colorpicker.Value
        Colorpicker.Color = Color3.fromHSV(Hue, Saturation, Value)
        Colorpicker.HexValue = Colorpicker.Color:ToHex()

        Library.Flags[Colorpicker.Flag] = {
            Color = Colorpicker.Color,
            HexValue = Colorpicker.HexValue,
        }

        Items["ColorpickerButton"]:Tween(nil, {BackgroundColor3 = Colorpicker.Color})
        Items["Palette"]:Tween(nil, {BackgroundColor3 = Color3.fromHSV(Hue, 1, 1)})

        if Data.Callback then 
            Library:SafeCall(Data.Callback, Colorpicker.Color)
        end
    end

    local SlidingPalette = false
    local PaletteChanged
    
    function Colorpicker:SlidePalette(Input)
        if not Input or not SlidingPalette then
            return
        end

        local ValueX = math.clamp(1 - (Input.Position.X - Items["Palette"].Instance.AbsolutePosition.X) / Items["Palette"].Instance.AbsoluteSize.X, 0, 1)
        local ValueY = math.clamp(1 - (Input.Position.Y - Items["Palette"].Instance.AbsolutePosition.Y) / Items["Palette"].Instance.AbsoluteSize.Y, 0, 1)

        Colorpicker.Saturation = ValueX
        Colorpicker.Value = ValueY

        local SlideX = math.clamp((Input.Position.X - Items["Palette"].Instance.AbsolutePosition.X) / Items["Palette"].Instance.AbsoluteSize.X, 0, 0.98)
        local SlideY = math.clamp((Input.Position.Y - Items["Palette"].Instance.AbsolutePosition.Y) / Items["Palette"].Instance.AbsoluteSize.Y, 0, 0.98)

        Items["PaletteDragger"]:Tween(TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(SlideX, 0, SlideY, 0)})
        Colorpicker:Update()
    end
    
    local SlidingHue = false
    local HueChanged

    function Colorpicker:SlideHue(Input)
        if not Input or not SlidingHue then
            return
        end
        
        local ValueX = math.clamp((Input.Position.X - Items["Hue"].Instance.AbsolutePosition.X) / Items["Hue"].Instance.AbsoluteSize.X, 0, 1)

        Colorpicker.Hue = ValueX

        local SlideX = math.clamp((Input.Position.X - Items["Hue"].Instance.AbsolutePosition.X) / Items["Hue"].Instance.AbsoluteSize.X, 0, 0.995)

        Items["HueDragger"]:Tween(TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(SlideX, 0, 0, 0)})
        Colorpicker:Update()
    end

    function Colorpicker:Set(Color, Alpha)
        if type(Color) == "table" then
            Color = Color3.fromRGB(Color[1], Color[2], Color[3])
            Alpha = Color[4]
        elseif type(Color) == "string" then
            Color = Color3.fromHex(Color)
        end 

        Colorpicker.Hue, Colorpicker.Saturation, Colorpicker.Value = Color:ToHSV()
        Colorpicker.Alpha = Alpha or 0  

        local PaletteValueX = math.clamp(1 - Colorpicker.Saturation, 0, 0.98)
        local PaletteValueY = math.clamp(1 - Colorpicker.Value, 0, 0.98)

        local HuePositionX = math.clamp(Colorpicker.Hue, 0, 0.99)

        Items["PaletteDragger"]:Tween(TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(PaletteValueX, 0, PaletteValueY, 0)})
        Items["HueDragger"]:Tween(TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(HuePositionX, 0, 0, 0)})
        Colorpicker:Update()
    end

    Items["ColorpickerButton"]:Connect("MouseButton1Down", function()
        Colorpicker:SetOpen(not Colorpicker.IsOpen)
    end)

    Items["Palette"]:Connect("InputBegan", function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
            SlidingPalette = true 
            Colorpicker:SlidePalette(Input)

            if PaletteChanged then
                return
            end

            PaletteChanged = Input.Changed:Connect(function()
                if Input.UserInputState == Enum.UserInputState.End then
                    SlidingPalette = false
                    PaletteChanged:Disconnect()
                    PaletteChanged = nil
                end
            end)
        end
    end)

    Items["Hue"]:Connect("InputBegan", function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
            SlidingHue = true 
            Colorpicker:SlideHue(Input)

            if HueChanged then
                return
            end

            HueChanged = Input.Changed:Connect(function()
                if Input.UserInputState == Enum.UserInputState.End then
                    SlidingHue = false
                    HueChanged:Disconnect()
                    HueChanged = nil
                end
            end)
        end
    end)

    Library:Connect(UserInputService.InputBegan, function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            if Colorpicker.IsOpen then
                if Library:IsMouseOverFrame(Items["ColorpickerWindow"]) then
                    return
                end
                Colorpicker:SetOpen(false)
            end
        end
    end)
    
    Library:Connect(UserInputService.InputChanged, function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
            if SlidingPalette then 
                Colorpicker:SlidePalette(Input)
            end
            if SlidingHue then 
                Colorpicker:SlideHue(Input)
            end
        end
    end)

    Items["ColorpickerButton"]:Connect("Changed", function(Property)
        if Property == "AbsolutePosition" and Colorpicker.IsOpen then
            Colorpicker.IsOpen = not Library:IsClipped(Items["ColorpickerButton"].Instance, Data.Section.Items["Section"].Instance.Parent)
            Items["ColorpickerWindow"].Instance.Visible = Colorpicker.IsOpen
        end
    end)

    if Data.Default then
        Colorpicker:Set(Data.Default)
    end

    Library.SetFlags[Colorpicker.Flag] = function(Color, Alpha)
        Colorpicker:Set(Color, Alpha)
    end

    return Colorpicker, Items
end

-- ===============================
-- 2. KEYBIND
-- ===============================
function Elements.CreateKeybind(Data, Library, Instances, Tween, UserInputService, RunService, Keys)
    local Keybind = {
        Flag = Data.Flag,
        Key = "",
        Value = "",
        Mode = "",
        Toggled = false,
        Picking = false,
        IsOpen = false
    }

    local Items = { }
    
    Items["KeyButton"] = Instances:Create("TextButton", {
        Parent = Data.Parent.Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Color3.fromRGB(100, 100, 100),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Text = "-",
        AutoButtonColor = false,
        Size = UDim2.new(0, 0, 1, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 12,
        BackgroundColor3 = Color3.fromRGB(30, 34, 34)
    })  
    Items["KeyButton"]:AddToTheme({BackgroundColor3 = "Element"})
    
    Instances:Create("UICorner", {
        Parent = Items["KeyButton"].Instance,
        Name = "\0",
        CornerRadius = UDim.new(0, 4)
    })
    
    Instances:Create("UIPadding", {
        Parent = Items["KeyButton"].Instance,
        Name = "\0",
        PaddingRight = UDim.new(0, 4),
        PaddingLeft = UDim.new(0, 5)
    })                

    Items["KeybindWindow"] = Instances:Create("Frame", {
        Parent = Library.UnusedHolder.Instance,
        Name = "\0",
        Visible = false,
        Position = UDim2.new(0, 231, 0, 102),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(0, 67, 0, 92),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(16, 18, 18)
    })  
    Items["KeybindWindow"]:AddToTheme({BackgroundColor3 = "Background"})
    
    Instances:Create("UICorner", {
        Parent = Items["KeybindWindow"].Instance,
        Name = "\0",
        CornerRadius = UDim.new(0, 7)
    })
    
    Items["Inline"] = Instances:Create("Frame", {
        Parent = Items["KeybindWindow"].Instance,
        Name = "\0",
        Position = UDim2.new(0, 6, 0, 6),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(1, -12, 1, -12),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(21, 24, 24)
    })  
    Items["Inline"]:AddToTheme({BackgroundColor3 = "Inline"})
    
    Instances:Create("UIStroke", {
        Parent = Items["Inline"].Instance,
        Name = "\0",
        Color = Color3.fromRGB(30, 33, 33),
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    }):AddToTheme({Color = "Border"})
    
    Instances:Create("UICorner", {
        Parent = Items["Inline"].Instance,
        Name = "\0",
        CornerRadius = UDim.new(0, 7)
    })
    
    Items["Toggle"] = Instances:Create("TextButton", {
        Parent = Items["Inline"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Text = "Toggle",
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 20),
        BorderSizePixel = 0,
        TextSize = 14,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })
    
    Instances:Create("UIListLayout", {
        Parent = Items["Inline"].Instance,
        Name = "\0",
        Padding = UDim.new(0, 5),
        SortOrder = Enum.SortOrder.LayoutOrder
    })
    
    Instances:Create("UIPadding", {
        Parent = Items["Inline"].Instance,
        Name = "\0",
        PaddingTop = UDim.new(0, 4)
    })
    
    Items["Hold"] = Instances:Create("TextButton", {
        Parent = Items["Inline"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Color3.fromRGB(100, 100, 100),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Text = "Hold",
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 20),
        BorderSizePixel = 0,
        TextSize = 14,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })
    
    Items["Always"] = Instances:Create("TextButton", {
        Parent = Items["Inline"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Color3.fromRGB(100, 100, 100),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Text = "Always",
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 20),
        BorderSizePixel = 0,
        TextSize = 14,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })                

    local Modes = {
        ["Always"] = Items["Always"],
        ["Hold"] = Items["Hold"],
        ["Toggle"] = Items["Toggle"]
    }

    local Debounce = false
    local RenderStepped 

    function Keybind:SetOpen(Bool)
        if Debounce then 
            return
        end

        Keybind.IsOpen = Bool
        Debounce = true 

        if Keybind.IsOpen then 
            Items["KeybindWindow"].Instance.Visible = true
            Items["KeybindWindow"].Instance.Parent = Library.Holder.Instance
            
            RenderStepped = RunService.RenderStepped:Connect(function()
                Items["KeybindWindow"].Instance.Position = UDim2.new(0, Items["KeyButton"].Instance.AbsolutePosition.X + 18, 0, Items["KeyButton"].Instance.AbsolutePosition.Y - 25)
            end)

            for Index, Value in Library.OpenFrames do 
                if not Data.Section.IsSettings then
                    Value:SetOpen(false)
                end
            end

            Library.OpenFrames[Keybind] = Keybind 
        else
            if Library.OpenFrames[Keybind] then 
                Library.OpenFrames[Keybind] = nil
            end

            if RenderStepped then 
                RenderStepped:Disconnect()
                RenderStepped = nil
            end
        end

        local Descendants = Items["KeybindWindow"].Instance:GetDescendants()
        TableInsert(Descendants, Items["KeybindWindow"].Instance)

        local NewTween

        for Index, Value in Descendants do 
            local TransparencyProperty = Tween:GetProperty(Value)

            if not TransparencyProperty then
                continue 
            end

            if not Value.ClassName:find("UI") then 
                Value.ZIndex = Keybind.IsOpen and 2 or 1
            end

            if type(TransparencyProperty) == "table" then 
                for _, Property in TransparencyProperty do 
                    NewTween = Tween:FadeItem(Value, Property, Bool, Library.FadeSpeed)
                end
            else
                NewTween = Tween:FadeItem(Value, TransparencyProperty, Bool, Library.FadeSpeed)
            end
        end
        
        NewTween.Tween.Completed:Connect(function()
            Debounce = false 
            Items["KeybindWindow"].Instance.Visible = Keybind.IsOpen
            task.wait(0.2)
            Items["KeybindWindow"].Instance.Parent = not Keybind.IsOpen and Library.UnusedHolder.Instance or Library.Holder.Instance
        end)
    end

    function Keybind:SetMode(Mode)
        for Index, Value in Modes do 
            if Index == Mode then
                Value:Tween(nil, {TextColor3 = Color3.fromRGB(255, 255, 255)})
            else
                Value:Tween(nil, {TextColor3 = Color3.fromRGB(100, 100, 100)})
            end
        end

        Library.Flags[Keybind.Flag] = {
            Mode = Keybind.Mode,
            Key = Keybind.Key,
            Toggled = Keybind.Toggled
        }

        if Data.Callback then 
            Library:SafeCall(Data.Callback, Keybind.Toggled)
        end
    end

    function Keybind:Get()
        return Keybind.Key, Keybind.Mode, Keybind.Toggled
    end

    function Keybind:Set(Key)
        if string.find(tostring(Key), "Enum") then 
            Keybind.Key = tostring(Key)
            Key = Key.Name == "Backspace" and "None" or Key.Name

            local KeyString = Keys[Keybind.Key] or string.gsub(Key, "Enum.", "") or "None"
            local TextToDisplay = string.gsub(string.gsub(KeyString, "KeyCode.", ""), "UserInputType.", "") or "None"

            Keybind.Value = TextToDisplay
            Items["KeyButton"].Instance.Text = TextToDisplay

            Library.Flags[Keybind.Flag] = {
                Mode = Keybind.Mode,
                Key = Keybind.Key,
                Toggled = Keybind.Toggled
            }

            if Data.Callback then 
                Library:SafeCall(Data.Callback, Keybind.Toggled)
            end
        elseif type(Key) == "table" then
            local RealKey = Key.Key == "Backspace" and "None" or Key.Key
            Keybind.Key = tostring(Key.Key)

            if Key.Mode then
                Keybind.Mode = Key.Mode
                Keybind:SetMode(Key.Mode)
            else
                Keybind.Mode = "Toggle"
                Keybind:SetMode("Toggle")
            end

            local KeyString = Keys[Keybind.Key] or string.gsub(tostring(RealKey), "Enum.", "") or RealKey
            local TextToDisplay = KeyString and string.gsub(string.gsub(KeyString, "KeyCode.", ""), "UserInputType.", "") or "None"

            TextToDisplay = string.gsub(string.gsub(KeyString, "KeyCode.", ""), "UserInputType.", "")

            Keybind.Value = TextToDisplay
            Items["KeyButton"].Instance.Text = TextToDisplay

            if Data.Callback then 
                Library:SafeCall(Data.Callback, Keybind.Toggled)
            end
        elseif table.find({"Toggle", "Hold", "Always"}, Key) then
            Keybind.Mode = Key
            Keybind:SetMode(Key)

            if Data.Callback then 
                Library:SafeCall(Data.Callback, Keybind.Toggled)
            end
        end

        Keybind.Picking = false
    end

    function Keybind:Press(Bool)
        if Keybind.Mode == "Toggle" then 
            Keybind.Toggled = not Keybind.Toggled
        elseif Keybind.Mode == "Hold" then 
            Keybind.Toggled = Bool
        elseif Keybind.Mode == "Always" then 
            Keybind.Toggled = true
        end

        Library.Flags[Keybind.Flag] = {
            Mode = Keybind.Mode,
            Key = Keybind.Key,
            Toggled = Keybind.Toggled
        }

        if Data.Callback then 
            Library:SafeCall(Data.Callback, Keybind.Toggled)
        end
    end

    Items["KeyButton"]:Connect("MouseButton1Click", function()
        Keybind.Picking = true 
        Items["KeyButton"].Instance.Text = "."
        
        Library:Thread(function()
            local Count = 1
            while true do 
                if not Keybind.Picking then 
                    break
                end
                if Count == 4 then
                    Count = 1
                end
                Items["KeyButton"].Instance.Text = Count == 1 and "." or Count == 2 and ".." or Count == 3 and "..."
                Count = Count + 1
                task.wait(0.35)
            end
        end)

        local InputBegan
        InputBegan = UserInputService.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.Keyboard then 
                Keybind:Set(Input.KeyCode)
            else
                Keybind:Set(Input.UserInputType)
            end
            InputBegan:Disconnect()
            InputBegan = nil
        end)
    end)

    Items["KeyButton"]:Connect("MouseButton2Down", function()
        Keybind:SetOpen(not Keybind.IsOpen)
    end)

    Items["KeyButton"]:Connect("Changed", function(Property)
        if Property == "AbsolutePosition" and Keybind.IsOpen then
            Keybind.IsOpen = not Library:IsClipped(Items["KeybindWindow"].Instance, Data.Section.Items["Section"].Instance.Parent)
            Items["KeybindWindow"].Instance.Visible = Keybind.IsOpen
        end
    end)

    Items["Toggle"]:Connect("MouseButton1Down", function()
        Keybind.Mode = "Toggle"
        Keybind:SetMode("Toggle")
    end)

    Items["Hold"]:Connect("MouseButton1Down", function()
        Keybind.Mode = "Hold"
        Keybind:SetMode("Hold")
    end)

    Items["Always"]:Connect("MouseButton1Down", function()
        Keybind.Mode = "Always"
        Keybind:SetMode("Always")
    end)

    Library:Connect(UserInputService.InputBegan, function(Input)
        if Keybind.Value == "None" then
            return
        end

        if tostring(Input.KeyCode) == Keybind.Key then
            if Keybind.Mode == "Toggle" then 
                Keybind:Press()
            elseif Keybind.Mode == "Hold" then 
                Keybind:Press(true)
            elseif Keybind.Mode == "Always" then 
                Keybind:Press(true)
            end
        elseif tostring(Input.UserInputType) == Keybind.Key then
            if Keybind.Mode == "Toggle" then 
                Keybind:Press()
            elseif Keybind.Mode == "Hold" then 
                Keybind:Press(true)
            elseif Keybind.Mode == "Always" then 
                Keybind:Press(true)
            end
        end

        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
            if not Keybind.IsOpen then
                return
            end
            if Library:IsMouseOverFrame(Items["KeybindWindow"]) then
                return
            end
            Keybind:SetOpen(false)
        end
    end)

    Library:Connect(UserInputService.InputEnded, function(Input)
        if Keybind.Value == "None" then
            return
        end

        if tostring(Input.KeyCode) == Keybind.Key then
            if Keybind.Mode == "Hold" then 
                Keybind:Press(false)
            elseif Keybind.Mode == "Always" then 
                Keybind:Press(true)
            end
        elseif tostring(Input.UserInputType) == Keybind.Key then
            if Keybind.Mode == "Hold" then 
                Keybind:Press(false)
            elseif Keybind.Mode == "Always" then 
                Keybind:Press(true)
            end
        end
    end)

    if Data.Default then 
        Keybind:Set({
            Mode = Data.Mode or "Toggle",
            Key = Data.Default,
        })
    end

    Library.SetFlags[Keybind.Flag] = function(Value)
        Keybind:Set(Value)
    end

    return Keybind, Items
end

-- ===============================
-- 3. NOTIFICATION
-- ===============================
function Elements.CreateNotification(Name, Duration, Icon, Library, Instances, Tween)
    local Items = { }
    
    Items["Notification"] = Instances:Create("Frame", {
        Parent = Library.NotifHolder.Instance,
        Name = "\0",
        Size = UDim2.new(0, 0, 0, 30),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundColor3 = Color3.fromRGB(16, 18, 18)
    })  
    Items["Notification"]:AddToTheme({BackgroundColor3 = "Background"})
    
    Instances:Create("UICorner", {
        Parent = Items["Notification"].Instance,
        Name = "\0",
        CornerRadius = UDim.new(0, 7)
    })
    
    Items["UIStroke"] = Instances:Create("UIStroke", {
        Parent = Items["Notification"].Instance,
        Name = "\0",
        Color = Color3.fromRGB(30, 33, 33),
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    })  
    Items["UIStroke"]:AddToTheme({Color = "Border"})
    
    Instances:Create("UIPadding", {
        Parent = Items["Notification"].Instance,
        Name = "\0",
        PaddingRight = UDim.new(0, 8),
        PaddingLeft = UDim.new(0, 8)
    })
    
    if Icon then
        Items["Icon"] = Instances:Create("ImageLabel", {
            Parent = Items["Notification"].Instance,
            Name = "\0",
            ImageColor3 = Color3.fromRGB(255, 255, 255),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            Image = "rbxassetid://"..Icon,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 0, 0.5, 0),
            Size = UDim2.new(0, 16, 0, 16),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        })
    end
    
    Items["Text"] = Instances:Create("TextLabel", {
        Parent = Items["Notification"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Text = Name,
        AnchorPoint = Vector2.new(0, 0.5),
        Size = UDim2.new(0, 0, 0, 15),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, Icon and 24 or 0, 0.5, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 14,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })  

    local Size = Items["Notification"].Instance.AbsoluteSize

    for Index, Value in Items do 
        if Value.Instance:IsA("Frame") then
            Value.Instance.BackgroundTransparency = 1
        elseif Value.Instance:IsA("TextLabel") then 
            Value.Instance.TextTransparency = 1
        elseif Value.Instance:IsA("ImageLabel") then 
            Value.Instance.ImageTransparency = 1
        elseif Value.Instance:IsA("UIStroke") then
            Value.Instance.Transparency = 1
        end
    end 
    
    task.wait(0.3)
    Items["Notification"].Instance.AutomaticSize = Enum.AutomaticSize.Y

    Library:Thread(function()
        for Index, Value in Items do 
            if Value.Instance:IsA("Frame") then
                Value:Tween(nil, {BackgroundTransparency = 0})
            elseif Value.Instance:IsA("TextLabel") then 
                Value:Tween(nil, {TextTransparency = 0})
            elseif Value.Instance:IsA("ImageLabel") then 
                Value:Tween(nil, {ImageTransparency = 0.5})
            elseif Value.Instance:IsA("UIStroke") then
                Value:Tween(nil, {Transparency = 0})
            end
        end

        Items["Notification"]:Tween(nil, {Size = UDim2.new(0, Size.X, 0, Size.Y)})

        task.delay(Duration, function()
            for Index, Value in Items do 
                if Value.Instance:IsA("Frame") then
                    Value:Tween(nil, {BackgroundTransparency = 1})
                elseif Value.Instance:IsA("TextLabel") then 
                    Value:Tween(nil, {TextTransparency = 1})
                elseif Value.Instance:IsA("ImageLabel") then 
                    Value:Tween(nil, {ImageTransparency = 1})
                elseif Value.Instance:IsA("UIStroke") then
                    Value:Tween(nil, {Transparency = 1})
                end
            end

            Items["Notification"]:Tween(nil, {Size = UDim2.new(0, 0, 0, 0)})
            task.wait(0.5)
            Items["Notification"]:Clean()
        end)
    end)
end

-- ===============================
-- 4. WINDOW
-- ===============================
function Elements.CreateWindow(Data, Library, Instances, Tween, UserInputService, RunService)
    local StartTime = tick()
    Data = Data or { }

    local Window = {
        Name = Data.Name or Data.name or "Window",
        SubTitle = Data.SubTitle or Data.subtitle or "for PUBG",
        ExpiresIn = Data.ExpiresIn or Data.expiresin or "23d",
        Pages = { },
        Items = { },
        IsOpen = false
    }

    local Items = { }
    
    local FirstLetterOfName = string.sub(Window.Name, 1, 1)
    Items["MainFrame"] = Instances:Create("Frame", {
        Parent = Library.Holder.Instance,
        Name = "\0",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(0, 798, 0, 599),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(16, 18, 18)
    })  
    Items["MainFrame"]:AddToTheme({BackgroundColor3 = "Background"})

    Items["MainFrame"]:MakeDraggable()
    Items["MainFrame"]:MakeResizeable(Vector2.new(Items["MainFrame"].Instance.AbsoluteSize.X, Items["MainFrame"].Instance.AbsoluteSize.Y), Vector2.new(9999, 9999))
    
    Instances:Create("UICorner", {
        Parent = Items["MainFrame"].Instance,
        Name = "\0",
        CornerRadius = UDim.new(0, 7)
    })
    
    Items["Side"] = Instances:Create("Frame", {
        Parent = Items["MainFrame"].Instance,
        Name = "\0",
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(0, 215, 1, 0),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })
    
    Items["Title"] = Instances:Create("Frame", {
        Parent = Items["Side"].Instance,
        Name = "\0",
        Position = UDim2.new(0, 6, 0, 6),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(1, -12, 0, 60),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(21, 24, 24)
    })  
    Items["Title"]:AddToTheme({BackgroundColor3 = "Inline"})
    
    Instances:Create("UICorner", {
        Parent = Items["Title"].Instance,
        Name = "\0",
        CornerRadius = UDim.new(0, 7)
    })
    
    Instances:Create("UIStroke", {
        Parent = Items["Title"].Instance,
        Name = "\0",
        Color = Color3.fromRGB(30, 33, 33),
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    }):AddToTheme({Color = "Border"})
    
    Items["Background"] = Instances:Create("Frame", {
        Parent = Items["Title"].Instance,
        Name = "\0",
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 12, 0.5, 0),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(0, 40, 0, 40),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(207, 207, 207)
    })
    
    Instances:Create("UICorner", {
        Parent = Items["Background"].Instance,
        Name = "\0",
        CornerRadius = UDim.new(0, 7)
    })
    
    Instances:Create("UIStroke", {
        Parent = Items["Background"].Instance,
        Name = "\0",
        Color = Color3.fromRGB(30, 33, 33),
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    }):AddToTheme({Color = "Border"})
    
    Items["Text"] = Instances:Create("TextLabel", {
        Parent = Items["Background"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Color3.fromRGB(0, 0, 0),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Text = FirstLetterOfName,
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, -10, 1, -10),
        BorderSizePixel = 0,
        TextSize = 22,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })
    
    Items["RealTitle"] = Instances:Create("TextLabel", {
        Parent = Items["Title"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Text = Window.Name,
        Size = UDim2.new(0, 0, 0, 15),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 65, 0, 14),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 14,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })  
    
    Items["Game"] = Instances:Create("TextLabel", {
        Parent = Items["Title"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextTransparency = 0.5,
        Text = Window.SubTitle,
        Size = UDim2.new(0, 0, 0, 15),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 65, 0, 30),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 14,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })
    
    Items["Pages"] = Instances:Create("Frame", {
        Parent = Items["Side"].Instance,
        Name = "\0",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 75),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(1, 0, 1, -80),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })
    
    Instances:Create("UIListLayout", {
        Parent = Items["Pages"].Instance,
        Name = "\0",
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    Instances:Create("UIPadding", {
        Parent = Items["Pages"].Instance,
        Name = "\0",
        PaddingLeft = UDim.new(0, 8)
    })                

    Items["Content"] = Instances:Create("Frame", {
        Parent = Items["MainFrame"].Instance,
        Name = "\0",
        Position = UDim2.new(0, 220, 0, 6),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(1, -226, 1, -12),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(21, 24, 24)
    })  
    Items["Content"]:AddToTheme({BackgroundColor3 = "Inline"})
    
    Instances:Create("UICorner", {
        Parent = Items["Content"].Instance,
        Name = "\0",
        CornerRadius = UDim.new(0, 7)
    })
    
    Instances:Create("UIStroke", {
        Parent = Items["Content"].Instance,
        Name = "\0",
        Color = Color3.fromRGB(30, 33, 33),
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    }):AddToTheme({Color = "Border"})          
    
    Items["Bottom_"] = Instances:Create("Frame", {
        Parent = Items["Side"].Instance,
        Name = "\0",
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.new(0, 6, 1, -6),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(1, -12, 0, 45),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(21, 24, 24)
    })  
    Items["Bottom_"]:AddToTheme({BackgroundColor3 = "Inline"})
    
    Instances:Create("UICorner", {
        Parent = Items["Bottom_"].Instance,
        Name = "\0",
        CornerRadius = UDim.new(0, 7)
    })
    
    Instances:Create("UIStroke", {
        Parent = Items["Bottom_"].Instance,
        Name = "\0",
        Color = Color3.fromRGB(30, 33, 33),
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    }):AddToTheme({Color = "Border"})
    
    Items["SubExpires"] = Instances:Create("TextLabel", {
        Parent = Items["Bottom_"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextTransparency = 0.5,
        Text = "Sub expires in "..Window.ExpiresIn,
        Size = UDim2.new(0, 0, 0, 15),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 8),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 12,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })
    
    Items["SessionDuration"] = Instances:Create("TextLabel", {
        Parent = Items["Bottom_"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Text = "Session duration: ",
        Size = UDim2.new(0, 0, 0, 15),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 23),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 12,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })                

    Library:Thread(function()
        while task.wait(1) do
            local SecondsPassed = math.floor(tick() - StartTime)
            local MinutesPassed = math.floor(SecondsPassed / 60)

            if MinutesPassed > 0 then
                SecondsPassed = SecondsPassed - MinutesPassed * 60
            end

            Items["SessionDuration"].Instance.Text = "Session duration: "..MinutesPassed..":"..SecondsPassed
        end
    end)

    Window.Items = Items

    local Debounce = false

    function Window:SetCenter()
        local CenterPosition = Items["MainFrame"].Instance.AbsolutePosition
        task.wait()
        Items["MainFrame"].Instance.AnchorPoint = Vector2.new(0, 0)
        Items["MainFrame"].Instance.Position = UDim2.new(0, CenterPosition.X, 0, CenterPosition.Y)
    end

    function Window:SetOpen(Bool)
        if Debounce then 
            return
        end

        Window.IsOpen = Bool
        Debounce = true 

        if Window.IsOpen then 
            Items["MainFrame"].Instance.Visible = true 
        end

        local Descendants = Items["MainFrame"].Instance:GetDescendants()
        TableInsert(Descendants, Items["MainFrame"].Instance)

        local NewTween

        for Index, Value in Descendants do 
            local TransparencyProperty = Tween:GetProperty(Value)

            if not TransparencyProperty then
                continue 
            end

            if type(TransparencyProperty) == "table" then 
                for _, Property in TransparencyProperty do 
                    NewTween = Tween:FadeItem(Value, Property, Bool, Library.FadeSpeed)
                end
            else
                NewTween = Tween:FadeItem(Value, TransparencyProperty, Bool, Library.FadeSpeed)
            end
        end
        
        NewTween.Tween.Completed:Connect(function()
            Debounce = false 
            Items["MainFrame"].Instance.Visible = Window.IsOpen
        end)
    end

    Library:Connect(UserInputService.InputBegan, function(Input)
        if tostring(Input.KeyCode) == Library.MenuKeybind or tostring(Input.UserInputType) == Library.MenuKeybind then
            Window:SetOpen(not Window.IsOpen)
        end
    end)

    Window:SetCenter()
    task.wait()
    Window:SetOpen(true)
    return setmetatable(Window, Library)
end

-- ===============================
-- 5. PAGE
-- ===============================
function Elements.CreatePage(Data, Library, Instances)
    Data = Data or { }

    local Page = {
        Window = Data.Window or Data,
        Name = Data.Name or Data.name or "Page",
        Icon = Data.Icon or Data.icon or "136879043989014",
        Items = { },
        SubPages = { },
        Active = false
    }

    local Items = { }
    
    Items["Inactive"] = Instances:Create("TextButton", {
        Parent = Page.Window.Items["Pages"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Color3.fromRGB(0, 0, 0),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Text = "",
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 200, 0, 30),
        BorderSizePixel = 0,
        TextSize = 14,
        BackgroundColor3 = Color3.fromRGB(21, 24, 24)
    })  
    Items["Inactive"]:AddToTheme({BackgroundColor3 = "Inline"})
    
    Items["UIStroke"] = Instances:Create("UIStroke", {
        Parent = Items["Inactive"].Instance,
        Name = "\0",
        Color = Color3.fromRGB(30, 33, 33),
        Transparency = 1,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    })  
    Items["UIStroke"]:AddToTheme({Color = "Border"})
    
    Instances:Create("UICorner", {
        Parent = Items["Inactive"].Instance,
        Name = "\0",
        CornerRadius = UDim.new(0, 7)
    })
    
    Items["Icon"] = Instances:Create("ImageLabel", {
        Parent = Items["Inactive"].Instance,
        Name = "\0",
        ImageColor3 = Color3.fromRGB(100, 100, 100),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        Image = "rbxassetid://"..Page.Icon,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0.5, 0),
        Size = UDim2.new(0, 16, 0, 16),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })
    
    Items["Text"] = Instances:Create("TextLabel", {
        Parent = Items["Inactive"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Color3.fromRGB(100, 100, 100),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Text = Page.Name,
        AnchorPoint = Vector2.new(0, 0.5),
        Size = UDim2.new(0, 0, 0, 15),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 38, 0.5, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 14,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })
                            
    Items["Page"] = Instances:Create("Frame", {
        Parent = Library.UnusedHolder.Instance,
        Name = "\0",
        Visible = false,
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(1, 0, 1, 0),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })
    
    Items["PageName"] = Instances:Create("TextLabel", {
        Parent = Items["Page"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Text = Page.Name,
        Size = UDim2.new(0, 0, 0, 15),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 15, 0, 15),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 18,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })
    
    Items["SubPages"] = Instances:Create("Frame", {
        Parent = Items["Page"].Instance,
        Name = "\0",
        Size = UDim2.new(0, 0, 0, 30),
        Position = UDim2.new(0, 13, 0, 42),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundColor3 = Color3.fromRGB(16, 18, 18)
    })  
    Items["SubPages"]:AddToTheme({BackgroundColor3 = "Background"})
    
    Instances:Create("UIPadding", {
        Parent = Items["SubPages"].Instance,
        Name = "\0",
        PaddingTop = UDim.new(0, 2),
        PaddingBottom = UDim.new(0, 2),
        PaddingRight = UDim.new(0, 2),
        PaddingLeft = UDim.new(0, 2)
    })
    
    Instances:Create("UIListLayout", {
        Parent = Items["SubPages"].Instance,
        Name = "\0",
        Padding = UDim.new(0, 2),
        FillDirection = Enum.FillDirection.Horizontal,
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    Instances:Create("UICorner", {
        Parent = Items["SubPages"].Instance,
        Name = "\0",
        CornerRadius = UDim.new(0, 7)
    })                

    Items["Columns"] = Instances:Create("Frame", {
        Parent = Items["Page"].Instance,
        Name = "\0",
        Size = UDim2.new(1, -20, 1, -82),
        Position = UDim2.new(0, 10, 0, 75),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1
    })  

    Page.Items = Items

    local Debounce = false

    function Page:Turn(Bool)
        if Debounce then 
            return 
        end

        Page.Active = Bool 
        
        Debounce = true
        Items["Page"].Instance.Visible = Bool 
        Items["Page"].Instance.Parent = Bool and Page.Window.Items["Content"].Instance or Library.UnusedHolder.Instance

        if Page.Active then
            Items["Inactive"]:Tween(nil, {BackgroundTransparency = 0})
            Items["Icon"]:Tween(nil, {ImageColor3 = Color3.fromRGB(200, 200, 200)})
            Items["Text"]:Tween(nil, {TextColor3 = Color3.fromRGB(200, 200, 200)})
            Items["UIStroke"]:Tween(nil, {Transparency = 0})
        else
            Items["Inactive"]:Tween(nil, {BackgroundTransparency = 1})
            Items["Icon"]:Tween(nil, {ImageColor3 = Color3.fromRGB(100, 100, 100)})
            Items["Text"]:Tween(nil, {TextColor3 = Color3.fromRGB(100, 100, 100)})
            Items["UIStroke"]:Tween(nil, {Transparency = 1})
        end

        Debounce = false
    end

    Items["Inactive"]:Connect("MouseButton1Down", function()
        for Index, Value in Page.Window.Pages do 
            if Value == Page and Page.Active then
                return
            end
            Value:Turn(Value == Page)
        end
    end)

    if #Page.Window.Pages == 0 then 
        Page:Turn(true)
    end

    TableInsert(Page.Window.Pages, Page)
    return setmetatable(Page, Library.Pages)
end

-- ===============================
-- 6. CATEGORY
-- ===============================
function Elements.CreateCategory(Name, Instances, Library)
    local Items = { }
    
    Items["Category"] = Instances:Create("TextLabel", {
        Parent = Library.Pages[1].Items["Pages"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextTransparency = 0.5,
        Text = Name,
        Size = UDim2.new(0, 0, 0, 15),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 12,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })                

    return Items
end

-- ===============================
-- 7. SUBPAGE
-- ===============================
function Elements.CreateSubPage(Data, Library, Instances)
    Data = Data or { }

    local Page = {
        Window = Data.Window,
        Page = Data.Page,
        Name = Data.Name or Data.name or "SubPage",
        Columns = Data.Columns or Data.columns or 2,
        Items = { },
        ColumnsData = { },
        Active = false
    }

    local Items = { }
    
    Items["Inactive"] = Instances:Create("TextButton", {
        Parent = Page.Page.Items["SubPages"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextTransparency = 0.5,
        Text = Page.Name,
        AutoButtonColor = false,
        Size = UDim2.new(0, 0, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 14,
        BackgroundColor3 = Color3.fromRGB(30, 34, 34)
    })  
    Items["Inactive"]:AddToTheme({BackgroundColor3 = "Element"})
     
    Instances:Create("UIPadding", {
        Parent = Items["Inactive"].Instance,
        Name = "\0",
        PaddingRight = UDim.new(0, 8),
        PaddingLeft = UDim.new(0, 8)
    })
    
    Instances:Create("UICorner", {
        Parent = Items["Inactive"].Instance,
        Name = "\0",
        CornerRadius = UDim.new(0, 7)
    })                

    Items["Page"] = Instances:Create("Frame", {
        Parent = Library.UnusedHolder.Instance,
        Name = "\0",
        Visible = false,
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(1, 0, 1, 0),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })

    Instances:Create("UIListLayout", {
        Parent = Items["Page"].Instance,
        Name = "\0",
        FillDirection = Enum.FillDirection.Horizontal,
        SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalFlex = Enum.UIFlexAlignment.Fill
    })

    for Index = 1, Page.Columns do 
        local NewColumn = Instances:Create("ScrollingFrame", {
            Parent = Items["Page"].Instance,
            Name = "\0",
            ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
            Active = true,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            ScrollBarThickness = 0,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        })
        
        if Index == 1 then
            Instances:Create("UIPadding", {
                Parent = NewColumn.Instance,
                Name = "\0",
                PaddingTop = UDim.new(0, 3),
                PaddingBottom = UDim.new(0, 3),
                PaddingRight = UDim.new(0, 8),
                PaddingLeft = UDim.new(0, 3)
            })                
        elseif Index == 2 then
            Instances:Create("UIPadding", {
                Parent = NewColumn.Instance,
                Name = "\0",
                PaddingTop = UDim.new(0, 3),
                PaddingBottom = UDim.new(0, 3),
                PaddingRight = UDim.new(0, 20),
                PaddingLeft = UDim.new(0, 8)
            })
        end

        Page.ColumnsData[Index] = NewColumn
    end

    local Debounce = false

    function Page:Turn(Bool)
        if Debounce then 
            return 
        end

        Page.Active = Bool 
        
        Debounce = true
        Items["Page"].Instance.Visible = Bool 
        Items["Page"].Instance.Parent = Bool and Page.Page.Items["Columns"].Instance or Library.UnusedHolder.Instance

        if Page.Active then
            Items["Inactive"]:Tween(nil, {BackgroundTransparency = 0, TextTransparency = 0})
        else
            Items["Inactive"]:Tween(nil, {BackgroundTransparency = 1, TextTransparency = 0.5})
        end

        Debounce = false
    end

    Items["Inactive"]:Connect("MouseButton1Down", function()
        for Index, Value in Page.Page.SubPages do 
            if Value == Page and Page.Active then
                return
            end
            Value:Turn(Value == Page)
        end
    end)

    if #Page.Page.SubPages == 0 then 
        Page:Turn(true)
    end

    TableInsert(Page.Page.SubPages, Page)
    return setmetatable(Page, Library.Pages)
end

-- ===============================
-- 8. SECTION
-- ===============================
function Elements.CreateSection(Data, Library, Instances)
    Data = Data or { }

    local Section = {
        Window = Data.Window,
        Page = Data.Page,
        Name = Data.Name or Data.name or "Section",
        Icon = Data.Icon or Data.icon or "",
        Side = Data.Side or Data.side or 1,
        Items = { }
    }

    local Items = { }
    
    Items["Section"] = Instances:Create("Frame", {
        Parent = Section.Page.ColumnsData[Section.Side].Instance,
        Name = "\0",
        Size = UDim2.new(1, 0, 0, 25),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = Color3.fromRGB(21, 24, 24)
    })  
    Items["Section"]:AddToTheme({BackgroundColor3 = "Inline"})
    
    Instances:Create("UICorner", {
        Parent = Items["Section"].Instance,
        Name = "\0",
        CornerRadius = UDim.new(0, 7)
    })
    
    Instances:Create("UIStroke", {
        Parent = Items["Section"].Instance,
        Name = "\0",
        Color = Color3.fromRGB(30, 33, 33),
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    }):AddToTheme({Color = "Border"})
    
    Items["Icon"] = Instances:Create("ImageLabel", {
        Parent = Items["Section"].Instance,
        Name = "\0",
        ImageColor3 = Color3.fromRGB(100, 100, 100),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Image = "rbxassetid://"..Section.Icon,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 12),
        Size = UDim2.new(0, 16, 0, 16),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })
    
    Instances:Create("UIPadding", {
        Parent = Items["Section"].Instance,
        Name = "\0",
        PaddingBottom = UDim.new(0, 12)
    })
    
    Items["Text"] = Instances:Create("TextLabel", {
        Parent = Items["Section"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Color3.fromRGB(100, 100, 100),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Text = Section.Name,
        Size = UDim2.new(0, 0, 0, 15),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 35, 0, 12),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 14,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })
    
    Items["Content"] = Instances:Create("Frame", {
        Parent = Items["Section"].Instance,
        Name = "\0",
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 42),
        Size = UDim2.new(1, -24, 0, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })
    
    Instances:Create("UIListLayout", {
        Parent = Items["Content"].Instance,
        Name = "\0",
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder
    })
    
    Section.Items = Items

    return setmetatable(Section, Library.Sections)
end

-- ===============================
-- 9. TOGGLE
-- ===============================
function Elements.CreateToggle(Data)
    local Toggle = {
        Window = Data.Window,
        Page = Data.Page,
        Section = Data.Section,
        Name = Data.Name or "Toggle",
        Flag = Data.Flag or Data.Library:NextFlag(),
        Default = Data.Default or false,
        Callback = Data.Callback or function() end,
        Value = false
    }

    local Items = { }
    
    Items["Toggle"] = Data.Instances:Create("TextButton", {
        Parent = Data.Parent.Instance,
        Name = "\0",
        FontFace = Data.Library.Font,
        TextColor3 = Color3.fromRGB(0, 0, 0),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Text = "",
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 16),
        BorderSizePixel = 0,
        TextSize = 14,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })
    
    Items["Text"] = Data.Instances:Create("TextLabel", {
        Parent = Items["Toggle"].Instance,
        Name = "\0",
        FontFace = Data.Library.Font,
        TextColor3 = Color3.fromRGB(100, 100, 100),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Text = Toggle.Name,
        AnchorPoint = Vector2.new(0, 0.5),
        Size = UDim2.new(0, 0, 0, 15),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0.5, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 14,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })
    
    Items["Indicator"] = Data.Instances:Create("Frame", {
        Parent = Items["Toggle"].Instance,
        Name = "\0",
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        AnchorPoint = Vector2.new(1, 0),
        BackgroundTransparency = 1,
        Position = UDim2.new(1, 0, 0, 0),
        Size = UDim2.new(0, 14, 0, 14),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(30, 33, 33)
    })  
    Items["Indicator"]:AddToTheme({BackgroundColor3 = "Element"})
    
    Data.Instances:Create("UIStroke", {
        Parent = Items["Indicator"].Instance,
        Name = "\0",
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Color = Color3.fromRGB(56, 62, 62),
        Thickness = 2
    }):AddToTheme({Color = "Border 2"})
    
    Data.Instances:Create("UICorner", {
        Parent = Items["Indicator"].Instance,
        Name = "\0",
        CornerRadius = UDim.new(0, 4)
    })
    
    Items["Inline"] = Data.Instances:Create("Frame", {
        Parent = Items["Indicator"].Instance,
        Name = "\0",
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(1, 0, 1, 0),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })  
    Items["Inline"]:AddToTheme({BackgroundColor3 = "Accent"})
    
    Data.Instances:Create("UICorner", {
        Parent = Items["Inline"].Instance,
        Name = "\0",
        CornerRadius = UDim.new(0, 4)
    })
    
    Items["CheckImage"] = Data.Instances:Create("ImageLabel", {
        Parent = Items["Inline"].Instance,
        Name = "\0",
        ImageColor3 = Color3.fromRGB(0, 0, 0),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Image = "rbxassetid://132128200461292",
        ImageTransparency = 1,
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, -4, 1, -4),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })
    
    Items["SubElements"] = Data.Instances:Create("Frame", {
        Parent = Items["Toggle"].Instance,
        Name = "\0",
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        AnchorPoint = Vector2.new(1, 0),
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -25, 0, 0),
        Size = UDim2.new(0, 0, 1, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })
    
    Data.Instances:Create("UIListLayout", {
        Parent = Items["SubElements"].Instance,
        Name = "\0",
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder
    })                

    function Toggle:Get()
        return Toggle.Value 
    end

    function Toggle:Set(Value)
        Toggle.Value = Value 
        Data.Library.Flags[Toggle.Flag] = Value 

        if Toggle.Value then 
            Items["Inline"]:Tween(nil, {BackgroundTransparency = 0})
            Items["CheckImage"]:Tween(nil, {ImageTransparency = 0})
            Items["Text"]:Tween(nil, {TextColor3 = Color3.fromRGB(255, 255, 255)})
        else
            Items["Inline"]:Tween(nil, {BackgroundTransparency = 1})
            Items["CheckImage"]:Tween(nil, {ImageTransparency = 1})
            Items["Text"]:Tween(nil, {TextColor3 = Color3.fromRGB(100, 100, 100)})
        end

        if Toggle.Callback then 
            Data.Library:SafeCall(Toggle.Callback, Toggle.Value)
        end
    end

    function Toggle:SetVisibility(Bool)
        Items["Toggle"].Instance.Visible = Bool 
    end

    function Toggle:Colorpicker(Callback)
        -- Placeholder untuk colorpicker
        print("Colorpicker not implemented in this version")
    end

    function Toggle:Keybind(Callback)
        -- Placeholder untuk keybind
        print("Keybind not implemented in this version")
    end

    Items["Toggle"]:Connect("MouseButton1Down", function()
        Toggle:Set(not Toggle.Value)
    end)

    Toggle:Set(Toggle.Default)

    Data.Library.SetFlags[Toggle.Flag] = function(Value)
        Toggle:Set(Value)
    end

    return Toggle 
end

-- ===============================
-- 10. BUTTON
-- ===============================
function Elements.CreateButton(Data)
    local Button = {
        Window = Data.Window,
        Page = Data.Page,
        Section = Data.Section,
        Name = Data.Name,
        Callback = Data.Callback or function() end
    }

    local Items = { }
    
    Items["Button"] = Data.Instances:Create("TextButton", {
        Parent = Data.Parent.Instance,
        Name = "\0",
        FontFace = Data.Library.Font,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Text = Button.Name,
        AutoButtonColor = false,
        Size = UDim2.new(1, 0, 0, 25),
        BorderSizePixel = 0,
        TextSize = 14,
        BackgroundColor3 = Color3.fromRGB(30, 34, 34)
    })  
    Items["Button"]:AddToTheme({BackgroundColor3 = "Element"})
    
    Data.Instances:Create("UICorner", {
        Parent = Items["Button"].Instance,
        Name = "\0",
        CornerRadius = UDim.new(0, 4)
    })
    
    Data.Instances:Create("UIStroke", {
        Parent = Items["Button"].Instance,
        Name = "\0",
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Color = Color3.fromRGB(56, 62, 62),
        Thickness = 2
    }):AddToTheme({Color = "Border 2"})
    
    Data.Instances:Create("UIPadding", {
        Parent = Items["Button"].Instance,
        Name = "\0",
        PaddingBottom = UDim.new(0, 1)
    })                

    function Button:SetVisibility(Bool)
        Items["Button"].Instance.Visible = Bool
    end

    function Button:Press()
        Items["Button"]:ChangeItemTheme({BackgroundColor3 = "Accent"})
        Items["Button"]:Tween(nil, {BackgroundColor3 = Data.Library.Theme.Accent, TextColor3 = Color3.fromRGB(0, 0, 0)})

        task.wait(0.1)

        Items["Button"]:ChangeItemTheme({BackgroundColor3 = "Element"})
        Items["Button"]:Tween(nil, {BackgroundColor3 = Data.Library.Theme.Element, TextColor3 = Color3.fromRGB(255, 255, 255)})

        Data.Library:SafeCall(Button.Callback)
    end

    Items["Button"]:Connect("MouseButton1Down", function()
        Button:Press()
    end)

    return Button
end

-- ===============================
-- 11. SLIDER
-- ===============================
function Elements.CreateSlider(Data)
    local Slider = {
        Window = Data.Window,
        Page = Data.Page,
        Section = Data.Section,
        Name = Data.Name or "Slider",
        Min = Data.Min or 0,
        Max = Data.Max or 100,
        Callback = Data.Callback or function() end,
        Default = Data.Default or 0,
        Flag = Data.Flag or Data.Library:NextFlag(),
        Decimals = Data.Decimals or 1,
        Suffix = Data.Suffix or "",
        Value = 0,
        Sliding = false
    }

    local Items = { }
    
    Items["Slider"] = Data.Instances:Create("Frame", {
        Parent = Data.Parent.Instance,
        Name = "\0",
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(1, 0, 0, 30),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })
    
    Items["Text"] = Data.Instances:Create("TextLabel", {
        Parent = Items["Slider"].Instance,
        Name = "\0",
        FontFace = Data.Library.Font,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Text = Slider.Name,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 0, 0, 15),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 14,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })
    
    Items["Value"] = Data.Instances:Create("TextLabel", {
        Parent = Items["Slider"].Instance,
        Name = "\0",
        FontFace = Data.Library.Font,
        TextColor3 = Color3.fromRGB(100, 100, 100),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Text = "",
        AnchorPoint = Vector2.new(1, 0),
        Size = UDim2.new(0, 0, 0, 15),
        BackgroundTransparency = 1,
        Position = UDim2.new(1, 0, 0, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 14,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })
    
    Items["RealSlider"] = Data.Instances:Create("TextButton", {
        Parent = Items["Slider"].Instance,
        Text = "",
        AutoButtonColor = false,
        Name = "\0",
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.new(0, 0, 1, 0),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(1, 0, 0, 5),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(30, 34, 34)
    })  
    Items["RealSlider"]:AddToTheme({BackgroundColor3 = "Element"})
    
    Data.Instances:Create("UICorner", {
        Parent = Items["RealSlider"].Instance,
        Name = "\0",
        CornerRadius = UDim.new(1, 0)
    })
    
    Items["Accent"] = Data.Instances:Create("Frame", {
        Parent = Items["RealSlider"].Instance,
        Name = "\0",
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(0.4000000059604645, 0, 1, 0),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })  
    Items["Accent"]:AddToTheme({BackgroundColor3 = "Accent"})
    
    Data.Instances:Create("UICorner", {
        Parent = Items["Accent"].Instance,
        Name = "\0",
        CornerRadius = UDim.new(0, 7)
    })
    
    Items["Circle"] = Data.Instances:Create("Frame", {
        Parent = Items["Accent"].Instance,
        Name = "\0",
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, 5, 0.5, 0),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(0, 8, 0, 8),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })  
    Items["Circle"]:AddToTheme({BackgroundColor3 = "Accent"})
    
    Data.Instances:Create("UICorner", {
        Parent = Items["Circle"].Instance,
        Name = "\0",
        CornerRadius = UDim.new(0, 7)
    })
    
    Data.Instances:Create("UIGradient", {
        Parent = Items["Accent"].Instance,
        Name = "\0",
        Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 180, 180)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
        }
    })                

    function Slider:Get()
        return Slider.Value
    end

    function Slider:SetVisibility(Bool)
        Items["Slider"].Instance.Visible = Bool
    end

    function Slider:Set(Value)
        Slider.Value = Data.Library:Round(math.clamp(Value, Slider.Min, Slider.Max), Slider.Decimals)
        Data.Library.Flags[Slider.Flag] = Slider.Value

        Items["Accent"]:Tween(TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new((Slider.Value - Slider.Min) / (Slider.Max - Slider.Min), -2, 1, 0)})
        Items["Value"].Instance.Text = string.format("%s%s", Slider.Value, Slider.Suffix)

        if Slider.Callback then
            Data.Library:SafeCall(Slider.Callback, Slider.Value)
        end
    end

    local InputChanged
    local InputChanged2

    Items["RealSlider"]:Connect("InputBegan", function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            Slider.Sliding = true

            local SizeX = (Input.Position.X - Items["RealSlider"].Instance.AbsolutePosition.X) / Items["RealSlider"].Instance.AbsoluteSize.X
            local Value = ((Slider.Max - Slider.Min) * SizeX) + Slider.Min

            Slider:Set(Value)

            if InputChanged then
                return 
            end

            InputChanged = Input.Changed:Connect(function()
                if Input.UserInputState == Enum.UserInputState.End then
                    Slider.Sliding = false
                    InputChanged:Disconnect()
                    InputChanged = nil
                end
            end)
        end
    end)

    Items["Circle"]:Connect("InputBegan", function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            Slider.Sliding = true

            local SizeX = (Input.Position.X - Items["RealSlider"].Instance.AbsolutePosition.X) / Items["RealSlider"].Instance.AbsoluteSize.X
            local Value = ((Slider.Max - Slider.Min) * SizeX) + Slider.Min

            Slider:Set(Value)

            if InputChanged2 or InputChanged then
                return 
            end

            InputChanged2 = Input.Changed:Connect(function()
                if Input.UserInputState == Enum.UserInputState.End then
                    Slider.Sliding = false
                    InputChanged2:Disconnect()
                    InputChanged2 = nil
                end
            end)
        end
    end)

    Data.Library:Connect(Data.UserInputService.InputChanged, function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
            if Slider.Sliding then
                local SizeX = (Input.Position.X - Items["RealSlider"].Instance.AbsolutePosition.X) / Items["RealSlider"].Instance.AbsoluteSize.X
                local Value = ((Slider.Max - Slider.Min) * SizeX) + Slider.Min
                Slider:Set(Value)
            end
        end
    end)

    Slider:Set(Slider.Default) 

    Data.Library.SetFlags[Slider.Flag] = function(Value)
        Slider:Set(Value)
    end

    return Slider 
end

-- ===============================
-- 12. DROPDOWN
-- ===============================
function Elements.CreateDropdown(Data)
    local Dropdown = {
        Window = Data.Window,
        Page = Data.Page,
        Section = Data.Section,
        Name = Data.Name or "Dropdown",
        Flag = Data.Flag or Data.Library:NextFlag(),
        Items = Data.Items or { },
        Default = Data.Default or "",
        Callback = Data.Callback or function() end,
        Multi = Data.Multi or false,
        Value = { },
        Options = { },
        IsOpen = false
    }

    local Items = { }
    
    Items["Dropdown"] = Data.Instances:Create("Frame", {
        Parent = Data.Parent.Instance,
        Name = "\0",
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(1, 0, 0, 25),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })
    
    Items["Text"] = Data.Instances:Create("TextLabel", {
        Parent = Items["Dropdown"].Instance,
        Name = "\0",
        FontFace = Data.Library.Font,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Text = Dropdown.Name,
        AnchorPoint = Vector2.new(0, 0.5),
        Size = UDim2.new(0, 0, 0, 15),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0.5, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 14,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })
    
    Items["RealDropdown"] = Data.Instances:Create("TextButton", {
        Parent = Items["Dropdown"].Instance,
        Name = "\0",
        FontFace = Data.Library.Font,
        TextColor3 = Color3.fromRGB(0, 0, 0),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Text = "",
        AutoButtonColor = false,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, 0, 0.5, 0),
        Size = UDim2.new(0, 80, 0, 25),
        BorderSizePixel = 0,
        TextSize = 14,
        BackgroundColor3 = Color3.fromRGB(30, 34, 34)
    })  
    Items["RealDropdown"]:AddToTheme({BackgroundColor3 = "Element"})
    
    Data.Instances:Create("UICorner", {
        Parent = Items["RealDropdown"].Instance,
        Name = "\0",
        CornerRadius = UDim.new(0, 4)
    })
    
    Items["Value"] = Data.Instances:Create("TextLabel", {
        Parent = Items["RealDropdown"].Instance,
        Name = "\0",
        FontFace = Data.Library.Font,
        TextColor3 = Color3.fromRGB(100, 100, 100),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Text = "...",
        AnchorPoint = Vector2.new(0, 0.5),
        Size = UDim2.new(1, -6, 0, 15),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 6, 0.5, 0),
        BorderSizePixel = 0,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })
    
    Items["Icon"] = Data.Instances:Create("ImageLabel", {
        Parent = Items["RealDropdown"].Instance,
        Name = "\0",
        ImageColor3 = Color3.fromRGB(100, 100, 100),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        Image = "rbxassetid://135448248851234",
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -5, 0.5, 0),
        Size = UDim2.new(0, 16, 0, 16),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })
    
    Items["OptionHolder"] = Data.Instances:Create("Frame", {
        Parent = Data.Library.UnusedHolder.Instance,
        Name = "\0",
        Visible = false,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        AnchorPoint = Vector2.new(0, 0),
        Position = UDim2.new(1, 0, 0.5, 0),
        Size = UDim2.new(0, 80, 0, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = Color3.fromRGB(21, 24, 24)
    })  
    Items["OptionHolder"]:AddToTheme({BackgroundColor3 = "Inline"})
    
    Data.Instances:Create("UIStroke", {
        Parent = Items["OptionHolder"].Instance,
        Name = "\0",
        Color = Color3.fromRGB(30, 33, 33),
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    }):AddToTheme({Color = "Border"})
    
    Items["Holder"] = Data.Instances:Create("ScrollingFrame", {
        Parent = Items["OptionHolder"].Instance,
        Name = "\0",
        Active = true,
        AutomaticCanvasSize = Enum.AutomaticSize.XY,
        ScrollBarThickness = 2,
        Size = UDim2.new(1, 0, 1, 0),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        AutomaticSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.new(0, 0, 0, 0)
    })  
    Items["Holder"]:AddToTheme({ScrollBarImageColor3 = "Accent"})
    
    Data.Instances:Create("UIListLayout", {
        Parent = Items["Holder"].Instance,
        Name = "\0",
        SortOrder = Enum.SortOrder.LayoutOrder
    })                

    Data.Instances:Create("UIPadding", {
        Parent = Items["OptionHolder"].Instance,
        Name = "\0",
        PaddingBottom = UDim.new(0, 4)
    })                

    function Dropdown:Get()
        return Dropdown.Value
    end

    function Dropdown:SetVisibility(Bool)
        Items["Dropdown"].Instance.Visible = Bool
    end

    local Debounce = false
    local RenderStepped

    function Dropdown:SetOpen(Bool)
        if Debounce then 
            return
        end

        Dropdown.IsOpen = Bool
        Debounce = true 

        if Dropdown.IsOpen then 
            Items["OptionHolder"].Instance.Visible = true
            Items["OptionHolder"].Instance.Parent = Data.Library.Holder.Instance
            
            RenderStepped = Data.RunService.RenderStepped:Connect(function()
                Items["OptionHolder"].Instance.Position = UDim2.new(0, Items["RealDropdown"].Instance.AbsolutePosition.X, 0, Items["RealDropdown"].Instance.AbsolutePosition.Y - 25)
                Items["OptionHolder"].Instance.Size = UDim2.new(0, Items["RealDropdown"].Instance.AbsoluteSize.X, 0, 0)
            end)

            for Index, Value in Data.Library.OpenFrames do 
                if Value ~= Dropdown and not Dropdown.Section.IsSettings then 
                    Value:SetOpen(false)
                end
            end

            Data.Library.OpenFrames[Dropdown] = Dropdown 
        else
            if Data.Library.OpenFrames[Dropdown] then 
                Data.Library.OpenFrames[Dropdown] = nil
            end

            if RenderStepped then 
                RenderStepped:Disconnect()
                RenderStepped = nil
            end
        end

        local Descendants = Items["OptionHolder"].Instance:GetDescendants()
        TableInsert(Descendants, Items["OptionHolder"].Instance)

        local NewTween

        for Index, Value in Descendants do 
            local TransparencyProperty = Data.Tween:GetProperty(Value)

            if not TransparencyProperty then
                continue 
            end

            if not Value.ClassName:find("UI") then 
                Value.ZIndex = Dropdown.IsOpen and 3 or 1
            end

            if type(TransparencyProperty) == "table" then 
                for _, Property in TransparencyProperty do 
                    NewTween = Data.Tween:FadeItem(Value, Property, Bool, Data.Library.FadeSpeed)
                end
            else
                NewTween = Data.Tween:FadeItem(Value, TransparencyProperty, Bool, Data.Library.FadeSpeed)
            end
        end
        
        NewTween.Tween.Completed:Connect(function()
            Debounce = false 
            Items["OptionHolder"].Instance.Visible = Dropdown.IsOpen
            task.wait(0.2)
            Items["OptionHolder"].Instance.Parent = not Dropdown.IsOpen and Data.Library.UnusedHolder.Instance or Data.Library.Holder.Instance
        end)
    end

    function Dropdown:Set(Option)
        if Dropdown.Multi then 
            if type(Option) ~= "table" then 
                return
            end

            Dropdown.Value = Option
            Data.Library.Flags[Dropdown.Flag] = Option

            for Index, Value in Option do
                local OptionData = Dropdown.Options[Value]
                 
                if not OptionData then
                    continue
                end

                OptionData.Selected = true 
                OptionData:Toggle("Active")
            end

            Items["Value"].Instance.Text = TableConcat(Option, ", ")
        else
            if not Dropdown.Options[Option] then
                return
            end

            local OptionData = Dropdown.Options[Option]

            Dropdown.Value = Option
            Data.Library.Flags[Dropdown.Flag] = Option

            for Index, Value in Dropdown.Options do
                if Value ~= OptionData then
                    Value.Selected = false 
                    Value:Toggle("Inactive")
                else
                    Value.Selected = true 
                    Value:Toggle("Active")
                end
            end

            Items["Value"].Instance.Text = Option
        end

        if Dropdown.Callback then   
            Data.Library:SafeCall(Dropdown.Callback, Dropdown.Value)
        end
    end

    function Dropdown:Add(Option)
        local OptionButton = Data.Instances:Create("TextButton", {
            Parent = Items["Holder"].Instance,
            Name = "\0",
            FontFace = Data.Library.Font,
            TextColor3 = Color3.fromRGB(100, 100, 100),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Text = Option,
            AutoButtonColor = false,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 25),
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.X,
            TextSize = 14,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        })  
        OptionButton:AddToTheme({BackgroundColor3 = "Accent"})

        local OptionData = {
            Button = OptionButton,
            Name = Option,
            Selected = false
        }
        
        function OptionData:Toggle(Value)
            if Value == "Active" then
                OptionData.Button:Tween(nil, {BackgroundTransparency = 0, TextColor3 = Color3.fromRGB(0, 0, 0)})
            else
                OptionData.Button:Tween(nil, {BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(100, 100, 100)})
            end
        end

        function OptionData:Set()
            OptionData.Selected = not OptionData.Selected

            if Dropdown.Multi then 
                local Index = TableFind(Dropdown.Value, OptionData.Name)

                if Index then 
                    TableRemove(Dropdown.Value, Index)
                else
                    TableInsert(Dropdown.Value, OptionData.Name)
                end

                OptionData:Toggle(Index and "Inactive" or "Active")

                Data.Library.Flags[Dropdown.Flag] = Dropdown.Value

                local TextFormat = #Dropdown.Value > 0 and TableConcat(Dropdown.Value, ", ") or "..."
                Items["Value"].Instance.Text = TextFormat
            else
                if OptionData.Selected then 
                    Dropdown.Value = OptionData.Name
                    Data.Library.Flags[Dropdown.Flag] = OptionData.Name

                    OptionData.Selected = true
                    OptionData:Toggle("Active")

                    for Index, Value in Dropdown.Options do 
                        if Value ~= OptionData then
                            Value.Selected = false 
                            Value:Toggle("Inactive")
                        end
                    end

                    Items["Value"].Instance.Text = OptionData.Name
                else
                    Dropdown.Value = nil
                    Data.Library.Flags[Dropdown.Flag] = nil

                    OptionData.Selected = false
                    OptionData:Toggle("Inactive")

                    Items["Value"].Instance.Text = "..."
                end
            end

            if Dropdown.Callback then
                Data.Library:SafeCall(Dropdown.Callback, Dropdown.Value)
            end
        end

        OptionData.Button:Connect("MouseButton1Down", function()
            OptionData:Set()
        end)

        Dropdown.Options[OptionData.Name] = OptionData
        return OptionData
    end

    function Dropdown:Remove(Option)
        if Dropdown.Options[Option] then
            Dropdown.Options[Option].Button:Clean()
            Dropdown.Options[Option] = nil
        end
    end

    function Dropdown:Refresh(List)
        for Index, Value in Dropdown.Options do 
            Dropdown:Remove(Value.Name)
        end

        for Index, Value in List do 
            Dropdown:Add(Value)
        end
    end

    Items["RealDropdown"]:Connect("MouseButton1Down", function()
        Dropdown:SetOpen(not Dropdown.IsOpen)
    end)

    Data.Library:Connect(Data.UserInputService.InputBegan, function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            if Dropdown.IsOpen then
                if Data.Library:IsMouseOverFrame(Items["OptionHolder"]) then
                    return
                end
                Dropdown:SetOpen(false)
            end
        end
    end)

    Items["RealDropdown"]:Connect("Changed", function(Property)
        if Property == "AbsolutePosition" and Dropdown.IsOpen then
            Dropdown.IsOpen = not Data.Library:IsClipped(Items["OptionHolder"].Instance, Dropdown.Section.Items["Section"].Instance.Parent)
            Items["OptionHolder"].Instance.Visible = Dropdown.IsOpen
        end
    end)

    for Index, Value in Dropdown.Items do 
        Dropdown:Add(Value)
    end

    if Dropdown.Default then 
        Dropdown:Set(Dropdown.Default)
    end

    Data.Library.SetFlags[Dropdown.Flag] = function(Value)
        Dropdown:Set(Value)
    end

    return Dropdown
end

-- ===============================
-- 13. LABEL
-- ===============================
function Elements.CreateLabel(Name, Section, Library, Instances)
    local Label = {
        Window = Section.Window,
        Page = Section.Page,
        Section = Section,
        Name = Name or "Label"
    }

    local Items = { }
    
    Items["Label"] = Instances:Create("Frame", {
        Parent = Section.Items["Content"].Instance,
        Name = "\0",
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(1, 0, 0, 17),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })
    
    Items["Text"] = Instances:Create("TextLabel", {
        Parent = Items["Label"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Color3.fromRGB(100, 100, 100),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Text = Label.Name,
        AnchorPoint = Vector2.new(0, 0.5),
        Size = UDim2.new(0, 0, 0, 15),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0.5, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 14,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })
    
    Items["SubElements"] = Instances:Create("Frame", {
        Parent = Items["Label"].Instance,
        Name = "\0",
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        AnchorPoint = Vector2.new(1, 0),
        BackgroundTransparency = 1,
        Position = UDim2.new(1, 0, 0, 0),
        Size = UDim2.new(0, 0, 1, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })
    
    Instances:Create("UIListLayout", {
        Parent = Items["SubElements"].Instance,
        Name = "\0",
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder
    })      

    function Label:SetText(Text)
       Text = tostring(Text)
       Items["Text"].Instance.Text = Text 
    end

    function Label:SetVisibility(Bool)
        Items["Label"].Instance.Visible = Bool
    end

    function Label:Colorpicker(Data)
        Data = Data or { }
        Data.Parent = Items["SubElements"]
        Data.Section = Label.Section
        
        local NewColorpicker = Library:CreateColorpicker(Data)
        return NewColorpicker
    end

    function Label:Keybind(Data)
        Data = Data or { }
        Data.Parent = Items["SubElements"]
        Data.Section = Label.Section
        
        local NewKeybind = Library:CreateKeybind(Data)
        return NewKeybind
    end
 
    return Label
end

-- ===============================
-- 14. TEXTBOX
-- ===============================
function Elements.CreateTextbox(Data)
    local Textbox = {
        Window = Data.Window,
        Page = Data.Page,
        Section = Data.Section,
        Flag = Data.Flag or Data.Library:NextFlag(),
        Default = Data.Default or "",
        Callback = Data.Callback or function() end,
        Placeholder = Data.Placeholder or "Placeholder",
        Numeric = Data.Numeric or false,
        Finished = Data.Finished or false,
        Value = ""
    }

    local Items = { }
    
    Items["Textbox"] = Data.Instances:Create("Frame", {
        Parent = Data.Parent.Instance,
        Name = "\0",
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(1, 0, 0, 25),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })
    
    Items["Input"] = Data.Instances:Create("TextBox", {
        Parent = Items["Textbox"].Instance,
        Name = "\0",
        FontFace = Data.Library.Font,
        CursorPosition = -1,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Text = "",
        Size = UDim2.new(1, 0, 1, 0),
        ClipsDescendants = true,
        BorderSizePixel = 0,
        PlaceholderColor3 = Color3.fromRGB(100, 100, 100),
        TextXAlignment = Enum.TextXAlignment.Left,
        PlaceholderText = Textbox.Placeholder,
        TextSize = 14,
        BackgroundColor3 = Color3.fromRGB(30, 34, 34)
    })  
    Items["Input"]:AddToTheme({BackgroundColor3 = "Element"})
    
    Data.Instances:Create("UICorner", {
        Parent = Items["Input"].Instance,
        Name = "\0",
        CornerRadius = UDim.new(0, 4)
    })
    
    Data.Instances:Create("UIStroke", {
        Parent = Items["Input"].Instance,
        Name = "\0",
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Color = Color3.fromRGB(56, 62, 62),
        Thickness = 2
    }):AddToTheme({Color = "Border 2"})
    
    Data.Instances:Create("UIPadding", {
        Parent = Items["Input"].Instance,
        Name = "\0",
        PaddingLeft = UDim.new(0, 8)
    })                 

    function Textbox:Get()
        return Textbox.Value
    end

    function Textbox:SetVisibility(Bool)
        Items["Textbox"].Instance.Visible = Bool
    end

    function Textbox:Set(Value)
        if Textbox.Numeric then
            if (not tonumber(Value)) and StringLen(tostring(Value)) > 0 then
                Value = Textbox.Value
            end
        end

        Textbox.Value = Value
        Items["Input"].Instance.Text = Value
        Data.Library.Flags[Textbox.Flag] = Value

        if Textbox.Callback then
            Data.Library:SafeCall(Textbox.Callback, Value)
        end
    end

    if Textbox.Finished then 
        Items["Input"]:Connect("FocusLost", function(PressedEnter)
            if PressedEnter then
                Textbox:Set(Items["Input"].Instance.Text)
            end
        end)
    else
        Items["Input"].Instance:GetPropertyChangedSignal("Text"):Connect(function()
            Textbox:Set(Items["Input"].Instance.Text)
        end)
    end

    if Textbox.Default then
        Textbox:Set(Textbox.Default)
    end

    Data.Library.SetFlags[Textbox.Flag] = function(Value)
        Textbox:Set(Value)
    end

    return Textbox 
end

-- ===============================
-- 15. SETTINGS PAGE
-- ===============================
function Elements.CreateSettingsPage(Window, Library)
    local SettingsPage = Window:Page({Name = "Settings", Icon = "72732892493295"})
    
    local ConfigsSubPage = SettingsPage:SubPage({Name = "Configs"})
    local ThemingSubPage = SettingsPage:SubPage({Name = "Theming"})
    local SettingsSubPage = SettingsPage:SubPage({Name = "Settings"})

    -- Configs
    local ConfigsSection = ConfigsSubPage:Section({Name = "Configs", Side = 1, Icon = "97491613646216"})

    local ConfigName = ""
    local ConfigSelected

    local ConfigsList = ConfigsSection:Dropdown({
        Name = "Configs", 
        Flag = "ConfigsList", 
        Items = { }, 
        Multi = false,
        Callback = function(Value)
            ConfigSelected = Value
        end
    })

    ConfigsSection:Textbox({ 
        Default = "", 
        Flag = "ConfigName", 
        Placeholder = "Config name", 
        Callback = function(Value)
            ConfigName = Value
        end
    })

    ConfigsSection:Button({
        Name = "Create",
        Callback = function()
            if ConfigName and ConfigName ~= "" then
                if not isfile(Library.Folders.Configs .. "/" .. ConfigName .. ".json") then
                    writefile(Library.Folders.Configs .. "/" .. ConfigName .. ".json", Library:GetConfig())
                    Library:RefreshConfigsList(ConfigsList)
                end
            end
        end
    })

    ConfigsSection:Button({
        Name = "Delete", 
        Callback = function()
            if ConfigSelected then
                Library:DeleteConfig(ConfigSelected)
                Library:RefreshConfigsList(ConfigsList)
            end
        end
    })

    ConfigsSection:Button({
        Name = "Load", 
        Callback = function()
            if ConfigSelected then
                Library:LoadConfig(readfile(Library.Folders.Configs .. "/" .. ConfigSelected))
            end
        end
    })

    ConfigsSection:Button({
        Name = "Save", 
        Callback = function()
            if ConfigName and ConfigName ~= "" then
                writefile(Library.Folders.Configs .. "/" .. ConfigName .. ".json", Library:GetConfig())
                Library:RefreshConfigsList(ConfigsList)
            end
        end
    })

    ConfigsSection:Button({
        Name = "Refresh", 
        Callback = function()
            Library:RefreshConfigsList(ConfigsList)
        end
    })

    Library:RefreshConfigsList(ConfigsList)               

    -- Theming
    local ThemingSection = ThemingSubPage:Section({Name = "Theming", Icon = "131595494666590", Side = 1})
    for Index, Value in Library.Theme do 
        ThemingSection:Label(Index):Colorpicker({
            Flag = Index.."Theme",
            Default = Value,
            Callback = function(Value)
                Library.Theme[Index] = Value
                Library:ChangeTheme(Index, Value)
            end
        })
    end

    -- Settings
    local SettingsSection = SettingsSubPage:Section({Name = "Settings", Icon = "72732892493295", Side = 1})     
    
    SettingsSection:Button({
        Name = "Unload",
        Callback = function()
            Library:Unload()
        end
    })
    
    SettingsSection:Label("Menu Keybind"):Keybind({
        Name = "Menu Keybind",
        Flag = "MenuKeybind",
        Default = Library.MenuKeybind,
        Mode = "Toggle",
        Callback = function()
            Library.MenuKeybind = Library.Flags["MenuKeybind"].Key
        end
    })

    SettingsSection:Slider({
        Name = "Tween Speed",
        Default = 0.3,
        Flag = "Tween Speed",
        Decimals = 0.01,
        Suffix = "s",
        Max = 10,
        Min = 0,
        Callback = function(Value)
            Library.Tween.Time = Value
        end
    })

    SettingsSection:Dropdown({
        Name = "Tween Style",
        Flag = "Tween style",
        Items = { "Linear", "Quad", "Quart", "Back", "Bounce", "Circular", "Cubic", "Elastic", "Exponential", "Sine", "Quint" },
        Default = "Quart",
        Callback = function(Value)
            if not Value then Value = "Quint" end
            Library.Tween.Style = Enum.EasingStyle[Value]
        end
    })

    SettingsSection:Dropdown({
        Name = "Tween Direction",
        Flag = "Tween direction",
        Items = { "In", "Out", "InOut" },
        Default = "Out",
        Callback = function(Value)
            if not Value then Value = "Out" end
            Library.Tween.Direction = Enum.EasingDirection[Value]
        end
    })

    return SettingsPage
end

return Elements
