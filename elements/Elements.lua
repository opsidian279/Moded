-- Elements.lua
-- Berisi semua definisi elemen UI yang dipisahkan dari main.lua

return function(Library, Instances, Tween)
    -- ==================== Helper Functions ====================
    local function createAccentGradient(parent, customCallback)
        local accent = Instances:Create("Frame", {
            Parent = parent,
            Name = "\0",
            Size = UDim2New(0, 0, 0, 0),
            BorderColor3 = FromRGB(0, 0, 0),
            ZIndex = 2,
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            BackgroundColor3 = FromRGB(255, 255, 255),
            AnchorPoint = Vector2New(0.5, 0.5),
            Position = UDim2New(0.5, 0, 0.5, 0)
        })
        
        Instances:Create("UIGradient", {
            Parent = accent.Instance,
            Name = "\0",
            Enabled = true,
            Rotation = -115,
            Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(143, 143, 143))}
        }):AddToTheme({Color = function()
            return RGBSequence{RGBSequenceKeypoint(0, Library.Theme.Accent), RGBSequenceKeypoint(1, Library.Theme.AccentGradient)}
        end})
        
        Instances:Create("UICorner", {
            Parent = accent.Instance,
            Name = "\0",
            CornerRadius = UDimNew(0, 4)
        })
        
        return accent
    end

    -- ==================== Toggle ====================
    Library.Sections.Toggle = function(self, Data)
        Data = Data or { }
        
        local Toggle = {
            Window = self.Window,
            Page = self.Page,
            Section = self,

            Name = Data.Name or Data.name or "Toggle",
            Flag = Data.Flag or Data.flag or Library:NextFlag(),
            Default = Data.Default or Data.default or false,
            Callback = Data.Callback or Data.callback or function() end,

            Value = false
        }

        local Items = { } do 
            Items["Toggle"] = Instances:Create("TextButton", {
                Parent = Toggle.Section.Items["Content"].Instance,
                Name = "\0",
                FontFace = Library.Font,
                TextColor3 = FromRGB(0, 0, 0),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = "",
                AutoButtonColor = false,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2New(1, 0, 0, 18),
                ZIndex = 2,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })
            
            Items["Indicator"] = Instances:Create("Frame", {
                Parent = Items["Toggle"].Instance,
                Name = "\0",
                Size = UDim2New(0, 18, 0, 18),
                BorderColor3 = FromRGB(0, 0, 0),
                ZIndex = 2,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(124, 163, 255)
            })  Items["Indicator"]:AddToTheme({BackgroundColor3 = "Element"})
            
            Instances:Create("UICorner", {
                Parent = Items["Indicator"].Instance,
                Name = "\0",
                CornerRadius = UDimNew(0, 3)
            })
            
            Items["Accent"] = createAccentGradient(Items["Indicator"].Instance)
            
            Items["CheckImage"] = Instances:Create("ImageLabel", {
                Parent = Items["Accent"].Instance,
                Name = "\0",
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(0, 0, 0, 0),
                AnchorPoint = Vector2New(0.5, 0.5),
                Image = "rbxassetid://121760666525660",
                BackgroundTransparency = 1,
                Position = UDim2New(0.5, 0, 0.5, 0),
                ZIndex = 2,
                BorderSizePixel = 0,
                ImageTransparency = 1,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["CheckImage"]:AddToTheme({ImageColor3 = "Text"})
            
            Items["Text"] = Instances:Create("TextLabel", {
                Parent = Items["Toggle"].Instance,
                Name = "\0",
                FontFace = Library.Font,
                TextColor3 = FromRGB(240, 240, 240),
                TextTransparency = 0.30000001192092896,
                Text = Toggle.Name,
                AutomaticSize = Enum.AutomaticSize.X,
                Size = UDim2New(0, 0, 0, 15),
                Position = UDim2New(0, 24, 0, 0),
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                BorderColor3 = FromRGB(0, 0, 0),
                ZIndex = 2,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Text"]:AddToTheme({TextColor3 = "Text"})

            Items["Toggle"]:OnHover(function()
                Items["Indicator"]:Tween(TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2New(0, 21, 0, 21), Position = UDim2New(0, -3, 0, -3)})
            end)

            Items["Toggle"]:OnHoverLeave(function()
                Items["Indicator"]:Tween(TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2New(0, 18, 0, 18), Position = UDim2New(0, 0, 0, 0)})
            end)
        end

        function Toggle:Get()
            return Toggle.Value 
        end

        function Toggle:Set(Value)
            Toggle.Value = Value 
            Library.Flags[Toggle.Flag] = Value 

            if Toggle.Value then 
                Items["Accent"]:Tween(TweenInfo.new(Library.Tween.Time + 0.1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 0, Size = UDim2New(1, 0, 1, 0)})
                Items["CheckImage"]:Tween(nil, {ImageTransparency = 0, Size = UDim2New(0, 10, 0, 9)})
            else
                Items["Accent"]:Tween(TweenInfo.new(Library.Tween.Time + 0.05, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 1, Size = UDim2New(0, 0, 0, 0)})
                Items["CheckImage"]:Tween(nil, {ImageTransparency = 1, Size = UDim2New(0, 0, 0, 0)})
            end

            if Toggle.Callback then 
                Library:SafeCall(Toggle.Callback, Toggle.Value)
            end
        end

        function Toggle:SetVisibility(Bool)
            Items["Toggle"].Instance.Visible = Bool
        end

        function Toggle:RefreshPosition(Bool)
            if Bool then 
                Items["Indicator"]:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2New(0, 0, 0, 0)})
                Items["Text"]:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2New(0, 24, 0, 0)})
            else
                Items["Indicator"].Instance.Position = UDim2New(0, 60, 0, 0)
                Items["Text"].Instance.Position = UDim2New(0, 84, 0, 0)
            end 
        end

        Items["Toggle"]:Connect("InputBegan", function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then 
                Toggle:Set(not Toggle.Value)
            end
        end)

        Toggle:Set(Toggle.Default)

        Library.SetFlags[Toggle.Flag] = function(Value)
            Toggle:Set(Value)
        end

        Toggle.Section.Elements[#Toggle.Section.Elements+1] = Toggle
        return Toggle 
    end

    -- ==================== Button ====================
    Library.Sections.Button = function(self, Data)
        Data = Data or { }

        local Button = {
            Window = self.Window,
            Page = self.Page,
            Section = self,

            Name = Data.Name or Data.name or "Button",
            Icon = Data.Icon or Data.icon or nil,
            Callback = Data.Callback or Data.callback or function() end
        }

        local Items = { } do 
            Items["Button"] = Instances:Create("TextButton", {
                Parent = Button.Section.Items["Content"].Instance,
                Name = "\0",
                FontFace = Library.Font,
                TextColor3 = FromRGB(0, 0, 0),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = "",
                AutoButtonColor = false,
                BorderSizePixel = 0,
                Size = UDim2New(1, 0, 0, 32),
                ZIndex = 2,
                TextSize = 14,
                BackgroundColor3 = FromRGB(27, 26, 29)
            })  Items["Button"]:AddToTheme({BackgroundColor3 = "Element"})

            Items["Accent"] = createAccentGradient(Items["Button"].Instance)
            
            Instances:Create("UICorner", {
                Parent = Items["Button"].Instance,
                Name = "\0",
                CornerRadius = UDimNew(0, 4)
            })
            
            Items["Text"] = Instances:Create("TextLabel", {
                Parent = Items["Button"].Instance,
                Name = "\0",
                FontFace = Library.Font,
                TextColor3 = FromRGB(240, 240, 240),
                TextTransparency = 0.30000001192092896,
                Text = Button.Name,
                AutomaticSize = Enum.AutomaticSize.X,
                Size = UDim2New(0, 0, 0, 15),
                AnchorPoint = Vector2New(0.5, 0.5),
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                Position = UDim2New(0.5, 0, 0.5, 0),
                BorderColor3 = FromRGB(0, 0, 0),
                ZIndex = 2,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Text"]:AddToTheme({TextColor3 = "Text"})          
            
            if Button.Icon then 
                Items["Icon"] = Instances:Create("ImageLabel", {
                    Parent = Items["Text"].Instance,
                    Name = "\0",
                    ImageColor3 = FromRGB(240, 240, 240),
                    ImageTransparency = 0.30000001192092896,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 18, 0, 18),
                    AnchorPoint = Vector2New(1, 0.5),
                    Image = "rbxassetid://"..Button.Icon,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, -8, 0.5, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Icon"]:AddToTheme({ImageColor3 = "Text"})
            end                    

            Items["Button"]:OnHover(function()
                Items["Accent"]:Tween(TweenInfo.new(Library.Tween.Time + 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2New(1, 0, 1, 0), BackgroundTransparency = 0})
            end)

            Items["Button"]:OnHoverLeave(function()
                Items["Accent"]:Tween(TweenInfo.new(Library.Tween.Time + 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2New(0, 0, 0, 0), BackgroundTransparency = 1})
            end)
        end 

        function Button:SetVisibility(Bool)
            Items["Button"].Instance.Visible = Bool
        end

        function Button:Press()
            Items["Button"]:ChangeItemTheme({BackgroundColor3 = "Accent"})
            Items["Button"]:Tween(nil, {BackgroundColor3 = Library.Theme.Accent})

            Items["Text"]:Tween(nil, {TextColor3 = FromRGB(0, 0, 0), TextTransparency = 0})

            if Button.Icon then 
                Items["Icon"]:Tween(nil, {ImageColor3 = FromRGB(0, 0, 0), ImageTransparency = 0})
            end

            task.wait(0.2)

            Library:SafeCall(Button.Callback)
            Items["Button"]:ChangeItemTheme({BackgroundColor3 = "Element"})
            Items["Button"]:Tween(nil, {BackgroundColor3 = Library.Theme.Element})

            Items["Text"]:Tween(nil, {TextColor3 = Library.Theme.Text, TextTransparency = 0.3})

            if Button.Icon then 
                Items["Icon"]:Tween(nil, {ImageColor3 = Library.Theme.Text, ImageTransparency = 0.3})
            end
        end

        Items["Button"]:Connect("MouseButton1Down", function()
            Button:Press()
        end)

        Button.Section.Elements[#Button.Section.Elements+1] = Button
        return Button
    end

    -- ==================== Slider ====================
    Library.Sections.Slider = function(self, Data)
        Data = Data or { }

        local Slider = {
            Window = self.Window,
            Page = self.Page,
            Section = self,

            Name = Data.Name or Data.name or "Slider",
            Flag = Data.Flag or Data.flag or Library:NextFlag(),
            Min = Data.Min or Data.min or 0,
            Default = Data.Default or Data.default or 0,
            Max = Data.Max or Data.max or 100,
            Suffix = Data.Suffix or Data.suffix or "",
            Decimals = Data.Decimals or Data.decimals or 1,
            Callback = Data.Callback or Data.callback or function() end,

            Value = 0,
            Sliding = false
        }

        local Items = { } do 
            Items["Slider"] = Instances:Create("Frame", {
                Parent = Slider.Section.Items["Content"].Instance,
                Name = "\0",
                BackgroundTransparency = 1,
                Size = UDim2New(1, 0, 0, 35),
                BorderColor3 = FromRGB(0, 0, 0),
                ZIndex = 2,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })
 
            Items["Text"] = Instances:Create("TextLabel", {
                Parent = Items["Slider"].Instance,
                Name = "\0",
                FontFace = Library.Font,
                TextColor3 = FromRGB(240, 240, 240),
                TextTransparency = 0.30000001192092896,
                Text = Slider.Name,
                AutomaticSize = Enum.AutomaticSize.X,
                Size = UDim2New(0, 0, 0, 15),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                BorderColor3 = FromRGB(0, 0, 0),
                ZIndex = 2,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Text"]:AddToTheme({TextColor3 = "Text"})

            Items["RealSlider"] = Instances:Create("TextButton", {
                Parent = Items["Slider"].Instance,
                Name = "\0",
                FontFace = Library.Font,
                TextColor3 = FromRGB(0, 0, 0),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = "",
                AutoButtonColor = false,
                AnchorPoint = Vector2New(0, 1),
                BorderSizePixel = 0,
                Position = UDim2New(0, 20, 1, -3),
                Size = UDim2New(1, -40, 0, 7),
                ZIndex = 2,
                TextSize = 14,
                BackgroundColor3 = FromRGB(27, 26, 29)
            })  Items["RealSlider"]:AddToTheme({BackgroundColor3 = "Element"})

            Instances:Create("UICorner", {
                Parent = Items["RealSlider"].Instance,
                Name = "\0"
            })

            Items["Accent"] = Instances:Create("Frame", {
                Parent = Items["RealSlider"].Instance,
                Name = "\0",
                Size = UDim2New(0.5, 0, 1, 0),
                BorderColor3 = FromRGB(0, 0, 0),
                ZIndex = 2,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })

            Instances:Create("UICorner", {
                Parent = Items["Accent"].Instance,
                Name = "\0"
            })

            Instances:Create("UIGradient", {
                Parent = Items["Accent"].Instance,
                Name = "\0",
                Rotation = -102,
                Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(166, 166, 166))}
            }):AddToTheme({Color = function()
                return RGBSequence{RGBSequenceKeypoint(0, Library.Theme.Accent), RGBSequenceKeypoint(1, Library.Theme.AccentGradient)}
            end})

            Items["Plus"] = Instances:Create("TextButton", {
                Parent = Items["RealSlider"].Instance,
                Name = "\0",
                FontFace = Library.Font,
                TextColor3 = FromRGB(240, 240, 240),
                TextTransparency = 0.30000001192092896,
                Text = "+",
                BorderColor3 = FromRGB(0, 0, 0),
                AutoButtonColor = false,
                AnchorPoint = Vector2New(0, 0.5),
                Size = UDim2New(0, 20, 0, 20),
                BackgroundTransparency = 1,
                Position = UDim2New(1, 0, 0.5, -3),
                BorderSizePixel = 0,
                ZIndex = 2,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Plus"]:AddToTheme({TextColor3 = "Text"})

            Items["Minus"] = Instances:Create("TextButton", {
                Parent = Items["RealSlider"].Instance,
                Name = "\0",
                FontFace = Library.Font,
                TextColor3 = FromRGB(240, 240, 240),
                TextTransparency = 0.30000001192092896,
                Text = "-",
                BorderColor3 = FromRGB(0, 0, 0),
                AutoButtonColor = false,
                AnchorPoint = Vector2New(1, 0.5),
                Size = UDim2New(0, 20, 0, 20),
                BackgroundTransparency = 1,
                Position = UDim2New(0, -2, 0.5, -2),
                BorderSizePixel = 0,
                ZIndex = 2,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Minus"]:AddToTheme({TextColor3 = "Text"})

            Items["Value"] = Instances:Create("TextLabel", {
                Parent = Items["Slider"].Instance,
                Name = "\0",
                FontFace = Library.Font,
                TextColor3 = FromRGB(240, 240, 240),
                TextTransparency = 0.30000001192092896,
                Text = "50%",
                AutomaticSize = Enum.AutomaticSize.X,
                Size = UDim2New(0, 0, 0, 15),
                AnchorPoint = Vector2New(1, 0),
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                Position = UDim2New(1, 0, 0, 0),
                BorderColor3 = FromRGB(0, 0, 0),
                ZIndex = 2,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Value"]:AddToTheme({TextColor3 = "Text"})
        end

        function Slider:Get()
            return Slider.Value 
        end

        function Slider:SetVisibility(Bool)
            Items["Slider"].Instance.Visible = Bool
        end

        function Slider:RefreshPosition(Bool)
            if Bool then 
                Items["RealSlider"]:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2New(0, 20, 1, -3)})
                Items["Text"]:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2New(0, 0, 0, 0)})
            else
                Items["RealSlider"].Instance.Position = UDim2New(0, 80, 1, -3)
                Items["Text"].Instance.Position = UDim2New(0, 80, 0, 0)
            end
        end

        function Slider:Set(Value)
            Slider.Value = Library:Round(MathClamp(Value, Slider.Min, Slider.Max), Slider.Decimals)
            Library.Flags[Slider.Flag] = Slider.Value

            Items["Accent"]:Tween(TweenInfo.new(Library.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2New((Slider.Value - Slider.Min) / (Slider.Max - Slider.Min), 0, 1, 0)})
            Items["Value"].Instance.Text = StringFormat("%s%s", Slider.Value, Slider.Suffix)

            if Slider.Callback then 
                Library:SafeCall(Slider.Callback, Slider.Value)
            end
        end

        Items["Plus"]:Connect("MouseButton1Down", function()
            Slider:Set(Slider.Value + Slider.Decimals)
        end)

        Items["Minus"]:Connect("MouseButton1Down", function()
            Slider:Set(Slider.Value - Slider.Decimals)
        end)

        local InputChanged 
        
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

        Library:Connect(UserInputService.InputChanged, function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                if Slider.Sliding then
                    local SizeX = (Input.Position.X - Items["RealSlider"].Instance.AbsolutePosition.X) / Items["RealSlider"].Instance.AbsoluteSize.X
                    local Value = ((Slider.Max - Slider.Min) * SizeX) + Slider.Min

                    Slider:Set(Value)
                end
            end
        end)

        if Slider.Default then
            Slider:Set(Slider.Default)
        end

        Library.SetFlags[Slider.Flag] = function(Value)
            Slider:Set(Value)
        end

        Slider.Section.Elements[#Slider.Section.Elements+1] = Slider
        return Slider 
    end

    -- ==================== Label ====================
    Library.Sections.Label = function(self, Name)
        local Label = {
            Window = self.Window,
            Page = self.Page,
            Section = self,

            Name = Name or "Label"
        }

        local Items = { } do 
            Items["Label"] = Instances:Create("Frame", {
                Parent = Label.Section.Items["Content"].Instance,
                Name = "\0",
                BackgroundTransparency = 1,
                Size = UDim2New(1, 0, 0, 20),
                BorderColor3 = FromRGB(0, 0, 0),
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })
            
            Items["Text"] = Instances:Create("TextLabel", {
                Parent = Items["Label"].Instance,
                Name = "\0",
                FontFace = Library.Font,
                TextColor3 = FromRGB(240, 240, 240),
                TextTransparency = 0.30000001192092896,
                Text = Label.Name,
                AutomaticSize = Enum.AutomaticSize.X,
                Size = UDim2New(0, 0, 0, 15),
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                Position = UDim2New(0, 30, 0, 5),
                BorderColor3 = FromRGB(0, 0, 0),
                ZIndex = 2,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Text"]:AddToTheme({TextColor3 = "Text"})          
        end

        function Label:SetText(Text)
            Text = tostring(Text)
            Items["Text"].Instance.Text = Text
        end

        function Label:SetVisibility(Bool)
            Items["Label"].Instance.Visible = Bool
        end

        function Label:RefreshPosition(Bool)
            if Bool then 
                Items["Text"]:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2New(0, 0, 0, 5)})
            else 
                Items["Text"].Instance.Position = UDim2New(0, 30, 0, 5)
            end
        end

        function Label:Colorpicker(Data)
            Data = Data or { }

            if not Items["SubElements"] then
                Items["SubElements"] = Instances:Create("Frame", {
                    Parent = Items["Label"].Instance,
                    Name = "\0",
                    Size = UDim2New(1, 0, 0, 30),
                    Position = UDim2New(0, 0, 0, 30),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(27, 26, 29)
                })  Items["SubElements"]:AddToTheme({BackgroundColor3 = "Element"})
                
                Instances:Create("UICorner", {
                    Parent = Items["SubElements"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })
                
                Instances:Create("UIListLayout", {
                    Parent = Items["SubElements"].Instance,
                    Name = "\0",
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    FillDirection = Enum.FillDirection.Horizontal,
                    Padding = UDimNew(0, 5),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })

                Instances:Create("UIPadding", {
                    Parent = Items["SubElements"].Instance,
                    Name = "\0",
                    PaddingLeft = UDimNew(0, 6)
                })                
            end

            local Colorpicker, _ = Library:CreateColorpicker({
                Parent = Items["SubElements"],
                Page = Label.Page,
                Section = Label.Section,
                Flag = Data.Flag,
                Default = Data.Default,
                Callback = Data.Callback,
                Alpha = Data.Alpha,
                Parent2 = Items["Label"]
            })

            return Colorpicker
        end

        Label.Section.Elements[#Label.Section.Elements+1] = Label
        return Label
    end

    -- ==================== Keybind ====================
    Library.Sections.Keybind = function(self, Data)
        Data = Data or { }

        local Keybind = {
            Window = self.Window,
            Page = self.Page,
            Section = self,

            Name = Data.Name or Data.name or "Keybind",
            Flag = Data.Flag or Data.flag or Library:NextFlag(),
            Default = Data.Default or Data.default or Enum.KeyCode.RightShift,
            Callback = Data.Callback or Data.callback or function() end,
            Mode = Data.Mode or Data.mode or "Toggle",

            Value = "",
            Key = "",
            ModeSelected = "Toggle",
            Toggled = false,
            Picking = false
        }

        local Items = { } do
            Items["Label"] = Instances:Create("Frame", {
                Parent = Keybind.Section.Items["Content"].Instance,
                Name = "\0",
                BackgroundTransparency = 1,
                Size = UDim2New(1, 0, 0, 20),
                BorderColor3 = FromRGB(0, 0, 0),
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })
            
            Items["SubElements"] = Instances:Create("Frame", {
                Parent = Items["Label"].Instance,
                Name = "\0",
                Size = UDim2New(1, 0, 0, 30),
                Position = UDim2New(0, 0, 0, 30),
                BorderColor3 = FromRGB(0, 0, 0),
                ZIndex = 2,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(27, 26, 29)
            })  Items["SubElements"]:AddToTheme({BackgroundColor3 = "Element"})
            
            Instances:Create("UICorner", {
                Parent = Items["SubElements"].Instance,
                Name = "\0",
                CornerRadius = UDimNew(0, 5)
            })
            
            Instances:Create("UIListLayout", {
                Parent = Items["SubElements"].Instance,
                Name = "\0",
                VerticalAlignment = Enum.VerticalAlignment.Center,
                FillDirection = Enum.FillDirection.Horizontal,
                Padding = UDimNew(0, 5),
                SortOrder = Enum.SortOrder.LayoutOrder
            })
            
            Instances:Create("UIPadding", {
                Parent = Items["SubElements"].Instance,
                Name = "\0",
                PaddingLeft = UDimNew(0, 6)
            })
            
            Items["KeyButton"] = Instances:Create("TextButton", {
                Parent = Items["SubElements"].Instance,
                Name = "\0",
                FontFace = Library.Font,
                TextColor3 = FromRGB(240, 240, 240),
                TextTransparency = 0.30000001192092896,
                Text = "None",
                AutoButtonColor = false,
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(1, 0, 1, 0),
                BackgroundTransparency = 1,
                SelectionOrder = 2,
                BorderSizePixel = 0,
                ZIndex = 2,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["KeyButton"]:AddToTheme({TextColor3 = "Text"})
            
            Items["Text"] = Instances:Create("TextLabel", {
                Parent = Items["Label"].Instance,
                Name = "\0",
                FontFace = Library.Font,
                TextColor3 = FromRGB(240, 240, 240),
                TextTransparency = 0.30000001192092896,
                Text = Keybind.Name,
                AutomaticSize = Enum.AutomaticSize.X,
                Size = UDim2New(0, 0, 0, 15),
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                Position = UDim2New(0, 0, 0, 5),
                BorderColor3 = FromRGB(0, 0, 0),
                ZIndex = 2,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Text"]:AddToTheme({TextColor3 = "Text"})
            
            Items["Modes"] = Instances:Create("Frame", {
                Parent = Items["Label"].Instance,
                Name = "\0",
                BorderColor3 = FromRGB(0, 0, 0),
                AnchorPoint = Vector2New(1, 0),
                Position = UDim2New(1, 0, 0, 0),
                Size = UDim2New(0, 200, 0, 25),
                ZIndex = 2,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(27, 26, 29)
            })  Items["Modes"]:AddToTheme({BackgroundColor3 = "Element"})
            
            Instances:Create("UICorner", {
                Parent = Items["Modes"].Instance,
                Name = "\0",
                CornerRadius = UDimNew(0, 5)
            })
            
            Items["Background"] = Instances:Create("Frame", {
                Parent = Items["Modes"].Instance,
                Name = "\0",
                Size = UDim2New(0.35, 0, 1, 0),
                BorderColor3 = FromRGB(0, 0, 0),
                ZIndex = 2,
                BorderSizePixel = 0,
                BackgroundTransparency = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })
            
            Instances:Create("UICorner", {
                Parent = Items["Background"].Instance,
                Name = "\0",
                CornerRadius = UDimNew(0, 5)
            })
            
            Instances:Create("UIGradient", {
                Parent = Items["Background"].Instance,
                Name = "\0",
                Rotation = -115,
                Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(166, 166, 166))}
            }):AddToTheme({Color = function()
                return RGBSequence{RGBSequenceKeypoint(0, Library.Theme.Accent), RGBSequenceKeypoint(1, Library.Theme.AccentGradient)}
            end})
            
            Items["Toggle"] = Instances:Create("TextButton", {
                Parent = Items["Modes"].Instance,
                Name = "\0",
                FontFace = Library.Font,
                TextColor3 = FromRGB(0, 0, 0),
                TextTransparency = 0.30000001192092896,
                Text = "Toggle",
                AutoButtonColor = false,
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(0.35, 0, 1, 0),
                BackgroundTransparency = 1,
                Position = UDim2New(0, 0, 0, -1),
                BorderSizePixel = 0,
                ZIndex = 2,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Toggle"]:AddToTheme({TextColor3 = function()
                return Library.Theme.Text
            end})
            
            Items["Hold"] = Instances:Create("TextButton", {
                Parent = Items["Modes"].Instance,
                Name = "\0",
                FontFace = Library.Font,
                TextColor3 = FromRGB(240, 240, 240),
                TextTransparency = 0.20000000298023224,
                Text = "Hold",
                BorderColor3 = FromRGB(0, 0, 0),
                AutoButtonColor = false,
                AnchorPoint = Vector2New(0, 0),
                Size = UDim2New(0.35, 0, 1, 0),
                BackgroundTransparency = 1,
                Position = UDim2New(0.35, 0, 0, -1),
                BorderSizePixel = 0,
                ZIndex = 2,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Hold"]:AddToTheme({TextColor3 = function()
                return Library.Theme.Text
            end})        
            
            Items["Always"] = Instances:Create("TextButton", {
                Parent = Items["Modes"].Instance,
                Name = "\0",
                FontFace = Library.Font,
                TextColor3 = FromRGB(240, 240, 240),
                TextTransparency = 0.20000000298023224,
                Text = "Always",
                BorderColor3 = FromRGB(0, 0, 0),
                AutoButtonColor = false,
                AnchorPoint = Vector2New(0, 0),
                Size = UDim2New(0.3, 0, 1, 0),
                BackgroundTransparency = 1,
                Position = UDim2New(0.7, -12, 0, -1),
                BorderSizePixel = 0,
                ZIndex = 2,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Always"]:AddToTheme({TextColor3 = function()
                return Library.Theme.Text
            end})              
        end

        local KeyListItem 
        if Library.KeyList then 
            KeyListItem = Library.KeyList:Add(Keybind.Name, "")
        end

        local function Update()
            if KeyListItem then 
                KeyListItem:Set(Keybind.Name, Keybind.Value)
                KeyListItem:SetStatus(Keybind.Toggled)
            end
        end

        function Keybind:RefreshPosition(Bool)
            if Bool then 
                Items["Text"]:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2New(0, 0, 0, 5)})
                Items["SubElements"]:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2New(0, 0, 0, 30)})
                Items["Modes"]:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2New(1, 0, 0, 0)})
            else
                Items["Text"].Instance.Position = UDim2New(0, 30, 0, 5)
                Items["SubElements"].Instance.Position = UDim2New(0, 30, 0, 30)
                Items["Modes"].Instance.Position = UDim2New(1, 30, 0, 0)
            end
        end

        function Keybind:SetMode(Mode)
            if Mode == "Toggle" then
                Items["Background"]:Tween(TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(0, 0, 0, 0), Size = UDim2New(0.35, 0, 1, 0)})
                Items["Toggle"]:ChangeItemTheme({TextColor3 = function() return FromRGB(0, 0, 0) end})
                Items["Toggle"]:Tween(nil, {TextColor3 = FromRGB(0, 0, 0)})
                Items["Hold"]:ChangeItemTheme({TextColor3 = function() return Library.Theme.Text end})
                Items["Hold"]:Tween(nil, {TextColor3 = Library.Theme.Text})
                Items["Always"]:ChangeItemTheme({TextColor3 = function() return Library.Theme.Text end})
                Items["Always"]:Tween(nil, {TextColor3 = Library.Theme.Text})
            elseif Mode == "Hold" then
                Items["Background"]:Tween(TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(0.35, 0, 0, 0), Size = UDim2New(0.35, 0, 1, 0)})
                Items["Toggle"]:ChangeItemTheme({TextColor3 = function() return Library.Theme.Text end})
                Items["Toggle"]:Tween(nil, {TextColor3 = Library.Theme.Text})
                Items["Hold"]:ChangeItemTheme({TextColor3 = function() return FromRGB(0, 0, 0) end})
                Items["Hold"]:Tween(nil, {TextColor3 = FromRGB(0, 0, 0)})
                Items["Always"]:ChangeItemTheme({TextColor3 = function() return Library.Theme.Text end})
                Items["Always"]:Tween(nil, {TextColor3 = Library.Theme.Text})
            elseif Mode == "Always" then
                Items["Background"]:Tween(TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(0.7, 0, 0, 0), Size = UDim2New(0.3, 0, 1, 0)})
                Items["Toggle"]:ChangeItemTheme({TextColor3 = function() return Library.Theme.Text end})
                Items["Toggle"]:Tween(nil, {TextColor3 = Library.Theme.Text})
                Items["Hold"]:ChangeItemTheme({TextColor3 = function() return Library.Theme.Text end})
                Items["Hold"]:Tween(nil, {TextColor3 = Library.Theme.Text})
                Items["Always"]:ChangeItemTheme({TextColor3 = function() return FromRGB(0, 0, 0) end})
                Items["Always"]:Tween(nil, {TextColor3 = FromRGB(0, 0, 0)})
            end

            Library.Flags[Keybind.Flag] = {
                Mode = Keybind.ModeSelected,
                Key = Keybind.Key,
                Toggled = Keybind.Toggled
            }

            if Keybind.Callback then 
                Library:SafeCall(Keybind.Callback, Keybind.Toggled)
            end
        end

        function Keybind:Press(Bool)
            if Keybind.ModeSelected == "Toggle" then 
                Keybind.Toggled = not Keybind.Toggled
            elseif Keybind.ModeSelected == "Hold" then 
                Keybind.Toggled = Bool
            elseif Keybind.ModeSelected == "Always" then 
                Keybind.Toggled = true
            end

            Library.Flags[Keybind.Flag] = {
                Mode = Keybind.ModeSelected,
                Key = Keybind.Key,
                Toggled = Keybind.Toggled
            }

            if Keybind.Callback then 
                Library:SafeCall(Keybind.Callback, Keybind.Toggled)
            end
            Update()
        end

        function Keybind:Get()
            return Keybind.Key, Keybind.ModeSelected, Keybind.Toggled
        end

        function Keybind:Set(Key)
            if type(Key) == "table" then
                local RealKey = Key.Key == "Backspace" and "None" or Key.Key
                Keybind.Key = tostring(Key.Key)
                if Key.Mode then
                    Keybind.ModeSelected = Key.Mode
                    Keybind:SetMode(Key.Mode)
                else
                    Keybind.ModeSelected = "Toggle"
                    Keybind:SetMode("Toggle")
                end
                local KeyString = Keys[Keybind.Key] or StringGSub(tostring(RealKey), "Enum.", "") or RealKey
                local TextToDisplay = StringGSub(StringGSub(KeyString, "KeyCode.", ""), "UserInputType.", "") or "None"
                Keybind.Value = TextToDisplay
                Items["KeyButton"].Instance.Text = TextToDisplay
                if Keybind.Callback then 
                    Library:SafeCall(Keybind.Callback, Keybind.Toggled)
                end
            elseif type(Key) == "string" and TableFind({"Toggle", "Hold", "Always"}, Key) then
                Keybind.ModeSelected = Key
                Keybind:SetMode(Key)
                if Keybind.Callback then 
                    Library:SafeCall(Keybind.Callback, Keybind.Toggled)
                end
            end
            Update()
        end

        function Keybind:SetKey(KeyCode)
            Keybind.Key = tostring(KeyCode)
            local Key = KeyCode.Name == "Backspace" and "None" or KeyCode.Name
            local KeyString = Keys[Keybind.Key] or StringGSub(Key, "Enum.", "") or "None"
            local TextToDisplay = StringGSub(StringGSub(KeyString, "KeyCode.", ""), "UserInputType.", "") or "None"
            Keybind.Value = TextToDisplay
            Items["KeyButton"].Instance.Text = TextToDisplay
            Library.Flags[Keybind.Flag] = {
                Mode = Keybind.ModeSelected,
                Key = Keybind.Key,
                Toggled = Keybind.Toggled
            }
            if Keybind.Callback then 
                Library:SafeCall(Keybind.Callback, Keybind.Toggled)
            end
            Update()
        end

        Items["KeyButton"]:Connect("MouseButton1Click", function()
            Keybind.Picking = true 
            Items["KeyButton"].Instance.Text = "."
            Library:Thread(function()
                local Count = 1
                while true do 
                    if not Keybind.Picking then break end
                    if Count == 4 then Count = 1 end
                    Items["KeyButton"].Instance.Text = Count == 1 and "." or Count == 2 and ".." or Count == 3 and "..."
                    Count += 1
                    task.wait(0.35)
                end
            end)

            local InputBegan
            InputBegan = UserInputService.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.Keyboard then 
                    Keybind:SetKey(Input.KeyCode)
                elseif Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.MouseButton2 or Input.UserInputType == Enum.UserInputType.MouseButton3 then
                    Keybind:SetKey(Input.UserInputType)
                else
                    Keybind:SetKey(Enum.KeyCode.Backspace)
                end
                Keybind.Picking = false
                InputBegan:Disconnect()
                InputBegan = nil
            end)
        end)

        Library:Connect(UserInputService.InputBegan, function(Input)
            if Keybind.Value == "None" then return end
            if tostring(Input.KeyCode) == Keybind.Key then
                if Keybind.ModeSelected == "Toggle" then 
                    Keybind:Press()
                elseif Keybind.ModeSelected == "Hold" then 
                    Keybind:Press(true)
                elseif Keybind.ModeSelected == "Always" then 
                    Keybind:Press(true)
                end
            elseif tostring(Input.UserInputType) == Keybind.Key then
                if Keybind.ModeSelected == "Toggle" then 
                    Keybind:Press()
                elseif Keybind.ModeSelected == "Hold" then 
                    Keybind:Press(true)
                elseif Keybind.ModeSelected == "Always" then 
                    Keybind:Press(true)
                end
            end
        end)

        Library:Connect(UserInputService.InputEnded, function(Input)
            if Keybind.Value == "None" then return end
            if tostring(Input.KeyCode) == Keybind.Key then
                if Keybind.ModeSelected == "Hold" then 
                    Keybind:Press(false)
                end
            elseif tostring(Input.UserInputType) == Keybind.Key then
                if Keybind.ModeSelected == "Hold" then 
                    Keybind:Press(false)
                end
            end
        end)

        Items["Toggle"]:Connect("MouseButton1Down", function()
            Keybind.ModeSelected = "Toggle"
            Keybind:SetMode("Toggle")
        end)

        Items["Hold"]:Connect("MouseButton1Down", function()
            Keybind.ModeSelected = "Hold"
            Keybind:SetMode("Hold")
        end)

        Items["Always"]:Connect("MouseButton1Down", function()
            Keybind.ModeSelected = "Always"
            Keybind:SetMode("Always")
        end)

        if Keybind.Default then 
            Keybind:Set({
                Mode = Keybind.Mode or "Toggle",
                Key = Keybind.Default,
            })
        end

        Library.SetFlags[Keybind.Flag] = function(Value)
            Keybind:Set(Value)
        end

        Keybind.Section.Elements[#Keybind.Section.Elements+1] = Keybind
        return Keybind 
    end

    -- ==================== Textbox ====================
    Library.Sections.Textbox = function(self, Data)
        Data = Data or { }

        local Textbox = {
            Window = self.Window,
            Page = self.Page,
            Section = self,

            Flag = Data.Flag or Data.flag or Library:NextFlag(),
            Default = Data.Default or Data.default or "",
            Callback = Data.Callback or Data.callback or function() end,
            Placeholder = Data.Placeholder or Data.placeholder or "Placeholder",
            Numeric = Data.Numeric or Data.numeric or false,
            Finished = Data.Finished or Data.finished or false,

            Value = ""
        }

        local Items = { } do 
            Items["Textbox"] = Instances:Create("Frame", {
                Parent = Textbox.Section.Items["Content"].Instance,
                Name = "\0",
                Active = true,
                BorderColor3 = FromRGB(0, 0, 0),
                BackgroundTransparency = 1,
                Selectable = true,
                Size = UDim2New(1, 0, 0, 32),
                ZIndex = 2,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(27, 26, 29)
            }) 
            
            Instances:Create("UICorner", {
                Parent = Items["Textbox"].Instance,
                Name = "\0",
                CornerRadius = UDimNew(0, 4)
            })
            
            Items["Background"] = Instances:Create("Frame", {
                Parent = Items["Textbox"].Instance,
                Name = "\0",
                Active = true,
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(1, 0, 1, 0),
                Selectable = true,
                ZIndex = 2,
                ClipsDescendants = true,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(27, 26, 29)
            })  Items["Background"]:AddToTheme({BackgroundColor3 = "Element"})
            
            Instances:Create("UICorner", {
                Parent = Items["Background"].Instance,
                Name = "\0",
                CornerRadius = UDimNew(0, 4)
            })
            
            Items["Input"] = Instances:Create("TextBox", {
                Parent = Items["Background"].Instance,
                Name = "\0",
                FontFace = Library.Font,
                TextColor3 = FromRGB(240, 240, 240),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = "",
                ZIndex = 2,
                Size = UDim2New(1, -20, 0, 15),
                Position = UDim2New(0, 10, 0, 8),
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                PlaceholderColor3 = FromRGB(185, 185, 185),
                TextXAlignment = Enum.TextXAlignment.Left,
                PlaceholderText = Textbox.Placeholder,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Input"]:AddToTheme({TextColor3 = "Text"})               
        end
        
        function Textbox:Get()
            return Textbox.Value
        end

        function Textbox:SetVisibility(Bool)
            Items["Textbox"].Instance.Visible = Bool
        end

        function Textbox:RefreshPosition(Bool)
            if Bool then
                Items["Background"]:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2New(0, 0, 0, 0)})
            else
                Items["Background"].Instance.Position = UDim2New(0, 30, 0, 0)
            end
        end

        function Textbox:Set(Value)
            if Textbox.Numeric then
                if (not tonumber(Value)) and StringLen(tostring(Value)) > 0 then
                    Value = Textbox.Value
                end
            end

            Textbox.Value = Value
            Items["Input"].Instance.Text = Value
            Library.Flags[Textbox.Flag] = Value

            if Textbox.Callback then
                Library:SafeCall(Textbox.Callback, Value)
            end
        end

        if Textbox.Finished then 
            Items["Input"]:Connect("FocusLost", function(PressedEnter)
                if PressedEnter then
                    Textbox:Set(Items["Input"].Instance.Text)
                end
            end)
        else
            Library:Connect(Items["Input"].Instance:GetPropertyChangedSignal("Text"), function()
                Textbox:Set(Items["Input"].Instance.Text)
            end)
        end

        if Textbox.Default then
            Textbox:Set(Textbox.Default)
        end

        Library.SetFlags[Textbox.Flag] = function(Value)
            Textbox:Set(Value)
        end

        Textbox.Section.Elements[#Textbox.Section.Elements+1] = Textbox
        return Textbox
    end

    -- ==================== Dropdown ====================
    Library.Sections.Dropdown = function(self, Data)
        Data = Data or { }

        local Dropdown = {
            Window = self.Window,
            Page = self.Page,
            Section = self,

            Name = Data.Name or Data.name or "Dropdown",
            Flag = Data.Flag or Data.flag or Library:NextFlag(),
            Items = Data.Items or Data.items or { "One", "Two", "Three" },
            Default = Data.Default or Data.default or nil,
            Callback = Data.Callback or Data.callback or function() end,
            Size = Data.Size or Data.size or 125,
            OptionHolderSize = Data.OptionHolderSize or Data.optionholder or 125,
            Multi = Data.Multi or Data.multi or false,

            Value = { },
            Options = { },
            OptionsWithIndexes = { },
            IsOpen = false
        }

        local Items = { } do 
            Items["Dropdown"] = Instances:Create("Frame", {
                Parent = Dropdown.Section.Items["Content"].Instance,
                Name = "\0",
                BackgroundTransparency = 1,
                Size = UDim2New(1, 0, 0, 25),
                BorderColor3 = FromRGB(0, 0, 0),
                ZIndex = 2,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })
            
            Items["Text"] = Instances:Create("TextLabel", {
                Parent = Items["Dropdown"].Instance,
                Name = "\0",
                FontFace = Library.Font,
                TextColor3 = FromRGB(240, 240, 240),
                TextTransparency = 0.30000001192092896,
                Text = Dropdown.Name,
                AutomaticSize = Enum.AutomaticSize.X,
                Size = UDim2New(0, 0, 0, 15),
                AnchorPoint = Vector2New(0, 0.5),
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                Position = UDim2New(0, 0, 0.5, 0),
                BorderColor3 = FromRGB(0, 0, 0),
                ZIndex = 2,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Text"]:AddToTheme({TextColor3 = "Text"})
            
            Items["RealDropdown"] = Instances:Create("TextButton", {
                Parent = Items["Dropdown"].Instance,
                Name = "\0",
                FontFace = Library.Font,
                TextColor3 = FromRGB(0, 0, 0),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = "",
                Size = UDim2New(0, Dropdown.Size or 125, 0, 25),
                AutoButtonColor = false,
                AnchorPoint = Vector2New(1, 0),
                Position = UDim2New(1, 0, 0, 0),
                BorderSizePixel = 0,
                ZIndex = 2,
                TextSize = 14,
                BackgroundColor3 = FromRGB(27, 26, 29)
            })  Items["RealDropdown"]:AddToTheme({BackgroundColor3 = "Element"})
            
            Instances:Create("UICorner", {
                Parent = Items["RealDropdown"].Instance,
                Name = "\0",
                CornerRadius = UDimNew(0, 6)
            })
            
            Items["Value"] = Instances:Create("TextLabel", {
                Parent = Items["RealDropdown"].Instance,
                Name = "\0",
                FontFace = Library.Font,
                TextColor3 = FromRGB(240, 240, 240),
                TextTransparency = 0.30000001192092896,
                Text = "-",
                Size = UDim2New(1, -40, 0, 15),
                AnchorPoint = Vector2New(0, 0.5),
                BorderSizePixel = 0,
                TextTruncate = Enum.TextTruncate.AtEnd,
                BackgroundTransparency = 1,
                Position = UDim2New(0, 10, 0.5, -1),
                TextXAlignment = Enum.TextXAlignment.Left,
                BorderColor3 = FromRGB(0, 0, 0),
                ZIndex = 2,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Value"]:AddToTheme({TextColor3 = "Text"})
            
            Items["Liner"] = Instances:Create("Frame", {
                Parent = Items["RealDropdown"].Instance,
                Name = "\0",
                BorderColor3 = FromRGB(0, 0, 0),
                AnchorPoint = Vector2New(1, 0),
                Position = UDim2New(1, -25, 0, 0),
                Size = UDim2New(0, 2, 1, 0),
                ZIndex = 2,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(34, 32, 36)
            })  Items["Liner"]:AddToTheme({BackgroundColor3 = "Outline"})
            
            Items["ArrowIcon"] = Instances:Create("ImageLabel", {
                Parent = Items["RealDropdown"].Instance,
                Name = "\0",
                ImageColor3 = FromRGB(141, 141, 150),
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(0, 16, 0, 8),
                AnchorPoint = Vector2New(1, 0.5),
                Image = "rbxassetid://123317177279443",
                BackgroundTransparency = 1,
                Position = UDim2New(1, -5, 0.5, 0),
                ZIndex = 2,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })

            Items["OptionHolder"] = Instances:Create("TextButton", {
                Parent = Library.UnusedHolder.Instance,
                Text = "",
                AutoButtonColor = false,
                Name = "\0",
                Visible = false,
                Position = UDim2New(0, 897, 0, 101),
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(0, 159, 0, 87),
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(27, 25, 29)
            })  Items["OptionHolder"]:AddToTheme({BackgroundColor3 = "Background"})
             
            Instances:Create("UIStroke", {
                Parent = Items["OptionHolder"].Instance,
                Name = "\0",
                Color = FromRGB(35, 33, 38),
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            }):AddToTheme({Color = "Outline"})
            
            Instances:Create("UICorner", {
                Parent = Items["OptionHolder"].Instance,
                Name = "\0",
                CornerRadius = UDimNew(0, 5)
            })
            
            Items["Holder"] = Instances:Create("ScrollingFrame", {
                Parent = Items["OptionHolder"].Instance,
                Name = "\0",
                Active = true,
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                ScrollBarThickness = 2,
                Size = UDim2New(1, -16, 1, -16),
                BackgroundTransparency = 1,
                Position = UDim2New(0, 8, 0, 8),
                BackgroundColor3 = FromRGB(255, 255, 255),
                BorderColor3 = FromRGB(0, 0, 0),
                BorderSizePixel = 0,
                CanvasSize = UDim2New(0, 0, 0, 0)
            })  Items["Holder"]:AddToTheme({ScrollBarImageColor3 = "Accent"})
            
            Instances:Create("UIListLayout", {
                Parent = Items["Holder"].Instance,
                Name = "\0",
                Padding = UDimNew(0, 4),
                SortOrder = Enum.SortOrder.LayoutOrder
            })                
        end

        function Dropdown:Get()
            return Dropdown.Value
        end

        function Dropdown:SetVisibility(Bool)
            Items["Dropdown"].Instance.Visible = Bool
        end

        function Dropdown:RefreshPosition(Bool)
            if Bool then
                Items["Text"]:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2New(0, 0, 0.5, 0)})
                Items["RealDropdown"]:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2New(1, 0, 0, 0)})
            else
                Items["Text"].Instance.Position = UDim2New(0, 30, 0.5, 0)
                Items["RealDropdown"].Instance.Position = UDim2New(1, 30, 0, 0)
            end
        end

        Items["RealDropdown"]:OnHover(function()
            if Dropdown.IsOpen then return end
            Items["ArrowIcon"]:Tween(nil, {ImageColor3 = FromRGB(255, 255, 255)})
        end)

        Items["RealDropdown"]:OnHoverLeave(function()
            if Dropdown.IsOpen then return end
            Items["ArrowIcon"]:Tween(nil, {ImageColor3 = FromRGB(141, 141, 150)})
        end)

        local RenderStepped 
        local Debounce = false

        function Dropdown:SetOpen(Bool)
            if Debounce then return end
            Dropdown.IsOpen = Bool
            Debounce = true 

            if Dropdown.IsOpen then 
                Items["OptionHolder"].Instance.Visible = true
                Items["OptionHolder"].Instance.Parent = Library.Holder.Instance
                Items["ArrowIcon"]:Tween(nil, {Rotation = 180, ImageColor3 = FromRGB(255, 255, 255)})
                
                Library:Thread(function()
                    for Index, Value in pairs(Dropdown.OptionsWithIndexes) do 
                        task.spawn(function() Value:RefreshPosition(true) end)
                        task.wait(0.05)
                    end
                end)
                
                RenderStepped = RunService.RenderStepped:Connect(function()
                    Items["OptionHolder"].Instance.Position = UDim2New(0, Items["RealDropdown"].Instance.AbsolutePosition.X, 0, Items["RealDropdown"].Instance.AbsolutePosition.Y + Items["RealDropdown"].Instance.AbsoluteSize.Y + 5)
                    Items["OptionHolder"].Instance.Size = UDim2New(0, Items["RealDropdown"].Instance.AbsoluteSize.X, 0, Dropdown.OptionHolderSize)
                end)

                for Index, Value in pairs(Library.OpenFrames) do 
                    if Value ~= Dropdown and not Dropdown.Section.IsSettings then 
                        Value:SetOpen(false)
                    end
                end
                Library.OpenFrames[Dropdown] = Dropdown 
            else
                for Index, Value in pairs(Dropdown.OptionsWithIndexes) do 
                    task.spawn(function() Value:RefreshPosition(false) end)
                end
                if Library.OpenFrames[Dropdown] then Library.OpenFrames[Dropdown] = nil end
                if RenderStepped then RenderStepped:Disconnect() RenderStepped = nil end
                Items["ArrowIcon"]:Tween(nil, {Rotation = 0, ImageColor3 = FromRGB(141, 141, 150)})
            end

            local Descendants = Items["OptionHolder"].Instance:GetDescendants()
            TableInsert(Descendants, Items["OptionHolder"].Instance)

            local NewTween
            for Index, Value in pairs(Descendants) do 
                local TransparencyProperty = Tween:GetProperty(Value)
                if not TransparencyProperty then continue end
                if not Value.ClassName:find("UI") then 
                    Value.ZIndex = (Dropdown.IsOpen and Dropdown.Section.IsSettings and 8) or (Dropdown.IsOpen and 3) or 1
                end
                if type(TransparencyProperty) == "table" then 
                    for _, Property in pairs(TransparencyProperty) do 
                        NewTween = Tween:FadeItem(Value, Property, Bool, Library.FadeSpeed)
                    end
                else
                    NewTween = Tween:FadeItem(Value, TransparencyProperty, Bool, Library.FadeSpeed)
                end
            end
            
            NewTween.Tween.Completed:Connect(function()
                Debounce = false 
                Items["OptionHolder"].Instance.Visible = Dropdown.IsOpen
                task.wait(0.2)
                Items["OptionHolder"].Instance.Parent = not Dropdown.IsOpen and Library.UnusedHolder.Instance or Library.Holder.Instance
            end)
        end

        function Dropdown:Set(Option)
            if Dropdown.Multi then 
                if type(Option) ~= "table" then return end
                Dropdown.Value = Option
                Library.Flags[Dropdown.Flag] = Option
                for Index, Value in pairs(Option) do
                    local OptionData = Dropdown.Options[Value]
                    if not OptionData then continue end
                    OptionData.Selected = true 
                    OptionData:Toggle("Active")
                end
                Items["Value"].Instance.Text = TableConcat(Option, ", ")
            else
                if not Dropdown.Options[Option] then return end
                local OptionData = Dropdown.Options[Option]
                Dropdown.Value = Option
                Library.Flags[Dropdown.Flag] = Option
                for Index, Value in pairs(Dropdown.Options) do
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
                Library:SafeCall(Dropdown.Callback, Dropdown.Value)
            end
        end

        function Dropdown:Add(Option)
            local OptionButton = Instances:Create("TextButton", {
                Parent = Items["Holder"].Instance,
                Name = "\0",
                FontFace = Library.Font,
                TextColor3 = FromRGB(0, 0, 0),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = "",
                AutoButtonColor = false,
                BackgroundTransparency = 1,
                Size = UDim2New(1, 0, 0, 20),
                BorderSizePixel = 0,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })
            
            local OptionAccent = Instances:Create("Frame", {
                Parent = OptionButton.Instance,
                Name = "\0",
                BorderColor3 = FromRGB(0, 0, 0),
                AnchorPoint = Vector2New(0, 0.5),
                BackgroundTransparency = 1,
                Position = UDim2New(0, 0, 0.5, 0),
                Size = UDim2New(0, 6, 0, 6),
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })
            
            Instances:Create("UIGradient", {
                Parent = OptionAccent.Instance,
                Name = "\0",
                Enabled = true,
                Rotation = -115,
                Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(143, 143, 143))}
            }):AddToTheme({Color = function()
                return RGBSequence{RGBSequenceKeypoint(0, Library.Theme.Accent), RGBSequenceKeypoint(1, Library.Theme.AccentGradient)}
            end})
            
            Instances:Create("UICorner", {
                Parent = OptionAccent.Instance,
                Name = "\0"
            })
            
            local OptionText = Instances:Create("TextLabel", {
                Parent = OptionButton.Instance,
                Name = "\0",
                FontFace = Library.Font,
                TextColor3 = FromRGB(255, 255, 255),
                TextTransparency = 0.30000001192092896,
                Text = Option,
                Size = UDim2New(0, 0, 0, 15),
                AnchorPoint = Vector2New(0, 0.5),
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                Position = UDim2New(0, 30, 0.5, 0),
                BorderColor3 = FromRGB(0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.X,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  OptionText:AddToTheme({TextColor3 = "Text"})
            
            local OptionData = {
                Button = OptionButton,
                Name = Option,
                OptionText = OptionText,
                OptionAccent = OptionAccent,
                Selected = false
            }
            
            function OptionData:Toggle(Value)
                if Value == "Active" then
                    OptionText:Tween(nil, {TextTransparency = 0, Position = UDim2New(0, 15, 0.5, 0)})
                    OptionAccent:Tween(nil, {BackgroundTransparency = 0})
                else
                    OptionText:Tween(nil, {TextTransparency = 0.3, Position = UDim2New(0, 0, 0.5, 0)})
                    OptionAccent:Tween(nil, {BackgroundTransparency = 1})
                end
            end

            function OptionData:RefreshPosition(Bool)
                if Bool then 
                    if OptionData.Selected then
                        OptionAccent:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2New(0, 0, 0.5, 0)})
                        OptionText:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2New(0, 15, 0.5, 0)})
                    else
                        OptionText:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2New(0, 0, 0.5, 0)})
                    end
                else
                    if OptionData.Selected then
                        OptionAccent.Instance.Position = UDim2New(0, 30, 0.5, 0)
                        OptionText.Instance.Position = UDim2New(0, 45, 0.5, 0)
                    else
                        OptionText.Instance.Position = UDim2New(0, 30, 0.5, 0)
                    end
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
                    Library.Flags[Dropdown.Flag] = Dropdown.Value
                    local TextFormat = #Dropdown.Value > 0 and TableConcat(Dropdown.Value, ", ") or "..."
                    Items["Value"].Instance.Text = TextFormat
                else
                    if OptionData.Selected then 
                        Dropdown.Value = OptionData.Name
                        Library.Flags[Dropdown.Flag] = OptionData.Name
                        OptionData.Selected = true
                        OptionData:Toggle("Active")
                        for Index, Value in pairs(Dropdown.Options) do 
                            if Value ~= OptionData then
                                Value.Selected = false 
                                Value:Toggle("Inactive")
                            end
                        end
                        Items["Value"].Instance.Text = OptionData.Name
                    else
                        Dropdown.Value = nil
                        Library.Flags[Dropdown.Flag] = nil
                        OptionData.Selected = false
                        OptionData:Toggle("Inactive")
                        Items["Value"].Instance.Text = "..."
                    end
                end
                if Dropdown.Callback then
                    Library:SafeCall(Dropdown.Callback, Dropdown.Value)
                end
            end

            OptionData.Button:Connect("MouseButton1Down", function()
                OptionData:Set()
            end)

            Dropdown.Options[OptionData.Name] = OptionData
            Dropdown.OptionsWithIndexes[#Dropdown.OptionsWithIndexes+1] = OptionData
            OptionData:RefreshPosition(false)
            return OptionData
        end

        function Dropdown:Remove(Option)
            if Dropdown.Options[Option] then
                Dropdown.Options[Option].Button:Clean()
                Dropdown.Options[Option] = nil
            end
        end

        function Dropdown:Refresh(List)
            for Index, Value in pairs(Dropdown.Options) do 
                Dropdown:Remove(Value.Name)
            end
            for Index, Value in pairs(List) do 
                Dropdown:Add(Value)
            end
        end

        Items["RealDropdown"]:Connect("MouseButton1Down", function()
            Dropdown:SetOpen(not Dropdown.IsOpen)
        end)

        Library:Connect(UserInputService.InputBegan, function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                if Dropdown.IsOpen then
                    if Library:IsMouseOverFrame(Items["OptionHolder"]) then return end
                    Dropdown:SetOpen(false)
                end
            end
        end)

        Items["RealDropdown"]:Connect("Changed", function(Property)
            if Property == "AbsolutePosition" and Dropdown.IsOpen then
                Dropdown.IsOpen = not Library:IsClipped(Items["OptionHolder"].Instance, Dropdown.Section.Items["Section"].Instance.Parent)
                Items["OptionHolder"].Instance.Visible = Dropdown.IsOpen
            end
        end)

        for Index, Value in pairs(Dropdown.Items) do 
            Dropdown:Add(Value)
        end

        if Dropdown.Default then 
            Dropdown:Set(Dropdown.Default)
        end

        Library.SetFlags[Dropdown.Flag] = function(Value)
            Dropdown:Set(Value)
        end

        Dropdown.Section.Elements[#Dropdown.Section.Elements+1] = Dropdown
        return Dropdown
    end

    -- ==================== Listbox ====================
    Library.Sections.Listbox = function(self, Data)
        Data = Data or { }

        local Listbox = {
            Window = self.Window,
            Page = self.Page,
            Section = self,

            Name = Data.Name or Data.name or "Listbox",
            Flag = Data.Flag or Data.flag or Library:NextFlag(),
            Items = Data.Items or Data.items or { "One", "Two", "Three" },
            Default = Data.Default or Data.default or nil,
            Callback = Data.Callback or Data.callback or function() end,
            Size = Data.Size or Data.size or 125,
            Multi = Data.Multi or Data.multi or false,

            Value = { },
            Options = { },
            IsOpen = false
        }

        local Items = { } do 
            Items["Listbox"] = Instances:Create("Frame", {
                Parent = Listbox.Section.Items["Content"].Instance,
                Name = "\0",
                BackgroundTransparency = 1,
                Size = UDim2New(1, 0, 0, Listbox.Size),
                BorderColor3 = FromRGB(0, 0, 0),
                ZIndex = 2,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })
            
            Items["Search"] = Instances:Create("TextBox", {
                Parent = Items["Listbox"].Instance,
                Name = "\0",
                FontFace = Library.Font,
                CursorPosition = -1,
                TextColor3 = FromRGB(240, 240, 240),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = "",
                ZIndex = 2,
                Size = UDim2New(1, 0, 0, 30),
                BorderSizePixel = 0,
                PlaceholderColor3 = FromRGB(185, 185, 185),
                TextXAlignment = Enum.TextXAlignment.Left,
                PlaceholderText = "Search..",
                TextSize = 14,
                BackgroundColor3 = FromRGB(27, 26, 29)
            })  Items["Search"]:AddToTheme({TextColor3 = "Text", BackgroundColor3 = "Element"})
            
            Instances:Create("UICorner", {
                Parent = Items["Search"].Instance,
                Name = "\0",
                CornerRadius = UDimNew(0, 6)
            })
            
            Instances:Create("UIPadding", {
                Parent = Items["Search"].Instance,
                Name = "\0",
                PaddingTop = UDimNew(0, 4),
                PaddingLeft = UDimNew(0, 8)
            })

            Items["Background"] = Instances:Create("Frame", {
                Parent = Items["Listbox"].Instance,
                Name = "\0",
                Active = true,
                Size = UDim2New(1, 0, 1, -30),
                BorderColor3 = FromRGB(0, 0, 0),
                Position = UDim2New(0, 0, 0, 30),
                BackgroundColor3 = FromRGB(27, 26, 29),
                ZIndex = 2,
                BorderSizePixel = 0,
            })  Items["Background"]:AddToTheme({BackgroundColor3 = "Element"})
            
            Items["Holder"] = Instances:Create("ScrollingFrame", {
                Parent = Items["Background"].Instance,
                Name = "\0",
                ScrollBarImageColor3 = FromRGB(0, 0, 0),
                Active = true,
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                ScrollBarThickness = 2,
                Size = UDim2New(1, -4, 1, -8),
                BorderColor3 = FromRGB(0, 0, 0),
                Position = UDim2New(0, 0, 0, 4),
                BackgroundColor3 = FromRGB(27, 26, 29),
                ZIndex = 2,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                CanvasSize = UDim2New(0, 0, 0, 0)
            })  Items["Holder"]:AddToTheme({ScrollBarImageColor3 = "Accent"})
            
            Instances:Create("UICorner", {
                Parent = Items["Background"].Instance,
                Name = "\0",
                CornerRadius = UDimNew(0, 6)
            })
            
            Instances:Create("UIListLayout", {
                Parent = Items["Holder"].Instance,
                Name = "\0",
                Padding = UDimNew(0, 4),
                SortOrder = Enum.SortOrder.LayoutOrder
            })
            
            Instances:Create("UIPadding", {
                Parent = Items["Holder"].Instance,
                Name = "\0",
                PaddingTop = UDimNew(0, 8),
                PaddingBottom = UDimNew(0, 8),
                PaddingRight = UDimNew(0, 12),
                PaddingLeft = UDimNew(0, 8)
            })      
            
            Items["_"] = Instances:Create("Frame", {
                Parent = Items["Listbox"].Instance,
                Name = "\0",
                Size = UDim2New(1, 0, 0, 10),
                Position = UDim2New(0, 0, 0, 25),
                BorderColor3 = FromRGB(0, 0, 0),
                ZIndex = 2,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(27, 26, 29)
            })  Items["_"]:AddToTheme({BackgroundColor3 = "Element"})

            Instances:Create("Frame", {
                Parent = Items["_"].Instance,
                Name = "\0",
                Size = UDim2New(1, 0, 0, 1),
                Position = UDim2New(0, 0, 1, -3),
                AnchorPoint = Vector2New(0, 1),
                BorderColor3 = FromRGB(0, 0, 0),
                ZIndex = 2,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(27, 26, 29),
            }):AddToTheme({BackgroundColor3 = "Outline"})
        end

        function Listbox:Get()
            return Listbox.Value
        end

        function Listbox:SetVisibility(Bool)
            Items["Listbox"].Instance.Visible = Bool
        end

        function Listbox:RefreshPosition(Bool)
            if Bool then
                Items["Background"]:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2New(0, 0, 0, 30)})
                Items["Search"]:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2New(0, 0, 0, 0)})
                Items["_"]:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2New(0, 0, 0, 25)})
            else
                Items["Background"].Instance.Position = UDim2New(0, 30, 0, 30)
                Items["Search"].Instance.Position = UDim2New(0, 30, 0, 0)
                Items["_"].Instance.Position = UDim2New(0, 30, 0, 25)
            end
        end

        function Listbox:Set(Option)
            if Listbox.Multi then 
                if type(Option) ~= "table" then return end
                Listbox.Value = Option
                Library.Flags[Listbox.Flag] = Option
                for Index, Value in pairs(Option) do
                    local OptionData = Listbox.Options[Value]
                    if not OptionData then continue end
                    OptionData.Selected = true 
                    OptionData:Toggle("Active")
                end
            else
                if not Listbox.Options[Option] then return end
                local OptionData = Listbox.Options[Option]
                Listbox.Value = Option
                Library.Flags[Listbox.Flag] = Option
                for Index, Value in pairs(Listbox.Options) do
                    if Value ~= OptionData then
                        Value.Selected = false 
                        Value:Toggle("Inactive")
                    else
                        Value.Selected = true 
                        Value:Toggle("Active")
                    end
                end
            end
            if Listbox.Callback then   
                Library:SafeCall(Listbox.Callback, Listbox.Value)
            end
        end

        function Listbox:Add(Option)
            local OptionButton = Instances:Create("TextButton", {
                Parent = Items["Holder"].Instance,
                Name = "\0",
                FontFace = Library.Font,
                TextColor3 = FromRGB(0, 0, 0),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = "",
                AutoButtonColor = false,
                BackgroundTransparency = 1,
                Size = UDim2New(1, 0, 0, 20),
                BorderSizePixel = 0,
                ZIndex = 2,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })
            
            local OptionAccent = Instances:Create("Frame", {
                Parent = OptionButton.Instance,
                Name = "\0",
                BorderColor3 = FromRGB(0, 0, 0),
                AnchorPoint = Vector2New(0, 0.5),
                BackgroundTransparency = 1,
                ZIndex = 2,
                Position = UDim2New(0, 0, 0.5, 0),
                Size = UDim2New(0, 6, 0, 6),
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })
            
            Instances:Create("UIGradient", {
                Parent = OptionAccent.Instance,
                Name = "\0",
                Enabled = true,
                Rotation = -115,
                Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(143, 143, 143))}
            }):AddToTheme({Color = function()
                return RGBSequence{RGBSequenceKeypoint(0, Library.Theme.Accent), RGBSequenceKeypoint(1, Library.Theme.AccentGradient)}
            end})
            
            Instances:Create("UICorner", {
                Parent = OptionAccent.Instance,
                Name = "\0"
            })
            
            local OptionText = Instances:Create("TextLabel", {
                Parent = OptionButton.Instance,
                Name = "\0",
                FontFace = Library.Font,
                TextColor3 = FromRGB(255, 255, 255),
                TextTransparency = 0.30000001192092896,
                Text = Option,
                Size = UDim2New(0, 0, 0, 15),
                AnchorPoint = Vector2New(0, 0.5),
                BorderSizePixel = 0,
                ZIndex = 2,
                BackgroundTransparency = 1,
                Position = UDim2New(0, 0, 0.5, 0),
                BorderColor3 = FromRGB(0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.X,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  OptionText:AddToTheme({TextColor3 = "Text"})
            
            local OptionData = {
                Button = OptionButton,
                Name = Option,
                OptionText = OptionText,
                IsSearching = false,
                OptionAccent = OptionAccent,
                Selected = false
            }
            
            function OptionData:Toggle(Value)
                if Value == "Active" then
                    OptionText:Tween(nil, {TextTransparency = 0, Position = UDim2New(0, 15, 0.5, 0)})
                    OptionAccent:Tween(nil, {BackgroundTransparency = 0})
                else
                    OptionText:Tween(nil, {TextTransparency = 0.3, Position = UDim2New(0, 0, 0.5, 0)})
                    OptionAccent:Tween(nil, {BackgroundTransparency = 1})
                end
            end

            function OptionData:Search(Bool)
                Library:Thread(function()
                    if Bool then 
                        OptionData.IsSearching = true
                        OptionText:Tween(TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 1})
                        task.wait(0.08)
                        OptionButton:Tween(TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2New(1, 0, 0, 0)})
                        if OptionData.Selected then 
                            OptionAccent:Tween(TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 1})
                        end
                    else
                        OptionData.IsSearching = false
                        OptionText:Tween(TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = OptionData.Selected and 0 or 0.3})
                        task.wait(0.08)
                        OptionButton:Tween(TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2New(1, 0, 0, 20)})
                        if OptionData.Selected then 
                            OptionAccent:Tween(TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0})
                        end
                    end
                end)
            end

            function OptionData:Set()
                OptionData.Selected = not OptionData.Selected
                if Listbox.Multi then 
                    local Index = TableFind(Listbox.Value, OptionData.Name)
                    if Index then 
                        TableRemove(Listbox.Value, Index)
                    else
                        TableInsert(Listbox.Value, OptionData.Name)
                    end
                    OptionData:Toggle(Index and "Inactive" or "Active")
                    Library.Flags[Listbox.Flag] = Listbox.Value
                else
                    if OptionData.Selected then 
                        Listbox.Value = OptionData.Name
                        Library.Flags[Listbox.Flag] = OptionData.Name
                        OptionData.Selected = true
                        OptionData:Toggle("Active")
                        for Index, Value in pairs(Listbox.Options) do 
                            if Value ~= OptionData and not Value.IsSearching then
                                Value.Selected = false 
                                Value:Toggle("Inactive")
                            end
                        end
                    else
                        Listbox.Value = nil
                        Library.Flags[Listbox.Flag] = nil
                        OptionData.Selected = false
                        OptionData:Toggle("Inactive")
                    end
                end
                if Listbox.Callback then
                    Library:SafeCall(Listbox.Callback, Listbox.Value)
                end
            end

            OptionData.Button:Connect("MouseButton1Down", function()
                OptionData:Set()
            end)

            Listbox.Options[OptionData.Name] = OptionData
            return OptionData
        end

        function Listbox:Remove(Option)
            if Listbox.Options[Option] then
                Listbox.Options[Option].Button:Clean()
                Listbox.Options[Option] = nil
            end
        end

        function Listbox:Refresh(List)
            for Index, Value in pairs(Listbox.Options) do 
                Listbox:Remove(Value.Name)
            end
            for Index, Value in pairs(List) do 
                Listbox:Add(Value)
            end
        end

        Library:Connect(Items["Search"].Instance:GetPropertyChangedSignal("Text"), function()
            Library:Thread(function()
                for Index, Value in pairs(Listbox.Options) do
                    local InputText = Items["Search"].Instance.Text
                    if InputText ~= "" then
                        if StringFind(StringLower(Value.Name), Library:EscapePattern(StringLower(InputText))) then
                            Value.Button.Instance.Visible = true
                            Value:Search(false)
                        else
                            Value:Search(true)
                            Value.Button.Instance.Visible = false
                        end
                    else
                        Value:Search(false)
                        Value.Button.Instance.Visible = true
                    end
                end
            end)
        end)

        for Index, Value in pairs(Listbox.Items) do 
            Listbox:Add(Value)
        end

        if Listbox.Default then 
            Listbox:Set(Listbox.Default)
        end

        Library.SetFlags[Listbox.Flag] = function(Value)
            Listbox:Set(Value)
        end

        Listbox.Section.Elements[#Listbox.Section.Elements+1] = Listbox
        return Listbox
    end

    return Library
end
