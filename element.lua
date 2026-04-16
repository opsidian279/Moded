-- element.lua
-- Complete UI Elements for Obsidian Library

local Library = getgenv().Library or {}

-- Templates for UI Elements
local Templates = {
    --// UI \\-
    Frame = {
        BorderSizePixel = 0,
    },
    ImageLabel = {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
    },
    ImageButton = {
        AutoButtonColor = false,
        BorderSizePixel = 0,
    },
    ScrollingFrame = {
        BorderSizePixel = 0,
    },
    TextLabel = {
        BorderSizePixel = 0,
        FontFace = "Font",
        RichText = true,
        TextColor3 = "FontColor",
    },
    TextButton = {
        AutoButtonColor = false,
        BorderSizePixel = 0,
        FontFace = "Font",
        RichText = true,
        TextColor3 = "FontColor",
    },
    TextBox = {
        BorderSizePixel = 0,
        FontFace = "Font",
        PlaceholderColor3 = function()
            local H, S, V = Library.Scheme.FontColor:ToHSV()
            return Color3.fromHSV(H, S, V / 2)
        end,
        Text = "",
        TextColor3 = "FontColor",
    },
    UIListLayout = {
        SortOrder = Enum.SortOrder.LayoutOrder,
    },
    UIStroke = {
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    },

    --// Library \\--
    Window = {
        Title = "No Title",
        Footer = "No Footer",
        Position = UDim2.fromOffset(6, 6),
        Size = UDim2.fromOffset(720, 600),
        IconSize = UDim2.fromOffset(30, 30),
        AutoShow = true,
        Center = true,
        Resizable = true,
        SearchbarSize = UDim2.fromScale(1, 1),
        GlobalSearch = false,
        CornerRadius = 4,
        NotifySide = "Right",
        ShowCustomCursor = true,
        Font = Enum.Font.Code,
        ToggleKeybind = Enum.KeyCode.RightControl,
        MobileButtonsSide = "Left",
        UnlockMouseWhileOpen = true,

        EnableSidebarResize = false,
        EnableCompacting = true,
        DisableCompactingSnap = false,
        SidebarCompacted = false,
        MinContainerWidth = 256,

        MinSidebarWidth = 128,
        SidebarCompactWidth = 48,
        SidebarCollapseThreshold = 0.5,

        CompactWidthActivation = 128,
    },
    Dialog = {
        Title = "Dialog",
        Description = "Description",
        AutoDismiss = true,
        OutsideClickDismiss = true,
        FooterButtons = {}
    },
    Loading = {
        Title = "mspaint",
        Icon = 95816097006870,
        IconSize = UDim2.fromOffset(30, 30),

        LoadingIcon = Library.ImageManager and Library.ImageManager.GetAsset("LoadingIcon") or "",
        LoadingIconColor = nil,
        LoadingIconTweenTime = 1,

        CurrentStep = 0,
        TotalSteps = 10,

        ShowSidebar = false,

        WindowWidth = 450,
        WindowHeight = 275,

        ContentWidth = 450,
        SidebarWidth = 250,
    },
    Toggle = {
        Text = "Toggle",
        Default = false,

        Callback = function() end,
        Changed = function() end,

        Risky = false,
        Disabled = false,
        Visible = true,
    },
    Input = {
        Text = "Input",
        Default = "",
        Finished = false,
        Numeric = false,
        ClearTextOnFocus = true,
        ClearTextOnBlur = false,
        Placeholder = "",
        AllowEmpty = true,
        EmptyReset = "---",

        Callback = function() end,
        Changed = function() end,
        VerifyValue = nil,

        Disabled = false,
        Visible = true,
    },
    Slider = {
        Text = "Slider",
        Default = 0,
        Min = 0,
        Max = 100,
        Rounding = 0,

        Prefix = "",
        Suffix = "",

        Callback = function() end,
        Changed = function() end,

        Disabled = false,
        Visible = true,
    },
    Dropdown = {
        Values = {},
        DisabledValues = {},
        Multi = false,
        MaxVisibleDropdownItems = 8,

        Callback = function() end,
        Changed = function() end,

        Disabled = false,
        Visible = true,
    },
    Viewport = {
        Object = nil,
        Camera = nil,
        Clone = true,
        AutoFocus = true,
        Interactive = false,
        Height = 200,
        Visible = true,
    },
    Image = {
        Image = "",
        Transparency = 0,
        BackgroundTransparency = 0,
        Color = Color3.new(1, 1, 1),
        RectOffset = Vector2.zero,
        RectSize = Vector2.zero,
        ScaleType = Enum.ScaleType.Fit,
        Height = 200,
        Visible = true,
    },
    Video = {
        Video = "",
        Looped = false,
        Playing = false,
        Volume = 1,
        Height = 200,
        Visible = true,
    },
    UIPassthrough = {
        Instance = nil,
        Height = 24,
        Visible = true,
    },

    --// Addons \\-
    KeyPicker = {
        Text = "KeyPicker",

        Default = "None",
        DefaultModifiers = {},

        Blacklisted = {},
        BlacklistedModifiers = {},
        Whitelisted = {},
        WhitelistedModifiers = {},

        Mode = "Toggle",
        Modes = { "Always", "Toggle", "Hold" },
        SyncToggleState = false,

        Callback = function() end,
        ChangedCallback = function() end,
        Changed = function() end,
        Clicked = function() end,
    },
    ColorPicker = {
        Default = Color3.new(1, 1, 1),

        Callback = function() end,
        Changed = function() end,
    },
}

-- Base Addons Functions
local BaseAddons = {}
BaseAddons.__index = BaseAddons

function BaseAddons:AddKeyPicker(Idx, Info)
    Info = Library:Validate(Info, Templates.KeyPicker)

    local ParentObj = self
    local ToggleLabel = ParentObj.TextLabel

    local KeyPicker = {
        Text = Info.Text,
        Value = Info.Default,
        Modifiers = Info.DefaultModifiers,
        DisplayValue = Info.Default,

        Blacklisted = Info.Blacklisted,
        BlacklistedModifiers = Info.BlacklistedModifiers,
        Whitelisted = Info.Whitelisted,
        WhitelistedModifiers = Info.WhitelistedModifiers,

        Toggled = false,
        Mode = Info.Mode,
        SyncToggleState = Info.SyncToggleState,

        Callback = Info.Callback,
        ChangedCallback = Info.ChangedCallback,
        Changed = Info.Changed,
        Clicked = Info.Clicked,

        Type = "KeyPicker",
    }

    if KeyPicker.Mode == "Press" then
        assert(ParentObj.Type == "Label", "KeyPicker with the mode 'Press' can be only applied on Labels.")
        KeyPicker.SyncToggleState = false
        Info.Modes = { "Press" }
        Info.Mode = "Press"
    end

    if KeyPicker.SyncToggleState then
        Info.Modes = { "Toggle", "Hold" }
        if not table.find(Info.Modes, Info.Mode) then
            Info.Mode = "Toggle"
        end
    end

    local Picking = false

    local SpecialKeys = {
        ["MB1"] = Enum.UserInputType.MouseButton1,
        ["MB2"] = Enum.UserInputType.MouseButton2,
        ["MB3"] = Enum.UserInputType.MouseButton3,
    }

    local SpecialKeysInput = {
        [Enum.UserInputType.MouseButton1] = "MB1",
        [Enum.UserInputType.MouseButton2] = "MB2",
        [Enum.UserInputType.MouseButton3] = "MB3",
    }

    local Modifiers = {
        ["LAlt"] = Enum.KeyCode.LeftAlt,
        ["RAlt"] = Enum.KeyCode.RightAlt,
        ["LCtrl"] = Enum.KeyCode.LeftControl,
        ["RCtrl"] = Enum.KeyCode.RightControl,
        ["LShift"] = Enum.KeyCode.LeftShift,
        ["RShift"] = Enum.KeyCode.RightShift,
        ["Tab"] = Enum.KeyCode.Tab,
        ["CapsLock"] = Enum.KeyCode.CapsLock,
    }

    local ModifiersInput = {
        [Enum.KeyCode.LeftAlt] = "LAlt",
        [Enum.KeyCode.RightAlt] = "RAlt",
        [Enum.KeyCode.LeftControl] = "LCtrl",
        [Enum.KeyCode.RightControl] = "RCtrl",
        [Enum.KeyCode.LeftShift] = "LShift",
        [Enum.KeyCode.RightShift] = "RShift",
        [Enum.KeyCode.Tab] = "Tab",
        [Enum.KeyCode.CapsLock] = "CapsLock",
    }

    local IsModifierInput = function(Input)
        return Input.UserInputType == Enum.UserInputType.Keyboard and ModifiersInput[Input.KeyCode] ~= nil
    end

    local GetActiveModifiers = function()
        local ActiveModifiers = {}
        for Name, Input in Modifiers do
            if not table.find(ActiveModifiers, Name) and Library.UserInputService:IsKeyDown(Input) then
                table.insert(ActiveModifiers, Name)
            end
        end
        return ActiveModifiers
    end

    local AreModifiersHeld = function(Required)
        if not (typeof(Required) == "table" and #Required > 0) then
            return true
        end
        local ActiveModifiers = GetActiveModifiers()
        for _, Name in Required do
            if not table.find(ActiveModifiers, Name) then
                return false
            end
        end
        return true
    end

    local ConvertToInputModifiers = function(CurrentModifiers)
        local InputModifiers = {}
        for _, name in CurrentModifiers do
            table.insert(InputModifiers, Modifiers[name])
        end
        return InputModifiers
    end

    local VerifyModifiers = function(CurrentModifiers)
        if typeof(CurrentModifiers) ~= "table" then
            return {}
        end
        local ValidModifiers = {}
        for _, name in CurrentModifiers do
            if Modifiers[name] then
                table.insert(ValidModifiers, name)
            end
        end
        return ValidModifiers
    end

    KeyPicker.Modifiers = VerifyModifiers(KeyPicker.Modifiers)

    local Picker = Instance.new("TextButton")
    Picker.BackgroundColor3 = Library.Scheme.MainColor
    Picker.Size = UDim2.fromOffset(18, 18)
    Picker.Text = KeyPicker.Value
    Picker.TextSize = 14
    Picker.Parent = ToggleLabel

    local PickerStroke = Instance.new("UIStroke")
    PickerStroke.Color = Library.Scheme.OutlineColor
    PickerStroke.Parent = Picker

    local PickerCorner = Instance.new("UICorner")
    PickerCorner.CornerRadius = UDim.new(0, Library.CornerRadius / 2)
    PickerCorner.Parent = Picker

    local KeybindsToggle = { Normal = KeyPicker.Mode ~= "Toggle" }
    
    if not Info.NoUI and Library.KeybindContainer then
        local Holder = Instance.new("TextButton")
        Holder.BackgroundTransparency = 1
        Holder.Size = UDim2.new(1, 0, 0, 16)
        Holder.Text = ""
        Holder.Visible = true
        Holder.Parent = Library.KeybindContainer

        local Label = Instance.new("TextLabel")
        Label.AutomaticSize = Enum.AutomaticSize.X
        Label.BackgroundTransparency = 1
        Label.Size = UDim2.fromScale(0, 1)
        Label.Text = ""
        Label.TextSize = 14
        Label.TextTransparency = 0.5
        Label.Parent = Holder

        local Checkbox = Instance.new("Frame")
        Checkbox.AnchorPoint = Vector2.new(0, 0.5)
        Checkbox.BackgroundColor3 = Library.Scheme.MainColor
        Checkbox.Position = UDim2.fromScale(0, 0.5)
        Checkbox.Size = UDim2.fromOffset(14, 14)
        Checkbox.SizeConstraint = Enum.SizeConstraint.RelativeYY
        Checkbox.Parent = Holder

        local CheckboxCorner = Instance.new("UICorner")
        CheckboxCorner.CornerRadius = UDim.new(0, Library.CornerRadius / 2)
        CheckboxCorner.Parent = Checkbox

        local CheckboxStroke = Instance.new("UIStroke")
        CheckboxStroke.Color = Library.Scheme.OutlineColor
        CheckboxStroke.Parent = Checkbox

        local CheckIcon = Library:GetIcon("check")
        local CheckImage = Instance.new("ImageLabel")
        CheckImage.Image = CheckIcon and CheckIcon.Url or ""
        CheckImage.ImageColor3 = Library.Scheme.FontColor
        CheckImage.ImageRectOffset = CheckIcon and CheckIcon.ImageRectOffset or Vector2.zero
        CheckImage.ImageRectSize = CheckIcon and CheckIcon.ImageRectSize or Vector2.zero
        CheckImage.ImageTransparency = 1
        CheckImage.Position = UDim2.fromOffset(2, 2)
        CheckImage.Size = UDim2.new(1, -4, 1, -4)
        CheckImage.Parent = Checkbox

        function KeybindsToggle:Display(State)
            Label.TextTransparency = State and 0 or 0.5
            CheckImage.ImageTransparency = State and 0 or 1
        end

        function KeybindsToggle:SetText(Text)
            Label.Text = Text
        end

        function KeybindsToggle:SetVisibility(Visibility)
            Holder.Visible = Visibility
        end

        function KeybindsToggle:SetNormal(Normal)
            KeybindsToggle.Normal = Normal
            Holder.Active = not Normal
            Label.Position = Normal and UDim2.fromOffset(0, 0) or UDim2.fromOffset(22, 0)
            Checkbox.Visible = not Normal
        end

        KeybindsToggle.Holder = Holder
        KeybindsToggle.Label = Label
        KeybindsToggle.Checkbox = Checkbox
        KeybindsToggle.Loaded = true
        table.insert(Library.KeybindToggles, KeybindsToggle)
    end

    local MenuTable = Library:AddContextMenu(Picker, UDim2.fromOffset(62, 0), function()
        return { Picker.AbsoluteSize.X + 1.5, 0.5 }
    end, 1, nil, true)
    KeyPicker.Menu = MenuTable

    local ModeButtons = {}
    for _, Mode in Info.Modes do
        local ModeButton = {}
        local Button = Instance.new("TextButton")
        Button.BackgroundColor3 = Library.Scheme.MainColor
        Button.BackgroundTransparency = 1
        Button.Size = UDim2.new(1, 0, 0, 21)
        Button.Text = Mode
        Button.TextSize = 14
        Button.TextTransparency = 0.5
        Button.Parent = MenuTable.Menu

        function ModeButton:Select()
            for _, btn in ModeButtons do
                btn:Deselect()
            end
            KeyPicker.Mode = Mode
            Button.BackgroundTransparency = 0
            Button.TextTransparency = 0
            MenuTable:Close()
        end

        function ModeButton:Deselect()
            KeyPicker.Mode = nil
            Button.BackgroundTransparency = 1
            Button.TextTransparency = 0.5
        end

        Button.MouseButton1Click:Connect(function()
            ModeButton:Select()
        end)

        if KeyPicker.Mode == Mode then
            ModeButton:Select()
        end

        ModeButtons[Mode] = ModeButton
    end

    function KeyPicker:Display(PickerText)
        if Library.Unloaded then return end
        local X, Y = Library:GetTextBounds(PickerText or KeyPicker.DisplayValue, Picker.FontFace, Picker.TextSize, ToggleLabel.AbsoluteSize.X)
        Picker.Text = PickerText or KeyPicker.DisplayValue
        Picker.Size = UDim2.fromOffset((X + 9), (Y + 4))
    end

    function KeyPicker:Update()
        KeyPicker:Display()
        if Info.NoUI then return end

        if KeyPicker.Mode == "Toggle" and ParentObj.Type == "Toggle" and ParentObj.Disabled then
            KeybindsToggle:SetVisibility(false)
            return
        end

        local State = KeyPicker:GetState()
        local ShowToggle = Library.ShowToggleFrameInKeybinds and KeyPicker.Mode == "Toggle"

        if KeyPicker.SyncToggleState and ParentObj.Value ~= State then
            ParentObj:SetValue(State)
        end

        if KeybindsToggle.Loaded then
            if ShowToggle then
                KeybindsToggle:SetNormal(false)
            else
                KeybindsToggle:SetNormal(true)
            end
            KeybindsToggle:SetText(("[%s] %s (%s)"):format(KeyPicker.DisplayValue, KeyPicker.Text, KeyPicker.Mode))
            KeybindsToggle:SetVisibility(true)
            KeybindsToggle:Display(State)
        end
    end

    function KeyPicker:GetState()
        if KeyPicker.Mode == "Always" then
            return true
        elseif KeyPicker.Mode == "Hold" then
            local Key = KeyPicker.Value
            if Key == "None" then return false end
            if not AreModifiersHeld(KeyPicker.Modifiers) then return false end
            if SpecialKeys[Key] ~= nil then
                return Library.UserInputService:IsMouseButtonPressed(SpecialKeys[Key]) and not Library.UserInputService:GetFocusedTextBox()
            else
                return Library.UserInputService:IsKeyDown(Enum.KeyCode[Key]) and not Library.UserInputService:GetFocusedTextBox()
            end
        else
            return KeyPicker.Toggled
        end
    end

    function KeyPicker:OnChanged(Func)
        KeyPicker.Changed = Func
    end

    function KeyPicker:OnClick(Func)
        KeyPicker.Clicked = Func
    end

    function KeyPicker:DoClick()
        if KeyPicker.Mode == "Press" then
            if KeyPicker.Toggled and Info.WaitForCallback == true then
                return
            end
            KeyPicker.Toggled = true
        end
        Library:SafeCallback(KeyPicker.Callback, KeyPicker.Toggled)
        Library:SafeCallback(KeyPicker.Clicked, KeyPicker.Toggled)
        if KeyPicker.Mode == "Press" then
            KeyPicker.Toggled = false
        end
    end

    function KeyPicker:SetValue(Data)
        local Key, Mode, Modifiers = Data[1], Data[2], Data[3]

        local IsKeyValid, KeyCode = pcall(function()
            if Key == "None" then return nil end
            if SpecialKeys[Key] == nil then
                return Enum.KeyCode[Key]
            end
            return SpecialKeys[Key]
        end)

        if Key == nil then
            KeyPicker.Value = "None"
        elseif IsKeyValid then
            KeyPicker.Value = Key
        else
            KeyPicker.Value = "Unknown"
        end

        KeyPicker.Modifiers = VerifyModifiers(if typeof(Modifiers) == "table" then Modifiers else KeyPicker.Modifiers)
        KeyPicker.DisplayValue = if #KeyPicker.Modifiers > 0
            then (table.concat(KeyPicker.Modifiers, " + ") .. " + " .. KeyPicker.Value)
            else KeyPicker.Value

        if ModeButtons[Mode] then
            ModeButtons[Mode]:Select()
        end

        local NewModifiers = ConvertToInputModifiers(KeyPicker.Modifiers)
        Library:SafeCallback(KeyPicker.ChangedCallback, KeyCode, NewModifiers)
        Library:SafeCallback(KeyPicker.Changed, KeyCode, NewModifiers)
        KeyPicker:Update()
    end

    function KeyPicker:SetText(Text)
        if KeybindsToggle then
            KeybindsToggle:SetText(Text)
        end
        KeyPicker:Update()
    end

    Picker.MouseButton1Click:Connect(function()
        if Picking then return end
        Picking = true
        Picker.Text = "..."
        Picker.Size = UDim2.fromOffset(29, 18)

        local Input
        local ActiveModifiers = {}

        local GetInput = nil
        GetInput = function()
            Input = Library.UserInputService.InputBegan:Wait()
            if Library.UserInputService:GetFocusedTextBox() ~= nil then
                return true
            end
            if Input.KeyCode == Enum.KeyCode.Escape then
                return false
            end

            local IsMod = IsModifierInput(Input)
            local KeyName
            if SpecialKeysInput[Input.UserInputType] ~= nil then
                KeyName = SpecialKeysInput[Input.UserInputType]
            elseif Input.UserInputType == Enum.UserInputType.Keyboard then
                if IsMod then
                    KeyName = ModifiersInput[Input.KeyCode]
                else
                    KeyName = Input.KeyCode.Name
                end
            end

            if KeyName then
                if IsMod then
                    if KeyPicker.WhitelistedModifiers and #KeyPicker.WhitelistedModifiers > 0 and not table.find(KeyPicker.WhitelistedModifiers, KeyName) then
                        return GetInput()
                    end
                    if KeyPicker.BlacklistedModifiers and table.find(KeyPicker.BlacklistedModifiers, KeyName) then
                        return GetInput()
                    end
                else
                    if KeyPicker.Whitelisted and #KeyPicker.Whitelisted > 0 and not table.find(KeyPicker.Whitelisted, KeyName) then
                        return GetInput()
                    end
                    if KeyPicker.Blacklisted and table.find(KeyPicker.Blacklisted, KeyName) then
                        return GetInput()
                    end
                end
            end
            return false
        end

        repeat
            task.wait()
            Picker.Text = "..."
            Picker.Size = UDim2.fromOffset(29, 18)

            if GetInput() then
                Picking = false
                KeyPicker:Update()
                return
            end

            if Input.KeyCode == Enum.KeyCode.Escape then
                break
            end

            if IsModifierInput(Input) then
                local StopLoop = false
                repeat
                    task.wait()
                    if Library.UserInputService:IsKeyDown(Input.KeyCode) then
                        task.wait(0.075)
                        if Library.UserInputService:IsKeyDown(Input.KeyCode) then
                            if not table.find(ActiveModifiers, ModifiersInput[Input.KeyCode]) then
                                table.insert(ActiveModifiers, ModifiersInput[Input.KeyCode])
                                KeyPicker:Display(table.concat(ActiveModifiers, " + ") .. " + ...")
                            end
                            if GetInput() then
                                StopLoop = true
                                break
                            end
                            if Input.KeyCode == Enum.KeyCode.Escape then
                                break
                            end
                            if not IsModifierInput(Input) then
                                break
                            end
                        else
                            if not table.find(ActiveModifiers, ModifiersInput[Input.KeyCode]) then
                                break
                            end
                        end
                    end
                until false
                if StopLoop then
                    Picking = false
                    KeyPicker:Update()
                    return
                end
            end
            break
        until false

        local Key = "Unknown"
        if SpecialKeysInput[Input.UserInputType] ~= nil then
            Key = SpecialKeysInput[Input.UserInputType]
        elseif Input.UserInputType == Enum.UserInputType.Keyboard then
            Key = Input.KeyCode == Enum.KeyCode.Escape and "None" or Input.KeyCode.Name
        end

        ActiveModifiers = if Input.KeyCode == Enum.KeyCode.Escape or Key == "Unknown" then {} else ActiveModifiers

        KeyPicker.Toggled = false
        KeyPicker:SetValue({ Key, KeyPicker.Mode, ActiveModifiers })

        repeat
            task.wait()
        until not (function()
            if not Input then return false end
            if SpecialKeysInput[Input.UserInputType] ~= nil then
                return Library.UserInputService:IsMouseButtonPressed(Input.UserInputType) and not Library.UserInputService:GetFocusedTextBox()
            elseif Input.UserInputType == Enum.UserInputType.Keyboard then
                return Library.UserInputService:IsKeyDown(Input.KeyCode) and not Library.UserInputService:GetFocusedTextBox()
            else
                return false
            end
        end)() or Library.UserInputService:GetFocusedTextBox()
        Picking = false
    end)

    Picker.MouseButton2Click:Connect(MenuTable.Toggle)

    Library:GiveSignal(Library.UserInputService.InputBegan:Connect(function(Input)
        if Library.Unloaded then return end
        if KeyPicker.Mode == "Always" or KeyPicker.Value == "Unknown" or KeyPicker.Value == "None" or Picking or Library.UserInputService:GetFocusedTextBox() then
            return
        end

        local Key = KeyPicker.Value
        local HoldingModifiers = AreModifiersHeld(KeyPicker.Modifiers)
        local HoldingKey = false

        if Key and HoldingModifiers == true and (
            SpecialKeysInput[Input.UserInputType] == Key or
            (Input.UserInputType == Enum.UserInputType.Keyboard and Input.KeyCode.Name == Key)
        ) then
            HoldingKey = true
        end

        if KeyPicker.Mode == "Toggle" then
            if HoldingKey then
                KeyPicker.Toggled = not KeyPicker.Toggled
                KeyPicker:DoClick()
            end
        elseif KeyPicker.Mode == "Press" then
            if HoldingKey then
                KeyPicker:DoClick()
            end
        end
        KeyPicker:Update()
    end))

    Library:GiveSignal(Library.UserInputService.InputEnded:Connect(function()
        if Library.Unloaded then return end
        if KeyPicker.Value == "Unknown" or KeyPicker.Value == "None" or Picking or Library.UserInputService:GetFocusedTextBox() then
            return
        end
        KeyPicker:Update()
    end))

    KeyPicker:Update()

    if ParentObj.Addons then
        table.insert(ParentObj.Addons, KeyPicker)
    end

    KeyPicker.Default = KeyPicker.Value
    KeyPicker.DefaultModifiers = table.clone(KeyPicker.Modifiers or {})

    Library.Options[Idx] = KeyPicker
    return self
end

local HueSequenceTable = {}
for Hue = 0, 1, 0.1 do
    table.insert(HueSequenceTable, ColorSequenceKeypoint.new(Hue, Color3.fromHSV(Hue, 1, 1)))
end

function BaseAddons:AddColorPicker(Idx, Info)
    Info = Library:Validate(Info, Templates.ColorPicker)

    local ParentObj = self
    local ToggleLabel = ParentObj.TextLabel

    local ColorPicker = {
        Value = Info.Default,
        Transparency = Info.Transparency or 0,
        Title = Info.Title,
        Callback = Info.Callback,
        Changed = Info.Changed,
        Type = "ColorPicker",
    }
    ColorPicker.Hue, ColorPicker.Sat, ColorPicker.Vib = ColorPicker.Value:ToHSV()

    local Holder = Instance.new("TextButton")
    Holder.BackgroundColor3 = ColorPicker.Value
    Holder.Size = UDim2.fromOffset(18, 18)
    Holder.Text = ""
    Holder.Parent = ToggleLabel

    local HolderStroke = Instance.new("UIStroke")
    HolderStroke.Color = Library:GetDarkerColor(ColorPicker.Value)
    HolderStroke.Parent = Holder

    local HolderCorner = Instance.new("UICorner")
    HolderCorner.CornerRadius = UDim.new(0, Library.CornerRadius / 2)
    HolderCorner.Parent = Holder

    local HolderTransparency = Instance.new("ImageLabel")
    HolderTransparency.Image = Library.ImageManager.GetAsset("TransparencyTexture")
    HolderTransparency.ImageTransparency = (1 - ColorPicker.Transparency)
    HolderTransparency.ScaleType = Enum.ScaleType.Tile
    HolderTransparency.Position = UDim2.new(0, -1, 0, -1)
    HolderTransparency.Size = UDim2.new(1, 2, 1, 2)
    HolderTransparency.TileSize = UDim2.fromOffset(9, 9)
    HolderTransparency.Parent = Holder

    local HolderTransparencyCorner = Instance.new("UICorner")
    HolderTransparencyCorner.CornerRadius = UDim.new(0, Library.CornerRadius / 2)
    HolderTransparencyCorner.Parent = HolderTransparency

    local ColorMenu = Library:AddContextMenu(Holder, UDim2.fromOffset(Info.Transparency and 256 or 234, 0), function()
        return { 0.5, Holder.AbsoluteSize.Y + 1.5 }
    end, 1)
    ColorMenu.List.Padding = UDim.new(0, 8)
    ColorPicker.ColorMenu = ColorMenu

    local MenuPadding = Instance.new("UIPadding")
    MenuPadding.PaddingBottom = UDim.new(0, 6)
    MenuPadding.PaddingLeft = UDim.new(0, 6)
    MenuPadding.PaddingRight = UDim.new(0, 6)
    MenuPadding.PaddingTop = UDim.new(0, 6)
    MenuPadding.Parent = ColorMenu.Menu

    if typeof(ColorPicker.Title) == "string" then
        local TitleLabel = Instance.new("TextLabel")
        TitleLabel.BackgroundTransparency = 1
        TitleLabel.Size = UDim2.new(1, 0, 0, 8)
        TitleLabel.Text = ColorPicker.Title
        TitleLabel.TextSize = 14
        TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
        TitleLabel.Parent = ColorMenu.Menu
    end

    local ColorHolder = Instance.new("Frame")
    ColorHolder.BackgroundTransparency = 1
    ColorHolder.Size = UDim2.new(1, 0, 0, 200)
    ColorHolder.Parent = ColorMenu.Menu

    local ColorHolderLayout = Instance.new("UIListLayout")
    ColorHolderLayout.FillDirection = Enum.FillDirection.Horizontal
    ColorHolderLayout.Padding = UDim.new(0, 6)
    ColorHolderLayout.Parent = ColorHolder

    local SatVipMap = Instance.new("ImageButton")
    SatVipMap.BackgroundColor3 = ColorPicker.Value
    SatVipMap.Image = Library.ImageManager.GetAsset("SaturationMap")
    SatVipMap.Size = UDim2.fromOffset(200, 200)
    SatVipMap.Parent = ColorHolder

    local SatVibCursor = Instance.new("Frame")
    SatVibCursor.AnchorPoint = Vector2.new(0.5, 0.5)
    SatVibCursor.BackgroundColor3 = Library.Scheme.WhiteColor
    SatVibCursor.Size = UDim2.fromOffset(6, 6)
    SatVibCursor.Parent = SatVipMap

    local SatVibCursorCorner = Instance.new("UICorner")
    SatVibCursorCorner.CornerRadius = UDim.new(1, 0)
    SatVibCursorCorner.Parent = SatVibCursor

    local SatVibCursorStroke = Instance.new("UIStroke")
    SatVibCursorStroke.Color = Library.Scheme.DarkColor
    SatVibCursorStroke.Parent = SatVibCursor

    local HueSelector = Instance.new("TextButton")
    HueSelector.Size = UDim2.fromOffset(16, 200)
    HueSelector.Text = ""
    HueSelector.Parent = ColorHolder

    local HueGradient = Instance.new("UIGradient")
    HueGradient.Color = ColorSequence.new(HueSequenceTable)
    HueGradient.Rotation = 90
    HueGradient.Parent = HueSelector

    local HueCursor = Instance.new("Frame")
    HueCursor.AnchorPoint = Vector2.new(0.5, 0.5)
    HueCursor.BackgroundColor3 = Library.Scheme.WhiteColor
    HueCursor.BorderColor3 = Library.Scheme.DarkColor
    HueCursor.BorderSizePixel = 1
    HueCursor.Position = UDim2.fromScale(0.5, ColorPicker.Hue)
    HueCursor.Size = UDim2.new(1, 2, 0, 1)
    HueCursor.Parent = HueSelector

    local TransparencySelector, TransparencyColor, TransparencyCursor
    if Info.Transparency then
        TransparencySelector = Instance.new("ImageButton")
        TransparencySelector.Image = Library.ImageManager.GetAsset("TransparencyTexture")
        TransparencySelector.ScaleType = Enum.ScaleType.Tile
        TransparencySelector.Size = UDim2.fromOffset(16, 200)
        TransparencySelector.TileSize = UDim2.fromOffset(8, 8)
        TransparencySelector.Parent = ColorHolder

        TransparencyColor = Instance.new("Frame")
        TransparencyColor.BackgroundColor3 = ColorPicker.Value
        TransparencyColor.Size = UDim2.fromScale(1, 1)
        TransparencyColor.Parent = TransparencySelector

        local TransparencyGradient = Instance.new("UIGradient")
        TransparencyGradient.Rotation = 90
        TransparencyGradient.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(1, 1),
        })
        TransparencyGradient.Parent = TransparencyColor

        TransparencyCursor = Instance.new("Frame")
        TransparencyCursor.AnchorPoint = Vector2.new(0.5, 0.5)
        TransparencyCursor.BackgroundColor3 = Library.Scheme.WhiteColor
        TransparencyCursor.BorderColor3 = Library.Scheme.DarkColor
        TransparencyCursor.BorderSizePixel = 1
        TransparencyCursor.Position = UDim2.fromScale(0.5, ColorPicker.Transparency)
        TransparencyCursor.Size = UDim2.new(1, 2, 0, 1)
        TransparencyCursor.Parent = TransparencySelector
    end

    local InfoHolder = Instance.new("Frame")
    InfoHolder.BackgroundTransparency = 1
    InfoHolder.Size = UDim2.new(1, 0, 0, 20)
    InfoHolder.Parent = ColorMenu.Menu

    local InfoHolderLayout = Instance.new("UIListLayout")
    InfoHolderLayout.FillDirection = Enum.FillDirection.Horizontal
    InfoHolderLayout.HorizontalFlex = Enum.UIFlexAlignment.Fill
    InfoHolderLayout.Padding = UDim.new(0, 8)
    InfoHolderLayout.Parent = InfoHolder

    local HueBox = Instance.new("TextBox")
    HueBox.BackgroundColor3 = Library.Scheme.MainColor
    HueBox.ClearTextOnFocus = false
    HueBox.Size = UDim2.fromScale(1, 1)
    HueBox.Text = "#??????"
    HueBox.TextSize = 14
    HueBox.Parent = InfoHolder

    local HueBoxStroke = Instance.new("UIStroke")
    HueBoxStroke.Color = Library.Scheme.OutlineColor
    HueBoxStroke.Parent = HueBox

    local HueBoxCorner = Instance.new("UICorner")
    HueBoxCorner.CornerRadius = UDim.new(0, Library.CornerRadius / 2)
    HueBoxCorner.Parent = HueBox

    local RgbBox = Instance.new("TextBox")
    RgbBox.BackgroundColor3 = Library.Scheme.MainColor
    RgbBox.ClearTextOnFocus = false
    RgbBox.Size = UDim2.fromScale(1, 1)
    RgbBox.Text = "?, ?, ?"
    RgbBox.TextSize = 14
    RgbBox.Parent = InfoHolder

    local RgbBoxStroke = Instance.new("UIStroke")
    RgbBoxStroke.Color = Library.Scheme.OutlineColor
    RgbBoxStroke.Parent = RgbBox

    local RgbBoxCorner = Instance.new("UICorner")
    RgbBoxCorner.CornerRadius = UDim.new(0, Library.CornerRadius / 2)
    RgbBoxCorner.Parent = RgbBox

    local ContextMenu = Library:AddContextMenu(Holder, UDim2.fromOffset(93, 0), function()
        return { Holder.AbsoluteSize.X + 1.5, 0.5 }
    end, 1)
    ColorPicker.ContextMenu = ContextMenu
    ContextMenu.List.Padding = UDim.new(0, 6)

    local function CreateButton(Text, Func)
        local Button = Instance.new("TextButton")
        Button.BackgroundTransparency = 1
        Button.Size = UDim2.new(1, 0, 0, 21)
        Button.Text = Text
        Button.TextSize = 14
        Button.Parent = ContextMenu.Menu

        Button.MouseButton1Click:Connect(function()
            Library:SafeCallback(Func)
            ContextMenu:Close()
        end)
    end

    CreateButton("Copy color", function()
        Library.CopiedColor = { ColorPicker.Value, ColorPicker.Transparency }
    end)

    CreateButton("Paste color", function()
        if Library.CopiedColor then
            ColorPicker:SetValueRGB(Library.CopiedColor[1], Library.CopiedColor[2])
        end
    end)

    if setclipboard then
        CreateButton("Copy Hex", function()
            setclipboard(tostring(ColorPicker.Value:ToHex()))
        end)
        CreateButton("Copy RGB", function()
            setclipboard(table.join({
                math.floor(ColorPicker.Value.R * 255),
                math.floor(ColorPicker.Value.G * 255),
                math.floor(ColorPicker.Value.B * 255),
            }, ", "))
        end)
    end

    function ColorPicker:SetHSVFromRGB(Color)
        ColorPicker.Hue, ColorPicker.Sat, ColorPicker.Vib = Color:ToHSV()
    end

    function ColorPicker:Display()
        if Library.Unloaded then return end
        ColorPicker.Value = Color3.fromHSV(ColorPicker.Hue, ColorPicker.Sat, ColorPicker.Vib)

        Holder.BackgroundColor3 = ColorPicker.Value
        HolderStroke.Color = Library:GetDarkerColor(ColorPicker.Value)
        HolderTransparency.ImageTransparency = (1 - ColorPicker.Transparency)

        SatVipMap.BackgroundColor3 = Color3.fromHSV(ColorPicker.Hue, 1, 1)
        if TransparencyColor then
            TransparencyColor.BackgroundColor3 = ColorPicker.Value
        end

        SatVibCursor.Position = UDim2.fromScale(ColorPicker.Sat, 1 - ColorPicker.Vib)
        HueCursor.Position = UDim2.fromScale(0.5, ColorPicker.Hue)
        if TransparencyCursor then
            TransparencyCursor.Position = UDim2.fromScale(0.5, ColorPicker.Transparency)
        end

        HueBox.Text = "#" .. ColorPicker.Value:ToHex()
        RgbBox.Text = table.join({
            math.floor(ColorPicker.Value.R * 255),
            math.floor(ColorPicker.Value.G * 255),
            math.floor(ColorPicker.Value.B * 255),
        }, ", ")
    end

    function ColorPicker:Update()
        ColorPicker:Display()
        Library:SafeCallback(ColorPicker.Callback, ColorPicker.Value)
        Library:SafeCallback(ColorPicker.Changed, ColorPicker.Value)
    end

    function ColorPicker:OnChanged(Func)
        ColorPicker.Changed = Func
    end

    function ColorPicker:SetValue(HSV, Transparency)
        if typeof(HSV) == "Color3" then
            ColorPicker:SetValueRGB(HSV, Transparency)
            return
        end
        local Color = Color3.fromHSV(HSV[1], HSV[2], HSV[3])
        ColorPicker.Transparency = Info.Transparency and Transparency or 0
        ColorPicker:SetHSVFromRGB(Color)
        ColorPicker:Update()
    end

    function ColorPicker:SetValueRGB(Color, Transparency)
        ColorPicker.Transparency = Info.Transparency and Transparency or 0
        ColorPicker:SetHSVFromRGB(Color)
        ColorPicker:Update()
    end

    Holder.MouseButton1Click:Connect(ColorMenu.Toggle)
    Holder.MouseButton2Click:Connect(ContextMenu.Toggle)

    SatVipMap.InputBegan:Connect(function(Input)
        while Library.IsDragInput(Input) do
            local MinX = SatVipMap.AbsolutePosition.X
            local MaxX = MinX + SatVipMap.AbsoluteSize.X
            local LocationX = math.clamp(Library.Mouse.X, MinX, MaxX)

            local MinY = SatVipMap.AbsolutePosition.Y
            local MaxY = MinY + SatVipMap.AbsoluteSize.Y
            local LocationY = math.clamp(Library.Mouse.Y, MinY, MaxY)

            local OldSat = ColorPicker.Sat
            local OldVib = ColorPicker.Vib
            ColorPicker.Sat = (LocationX - MinX) / (MaxX - MinX)
            ColorPicker.Vib = 1 - ((LocationY - MinY) / (MaxY - MinY))

            if ColorPicker.Sat ~= OldSat or ColorPicker.Vib ~= OldVib then
                ColorPicker:Update()
            end
            Library.RunService.RenderStepped:Wait()
        end
    end)

    HueSelector.InputBegan:Connect(function(Input)
        while Library.IsDragInput(Input) do
            local Min = HueSelector.AbsolutePosition.Y
            local Max = Min + HueSelector.AbsoluteSize.Y
            local Location = math.clamp(Library.Mouse.Y, Min, Max)

            local OldHue = ColorPicker.Hue
            ColorPicker.Hue = (Location - Min) / (Max - Min)

            if ColorPicker.Hue ~= OldHue then
                ColorPicker:Update()
            end
            Library.RunService.RenderStepped:Wait()
        end
    end)

    if TransparencySelector then
        TransparencySelector.InputBegan:Connect(function(Input)
            while Library.IsDragInput(Input) do
                local Min = TransparencySelector.AbsolutePosition.Y
                local Max = Min + TransparencySelector.AbsoluteSize.Y
                local Location = math.clamp(Library.Mouse.Y, Min, Max)

                local OldTransparency = ColorPicker.Transparency
                ColorPicker.Transparency = (Location - Min) / (Max - Min)

                if ColorPicker.Transparency ~= OldTransparency then
                    ColorPicker:Update()
                end
                Library.RunService.RenderStepped:Wait()
            end
        end)
    end

    HueBox.FocusLost:Connect(function(Enter)
        if not Enter then return end
        local Success, Color = pcall(Color3.fromHex, HueBox.Text)
        if Success and typeof(Color) == "Color3" then
            ColorPicker.Hue, ColorPicker.Sat, ColorPicker.Vib = Color:ToHSV()
        end
        ColorPicker:Update()
    end)

    RgbBox.FocusLost:Connect(function(Enter)
        if not Enter then return end
        local R, G, B = RgbBox.Text:match("(%d+),%s*(%d+),%s*(%d+)")
        if R and G and B then
            ColorPicker:SetHSVFromRGB(Color3.fromRGB(R, G, B))
        end
        ColorPicker:Update()
    end)

    ColorPicker:Display()

    if ParentObj.Addons then
        table.insert(ParentObj.Addons, ColorPicker)
    end

    ColorPicker.Default = ColorPicker.Value
    Library.Options[Idx] = ColorPicker
    return self
end

-- Base Groupbox Functions
local BaseGroupbox = {}
BaseGroupbox.__index = BaseGroupbox

function BaseGroupbox:AddDivider(...)
    local Params = select(1, ...)
    local Text
    local MarginTop = 0
    local MarginBottom = 0

    if typeof(Params) == "table" then
        Text = Params.Text
        MarginTop = Params.MarginTop or Params.Margin or 0
        MarginBottom = Params.MarginBottom or Params.Margin or 0
    elseif typeof(Params) == "string" then
        Text = Params
    end

    local Groupbox = self
    local Container = Groupbox.Container

    local Holder = Instance.new("Frame")
    Holder.BackgroundTransparency = 1
    Holder.Size = UDim2.new(1, 0, 0, 6 + MarginTop + MarginBottom)
    Holder.Parent = Container

    local InnerHolder = Instance.new("Frame")
    InnerHolder.BackgroundTransparency = 1
    InnerHolder.Size = UDim2.new(1, 0, 1, 0)
    InnerHolder.Parent = Holder

    local Padding = Instance.new("UIPadding")
    Padding.PaddingTop = UDim.new(0, MarginTop)
    Padding.PaddingBottom = UDim.new(0, MarginBottom)
    Padding.Parent = Holder

    if Text then
        local TextLabel = Instance.new("TextLabel")
        TextLabel.AutomaticSize = Enum.AutomaticSize.X
        TextLabel.BackgroundTransparency = 1
        TextLabel.Size = UDim2.fromScale(1, 0)
        TextLabel.Text = Text
        TextLabel.TextSize = 14
        TextLabel.TextTransparency = 0.5
        TextLabel.TextXAlignment = Enum.TextXAlignment.Center
        TextLabel.Parent = InnerHolder

        local X, _ = Library:GetTextBounds(Text, TextLabel.FontFace, TextLabel.TextSize, TextLabel.AbsoluteSize.X)
        local SizeX = X // 2 + 10

        local LeftLine = Instance.new("Frame")
        LeftLine.AnchorPoint = Vector2.new(0, 0.5)
        LeftLine.BackgroundColor3 = Library.Scheme.MainColor
        LeftLine.BorderColor3 = Library.Scheme.OutlineColor
        LeftLine.BorderSizePixel = 1
        LeftLine.Position = UDim2.fromScale(0, 0.5)
        LeftLine.Size = UDim2.new(0.5, -SizeX, 0, 2)
        LeftLine.Parent = InnerHolder

        local RightLine = Instance.new("Frame")
        RightLine.AnchorPoint = Vector2.new(1, 0.5)
        RightLine.BackgroundColor3 = Library.Scheme.MainColor
        RightLine.BorderColor3 = Library.Scheme.OutlineColor
        RightLine.BorderSizePixel = 1
        RightLine.Position = UDim2.fromScale(1, 0.5)
        RightLine.Size = UDim2.new(0.5, -SizeX, 0, 2)
        RightLine.Parent = InnerHolder
    else
        local CenterLine = Instance.new("Frame")
        CenterLine.AnchorPoint = Vector2.new(0, 0.5)
        CenterLine.BackgroundColor3 = Library.Scheme.MainColor
        CenterLine.BorderColor3 = Library.Scheme.OutlineColor
        CenterLine.BorderSizePixel = 1
        CenterLine.Position = UDim2.fromScale(0, 0.5)
        CenterLine.Size = UDim2.new(1, 0, 0, 2)
        CenterLine.Parent = InnerHolder
    end

    Groupbox:Resize()
    table.insert(Groupbox.Elements, {
        Holder = Holder,
        Type = "Divider",
    })
end

function BaseGroupbox:AddLabel(...)
    local Data = {}
    local Addons = {}

    local First = select(1, ...)
    local Second = select(2, ...)

    if typeof(First) == "table" or typeof(Second) == "table" then
        local Params = typeof(First) == "table" and First or Second
        Data.Text = Params.Text or ""
        Data.DoesWrap = Params.DoesWrap or false
        Data.Size = Params.Size or 14
        Data.Visible = Params.Visible or true
        Data.Idx = typeof(Second) == "table" and First or nil
    else
        Data.Text = First or ""
        Data.DoesWrap = Second or false
        Data.Size = 14
        Data.Visible = true
        Data.Idx = select(3, ...) or nil
    end

    local Groupbox = self
    local Container = Groupbox.Container

    local Label = {
        Text = Data.Text,
        DoesWrap = Data.DoesWrap,
        Addons = Addons,
        Visible = Data.Visible,
        Type = "Label",
    }

    local TextLabel = Instance.new("TextLabel")
    TextLabel.BackgroundTransparency = 1
    TextLabel.Size = UDim2.new(1, 0, 0, 18)
    TextLabel.Text = Label.Text
    TextLabel.TextSize = Data.Size
    TextLabel.TextWrapped = Label.DoesWrap
    TextLabel.TextXAlignment = Groupbox.IsKeyTab and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left
    TextLabel.Parent = Container

    function Label:SetVisible(Visible)
        Label.Visible = Visible
        TextLabel.Visible = Label.Visible
        Groupbox:Resize()
    end

    function Label:SetText(Text)
        Label.Text = Text
        TextLabel.Text = Text
        if Label.DoesWrap then
            local _, Y = Library:GetTextBounds(Label.Text, TextLabel.FontFace, TextLabel.TextSize, TextLabel.AbsoluteSize.X)
            TextLabel.Size = UDim2.new(1, 0, 0, Y + 4)
        end
        Groupbox:Resize()
    end

    if Label.DoesWrap then
        local _, Y = Library:GetTextBounds(Label.Text, TextLabel.FontFace, TextLabel.TextSize, TextLabel.AbsoluteSize.X)
        TextLabel.Size = UDim2.new(1, 0, 0, Y + 4)
        local Last = TextLabel.AbsoluteSize
        TextLabel:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
            if TextLabel.AbsoluteSize == Last then return end
            local _, Y = Library:GetTextBounds(Label.Text, TextLabel.FontFace, TextLabel.TextSize, TextLabel.AbsoluteSize.X)
            TextLabel.Size = UDim2.new(1, 0, 0, Y + 4)
            Last = TextLabel.AbsoluteSize
            Groupbox:Resize()
        end)
    else
        local Layout = Instance.new("UIListLayout")
        Layout.FillDirection = Enum.FillDirection.Horizontal
        Layout.HorizontalAlignment = Enum.HorizontalAlignment.Right
        Layout.Padding = UDim.new(0, 6)
        Layout.Parent = TextLabel
    end

    Groupbox:Resize()
    Label.TextLabel = TextLabel
    Label.Container = Container
    setmetatable(Label, BaseAddons)
    Label.Holder = TextLabel
    table.insert(Groupbox.Elements, Label)

    if Data.Idx then
        Library.Labels[Data.Idx] = Label
    else
        table.insert(Library.Labels, Label)
    end
    return Label
end

function BaseGroupbox:AddButton(...)
    local function GetInfo(...)
        local Info = {}
        local First = select(1, ...)
        local Second = select(2, ...)

        if typeof(First) == "table" or typeof(Second) == "table" then
            local Params = typeof(First) == "table" and First or Second
            Info.Text = Params.Text or ""
            Info.Func = Params.Func or Params.Callback or function() end
            Info.DoubleClick = Params.DoubleClick
            Info.Tooltip = Params.Tooltip
            Info.DisabledTooltip = Params.DisabledTooltip
            Info.Risky = Params.Risky or false
            Info.Disabled = Params.Disabled or false
            Info.Visible = Params.Visible or true
            Info.Idx = typeof(Second) == "table" and First or nil
        else
            Info.Text = First or ""
            Info.Func = Second or function() end
            Info.DoubleClick = false
            Info.Tooltip = nil
            Info.DisabledTooltip = nil
            Info.Risky = false
            Info.Disabled = false
            Info.Visible = true
            Info.Idx = select(3, ...) or nil
        end
        return Info
    end

    local Info = GetInfo(...)
    local Groupbox = self
    local Container = Groupbox.Container

    local Button = {
        Text = Info.Text,
        Func = Info.Func,
        DoubleClick = Info.DoubleClick,
        Tooltip = Info.Tooltip,
        DisabledTooltip = Info.DisabledTooltip,
        TooltipTable = nil,
        Risky = Info.Risky,
        Disabled = Info.Disabled,
        Visible = Info.Visible,
        Tween = nil,
        Type = "Button",
    }

    local Holder = Instance.new("Frame")
    Holder.BackgroundTransparency = 1
    Holder.Size = UDim2.new(1, 0, 0, 21)
    Holder.Parent = Container

    local HolderLayout = Instance.new("UIListLayout")
    HolderLayout.FillDirection = Enum.FillDirection.Horizontal
    HolderLayout.HorizontalFlex = Enum.UIFlexAlignment.Fill
    HolderLayout.Padding = UDim.new(0, 9)
    HolderLayout.Parent = Holder

    local function CreateButton(Button)
        local Base = Instance.new("TextButton")
        Base.Active = not Button.Disabled
        Base.BackgroundColor3 = Button.Disabled and "BackgroundColor" or "MainColor"
        Base.Size = UDim2.fromScale(1, 1)
        Base.Text = Button.Text
        Base.TextSize = 14
        Base.TextTransparency = 0.4
        Base.Visible = Button.Visible
        Base.Parent = Holder

        local Stroke = Instance.new("UIStroke")
        Stroke.Color = "OutlineColor"
        Stroke.Transparency = Button.Disabled and 0.5 or 0
        Stroke.Parent = Base

        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, Library.CornerRadius / 2)
        Corner.Parent = Base

        return Base, Stroke
    end

    local function InitEvents(Button)
        Button.Base.MouseEnter:Connect(function()
            if Button.Disabled then return end
            Button.Tween = Library.TweenService:Create(Button.Base, Library.TweenInfo, {
                TextTransparency = 0,
            })
            Button.Tween:Play()
        end)
        Button.Base.MouseLeave:Connect(function()
            if Button.Disabled then return end
            Button.Tween = Library.TweenService:Create(Button.Base, Library.TweenInfo, {
                TextTransparency = 0.4,
            })
            Button.Tween:Play()
        end)

        Button.Base.MouseButton1Click:Connect(function()
            if Button.Disabled or Button.Locked then return end
            if Button.DoubleClick then
                Button.Locked = true
                Button.Base.Text = "Are you sure?"
                Button.Base.TextColor3 = Library.Scheme.AccentColor
                Library.Registry[Button.Base].TextColor3 = "AccentColor"

                local function CheckClick()
                    local Bindable = Instance.new("BindableEvent")
                    local Connection = Button.Base.MouseButton1Click:Once(function()
                        Bindable:Fire(true)
                    end)
                    task.delay(0.5, function()
                        Connection:Disconnect()
                        Bindable:Fire(false)
                    end)
                    local Clicked = Bindable.Event:Wait()
                    Bindable:Destroy()
                    return Clicked
                end

                local Clicked = CheckClick()

                Button.Base.Text = Button.Text
                Button.Base.TextColor3 = Button.Risky and Library.Scheme.RedColor or Library.Scheme.FontColor
                Library.Registry[Button.Base].TextColor3 = Button.Risky and "RedColor" or "FontColor"

                if Clicked then
                    Library:SafeCallback(Button.Func)
                end
                Library.RunService.RenderStepped:Wait()
                Button.Locked = false
                return
            end
            Library:SafeCallback(Button.Func)
        end)
    end

    Button.Base, Button.Stroke = CreateButton(Button)
    InitEvents(Button)

    function Button:AddButton(...)
        local Info = GetInfo(...)
        local SubButton = {
            Text = Info.Text,
            Func = Info.Func,
            DoubleClick = Info.DoubleClick,
            Tooltip = Info.Tooltip,
            DisabledTooltip = Info.DisabledTooltip,
            TooltipTable = nil,
            Risky = Info.Risky,
            Disabled = Info.Disabled,
            Visible = Info.Visible,
            Tween = nil,
            Type = "SubButton",
        }

        Button.SubButton = SubButton
        SubButton.Base, SubButton.Stroke = CreateButton(SubButton)
        InitEvents(SubButton)

        function SubButton:UpdateColors()
            if Library.Unloaded then return end
            if SubButton.Tween then SubButton.Tween:Cancel() end
            SubButton.Base.BackgroundColor3 = SubButton.Disabled and Library.Scheme.BackgroundColor or Library.Scheme.MainColor
            SubButton.Base.TextTransparency = SubButton.Disabled and 0.8 or 0.4
            SubButton.Stroke.Transparency = SubButton.Disabled and 0.5 or 0
            Library.Registry[SubButton.Base].BackgroundColor3 = SubButton.Disabled and "BackgroundColor" or "MainColor"
        end

        function SubButton:SetDisabled(Disabled)
            SubButton.Disabled = Disabled
            if SubButton.TooltipTable then
                SubButton.TooltipTable.Disabled = SubButton.Disabled
            end
            SubButton.Base.Active = not SubButton.Disabled
            SubButton:UpdateColors()
        end

        function SubButton:SetVisible(Visible)
            SubButton.Visible = Visible
            SubButton.Base.Visible = SubButton.Visible
            Groupbox:Resize()
        end

        function SubButton:SetText(Text)
            SubButton.Text = Text
            SubButton.Base.Text = Text
        end

        if typeof(SubButton.Tooltip) == "string" or typeof(SubButton.DisabledTooltip) == "string" then
            SubButton.TooltipTable = Library:AddTooltip(SubButton.Tooltip, SubButton.DisabledTooltip, SubButton.Base)
            SubButton.TooltipTable.Disabled = SubButton.Disabled
        end

        if SubButton.Risky then
            SubButton.Base.TextColor3 = Library.Scheme.RedColor
            Library.Registry[SubButton.Base].TextColor3 = "RedColor"
        end

        SubButton:UpdateColors()

        if Info.Idx then
            Library.Buttons[Info.Idx] = SubButton
        else
            table.insert(Library.Buttons, SubButton)
        end
        return SubButton
    end

    function Button:UpdateColors()
        if Library.Unloaded then return end
        if Button.Tween then Button.Tween:Cancel() end
        Button.Base.BackgroundColor3 = Button.Disabled and Library.Scheme.BackgroundColor or Library.Scheme.MainColor
        Button.Base.TextTransparency = Button.Disabled and 0.8 or 0.4
        Button.Stroke.Transparency = Button.Disabled and 0.5 or 0
        Library.Registry[Button.Base].BackgroundColor3 = Button.Disabled and "BackgroundColor" or "MainColor"
    end

    function Button:SetDisabled(Disabled)
        Button.Disabled = Disabled
        if Button.TooltipTable then
            Button.TooltipTable.Disabled = Button.Disabled
        end
        Button.Base.Active = not Button.Disabled
        Button:UpdateColors()
    end

    function Button:SetVisible(Visible)
        Button.Visible = Visible
        Holder.Visible = Button.Visible
        Groupbox:Resize()
    end

    function Button:SetText(Text)
        Button.Text = Text
        Button.Base.Text = Text
    end

    if typeof(Button.Tooltip) == "string" or typeof(Button.DisabledTooltip) == "string" then
        Button.TooltipTable = Library:AddTooltip(Button.Tooltip, Button.DisabledTooltip, Button.Base)
        Button.TooltipTable.Disabled = Button.Disabled
    end

    if Button.Risky then
        Button.Base.TextColor3 = Library.Scheme.RedColor
        Library.Registry[Button.Base].TextColor3 = "RedColor"
    end

    Button:UpdateColors()
    Groupbox:Resize()
    Button.Holder = Holder
    table.insert(Groupbox.Elements, Button)

    if Info.Idx then
        Library.Buttons[Info.Idx] = Button
    else
        table.insert(Library.Buttons, Button)
    end
    return Button
end

function BaseGroupbox:AddCheckbox(Idx, Info)
    Info = Library:Validate(Info, Templates.Toggle)

    local Groupbox = self
    local Container = Groupbox.Container

    local Toggle = {
        Text = Info.Text,
        Value = Info.Default,
        Tooltip = Info.Tooltip,
        DisabledTooltip = Info.DisabledTooltip,
        TooltipTable = nil,
        Callback = Info.Callback,
        Changed = Info.Changed,
        Risky = Info.Risky,
        Disabled = Info.Disabled,
        Visible = Info.Visible,
        Addons = {},
        Type = "Toggle",
    }

    local Button = Instance.new("TextButton")
    Button.Active = not Toggle.Disabled
    Button.BackgroundTransparency = 1
    Button.Size = UDim2.new(1, 0, 0, 18)
    Button.Text = ""
    Button.Visible = Toggle.Visible
    Button.Parent = Container

    local Label = Instance.new("TextLabel")
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.fromOffset(26, 0)
    Label.Size = UDim2.new(1, -26, 1, 0)
    Label.Text = Toggle.Text
    Label.TextSize = 14
    Label.TextTransparency = 0.4
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Button

    local LabelLayout = Instance.new("UIListLayout")
    LabelLayout.FillDirection = Enum.FillDirection.Horizontal
    LabelLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    LabelLayout.Padding = UDim.new(0, 6)
    LabelLayout.Parent = Label

    local Checkbox = Instance.new("Frame")
    Checkbox.BackgroundColor3 = "MainColor"
    Checkbox.Size = UDim2.fromScale(1, 1)
    Checkbox.SizeConstraint = Enum.SizeConstraint.RelativeYY
    Checkbox.Parent = Button

    local CheckboxCorner = Instance.new("UICorner")
    CheckboxCorner.CornerRadius = UDim.new(0, Library.CornerRadius / 2)
    CheckboxCorner.Parent = Checkbox

    local CheckboxStroke = Instance.new("UIStroke")
    CheckboxStroke.Color = "OutlineColor"
    CheckboxStroke.Parent = Checkbox

    local CheckIcon = Library:GetIcon("check")
    local CheckImage = Instance.new("ImageLabel")
    CheckImage.Image = CheckIcon and CheckIcon.Url or ""
    CheckImage.ImageColor3 = "FontColor"
    CheckImage.ImageRectOffset = CheckIcon and CheckIcon.ImageRectOffset or Vector2.zero
    CheckImage.ImageRectSize = CheckIcon and CheckIcon.ImageRectSize or Vector2.zero
    CheckImage.ImageTransparency = 1
    CheckImage.Position = UDim2.fromOffset(2, 2)
    CheckImage.Size = UDim2.new(1, -4, 1, -4)
    CheckImage.Parent = Checkbox

    function Toggle:UpdateColors()
        Toggle:Display()
    end

    function Toggle:Display()
        if Library.Unloaded then return end
        CheckboxStroke.Transparency = Toggle.Disabled and 0.5 or 0

        if Toggle.Disabled then
            Label.TextTransparency = 0.8
            CheckImage.ImageTransparency = Toggle.Value and 0.8 or 1
            Checkbox.BackgroundColor3 = Library.Scheme.BackgroundColor
            Library.Registry[Checkbox].BackgroundColor3 = "BackgroundColor"
            return
        end

        Library.TweenService:Create(Label, Library.TweenInfo, {
            TextTransparency = Toggle.Value and 0 or 0.4,
        }):Play()
        Library.TweenService:Create(CheckImage, Library.TweenInfo, {
            ImageTransparency = Toggle.Value and 0 or 1,
        }):Play()

        Checkbox.BackgroundColor3 = Library.Scheme.MainColor
        Library.Registry[Checkbox].BackgroundColor3 = "MainColor"
    end

    function Toggle:OnChanged(Func)
        Toggle.Changed = Func
    end

    function Toggle:SetValue(Value)
        if Toggle.Disabled then return end
        Toggle.Value = Value
        Toggle:Display()

        for _, Addon in Toggle.Addons do
            if Addon.Type == "KeyPicker" and Addon.SyncToggleState then
                Addon.Toggled = Toggle.Value
                Addon:Update()
            end
        end

        Library:UpdateDependencyBoxes()
        Library:SafeCallback(Toggle.Callback, Toggle.Value)
        Library:SafeCallback(Toggle.Changed, Toggle.Value)
    end

    function Toggle:SetDisabled(Disabled)
        Toggle.Disabled = Disabled
        if Toggle.TooltipTable then
            Toggle.TooltipTable.Disabled = Toggle.Disabled
        end
        for _, Addon in Toggle.Addons do
            if Addon.Type == "KeyPicker" and Addon.SyncToggleState then
                Addon:Update()
            end
        end
        Button.Active = not Toggle.Disabled
        Toggle:Display()
    end

    function Toggle:SetVisible(Visible)
        Toggle.Visible = Visible
        Button.Visible = Toggle.Visible
        Groupbox:Resize()
    end

    function Toggle:SetText(Text)
        Toggle.Text = Text
        Label.Text = Text
    end

    Button.MouseButton1Click:Connect(function()
        if Toggle.Disabled then return end
        Toggle:SetValue(not Toggle.Value)
    end)

    if typeof(Toggle.Tooltip) == "string" or typeof(Toggle.DisabledTooltip) == "string" then
        Toggle.TooltipTable = Library:AddTooltip(Toggle.Tooltip, Toggle.DisabledTooltip, Button)
        Toggle.TooltipTable.Disabled = Toggle.Disabled
    end

    if Toggle.Risky then
        Label.TextColor3 = Library.Scheme.RedColor
        Library.Registry[Label].TextColor3 = "RedColor"
    end

    Toggle:Display()
    Groupbox:Resize()
    Toggle.TextLabel = Label
    Toggle.Container = Container
    setmetatable(Toggle, BaseAddons)
    Toggle.Holder = Button
    table.insert(Groupbox.Elements, Toggle)
    Toggle.Default = Toggle.Value

    Library.Toggles[Idx] = Toggle
    return Toggle
end

function BaseGroupbox:AddToggle(Idx, Info)
    if Library.ForceCheckbox then
        return BaseGroupbox.AddCheckbox(self, Idx, Info)
    end

    Info = Library:Validate(Info, Templates.Toggle)

    local Groupbox = self
    local Container = Groupbox.Container

    local Toggle = {
        Text = Info.Text,
        Value = Info.Default,
        Tooltip = Info.Tooltip,
        DisabledTooltip = Info.DisabledTooltip,
        TooltipTable = nil,
        Callback = Info.Callback,
        Changed = Info.Changed,
        Risky = Info.Risky,
        Disabled = Info.Disabled,
        Visible = Info.Visible,
        Addons = {},
        Type = "Toggle",
    }

    local Button = Instance.new("TextButton")
    Button.Active = not Toggle.Disabled
    Button.BackgroundTransparency = 1
    Button.Size = UDim2.new(1, 0, 0, 18)
    Button.Text = ""
    Button.Visible = Toggle.Visible
    Button.Parent = Container

    local Label = Instance.new("TextLabel")
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(1, -40, 1, 0)
    Label.Text = Toggle.Text
    Label.TextSize = 14
    Label.TextTransparency = 0.4
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Button

    local LabelLayout = Instance.new("UIListLayout")
    LabelLayout.FillDirection = Enum.FillDirection.Horizontal
    LabelLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    LabelLayout.Padding = UDim.new(0, 6)
    LabelLayout.Parent = Label

    local Switch = Instance.new("Frame")
    Switch.AnchorPoint = Vector2.new(1, 0)
    Switch.BackgroundColor3 = "MainColor"
    Switch.Position = UDim2.fromScale(1, 0)
    Switch.Size = UDim2.fromOffset(32, 18)
    Switch.Parent = Button

    local SwitchCorner = Instance.new("UICorner")
    SwitchCorner.CornerRadius = UDim.new(1, 0)
    SwitchCorner.Parent = Switch

    local SwitchPadding = Instance.new("UIPadding")
    SwitchPadding.PaddingBottom = UDim.new(0, 2)
    SwitchPadding.PaddingLeft = UDim.new(0, 2)
    SwitchPadding.PaddingRight = UDim.new(0, 2)
    SwitchPadding.PaddingTop = UDim.new(0, 2)
    SwitchPadding.Parent = Switch

    local SwitchStroke = Instance.new("UIStroke")
    SwitchStroke.Color = "OutlineColor"
    SwitchStroke.Parent = Switch

    local Ball = Instance.new("Frame")
    Ball.BackgroundColor3 = "FontColor"
    Ball.Size = UDim2.fromScale(1, 1)
    Ball.SizeConstraint = Enum.SizeConstraint.RelativeYY
    Ball.Parent = Switch

    local BallCorner = Instance.new("UICorner")
    BallCorner.CornerRadius = UDim.new(1, 0)
    BallCorner.Parent = Ball

    function Toggle:UpdateColors()
        Toggle:Display()
    end

    function Toggle:Display()
        if Library.Unloaded then return end
        local Offset = Toggle.Value and 1 or 0

        Switch.BackgroundTransparency = Toggle.Disabled and 0.75 or 0
        SwitchStroke.Transparency = Toggle.Disabled and 0.75 or 0

        Switch.BackgroundColor3 = Toggle.Value and Library.Scheme.AccentColor or Library.Scheme.MainColor
        SwitchStroke.Color = Toggle.Value and Library.Scheme.AccentColor or Library.Scheme.OutlineColor

        Library.Registry[Switch].BackgroundColor3 = Toggle.Value and "AccentColor" or "MainColor"
        Library.Registry[SwitchStroke].Color = Toggle.Value and "AccentColor" or "OutlineColor"

        if Toggle.Disabled then
            Label.TextTransparency = 0.8
            Ball.AnchorPoint = Vector2.new(Offset, 0)
            Ball.Position = UDim2.fromScale(Offset, 0)
            Ball.BackgroundColor3 = Library:GetDarkerColor(Library.Scheme.FontColor)
            Library.Registry[Ball].BackgroundColor3 = function()
                return Library:GetDarkerColor(Library.Scheme.FontColor)
            end
            return
        end

        Library.TweenService:Create(Label, Library.TweenInfo, {
            TextTransparency = Toggle.Value and 0 or 0.4,
        }):Play()
        Library.TweenService:Create(Ball, Library.TweenInfo, {
            AnchorPoint = Vector2.new(Offset, 0),
            Position = UDim2.fromScale(Offset, 0),
        }):Play()

        Ball.BackgroundColor3 = Library.Scheme.FontColor
        Library.Registry[Ball].BackgroundColor3 = "FontColor"
    end

    function Toggle:OnChanged(Func)
        Toggle.Changed = Func
    end

    function Toggle:SetValue(Value)
        if Toggle.Disabled then return end
        Toggle.Value = Value
        Toggle:Display()

        for _, Addon in Toggle.Addons do
            if Addon.Type == "KeyPicker" and Addon.SyncToggleState then
                Addon.Toggled = Toggle.Value
                Addon:Update()
            end
        end

        Library:UpdateDependencyBoxes()
        Library:SafeCallback(Toggle.Callback, Toggle.Value)
        Library:SafeCallback(Toggle.Changed, Toggle.Value)
    end

    function Toggle:SetDisabled(Disabled)
        Toggle.Disabled = Disabled
        if Toggle.TooltipTable then
            Toggle.TooltipTable.Disabled = Toggle.Disabled
        end
        for _, Addon in Toggle.Addons do
            if Addon.Type == "KeyPicker" and Addon.SyncToggleState then
                Addon:Update()
            end
        end
        Button.Active = not Toggle.Disabled
        Toggle:Display()
    end

    function Toggle:SetVisible(Visible)
        Toggle.Visible = Visible
        Button.Visible = Toggle.Visible
        Groupbox:Resize()
    end

    function Toggle:SetText(Text)
        Toggle.Text = Text
        Label.Text = Text
    end

    Button.MouseButton1Click:Connect(function()
        if Toggle.Disabled then return end
        Toggle:SetValue(not Toggle.Value)
    end)

    if typeof(Toggle.Tooltip) == "string" or typeof(Toggle.DisabledTooltip) == "string" then
        Toggle.TooltipTable = Library:AddTooltip(Toggle.Tooltip, Toggle.DisabledTooltip, Button)
        Toggle.TooltipTable.Disabled = Toggle.Disabled
    end

    if Toggle.Risky then
        Label.TextColor3 = Library.Scheme.RedColor
        Library.Registry[Label].TextColor3 = "RedColor"
    end

    Toggle:Display()
    Groupbox:Resize()
    Toggle.TextLabel = Label
    Toggle.Container = Container
    setmetatable(Toggle, BaseAddons)
    Toggle.Holder = Button
    table.insert(Groupbox.Elements, Toggle)
    Toggle.Default = Toggle.Value

    Library.Toggles[Idx] = Toggle
    return Toggle
end

function BaseGroupbox:AddInput(Idx, Info)
    if typeof(Info) == "table" and (typeof(Info.VerifyValue) == "function" and Info.Finished ~= true) then
        Info.Finished = true
    end

    Info = Library:Validate(Info, Templates.Input)

    local Groupbox = self
    local Container = Groupbox.Container

    local Input = {
        Text = Info.Text,
        Value = Info.Default,
        Finished = Info.Finished,
        Numeric = Info.Numeric,
        ClearTextOnFocus = Info.ClearTextOnFocus,
        ClearTextOnBlur = Info.ClearTextOnBlur,
        Placeholder = Info.Placeholder,
        AllowEmpty = Info.AllowEmpty,
        EmptyReset = Info.EmptyReset,
        Tooltip = Info.Tooltip,
        DisabledTooltip = Info.DisabledTooltip,
        TooltipTable = nil,
        Callback = Info.Callback,
        Changed = Info.Changed,
        VerifyValue = Info.VerifyValue,
        Disabled = Info.Disabled,
        Visible = Info.Visible,
        Type = "Input",
    }

    local Holder = Instance.new("Frame")
    Holder.BackgroundTransparency = 1
    Holder.Size = UDim2.new(1, 0, 0, 39)
    Holder.Visible = Input.Visible
    Holder.Parent = Container

    local Label = Instance.new("TextLabel")
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(1, 0, 0, 14)
    Label.Text = Input.Text
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Holder

    local Box = Instance.new("TextBox")
    Box.AnchorPoint = Vector2.new(0, 1)
    Box.BackgroundColor3 = "MainColor"
    Box.ClearTextOnFocus = not Input.Disabled and Input.ClearTextOnFocus
    Box.PlaceholderText = Input.Placeholder
    Box.Position = UDim2.fromScale(0, 1)
    Box.Size = UDim2.new(1, 0, 0, 21)
    Box.Text = Input.Value
    Box.TextEditable = not Input.Disabled
    Box.TextScaled = true
    Box.TextXAlignment = Enum.TextXAlignment.Left
    Box.Parent = Holder

    local BoxPadding = Instance.new("UIPadding")
    BoxPadding.PaddingBottom = UDim.new(0, 3)
    BoxPadding.PaddingLeft = UDim.new(0, 8)
    BoxPadding.PaddingRight = UDim.new(0, 8)
    BoxPadding.PaddingTop = UDim.new(0, 4)
    BoxPadding.Parent = Box

    local BoxStroke = Instance.new("UIStroke")
    BoxStroke.Color = "OutlineColor"
    BoxStroke.Parent = Box

    local BoxCorner = Instance.new("UICorner")
    BoxCorner.CornerRadius = UDim.new(0, Library.CornerRadius / 2)
    BoxCorner.Parent = Box

    function Input:UpdateColors()
        if Library.Unloaded then return end
        Label.TextTransparency = Input.Disabled and 0.8 or 0
        Box.TextTransparency = Input.Disabled and 0.8 or 0
    end

    function Input:OnChanged(Func)
        Input.Changed = Func
    end

    function Input:SetValue(Text)
        if not Input.AllowEmpty and Trim(Text) == "" then
            Text = Input.EmptyReset
        end

        if Info.MaxLength and #Text > Info.MaxLength then
            Text = Text:sub(1, Info.MaxLength)
        end

        if Input.Numeric then
            if #tostring(Text) > 0 and not tonumber(Text) then
                Text = Input.Value
            end
        end

        if typeof(Info.VerifyValue) == "function" and (Text ~= Input.EmptyReset and Info.VerifyValue(Text) ~= true) then
            Text = Input.EmptyReset
        end

        Input.Value = Text
        Box.Text = Text

        if not Input.Disabled then
            Library:SafeCallback(Input.Callback, Input.Value)
            Library:SafeCallback(Input.Changed, Input.Value)
        end
    end

    function Input:SetDisabled(Disabled)
        Input.Disabled = Disabled
        if Input.TooltipTable then
            Input.TooltipTable.Disabled = Input.Disabled
        end
        Box.ClearTextOnFocus = not Input.Disabled and Input.ClearTextOnFocus
        Box.TextEditable = not Input.Disabled
        Input:UpdateColors()
    end

    function Input:SetVisible(Visible)
        Input.Visible = Visible
        Holder.Visible = Input.Visible
        Groupbox:Resize()
    end

    function Input:SetText(Text)
        Input.Text = Text
        Label.Text = Text
    end

    if Input.Finished then
        Box.FocusLost:Connect(function(Enter)
            if not Enter then
                if Input.ClearTextOnBlur then
                    Box.Text = Input.Value
                end
                return
            end
            Input:SetValue(Box.Text)
        end)
    else
        Box:GetPropertyChangedSignal("Text"):Connect(function()
            if Box.Text == Input.Value then return end
            Input:SetValue(Box.Text)
        end)
    end

    if typeof(Input.Tooltip) == "string" or typeof(Input.DisabledTooltip) == "string" then
        Input.TooltipTable = Library:AddTooltip(Input.Tooltip, Input.DisabledTooltip, Box)
        Input.TooltipTable.Disabled = Input.Disabled
    end

    Groupbox:Resize()
    Input.Holder = Holder
    table.insert(Groupbox.Elements, Input)

    Input.Default = Input.Value
    if typeof(Info.VerifyValue) == "function" and (Input.Default ~= Input.EmptyReset and Info.VerifyValue(Input.Default) ~= true) then
        Input:SetValue(Input.EmptyReset)
        Input.Default = Input.EmptyReset
    end

    Library.Options[Idx] = Input
    return Input
end

function BaseGroupbox:AddSlider(Idx, Info)
    Info = Library:Validate(Info, Templates.Slider)

    local Groupbox = self
    local Container = Groupbox.Container

    local Slider = {
        Text = Info.Text,
        Value = Info.Default,
        Min = Info.Min,
        Max = Info.Max,
        Prefix = Info.Prefix,
        Suffix = Info.Suffix,
        Compact = Info.Compact,
        Rounding = Info.Rounding,
        Tooltip = Info.Tooltip,
        DisabledTooltip = Info.DisabledTooltip,
        TooltipTable = nil,
        Callback = Info.Callback,
        Changed = Info.Changed,
        Disabled = Info.Disabled,
        Visible = Info.Visible,
        Type = "Slider",
    }

    local Holder = Instance.new("Frame")
    Holder.BackgroundTransparency = 1
    Holder.Size = UDim2.new(1, 0, 0, Info.Compact and 15 or 33)
    Holder.Visible = Slider.Visible
    Holder.Parent = Container

    local SliderLabel
    if not Info.Compact then
        SliderLabel = Instance.new("TextLabel")
        SliderLabel.BackgroundTransparency = 1
        SliderLabel.Size = UDim2.new(1, 0, 0, 14)
        SliderLabel.Text = Slider.Text
        SliderLabel.TextSize = 14
        SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
        SliderLabel.Parent = Holder
    end

    local Bar = Instance.new("TextButton")
    Bar.Active = not Slider.Disabled
    Bar.AnchorPoint = Vector2.new(0, 1)
    Bar.BackgroundColor3 = "MainColor"
    Bar.Position = UDim2.fromScale(0, 1)
    Bar.Size = UDim2.new(1, 0, 0, 15)
    Bar.Text = ""
    Bar.Parent = Holder

    local BarStroke = Instance.new("UIStroke")
    BarStroke.Color = "OutlineColor"
    BarStroke.Parent = Bar

    local DisplayLabel = Instance.new("TextLabel")
    DisplayLabel.BackgroundTransparency = 1
    DisplayLabel.Size = UDim2.fromScale(1, 1)
    DisplayLabel.Text = ""
    DisplayLabel.TextSize = 14
    DisplayLabel.ZIndex = 2
    DisplayLabel.Parent = Bar

    local DisplayLabelStroke = Instance.new("UIStroke")
    DisplayLabelStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
    DisplayLabelStroke.Color = "DarkColor"
    DisplayLabelStroke.LineJoinMode = Enum.LineJoinMode.Miter
    DisplayLabelStroke.Parent = DisplayLabel

    local Fill = Instance.new("Frame")
    Fill.BackgroundColor3 = "AccentColor"
    Fill.Size = UDim2.fromScale(0.5, 1)
    Fill.Parent = Bar

    local BarCorner = Instance.new("UICorner")
    BarCorner.CornerRadius = UDim.new(0, Library.CornerRadius / 2)
    BarCorner.Parent = Bar

    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(0, Library.CornerRadius / 2)
    FillCorner.Parent = Fill

    function Slider:UpdateColors()
        if Library.Unloaded then return end
        if SliderLabel then
            SliderLabel.TextTransparency = Slider.Disabled and 0.8 or 0
        end
        DisplayLabel.TextTransparency = Slider.Disabled and 0.8 or 0
        Fill.BackgroundColor3 = Slider.Disabled and Library.Scheme.OutlineColor or Library.Scheme.AccentColor
        Library.Registry[Fill].BackgroundColor3 = Slider.Disabled and "OutlineColor" or "AccentColor"
    end

    function Slider:Display()
        if Library.Unloaded then return end
        local CustomDisplayText = nil
        if Info.FormatDisplayValue then
            CustomDisplayText = Info.FormatDisplayValue(Slider, Slider.Value)
        end

        if CustomDisplayText then
            DisplayLabel.Text = tostring(CustomDisplayText)
        else
            if Info.Compact then
                DisplayLabel.Text = string.format("%s: %s%s%s", Slider.Text, Slider.Prefix, Slider.Value, Slider.Suffix)
            elseif Info.HideMax then
                DisplayLabel.Text = string.format("%s%s%s", Slider.Prefix, Slider.Value, Slider.Suffix)
            else
                DisplayLabel.Text = string.format("%s%s%s/%s%s%s", Slider.Prefix, Slider.Value, Slider.Suffix, Slider.Prefix, Slider.Max, Slider.Suffix)
            end
        end

        local X = (Slider.Value - Slider.Min) / (Slider.Max - Slider.Min)
        Fill.Size = UDim2.fromScale(X, 1)
    end

    function Slider:OnChanged(Func)
        Slider.Changed = Func
    end

    function Slider:SetMax(Value)
        assert(Value > Slider.Min, "Max value cannot be less than the current min value.")
        Slider:SetValue(math.clamp(Slider.Value, Slider.Min, Value))
        Slider.Max = Value
        Slider:Display()
    end

    function Slider:SetMin(Value)
        assert(Value < Slider.Max, "Min value cannot be greater than the current max value.")
        Slider:SetValue(math.clamp(Slider.Value, Value, Slider.Max))
        Slider.Min = Value
        Slider:Display()
    end

    function Slider:SetValue(Str)
        if Slider.Disabled then return end
        local Num = tonumber(Str)
        if not Num or Num == Slider.Value then return end
        Num = math.clamp(Num, Slider.Min, Slider.Max)
        Slider.Value = Num
        Slider:Display()
        Library:SafeCallback(Slider.Callback, Slider.Value)
        Library:SafeCallback(Slider.Changed, Slider.Value)
    end

    function Slider:SetDisabled(Disabled)
        Slider.Disabled = Disabled
        if Slider.TooltipTable then
            Slider.TooltipTable.Disabled = Slider.Disabled
        end
        Bar.Active = not Slider.Disabled
        Slider:UpdateColors()
    end

    function Slider:SetVisible(Visible)
        Slider.Visible = Visible
        Holder.Visible = Slider.Visible
        Groupbox:Resize()
    end

    function Slider:SetText(Text)
        Slider.Text = Text
        if SliderLabel then
            SliderLabel.Text = Text
            return
        end
        Slider:Display()
    end

    function Slider:SetPrefix(Prefix)
        Slider.Prefix = Prefix
        Slider:Display()
    end

    function Slider:SetSuffix(Suffix)
        Slider.Suffix = Suffix
        Slider:Display()
    end

    Bar.InputBegan:Connect(function(Input)
        if not Library.IsClickInput(Input) or Slider.Disabled then return end

        if Library.ActiveTab then
            for _, Side in Library.ActiveTab.Sides do
                Side.ScrollingEnabled = false
            end
        end

        if Library.ActiveLoading and Library.ActiveLoading.Sidebar then
            Library.ActiveLoading.Sidebar.Container.ScrollingEnabled = false
        end

        while Library.IsDragInput(Input) do
            local Location = Library.Mouse.X
            local Scale = math.clamp((Location - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)

            local OldValue = Slider.Value
            Slider.Value = Round(Slider.Min + ((Slider.Max - Slider.Min) * Scale), Slider.Rounding)

            Slider:Display()
            if Slider.Value ~= OldValue then
                Library:SafeCallback(Slider.Callback, Slider.Value)
                Library:SafeCallback(Slider.Changed, Slider.Value)
            end
            Library.RunService.RenderStepped:Wait()
        end

        if Library.ActiveTab then
            for _, Side in Library.ActiveTab.Sides do
                Side.ScrollingEnabled = true
            end
        end

        if Library.ActiveLoading and Library.ActiveLoading.Sidebar then
            Library.ActiveLoading.Sidebar.Container.ScrollingEnabled = true
        end
    end)

    if typeof(Slider.Tooltip) == "string" or typeof(Slider.DisabledTooltip) == "string" then
        Slider.TooltipTable = Library:AddTooltip(Slider.Tooltip, Slider.DisabledTooltip, Bar)
        Slider.TooltipTable.Disabled = Slider.Disabled
    end

    Slider:UpdateColors()
    Slider:Display()
    Groupbox:Resize()
    Slider.Holder = Holder
    table.insert(Groupbox.Elements, Slider)
    Slider.Default = Slider.Value

    Library.Options[Idx] = Slider
    return Slider
end

function BaseGroupbox:AddDropdown(Idx, Info)
    Info = Library:Validate(Info, Templates.Dropdown)

    local Groupbox = self
    local Container = Groupbox.Container

    if Info.SpecialType == "Player" then
        Info.Values = GetPlayers(Info.ExcludeLocalPlayer)
        Info.AllowNull = true
    elseif Info.SpecialType == "Team" then
        Info.Values = GetTeams()
        Info.AllowNull = true
    end

    local Dropdown = {
        Text = typeof(Info.Text) == "string" and Info.Text or nil,
        Value = Info.Multi and {} or nil,
        Values = Info.Values,
        DisabledValues = Info.DisabledValues,
        Multi = Info.Multi,
        SpecialType = Info.SpecialType,
        ExcludeLocalPlayer = Info.ExcludeLocalPlayer,
        Tooltip = Info.Tooltip,
        DisabledTooltip = Info.DisabledTooltip,
        TooltipTable = nil,
        Callback = Info.Callback,
        Changed = Info.Changed,
        Disabled = Info.Disabled,
        Visible = Info.Visible,
        Type = "Dropdown",
    }

    local Holder = Instance.new("Frame")
    Holder.BackgroundTransparency = 1
    Holder.Size = UDim2.new(1, 0, 0, Dropdown.Text and 39 or 21)
    Holder.Visible = Dropdown.Visible
    Holder.Parent = Container

    local Label = Instance.new("TextLabel")
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(1, 0, 0, 14)
    Label.Text = Dropdown.Text
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Visible = not not Info.Text
    Label.ZIndex = 3
    Label.Parent = Holder

    local Display = Instance.new("TextButton")
    Display.Active = not Dropdown.Disabled
    Display.AnchorPoint = Vector2.new(0, 1)
    Display.BackgroundColor3 = "MainColor"
    Display.Position = UDim2.fromScale(0, 1)
    Display.Size = UDim2.new(1, 0, 0, 21)
    Display.Text = "---"
    Display.TextSize = 14
    Display.TextXAlignment = Enum.TextXAlignment.Left
    Display.ZIndex = 2
    Display.Parent = Holder

    local DisplayPadding = Instance.new("UIPadding")
    DisplayPadding.PaddingLeft = UDim.new(0, 8)
    DisplayPadding.PaddingRight = UDim.new(0, 4)
    DisplayPadding.Parent = Display

    local DisplayStroke = Instance.new("UIStroke")
    DisplayStroke.Color = "OutlineColor"
    DisplayStroke.Parent = Display

    local ArrowIcon = Library:GetIcon("chevron-up")
    local ArrowImage = Instance.new("ImageLabel")
    ArrowImage.AnchorPoint = Vector2.new(1, 0.5)
    ArrowImage.Image = ArrowIcon and ArrowIcon.Url or ""
    ArrowImage.ImageColor3 = "FontColor"
    ArrowImage.ImageRectOffset = ArrowIcon and ArrowIcon.ImageRectOffset or Vector2.zero
    ArrowImage.ImageRectSize = ArrowIcon and ArrowIcon.ImageRectSize or Vector2.zero
    ArrowImage.ImageTransparency = 0.5
    ArrowImage.Position = UDim2.fromScale(1, 0.5)
    ArrowImage.Size = UDim2.fromOffset(16, 16)
    ArrowImage.Parent = Display

    local SearchBox
    if Info.Searchable then
        SearchBox = Instance.new("TextBox")
        SearchBox.BackgroundTransparency = 1
        SearchBox.PlaceholderText = "Search..."
        SearchBox.Position = UDim2.fromOffset(-8, 0)
        SearchBox.Size = UDim2.new(1, -12, 1, 0)
        SearchBox.TextSize = 14
        SearchBox.TextXAlignment = Enum.TextXAlignment.Left
        SearchBox.Visible = false
        SearchBox.Parent = Display

        local SearchBoxPadding = Instance.new("UIPadding")
        SearchBoxPadding.PaddingLeft = UDim.new(0, 8)
        SearchBoxPadding.Parent = SearchBox
    end

    local MenuTable = Library:AddContextMenu(Display, function()
        return UDim2.fromOffset(Display.AbsoluteSize.X / Library.DPIScale, 0)
    end, function()
        return { 0.5, Display.AbsoluteSize.Y + 1.5 }
    end, 2, function(Active)
        Display.TextTransparency = (Active and SearchBox) and 1 or 0
        ArrowImage.ImageTransparency = Active and 0 or 0.5
        ArrowImage.Rotation = Active and 180 or 0
        if SearchBox then
            SearchBox.Text = ""
            SearchBox.Visible = Active
        end
    end, true)
    Dropdown.Menu = MenuTable

    function Dropdown:RecalculateListSize(Count)
        local Y = math.clamp((Count or GetTableSize(Dropdown.Values)) * 21, 0, Info.MaxVisibleDropdownItems * 21)
        MenuTable:SetSize(function()
            return UDim2.fromOffset(Display.AbsoluteSize.X / Library.DPIScale, Y)
        end)
    end

    function Dropdown:UpdateColors()
        if Library.Unloaded then return end
        Label.TextTransparency = Dropdown.Disabled and 0.8 or 0
        Display.TextTransparency = Dropdown.Disabled and 0.8 or 0
        ArrowImage.ImageTransparency = Dropdown.Disabled and 0.8 or MenuTable.Active and 0 or 0.5
    end

    function Dropdown:Display()
        if Library.Unloaded then return end
        local Str = ""

        if Info.Multi then
            for _, Value in Dropdown.Values do
                if Dropdown.Value[Value] then
                    Str = Str .. (Info.FormatDisplayValue and tostring(Info.FormatDisplayValue(Value)) or tostring(Value)) .. ", "
                end
            end
            Str = Str:sub(1, #Str - 2)
        else
            Str = Dropdown.Value and tostring(Dropdown.Value) or ""
            if Str ~= "" and Info.FormatDisplayValue then
                Str = tostring(Info.FormatDisplayValue(Str))
            end
        end

        if #Str > 25 then
            Str = Str:sub(1, 22) .. "..."
        end

        Display.Text = (Str == "" and "---" or Str)
    end

    function Dropdown:OnChanged(Func)
        Dropdown.Changed = Func
    end

    function Dropdown:GetActiveValues()
        if Info.Multi then
            local Table = {}
            for Value, _ in Dropdown.Value do
                table.insert(Table, Value)
            end
            return Table
        end
        return Dropdown.Value and 1 or 0
    end

    local Buttons = {}
    function Dropdown:BuildDropdownList()
        local Values = Dropdown.Values
        local DisabledValues = Dropdown.DisabledValues

        for Button, _ in Buttons do
            Button:Destroy()
        end
        table.clear(Buttons)

        local Count = 0
        for _, Value in Values do
            local FormattedValue = tostring(Info.FormatListValue and Info.FormatListValue(Value) or Value)
            if SearchBox and not FormattedValue:lower():match(SearchBox.Text:lower()) then
                continue
            end

            Count += 1
            local IsDisabled = table.find(DisabledValues, Value)
            local Table = {}

            local Button = Instance.new("TextButton")
            Button.BackgroundColor3 = "MainColor"
            Button.BackgroundTransparency = 1
            Button.LayoutOrder = IsDisabled and 1 or 0
            Button.Size = UDim2.new(1, 0, 0, 21)
            Button.Text = FormattedValue
            Button.TextSize = 14
            Button.TextTransparency = 0.5
            Button.TextXAlignment = Enum.TextXAlignment.Left
            Button.Parent = MenuTable.Menu

            local ButtonPadding = Instance.new("UIPadding")
            ButtonPadding.PaddingLeft = UDim.new(0, 7)
            ButtonPadding.PaddingRight = UDim.new(0, 7)
            ButtonPadding.Parent = Button

            local Selected
            if Info.Multi then
                Selected = Dropdown.Value[Value]
            else
                Selected = Dropdown.Value == Value
            end

            function Table:UpdateButton()
                if Info.Multi then
                    Selected = Dropdown.Value[Value]
                else
                    Selected = Dropdown.Value == Value
                end
                Button.BackgroundTransparency = Selected and 0 or 1
                Button.TextTransparency = IsDisabled and 0.8 or Selected and 0 or 0.5
            end

            if not IsDisabled then
                Button.MouseButton1Click:Connect(function()
                    local Try = not Selected
                    if not (Dropdown:GetActiveValues() == 1 and not Try and not Info.AllowNull) then
                        Selected = Try
                        if Info.Multi then
                            Dropdown.Value[Value] = Selected and true or nil
                        else
                            Dropdown.Value = Selected and Value or nil
                        end
                        for _, OtherButton in Buttons do
                            OtherButton:UpdateButton()
                        end
                    end
                    Table:UpdateButton()
                    Dropdown:Display()
                    Library:UpdateDependencyBoxes()
                    Library:SafeCallback(Dropdown.Callback, Dropdown.Value)
                    Library:SafeCallback(Dropdown.Changed, Dropdown.Value)
                end)
            end

            Table:UpdateButton()
            Dropdown:Display()
            Buttons[Button] = Table
        end
        Dropdown:RecalculateListSize(Count)
    end

    function Dropdown:SetValue(Value)
        if Info.Multi then
            local Table = {}
            for Val, Active in Value or {} do
                if typeof(Active) ~= "boolean" then
                    Table[Active] = true
                elseif Active and table.find(Dropdown.Values, Val) then
                    Table[Val] = true
                end
            end
            Dropdown.Value = Table
        else
            if table.find(Dropdown.Values, Value) then
                Dropdown.Value = Value
            elseif not Value then
                Dropdown.Value = nil
            end
        end
        Dropdown:Display()
        for _, Button in Buttons do
            Button:UpdateButton()
        end
        if not Dropdown.Disabled then
            Library:UpdateDependencyBoxes()
            Library:SafeCallback(Dropdown.Callback, Dropdown.Value)
            Library:SafeCallback(Dropdown.Changed, Dropdown.Value)
        end
    end

    function Dropdown:SetValues(Values)
        Dropdown.Values = Values
        Dropdown:BuildDropdownList()
    end

    function Dropdown:AddValues(Values)
        if typeof(Values) == "table" then
            for _, val in Values do
                table.insert(Dropdown.Values, val)
            end
        elseif typeof(Values) == "string" then
            table.insert(Dropdown.Values, Values)
        else
            return
        end
        Dropdown:BuildDropdownList()
    end

    function Dropdown:SetDisabledValues(DisabledValues)
        Dropdown.DisabledValues = DisabledValues
        Dropdown:BuildDropdownList()
    end

    function Dropdown:AddDisabledValues(DisabledValues)
        if typeof(DisabledValues) == "table" then
            for _, val in DisabledValues do
                table.insert(Dropdown.DisabledValues, val)
            end
        elseif typeof(DisabledValues) == "string" then
            table.insert(Dropdown.DisabledValues, DisabledValues)
        else
            return
        end
        Dropdown:BuildDropdownList()
    end

    function Dropdown:SetDisabled(Disabled)
        Dropdown.Disabled = Disabled
        if Dropdown.TooltipTable then
            Dropdown.TooltipTable.Disabled = Dropdown.Disabled
        end
        MenuTable:Close()
        Display.Active = not Dropdown.Disabled
        Dropdown:UpdateColors()
    end

    function Dropdown:SetVisible(Visible)
        Dropdown.Visible = Visible
        Holder.Visible = Dropdown.Visible
        Groupbox:Resize()
    end

    function Dropdown:SetText(Text)
        Dropdown.Text = Text
        Holder.Size = UDim2.new(1, 0, 0, Text and 39 or 21)
        Label.Text = Text and Text or ""
        Label.Visible = not not Text
    end

    Display.MouseButton1Click:Connect(function()
        if Dropdown.Disabled then return end
        MenuTable:Toggle()
    end)

    if SearchBox then
        SearchBox:GetPropertyChangedSignal("Text"):Connect(Dropdown.BuildDropdownList)
    end

    local Defaults = {}
    if typeof(Info.Default) == "string" then
        local Index = table.find(Dropdown.Values, Info.Default)
        if Index then
            table.insert(Defaults, Index)
        end
    elseif typeof(Info.Default) == "table" then
        for _, Value in next, Info.Default do
            local Index = table.find(Dropdown.Values, Value)
            if Index then
                table.insert(Defaults, Index)
            end
        end
    elseif Dropdown.Values[Info.Default] ~= nil then
        table.insert(Defaults, Info.Default)
    end

    if next(Defaults) then
        for i = 1, #Defaults do
            local Index = Defaults[i]
            if Info.Multi then
                Dropdown.Value[Dropdown.Values[Index]] = true
            else
                Dropdown.Value = Dropdown.Values[Index]
            end
            if not Info.Multi then
                break
            end
        end
    end

    if typeof(Dropdown.Tooltip) == "string" or typeof(Dropdown.DisabledTooltip) == "string" then
        Dropdown.TooltipTable = Library:AddTooltip(Dropdown.Tooltip, Dropdown.DisabledTooltip, Display)
        Dropdown.TooltipTable.Disabled = Dropdown.Disabled
    end

    Dropdown:UpdateColors()
    Dropdown:Display()
    Dropdown:BuildDropdownList()
    Groupbox:Resize()
    Dropdown.Holder = Holder
    table.insert(Groupbox.Elements, Dropdown)

    Dropdown.Default = Defaults
    Dropdown.DefaultValues = Dropdown.Values

    Library.Options[Idx] = Dropdown
    return Dropdown
end

function BaseGroupbox:AddViewport(Idx, Info)
    Info = Library:Validate(Info, Templates.Viewport)

    local Groupbox = self
    local Container = Groupbox.Container

    local Dragging, Pinching = false, false
    local LastMousePos, LastPinchDist = nil, 0

    local ViewportObject = Info.Object
    if Info.Clone and typeof(Info.Object) == "Instance" then
        if Info.Object.Archivable then
            ViewportObject = ViewportObject:Clone()
        else
            Info.Object.Archivable = true
            ViewportObject = ViewportObject:Clone()
            Info.Object.Archivable = false
        end
    end

    local Viewport = {
        Object = ViewportObject,
        Camera = if not Info.Camera then Instance.new("Camera") else Info.Camera,
        Interactive = Info.Interactive,
        AutoFocus = Info.AutoFocus,
        Visible = Info.Visible,
        Type = "Viewport",
    }

    assert(typeof(Viewport.Object) == "Instance" and (Viewport.Object:IsA("BasePart") or Viewport.Object:IsA("Model")), "Instance must be a BasePart or Model.")
    assert(typeof(Viewport.Camera) == "Instance" and Viewport.Camera:IsA("Camera"), "Camera must be a valid Camera instance.")

    local function GetModelSize(model)
        if model:IsA("BasePart") then
            return model.Size
        end
        return select(2, model:GetBoundingBox())
    end

    local function FocusCamera()
        local ModelSize = GetModelSize(Viewport.Object)
        local MaxExtent = math.max(ModelSize.X, ModelSize.Y, ModelSize.Z)
        local CameraDistance = MaxExtent * 2
        local ModelPosition = Viewport.Object:GetPivot().Position
        Viewport.Camera.CFrame = CFrame.new(ModelPosition + Vector3.new(0, MaxExtent / 2, CameraDistance), ModelPosition)
    end

    local Holder = Instance.new("Frame")
    Holder.BackgroundTransparency = 1
    Holder.Size = UDim2.new(1, 0, 0, Info.Height)
    Holder.Visible = Viewport.Visible
    Holder.Parent = Container

    local Box = Instance.new("Frame")
    Box.AnchorPoint = Vector2.new(0, 1)
    Box.BackgroundColor3 = "MainColor"
    Box.BorderColor3 = "OutlineColor"
    Box.BorderSizePixel = 1
    Box.Position = UDim2.fromScale(0, 1)
    Box.Size = UDim2.fromScale(1, 1)
    Box.Parent = Holder

    local BoxPadding = Instance.new("UIPadding")
    BoxPadding.PaddingBottom = UDim.new(0, 3)
    BoxPadding.PaddingLeft = UDim.new(0, 8)
    BoxPadding.PaddingRight = UDim.new(0, 8)
    BoxPadding.PaddingTop = UDim.new(0, 4)
    BoxPadding.Parent = Box

    local ViewportFrame = Instance.new("ViewportFrame")
    ViewportFrame.BackgroundTransparency = 1
    ViewportFrame.Size = UDim2.fromScale(1, 1)
    ViewportFrame.CurrentCamera = Viewport.Camera
    ViewportFrame.Active = Viewport.Interactive
    ViewportFrame.Parent = Box

    ViewportFrame.MouseEnter:Connect(function()
        if not Viewport.Interactive then return end
        for _, Side in Groupbox.Tab.Sides do
            Side.ScrollingEnabled = false
        end
    end)

    ViewportFrame.MouseLeave:Connect(function()
        if not Viewport.Interactive then return end
        for _, Side in Groupbox.Tab.Sides do
            Side.ScrollingEnabled = true
        end
    end)

    ViewportFrame.InputBegan:Connect(function(input)
        if not Viewport.Interactive then return end
        if input.UserInputType == Enum.UserInputType.MouseButton2 then
            Dragging = true
            LastMousePos = input.Position
        elseif input.UserInputType == Enum.UserInputType.Touch and not Pinching then
            Dragging = true
            LastMousePos = input.Position
        end
    end)

    Library:GiveSignal(Library.UserInputService.InputEnded:Connect(function(input)
        if Library.Unloaded then return end
        if not Viewport.Interactive then return end
        if input.UserInputType == Enum.UserInputType.MouseButton2 then
            Dragging = false
        elseif input.UserInputType == Enum.UserInputType.Touch then
            Dragging = false
        end
    end))

    Library:GiveSignal(Library.UserInputService.InputChanged:Connect(function(input)
        if Library.Unloaded then return end
        if not Viewport.Interactive or not Dragging or Pinching then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            local MouseDelta = input.Position - LastMousePos
            LastMousePos = input.Position

            local Position = Viewport.Object:GetPivot().Position
            local Camera = Viewport.Camera

            local RotationY = CFrame.fromAxisAngle(Vector3.new(0, 1, 0), -MouseDelta.X * 0.01)
            Camera.CFrame = CFrame.new(Position) * RotationY * CFrame.new(-Position) * Camera.CFrame

            local RotationX = CFrame.fromAxisAngle(Camera.CFrame.RightVector, -MouseDelta.Y * 0.01)
            local PitchedCFrame = CFrame.new(Position) * RotationX * CFrame.new(-Position) * Camera.CFrame

            if PitchedCFrame.UpVector.Y > 0.1 then
                Camera.CFrame = PitchedCFrame
            end
        end
    end))

    ViewportFrame.InputChanged:Connect(function(input)
        if not Viewport.Interactive then return end
        if input.UserInputType == Enum.UserInputType.MouseWheel then
            local ZoomAmount = input.Position.Z * 2
            Viewport.Camera.CFrame += Viewport.Camera.CFrame.LookVector * ZoomAmount
        end
    end)

    Library:GiveSignal(Library.UserInputService.TouchPinch:Connect(function(touchPositions, scale, velocity, state)
        if Library.Unloaded then return end
        if not Viewport.Interactive or not Library:MouseIsOverFrame(ViewportFrame, touchPositions[1]) then return end

        if state == Enum.UserInputState.Begin then
            Pinching = true
            Dragging = false
            LastPinchDist = (touchPositions[1] - touchPositions[2]).Magnitude
        elseif state == Enum.UserInputState.Change then
            local currentDist = (touchPositions[1] - touchPositions[2]).Magnitude
            local delta = (currentDist - LastPinchDist) * 0.1
            LastPinchDist = currentDist
            Viewport.Camera.CFrame += Viewport.Camera.CFrame.LookVector * delta
        elseif state == Enum.UserInputState.End or state == Enum.UserInputState.Cancel then
            Pinching = false
        end
    end))

    Viewport.Object.Parent = ViewportFrame
    if Viewport.AutoFocus then
        FocusCamera()
    end

    function Viewport:SetObject(Object, Clone)
        assert(Object, "Object cannot be nil.")
        if Clone then
            Object = Object:Clone()
        end
        if Viewport.Object then
            Viewport.Object:Destroy()
        end
        Viewport.Object = Object
        Viewport.Object.Parent = ViewportFrame
        Groupbox:Resize()
    end

    function Viewport:SetHeight(Height)
        assert(Height > 0, "Height must be greater than 0.")
        Holder.Size = UDim2.new(1, 0, 0, Height)
        Groupbox:Resize()
    end

    function Viewport:Focus()
        if not Viewport.Object then return end
        FocusCamera()
    end

    function Viewport:SetCamera(Camera)
        assert(Camera and typeof(Camera) == "Instance" and Camera:IsA("Camera"), "Camera must be a valid Camera instance.")
        Viewport.Camera = Camera
        ViewportFrame.CurrentCamera = Camera
    end

    function Viewport:SetInteractive(Interactive)
        Viewport.Interactive = Interactive
        ViewportFrame.Active = Interactive
    end

    function Viewport:SetVisible(Visible)
        Viewport.Visible = Visible
        Holder.Visible = Viewport.Visible
        Groupbox:Resize()
    end

    Groupbox:Resize()
    Viewport.Holder = Holder
    table.insert(Groupbox.Elements, Viewport)
    Library.Options[Idx] = Viewport
    return Viewport
end

function BaseGroupbox:AddImage(Idx, Info)
    Info = Library:Validate(Info, Templates.Image)

    local Groupbox = self
    local Container = Groupbox.Container

    local Image = {
        Image = Info.Image,
        Color = Info.Color,
        RectOffset = Info.RectOffset,
        RectSize = Info.RectSize,
        Height = Info.Height,
        ScaleType = Info.ScaleType,
        Transparency = Info.Transparency,
        BackgroundTransparency = Info.BackgroundTransparency,
        Visible = Info.Visible,
        Type = "Image",
    }

    local Holder = Instance.new("Frame")
    Holder.BackgroundTransparency = 1
    Holder.Size = UDim2.new(1, 0, 0, Info.Height)
    Holder.Visible = Image.Visible
    Holder.Parent = Container

    local Box = Instance.new("Frame")
    Box.AnchorPoint = Vector2.new(0, 1)
    Box.BackgroundColor3 = "MainColor"
    Box.BorderColor3 = "OutlineColor"
    Box.BorderSizePixel = 1
    Box.BackgroundTransparency = Image.BackgroundTransparency
    Box.Position = UDim2.fromScale(0, 1)
    Box.Size = UDim2.fromScale(1, 1)
    Box.Parent = Holder

    local BoxPadding = Instance.new("UIPadding")
    BoxPadding.PaddingBottom = UDim.new(0, 3)
    BoxPadding.PaddingLeft = UDim.new(0, 8)
    BoxPadding.PaddingRight = UDim.new(0, 8)
    BoxPadding.PaddingTop = UDim.new(0, 4)
    BoxPadding.Parent = Box

    local ImageProperties = {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        Image = Image.Image,
        ImageTransparency = Image.Transparency,
        ImageColor3 = Image.Color,
        ImageRectOffset = Image.RectOffset,
        ImageRectSize = Image.RectSize,
        ScaleType = Image.ScaleType,
    }

    local Icon = Library:GetCustomIcon(ImageProperties.Image)
    assert(Icon, "Image must be a valid Roblox asset or a valid URL or a valid lucide icon.")

    ImageProperties.Image = Icon.Url
    ImageProperties.ImageRectOffset = Icon.ImageRectOffset
    ImageProperties.ImageRectSize = Icon.ImageRectSize

    local ImageLabel = Instance.new("ImageLabel", ImageProperties)
    ImageLabel.Parent = Box

    function Image:SetHeight(Height)
        assert(Height > 0, "Height must be greater than 0.")
        Image.Height = Height
        Holder.Size = UDim2.new(1, 0, 0, Height)
        Groupbox:Resize()
    end

    function Image:SetImage(NewImage)
        assert(typeof(NewImage) == "string", "Image must be a string.")
        local Icon = Library:GetCustomIcon(NewImage)
        assert(Icon, "Image must be a valid Roblox asset or a valid URL or a valid lucide icon.")
        NewImage = Icon.Url
        Image.RectOffset = Icon.ImageRectOffset
        Image.RectSize = Icon.ImageRectSize
        ImageLabel.Image = NewImage
        Image.Image = NewImage
    end

    function Image:SetColor(Color)
        assert(typeof(Color) == "Color3", "Color must be a Color3 value.")
        ImageLabel.ImageColor3 = Color
        Image.Color = Color
    end

    function Image:SetRectOffset(RectOffset)
        assert(typeof(RectOffset) == "Vector2", "RectOffset must be a Vector2 value.")
        ImageLabel.ImageRectOffset = RectOffset
        Image.RectOffset = RectOffset
    end

    function Image:SetRectSize(RectSize)
        assert(typeof(RectSize) == "Vector2", "RectSize must be a Vector2 value.")
        ImageLabel.ImageRectSize = RectSize
        Image.RectSize = RectSize
    end

    function Image:SetScaleType(ScaleType)
        assert(typeof(ScaleType) == "EnumItem" and ScaleType:IsA("ScaleType"), "ScaleType must be a valid Enum.ScaleType.")
        ImageLabel.ScaleType = ScaleType
        Image.ScaleType = ScaleType
    end

    function Image:SetTransparency(Transparency)
        assert(typeof(Transparency) == "number", "Transparency must be a number between 0 and 1.")
        assert(Transparency >= 0 and Transparency <= 1, "Transparency must be between 0 and 1.")
        ImageLabel.ImageTransparency = Transparency
        Image.Transparency = Transparency
    end

    function Image:SetVisible(Visible)
        Image.Visible = Visible
        Holder.Visible = Image.Visible
        Groupbox:Resize()
    end

    Groupbox:Resize()
    Image.Holder = Holder
    table.insert(Groupbox.Elements, Image)
    Library.Options[Idx] = Image
    return Image
end

function BaseGroupbox:AddVideo(Idx, Info)
    Info = Library:Validate(Info, Templates.Video)

    local Groupbox = self
    local Container = Groupbox.Container

    local Video = {
        Video = Info.Video,
        Looped = Info.Looped,
        Playing = Info.Playing,
        Volume = Info.Volume,
        Height = Info.Height,
        Visible = Info.Visible,
        Type = "Video",
    }

    local Holder = Instance.new("Frame")
    Holder.BackgroundTransparency = 1
    Holder.Size = UDim2.new(1, 0, 0, Info.Height)
    Holder.Visible = Video.Visible
    Holder.Parent = Container

    local Box = Instance.new("Frame")
    Box.AnchorPoint = Vector2.new(0, 1)
    Box.BackgroundColor3 = "MainColor"
    Box.BorderColor3 = "OutlineColor"
    Box.BorderSizePixel = 1
    Box.Position = UDim2.fromScale(0, 1)
    Box.Size = UDim2.fromScale(1, 1)
    Box.Parent = Holder

    local BoxPadding = Instance.new("UIPadding")
    BoxPadding.PaddingBottom = UDim.new(0, 3)
    BoxPadding.PaddingLeft = UDim.new(0, 8)
    BoxPadding.PaddingRight = UDim.new(0, 8)
    BoxPadding.PaddingTop = UDim.new(0, 4)
    BoxPadding.Parent = Box

    local VideoFrameInstance = Instance.new("VideoFrame")
    VideoFrameInstance.BackgroundTransparency = 1
    VideoFrameInstance.Size = UDim2.fromScale(1, 1)
    VideoFrameInstance.Video = Video.Video
    VideoFrameInstance.Looped = Video.Looped
    VideoFrameInstance.Volume = Video.Volume
    VideoFrameInstance.Parent = Box

    VideoFrameInstance.Playing = Video.Playing

    function Video:SetHeight(Height)
        assert(Height > 0, "Height must be greater than 0.")
        Video.Height = Height
        Holder.Size = UDim2.new(1, 0, 0, Height)
        Groupbox:Resize()
    end

    function Video:SetVideo(NewVideo)
        assert(typeof(NewVideo) == "string", "Video must be a string.")
        VideoFrameInstance.Video = NewVideo
        Video.Video = NewVideo
    end

    function Video:SetLooped(Looped)
        assert(typeof(Looped) == "boolean", "Looped must be a boolean.")
        VideoFrameInstance.Looped = Looped
        Video.Looped = Looped
    end

    function Video:SetVolume(Volume)
        assert(typeof(Volume) == "number", "Volume must be a number between 0 and 10.")
        VideoFrameInstance.Volume = Volume
        Video.Volume = Volume
    end

    function Video:SetPlaying(Playing)
        assert(typeof(Playing) == "boolean", "Playing must be a boolean.")
        VideoFrameInstance.Playing = Playing
        Video.Playing = Playing
    end

    function Video:Play()
        VideoFrameInstance.Playing = true
        Video.Playing = true
    end

    function Video:Pause()
        VideoFrameInstance.Playing = false
        Video.Playing = false
    end

    function Video:SetVisible(Visible)
        Video.Visible = Visible
        Holder.Visible = Video.Visible
        Groupbox:Resize()
    end

    Groupbox:Resize()
    Video.Holder = Holder
    Video.VideoFrame = VideoFrameInstance
    table.insert(Groupbox.Elements, Video)
    Library.Options[Idx] = Video
    return Video
end

function BaseGroupbox:AddUIPassthrough(Idx, Info)
    Info = Library:Validate(Info, Templates.UIPassthrough)

    local Groupbox = self
    local Container = Groupbox.Container

    assert(Info.Instance, "Instance must be provided.")
    assert(typeof(Info.Instance) == "Instance" and Info.Instance:IsA("GuiBase2d"), "Instance must inherit from GuiBase2d.")
    assert(typeof(Info.Height) == "number" and Info.Height > 0, "Height must be a number greater than 0.")

    local Passthrough = {
        Instance = Info.Instance,
        Height = Info.Height,
        Visible = Info.Visible,
        Type = "UIPassthrough",
    }

    local Holder = Instance.new("Frame")
    Holder.BackgroundTransparency = 1
    Holder.Size = UDim2.new(1, 0, 0, Info.Height)
    Holder.Visible = Passthrough.Visible
    Holder.Parent = Container

    Passthrough.Instance.Parent = Holder
    Groupbox:Resize()

    function Passthrough:SetHeight(Height)
        assert(typeof(Height) == "number" and Height > 0, "Height must be a number greater than 0.")
        Passthrough.Height = Height
        Holder.Size = UDim2.new(1, 0, 0, Height)
        Groupbox:Resize()
    end

    function Passthrough:SetInstance(Instance)
        assert(Instance, "Instance must be provided.")
        assert(typeof(Instance) == "Instance" and Instance:IsA("GuiBase2d"), "Instance must inherit from GuiBase2d.")
        if Passthrough.Instance then
            Passthrough.Instance.Parent = nil
        end
        Passthrough.Instance = Instance
        Passthrough.Instance.Parent = Holder
    end

    function Passthrough:SetVisible(Visible)
        Passthrough.Visible = Visible
        Holder.Visible = Passthrough.Visible
        Groupbox:Resize()
    end

    Passthrough.Holder = Holder
    table.insert(Groupbox.Elements, Passthrough)
    Library.Options[Idx] = Passthrough
    return Passthrough
end

function BaseGroupbox:AddDependencyBox()
    local Groupbox = self
    local Container = Groupbox.Container

    local DepboxContainer = Instance.new("Frame")
    DepboxContainer.BackgroundTransparency = 1
    DepboxContainer.Size = UDim2.fromScale(1, 1)
    DepboxContainer.Visible = false
    DepboxContainer.Parent = Container

    local DepboxList = Instance.new("UIListLayout")
    DepboxList.Padding = UDim.new(0, 8)
    DepboxList.Parent = DepboxContainer

    local Depbox = {
        Visible = false,
        Dependencies = {},
        Holder = DepboxContainer,
        Container = DepboxContainer,
        Elements = {},
        DependencyBoxes = {},
    }

    function Depbox:Resize()
        DepboxContainer.Size = UDim2.new(1, 0, 0, DepboxList.AbsoluteContentSize.Y / Library.DPIScale)
        Groupbox:Resize()
    end

    function Depbox:Update(CancelSearch)
        for _, Dependency in Depbox.Dependencies do
            local Element = Dependency[1]
            local Value = Dependency[2]

            if Element.Type == "Toggle" and Element.Value ~= Value then
                DepboxContainer.Visible = false
                Depbox.Visible = false
                return
            elseif Element.Type == "Dropdown" then
                if typeof(Element.Value) == "table" then
                    if not Element.Value[Value] then
                        DepboxContainer.Visible = false
                        Depbox.Visible = false
                        return
                    end
                else
                    if Element.Value ~= Value then
                        DepboxContainer.Visible = false
                        Depbox.Visible = false
                        return
                    end
                end
            end
        end

        Depbox.Visible = true
        DepboxContainer.Visible = true
        if not Library.Searching then
            task.defer(function()
                Depbox:Resize()
            end)
        elseif not CancelSearch then
            Library:UpdateSearch(Library.SearchText)
        end
    end

    DepboxList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        if not Depbox.Visible then return end
        Depbox:Resize()
    end)

    function Depbox:SetupDependencies(Dependencies)
        for _, Dependency in Dependencies do
            assert(typeof(Dependency) == "table", "Dependency should be a table.")
            assert(Dependency[1] ~= nil, "Dependency is missing element.")
            assert(Dependency[2] ~= nil, "Dependency is missing expected value.")
        end
        Depbox.Dependencies = Dependencies
        Depbox:Update()
    end

    DepboxContainer:GetPropertyChangedSignal("Visible"):Connect(function()
        Depbox:Resize()
    end)

    setmetatable(Depbox, BaseGroupbox)
    table.insert(Groupbox.DependencyBoxes, Depbox)
    table.insert(Library.DependencyBoxes, Depbox)
    return Depbox
end

function BaseGroupbox:AddDependencyGroupbox()
    local Groupbox = self
    local Tab = Groupbox.Tab
    local BoxHolder = Groupbox.BoxHolder

    local DepGroupboxContainer = Instance.new("Frame")
    DepGroupboxContainer.BackgroundColor3 = "BackgroundColor"
    DepGroupboxContainer.Size = UDim2.fromScale(1, 0)
    DepGroupboxContainer.Visible = false
    DepGroupboxContainer.Parent = BoxHolder

    local DepGroupboxCorner = Instance.new("UICorner")
    DepGroupboxCorner.CornerRadius = UDim.new(0, Library.CornerRadius)
    DepGroupboxCorner.Parent = DepGroupboxContainer

    Library:AddOutline(DepGroupboxContainer)

    local DepGroupboxList = Instance.new("UIListLayout")
    DepGroupboxList.Padding = UDim.new(0, 8)
    DepGroupboxList.Parent = DepGroupboxContainer

    local DepGroupboxPadding = Instance.new("UIPadding")
    DepGroupboxPadding.PaddingBottom = UDim.new(0, 7)
    DepGroupboxPadding.PaddingLeft = UDim.new(0, 7)
    DepGroupboxPadding.PaddingRight = UDim.new(0, 7)
    DepGroupboxPadding.PaddingTop = UDim.new(0, 7)
    DepGroupboxPadding.Parent = DepGroupboxContainer

    local DepGroupbox = {
        Visible = false,
        Dependencies = {},
        BoxHolder = BoxHolder,
        Holder = DepGroupboxContainer,
        Container = DepGroupboxContainer,
        Tab = Tab,
        Elements = {},
        DependencyBoxes = {},
    }

    function DepGroupbox:Resize()
        DepGroupboxContainer.Size = UDim2.new(1, 0, 0, (DepGroupboxList.AbsoluteContentSize.Y / Library.DPIScale) + 18)
    end

    function DepGroupbox:Update(CancelSearch)
        for _, Dependency in DepGroupbox.Dependencies do
            local Element = Dependency[1]
            local Value = Dependency[2]

            if Element.Type == "Toggle" and Element.Value ~= Value then
                DepGroupboxContainer.Visible = false
                DepGroupbox.Visible = false
                return
            elseif Element.Type == "Dropdown" then
                if typeof(Element.Value) == "table" then
                    if not Element.Value[Value] then
                        DepGroupboxContainer.Visible = false
                        DepGroupbox.Visible = false
                        return
                    end
                else
                    if Element.Value ~= Value then
                        DepGroupboxContainer.Visible = false
                        DepGroupbox.Visible = false
                        return
                    end
                end
            end
        end

        DepGroupbox.Visible = true
        if not Library.Searching then
            DepGroupboxContainer.Visible = true
            DepGroupbox:Resize()
        elseif not CancelSearch then
            Library:UpdateSearch(Library.SearchText)
        end
    end

    function DepGroupbox:SetupDependencies(Dependencies)
        for _, Dependency in Dependencies do
            assert(typeof(Dependency) == "table", "Dependency should be a table.")
            assert(Dependency[1] ~= nil, "Dependency is missing element.")
            assert(Dependency[2] ~= nil, "Dependency is missing expected value.")
        end
        DepGroupbox.Dependencies = Dependencies
        DepGroupbox:Update()
    end

    setmetatable(DepGroupbox, BaseGroupbox)
    table.insert(Tab.DependencyGroupboxes, DepGroupbox)
    table.insert(Library.DependencyBoxes, DepGroupbox)
    return DepGroupbox
end

-- Helper Functions
local function GetTableSize(Table)
    local Size = 0
    for _, _ in Table do
        Size += 1
    end
    return Size
end

local function GetPlayers(ExcludeLocalPlayer)
    local PlayerList = Library.Players:GetPlayers()
    if ExcludeLocalPlayer then
        local Idx = table.find(PlayerList, Library.LocalPlayer)
        if Idx then
            table.remove(PlayerList, Idx)
        end
    end
    table.sort(PlayerList, function(Player1, Player2)
        return Player1.Name:lower() < Player2.Name:lower()
    end)
    return PlayerList
end

local function GetTeams()
    local TeamList = Library.Teams:GetTeams()
    table.sort(TeamList, function(Team1, Team2)
        return Team1.Name:lower() < Team2.Name:lower()
    end)
    return TeamList
end

local function Round(Value, Rounding)
    assert(Rounding >= 0, "Invalid rounding number.")
    if Rounding == 0 then
        return math.floor(Value)
    end
    return tonumber(string.format("%." .. Rounding .. "f", Value))
end

-- Export
return {
    Templates = Templates,
    BaseAddons = BaseAddons,
    BaseGroupbox = BaseGroupbox,
    GetPlayers = GetPlayers,
    GetTeams = GetTeams,
    Round = Round,
    GetTableSize = GetTableSize,
}
