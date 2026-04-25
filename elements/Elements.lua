-- =============================================================================
-- Elements.lua
-- Modul terpisah untuk semua elemen UI VoraHub
-- Version: 2.2 (Complete - Full Features)
-- =============================================================================

-- ------------------------------------------------------------
-- Services & Utilitas Dasar
-- ------------------------------------------------------------
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local TextService = game:GetService("TextService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

-- ------------------------------------------------------------
-- Font Support
-- ------------------------------------------------------------
local Font = {
    new = function(family, weight, style)
        return {
            __vora_font = true,
            Family = family or "rbxasset://fonts/families/GothamSSm.json",
            Weight = weight or Enum.FontWeight.SemiBold,
            Style = style or Enum.FontStyle.Normal
        }
    end,
    fromEnum = function(enumFont)
        return {
            __vora_font = true,
            EnumFont = enumFont or Enum.Font.GothamSemibold
        }
    end
}

local function apply_font(instance, fontConfig)
    if not instance then return end
    if type(fontConfig) == "table" and fontConfig.__vora_font then
        if fontConfig.EnumFont then
            pcall(function() instance.Font = fontConfig.EnumFont end)
        elseif fontConfig.Family then
            pcall(function()
                instance.FontFace = Font.new(fontConfig.Family, fontConfig.Weight, fontConfig.Style)
            end)
        end
    elseif fontConfig then
        pcall(function() instance.Font = fontConfig end)
    end
end

-- ------------------------------------------------------------
-- Safe Viewport Size (with fallback)
-- ------------------------------------------------------------
local function get_safe_viewport_size()
    local success, camera = pcall(function() return workspace.CurrentCamera end)
    if success and camera then
        local viewportSize = camera.ViewportSize
        if viewportSize and viewportSize.X > 0 and viewportSize.Y > 0 then
            return viewportSize
        end
    end
    return Vector2.new(1920, 1080)
end

-- ------------------------------------------------------------
-- Core Utilities
-- ------------------------------------------------------------
local function tween_to(instance, properties, duration, easingStyle, easingDirection)
    local tween = TweenService:Create(instance, TweenInfo.new(duration or 0.22, easingStyle or Enum.EasingStyle.Quint, easingDirection or Enum.EasingDirection.Out), properties)
    tween:Play()
    return tween
end

local function create(className, properties)
    local inst = Instance.new(className)
    for prop, val in pairs(properties) do
        if prop ~= "Parent" then
            pcall(function() inst[prop] = val end)
        end
    end
    if properties.Parent then inst.Parent = properties.Parent end
    return inst
end

local function measure_text_width(text, textSize, font)
    local bounds = TextService:GetTextSize(text, textSize, font or Enum.Font.GothamSemibold, Vector2.new(math.huge, math.huge))
    return bounds.X
end

local function normalize_search(text)
    return string.lower(tostring(text or "")):gsub("^%s+", ""):gsub("%s+$", "")
end

local function get_decimal_places(value)
    if type(value) ~= "number" then return 0 end
    local s = tostring(value)
    local dec = s:match("%.(%d+)")
    if dec then return #dec end
    local exp = s:match("[eE]([%+%-]?%d+)")
    if exp then
        local e = tonumber(exp) or 0
        if e < 0 then return -e end
    end
    return 0
end

local function round_to_decimals(value, decimals)
    if decimals <= 0 then
        if value >= 0 then return math.floor(value + 0.5) else return math.ceil(value - 0.5) end
    end
    local factor = 10 ^ decimals
    if value >= 0 then return math.floor(value * factor + 0.5) / factor
    else return math.ceil(value * factor - 0.5) / factor end
end

local function resolve_precision(minValue, maxValue, increment, defaultValue)
    local prec = 0
    prec = math.max(prec, get_decimal_places(minValue))
    prec = math.max(prec, get_decimal_places(maxValue))
    prec = math.max(prec, get_decimal_places(increment))
    prec = math.max(prec, get_decimal_places(defaultValue))
    return math.clamp(prec, 0, 6)
end

local function normalize_slider_value(value, minValue, maxValue, increment, precision)
    local num = tonumber(value) or minValue
    num = math.clamp(num, minValue, maxValue)
    local inc = math.max(math.abs(tonumber(increment) or 1), 1e-6)
    local steps = math.floor(((num - minValue) / inc) + 0.5)
    local snapped = minValue + (steps * inc)
    snapped = round_to_decimals(snapped, precision)
    return math.clamp(snapped, minValue, maxValue)
end

local function format_slider_value(value, precision)
    if precision <= 0 then return tostring(round_to_decimals(value, 0)) end
    local formatted = string.format("%." .. precision .. "f", value)
    formatted = formatted:gsub("(%..-)0+$", "%1"):gsub("%.$", "")
    return formatted
end

local function normalize_dropdown(options)
    local normalized = {}
    if type(options) == "table" then
        for _, opt in ipairs(options) do
            if opt ~= nil then table.insert(normalized, opt) end
        end
    end
    if #normalized == 0 then normalized[1] = "None" end
    return normalized
end

local function get_dropdown_signature(options)
    if type(options) ~= "table" then return "0" end
    local count = #options
    if count <= 0 then return "0" end
    local pieces = { tostring(count) }
    for _, opt in ipairs(options) do
        pieces[#pieces+1] = tostring(opt)
    end
    return table.concat(pieces, "\31")
end

-- ------------------------------------------------------------
-- Elemen: TOGGLE
-- ------------------------------------------------------------
local function CreateToggle(parent, config, scale, accentColor)
    scale = scale or 1
    accentColor = accentColor or Color3.fromRGB(0,133,255)
    local state = config.Default == true
    local yPos = config.yPosition or 0

    local label = create("TextLabel", {
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
        TextColor3 = Color3.fromRGB(124,124,124),
        Text = config.Name,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10*scale, 0, yPos),
        TextSize = 14.6*scale,
        Size = UDim2.new(0, 195*scale, 0, 20*scale),
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Parent = parent
    })

    local switchFrame = create("Frame", {
        BackgroundColor3 = state and accentColor or Color3.fromRGB(32,32,32),
        Position = UDim2.new(1, -44*scale, 0, yPos),
        Size = UDim2.new(0, 36*scale, 0, 22*scale),
        Parent = parent
    })
    create("UICorner", {CornerRadius = UDim.new(1,0), Parent = switchFrame})

    local circleFrame = create("Frame", {
        BackgroundColor3 = state and Color3.new(1,1,1) or Color3.fromRGB(75,75,75),
        Position = state and UDim2.new(0.462, 0, 0.143, 0) or UDim2.new(0.0104, 0, 0.143, 0),
        Size = UDim2.new(0, 16*scale, 0, 16*scale),
        Parent = switchFrame
    })
    create("UICorner", {CornerRadius = UDim.new(1,0), Parent = circleFrame})

    local button = create("TextButton", {
        Text = "", BackgroundTransparency = 1, Size = UDim2.new(1,0,1,0),
        Parent = switchFrame
    })

    local connections = {}
    local function setValue(value, silent)
        state = value == true
        if state then
            tween_to(switchFrame, {BackgroundColor3 = accentColor}, 0.2)
            tween_to(circleFrame, {Position = UDim2.new(0.462, 0, 0.143, 0), BackgroundColor3 = Color3.new(1,1,1)}, 0.2, Enum.EasingStyle.Back)
        else
            tween_to(switchFrame, {BackgroundColor3 = Color3.fromRGB(32,32,32)}, 0.2)
            tween_to(circleFrame, {Position = UDim2.new(0.0104, 0, 0.143, 0), BackgroundColor3 = Color3.fromRGB(75,75,75)}, 0.2, Enum.EasingStyle.Back)
        end
        if not silent and config.Callback then config.Callback(state) end
    end

    table.insert(connections, button.MouseButton1Click:Connect(function() setValue(not state, false) end))

    local api = {
        Set = setValue,
        Get = function() return state end,
        Value = state,
        _updateAccent = function(newColor)
            accentColor = newColor
            if state then
                switchFrame.BackgroundColor3 = newColor
            end
        end,
        Close = function()
            for _, conn in ipairs(connections) do conn:Disconnect() end
            label:Destroy(); switchFrame:Destroy()
        end
    }
    return api
end

-- ------------------------------------------------------------
-- Elemen: SLIDER
-- ------------------------------------------------------------
local function CreateSlider(parent, config, scale, accentColor)
    scale = scale or 1
    accentColor = accentColor or Color3.fromRGB(0,133,255)
    local min = tonumber(config.Min) or 0
    local max = tonumber(config.Max) or 100
    if max < min then min, max = max, min end
    local inc = math.abs(tonumber(config.Increment) or 1)
    local defaultValue = tonumber(config.Default) or min
    local suffix = tostring(config.Suffix or "")
    local showMax = config.ShowMax == true

    local precision = resolve_precision(min, max, inc, defaultValue)
    local range = max - min
    local function getPercentage(value) return range <= 0 and 0 or math.clamp((value - min) / range, 0, 1) end
    local function formatDisplay(value)
        local txt = format_slider_value(value, precision) .. suffix
        if showMax then return txt .. " / " .. format_slider_value(max, precision) .. suffix end
        return txt
    end

    local valueObj = normalize_slider_value(defaultValue, min, max, inc, precision)
    local yPos = config.yPosition or 0
    local valueLabelWidth = 72 * scale
    local padding = 10 * scale

    local label = create("TextLabel", {
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
        TextColor3 = Color3.fromRGB(118,118,130),
        Text = config.Name,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, padding, 0, yPos),
        TextSize = 14.2*scale,
        Size = UDim2.new(1, -valueLabelWidth - padding*3, 0, 19*scale),
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Parent = parent
    })

    local bgFrame = create("Frame", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, padding, 0, yPos + 20*scale),
        Size = UDim2.new(1, -padding*2, 0, 20*scale),
        Parent = parent
    })

    local track = create("Frame", {
        BackgroundColor3 = Color3.fromRGB(43,43,51),
        BorderSizePixel = 0,
        Position = UDim2.new(0,0,0.5,-4*scale),
        Size = UDim2.new(1,0,0,8*scale),
        Parent = bgFrame
    })
    create("UICorner", {CornerRadius = UDim.new(1,0), Parent = track})

    local fill = create("Frame", {
        BackgroundColor3 = accentColor,
        BorderSizePixel = 0,
        Size = UDim2.new(getPercentage(valueObj),0,1,0),
        Parent = track
    })
    create("UICorner", {CornerRadius = UDim.new(1,0), Parent = fill})

    local knob = create("Frame", {
        BackgroundColor3 = Color3.fromRGB(244,244,248),
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5,0.5),
        Position = UDim2.new(getPercentage(valueObj),0,0.5,0),
        Size = UDim2.new(0, 16*scale, 0, 16*scale),
        ZIndex = 2,
        Parent = bgFrame
    })
    create("UICorner", {CornerRadius = UDim.new(1,0), Parent = knob})
    create("UIStroke", {Color = Color3.fromRGB(196,196,204), Thickness = 1, Parent = knob})

    local valueLabel = create("TextLabel", {
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
        TextColor3 = Color3.fromRGB(184,184,194),
        Text = formatDisplay(valueObj),
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -valueLabelWidth - padding, 0, yPos),
        TextSize = 14.2*scale,
        Size = UDim2.new(0, valueLabelWidth, 0, 19*scale),
        TextXAlignment = Enum.TextXAlignment.Right,
        Parent = parent
    })

    local clickButton = create("TextButton", {Text="", BackgroundTransparency=1, Size=UDim2.new(1,0,1,0), Parent=bgFrame})
    local connections = {}
    local isDragging = false
    local activeInput = nil

    local function updateVisuals(animate)
        local perc = getPercentage(valueObj)
        if animate then
            tween_to(fill, {Size = UDim2.new(perc,0,1,0)}, 0.12)
            tween_to(knob, {Position = UDim2.new(perc,0,0.5,0)}, 0.12, Enum.EasingStyle.Quint)
        else
            fill.Size = UDim2.new(perc,0,1,0)
            knob.Position = UDim2.new(perc,0,0.5,0)
        end
        valueLabel.Text = formatDisplay(valueObj)
    end

    local function setValue(value, instant, silent)
        valueObj = normalize_slider_value(value, min, max, inc, precision)
        updateVisuals(not instant)
        if not silent and config.Callback then config.Callback(valueObj) end
    end

    local function setFromInput(input, instant)
        if not input then return end
        local perc = math.clamp((input.Position.X - bgFrame.AbsolutePosition.X) / math.max(1, bgFrame.AbsoluteSize.X), 0, 1)
        setValue(min + range * perc, instant, false)
    end

    table.insert(connections, clickButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDragging = true
            activeInput = input.UserInputType == Enum.UserInputType.Touch and input or nil
            setFromInput(input, true)
        end
    end))

    local inputEndedConn = UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or (input.UserInputType == Enum.UserInputType.Touch and (activeInput == nil or input == activeInput)) then
            isDragging = false
            activeInput = nil
        end
    end)
    table.insert(connections, inputEndedConn)

    local inputChangedConn = UserInputService.InputChanged:Connect(function(input)
        if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or (input.UserInputType == Enum.UserInputType.Touch and (activeInput == nil or input == activeInput))) then
            setFromInput(input, true)
        end
    end)
    table.insert(connections, inputChangedConn)

    updateVisuals(false)

    local api = {
        Set = setValue,
        Get = function() return valueObj end,
        Value = valueObj,
        _updateAccent = function(newColor)
            accentColor = newColor
            fill.BackgroundColor3 = newColor
        end,
        Close = function()
            for _, conn in ipairs(connections) do conn:Disconnect() end
            label:Destroy(); bgFrame:Destroy(); valueLabel:Destroy()
        end
    }
    return api
end

-- ------------------------------------------------------------
-- Elemen: DROPDOWN (Single-select + Search)
-- ------------------------------------------------------------
local function CreateDropdown(parent, config, scale, accentColor, dropdownHolder)
    scale = scale or 1
    accentColor = accentColor or Color3.fromRGB(0,133,255)
    local options = normalize_dropdown(config.Options or {"Option 1","Option 2"})
    local default = config.Default
    if not table.find(options, default) then default = options[1] or "None" end
    local value = default
    local isOpen = false
    local yPos = config.yPosition or 0

    local label = create("TextLabel", {
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
        TextColor3 = Color3.fromRGB(124,124,124),
        Text = config.Name,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10*scale, 0, yPos),
        TextSize = 13.8*scale,
        Size = UDim2.new(0, 130*scale, 0, 20*scale),
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Parent = parent
    })

    local displayText = tostring(value)
    local btnWidth = math.max(70*scale, measure_text_width(displayText, 12*scale, Enum.Font.GothamSemibold) + 30*scale)
    local buttonFrame = create("Frame", {
        BackgroundColor3 = Color3.fromRGB(32,32,32),
        Position = UDim2.new(1, -btnWidth - 10*scale, 0, yPos),
        Size = UDim2.new(0, btnWidth, 0, 23*scale),
        Parent = parent
    })
    create("UICorner", {CornerRadius = UDim.new(1,0), Parent = buttonFrame})
    local stroke = create("UIStroke", {Color = Color3.fromRGB(44,44,44), Parent = buttonFrame})

    local selectedLabel = create("TextLabel", {
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
        TextColor3 = Color3.fromRGB(84,84,84),
        Text = displayText,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 8*scale, 0, 0),
        TextSize = 12.8*scale,
        Size = UDim2.new(1, -28*scale, 1, 0),
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Parent = buttonFrame
    })
    local arrow = create("ImageLabel", {
        ImageColor3 = Color3.fromRGB(80,80,80),
        Image = "rbxassetid://111626678408582",
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -20*scale, 0.5, -7.5*scale),
        Size = UDim2.new(0, 15*scale, 0, 15*scale),
        Parent = buttonFrame
    })

    local popupWidth = math.max(180*scale, btnWidth + 20*scale)
    local optionHolder = create("Frame", {
        BackgroundColor3 = Color3.fromRGB(16,16,16),
        Size = UDim2.new(0, popupWidth, 0, 0),
        ClipsDescendants = true, Visible = false, ZIndex = 9999,
        Parent = dropdownHolder
    })
    create("UICorner", {CornerRadius = UDim.new(0,8), Parent = optionHolder})
    create("UIStroke", {Color = Color3.fromRGB(40,40,40), Parent = optionHolder})

    create("TextLabel", {
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
        TextColor3 = Color3.new(1,1,1),
        Text = config.Name,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12*scale, 0, 7*scale),
        TextSize = 13*scale,
        Size = UDim2.new(1, -44*scale, 0, 20*scale),
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 10000,
        Parent = optionHolder
    })

    local closeBtn = create("Frame", {
        BackgroundColor3 = Color3.fromRGB(26,26,26),
        Position = UDim2.new(1, -26*scale, 0, 6*scale),
        Size = UDim2.new(0, 18*scale, 0, 18*scale),
        ZIndex = 10002,
        Parent = optionHolder
    })
    create("UICorner", {CornerRadius = UDim.new(1,0), Parent = closeBtn})
    local closeIcon = create("ImageLabel", {
        Image = "rbxassetid://10747384394",
        ImageColor3 = Color3.fromRGB(130,130,130),
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5,0.5),
        Position = UDim2.new(0.5,0,0.5,0),
        Size = UDim2.new(0.6,0,0.6,0),
        ZIndex = 10003,
        Parent = closeBtn
    })
    local closeClick = create("TextButton", {Text="", BackgroundTransparency=1, Size=UDim2.new(1,0,1,0), ZIndex=10004, Parent=closeBtn})

    local searchFrame = create("Frame", {
        BackgroundColor3 = Color3.fromRGB(22,22,22),
        Position = UDim2.new(0, 8*scale, 0, 32*scale),
        Size = UDim2.new(1, -16*scale, 0, 22*scale),
        ZIndex = 10001,
        Parent = optionHolder
    })
    create("UICorner", {CornerRadius = UDim.new(0,5), Parent = searchFrame})
    create("UIStroke", {Color = Color3.fromRGB(50,50,50), Thickness = 1, Parent = searchFrame})
    local searchBox = create("TextBox", {
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular),
        TextColor3 = Color3.fromRGB(200,200,200),
        PlaceholderColor3 = Color3.fromRGB(70,70,70),
        PlaceholderText = "Search...",
        Text = "",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 8*scale, 0, 0),
        TextSize = 12*scale,
        Size = UDim2.new(1, -16*scale, 1, 0),
        TextXAlignment = Enum.TextXAlignment.Left,
        ClearTextOnFocus = false,
        ZIndex = 10002,
        Parent = searchFrame
    })

    local optionScroll = create("ScrollingFrame", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0,0,0,58*scale),
        Size = UDim2.new(1,0,1,-63*scale),
        ScrollBarThickness = 0,
        ZIndex = 10000,
        Parent = optionHolder
    })
    local optionContainer = create("Frame", {BackgroundTransparency=1, Size=UDim2.new(1,-6*scale,0,0), ZIndex=10000, Parent=optionScroll})

    local maxHeight = 200 * scale
    local positionConn = nil
    local connections = {}
    local searchQuery = ""

    local function updateOptions(filter)
        for _, child in pairs(optionContainer:GetChildren()) do
            if child:IsA("TextLabel") or child:IsA("TextButton") then child:Destroy() end
        end
        local filtered = {}
        for _, opt in ipairs(options) do
            if filter == "" or string.find(opt:lower(), filter:lower(), 1, true) then
                table.insert(filtered, opt)
            end
        end
        local optY = 0
        for _, opt in ipairs(filtered) do
            local isSelected = (value == opt)
            local optLabel = create("TextLabel", {
                FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
                TextColor3 = isSelected and accentColor or Color3.fromRGB(124,124,124),
                Text = opt,
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 12*scale, 0, optY),
                TextSize = 14*scale,
                Size = UDim2.new(1, -24*scale, 0, 18*scale),
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                ZIndex = 10001,
                Parent = optionContainer
            })
            local optBtn = create("TextButton", {
                Text = "", BackgroundTransparency = 1,
                Position = UDim2.new(0,0,0,optY),
                Size = UDim2.new(1,0,0,20*scale),
                ZIndex = 10002,
                Parent = optionContainer
            })
            table.insert(connections, optBtn.MouseButton1Click:Connect(function()
                value = opt
                selectedLabel.Text = tostring(value)
                local newWidth = math.max(70*scale, measure_text_width(tostring(value), 12*scale, Enum.Font.GothamSemibold) + 30*scale)
                tween_to(buttonFrame, {Size = UDim2.new(0, newWidth, 0, 23*scale), Position = UDim2.new(1, -newWidth - 10*scale, 0, yPos)}, 0.15)
                closeDropdown(false)
                if config.Callback then config.Callback(value) end
            end))
            table.insert(connections, optBtn.MouseEnter:Connect(function()
                if value ~= opt then tween_to(optLabel, {TextColor3 = Color3.fromRGB(180,180,180)}, 0.2) end
            end))
            table.insert(connections, optBtn.MouseLeave:Connect(function()
                if value ~= opt then tween_to(optLabel, {TextColor3 = Color3.fromRGB(124,124,124)}, 0.2) end
            end))
            optY = optY + 22 * scale
        end
        optionContainer.Size = UDim2.new(1, -6*scale, 0, optY)
        optionScroll.CanvasSize = UDim2.new(0,0,0,optY)
        if isOpen then
            local targetH = math.min((63 + optY/scale) * scale, maxHeight)
            tween_to(optionHolder, {Size = UDim2.new(0, popupWidth, 0, targetH)}, 0.14)
        end
    end

    local function closeDropdown(instant)
        isOpen = false
        if positionConn then positionConn(); positionConn = nil end
        searchBox.Text = ""; searchQuery = ""
        if instant then
            optionHolder.Size = UDim2.new(0, popupWidth, 0, 0)
            optionHolder.Visible = false
            arrow.Rotation = 0
            buttonFrame.BackgroundColor3 = Color3.fromRGB(32,32,32)
            stroke.Color = Color3.fromRGB(44,44,44)
            return
        end
        tween_to(optionHolder, {Size = UDim2.new(0, popupWidth, 0, 0)}, 0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
        tween_to(arrow, {Rotation = 0}, 0.2)
        tween_to(buttonFrame, {BackgroundColor3 = Color3.fromRGB(32,32,32)}, 0.18)
        tween_to(stroke, {Color = Color3.fromRGB(44,44,44)}, 0.18)
        task.delay(0.22, function()
            if not isOpen and optionHolder.Parent then optionHolder.Visible = false end
        end)
    end

    local function updatePosition()
        local absPos = buttonFrame.AbsolutePosition
        local absSize = buttonFrame.AbsoluteSize
        local screenSize = get_safe_viewport_size()
        local popupH = optionHolder.AbsoluteSize.Y
        local rawX = absPos.X
        local rawY = absPos.Y + absSize.Y + 5
        if rawY + popupH > screenSize.Y - 5 then rawY = math.max(5, absPos.Y - popupH - 5) end
        local clampedX = math.clamp(rawX, 5, math.max(5, screenSize.X - popupWidth - 5))
        optionHolder.Position = UDim2.new(0, clampedX, 0, rawY)
    end

    local function openDropdown()
        isOpen = true
        updatePosition()
        optionHolder.Visible = true
        updateOptions("")
        local contentH = (63 + (#options * 22)) * scale
        local height = math.min(contentH, maxHeight)
        tween_to(optionHolder, {Size = UDim2.new(0, popupWidth, 0, height)}, 0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        tween_to(arrow, {Rotation = 180}, 0.24)
        task.defer(function() if searchBox and searchBox.Parent then searchBox:CaptureFocus() end end)
        if positionConn then positionConn() end
        positionConn = RunService.RenderStepped:Connect(function()
            if isOpen then updatePosition() end
        end)
    end

    table.insert(connections, closeClick.MouseButton1Click:Connect(function() closeDropdown(false) end))
    table.insert(connections, closeClick.MouseEnter:Connect(function()
        tween_to(closeBtn, {BackgroundColor3 = Color3.fromRGB(44,44,44)}, 0.12)
        tween_to(closeIcon, {ImageColor3 = Color3.fromRGB(220,220,220)}, 0.12)
    end))
    table.insert(connections, closeClick.MouseLeave:Connect(function()
        tween_to(closeBtn, {BackgroundColor3 = Color3.fromRGB(26,26,26)}, 0.12)
        tween_to(closeIcon, {ImageColor3 = Color3.fromRGB(130,130,130)}, 0.12)
    end))

    table.insert(connections, searchBox:GetPropertyChangedSignal("Text"):Connect(function()
        searchQuery = searchBox.Text
        updateOptions(searchQuery)
    end))

    local dropdownButton = create("TextButton", {Text="", BackgroundTransparency=1, Size=UDim2.new(1,0,1,0), Parent=buttonFrame})
    table.insert(connections, dropdownButton.MouseButton1Click:Connect(function()
        if isOpen then closeDropdown(false) else openDropdown() end
    end))
    table.insert(connections, dropdownButton.MouseEnter:Connect(function()
        tween_to(buttonFrame, {BackgroundColor3 = Color3.fromRGB(48,48,48)}, 0.2)
        tween_to(stroke, {Color = Color3.fromRGB(83,83,83)}, 0.2)
    end))
    table.insert(connections, dropdownButton.MouseLeave:Connect(function()
        if not isOpen then
            tween_to(buttonFrame, {BackgroundColor3 = Color3.fromRGB(32,32,32)}, 0.2)
            tween_to(stroke, {Color = Color3.fromRGB(44,44,44)}, 0.2)
        end
    end))

    updateOptions("")

    local api = {
        Set = function(newVal, silent)
            value = newVal
            selectedLabel.Text = tostring(value)
            local newWidth = math.max(70*scale, measure_text_width(tostring(value), 12*scale, Enum.Font.GothamSemibold) + 30*scale)
            buttonFrame.Size = UDim2.new(0, newWidth, 0, 23*scale)
            buttonFrame.Position = UDim2.new(1, -newWidth - 10*scale, 0, yPos)
            updateOptions(searchQuery)
            if not silent and config.Callback then config.Callback(value) end
        end,
        Get = function() return value end,
        Value = value,
        _updateAccent = function(newColor)
            accentColor = newColor
            updateOptions(searchQuery)
        end,
        UpdateOptions = function(newOptions)
            options = normalize_dropdown(newOptions)
            if not table.find(options, value) then value = options[1] or "None" end
            selectedLabel.Text = tostring(value)
            local newWidth = math.max(70*scale, measure_text_width(tostring(value), 12*scale, Enum.Font.GothamSemibold) + 30*scale)
            buttonFrame.Size = UDim2.new(0, newWidth, 0, 23*scale)
            buttonFrame.Position = UDim2.new(1, -newWidth - 10*scale, 0, yPos)
            updateOptions(searchQuery)
        end,
        SetValues = function(newOptions)
            api.UpdateOptions(newOptions)
        end,
        Close = function()
            closeDropdown(true)
            for _, conn in ipairs(connections) do conn:Disconnect() end
            label:Destroy(); buttonFrame:Destroy(); optionHolder:Destroy()
        end
    }
    return api
end

-- ------------------------------------------------------------
-- Elemen: MULTI DROPDOWN (dengan checkbox)
-- ------------------------------------------------------------
local function CreateMultiDropdown(parent, config, scale, accentColor, dropdownHolder)
    scale = scale or 1
    accentColor = accentColor or Color3.fromRGB(0,133,255)
    local options = normalize_dropdown(config.Options or {"Option 1","Option 2"})
    local selected = {}
    if type(config.Default) == "table" then
        for _, v in ipairs(config.Default) do
            if table.find(options, v) then selected[v] = true end
        end
    end
    local isOpen = false
    local yPos = config.yPosition or 0

    local function getDisplayText()
        local selectedList = {}
        for opt, sel in pairs(selected) do if sel then table.insert(selectedList, opt) end end
        table.sort(selectedList, function(a,b) return tostring(a) < tostring(b) end)
        if #selectedList == 0 then return "None"
        elseif #selectedList == 1 then return selectedList[1]
        elseif #selectedList <= 2 then return table.concat(selectedList, ", ")
        else return #selectedList .. " selected" end
    end

    local function getSelectedArray()
        local arr = {}
        for opt, sel in pairs(selected) do if sel then table.insert(arr, opt) end end
        table.sort(arr, function(a,b) return tostring(a) < tostring(b) end)
        return arr
    end

    local displayText = getDisplayText()
    local btnWidth = math.max(85*scale, measure_text_width(displayText, 12*scale, Enum.Font.GothamSemibold) + 35*scale)

    local label = create("TextLabel", {
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
        TextColor3 = Color3.fromRGB(124,124,124),
        Text = config.Name,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10*scale, 0, yPos),
        TextSize = 14*scale,
        Size = UDim2.new(0, 100*scale, 0, 20*scale),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = parent
    })

    local buttonFrame = create("Frame", {
        BackgroundColor3 = Color3.fromRGB(32,32,32),
        Position = UDim2.new(1, -btnWidth - 10*scale, 0, yPos),
        Size = UDim2.new(0, btnWidth, 0, 21*scale),
        Parent = parent
    })
    create("UICorner", {CornerRadius = UDim.new(1,0), Parent = buttonFrame})
    local stroke = create("UIStroke", {Color = Color3.fromRGB(44,44,44), Parent = buttonFrame})

    local selectedLabel = create("TextLabel", {
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
        TextColor3 = Color3.fromRGB(84,84,84),
        Text = displayText,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 8*scale, 0, 0),
        TextSize = 12*scale,
        Size = UDim2.new(1, -28*scale, 1, 0),
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Parent = buttonFrame
    })
    local arrow = create("ImageLabel", {
        ImageColor3 = Color3.fromRGB(80,80,80),
        Image = "rbxassetid://111626678408582",
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -20*scale, 0.5, -7*scale),
        Size = UDim2.new(0, 14*scale, 0, 14*scale),
        Parent = buttonFrame
    })

    local popupWidth = 180 * scale
    local optionHolder = create("Frame", {
        BackgroundColor3 = Color3.fromRGB(16,16,16),
        Size = UDim2.new(0, popupWidth, 0, 0),
        ClipsDescendants = true, Visible = false, ZIndex = 9999,
        Parent = dropdownHolder
    })
    create("UICorner", {CornerRadius = UDim.new(0,6), Parent = optionHolder})
    create("UIStroke", {Color = Color3.fromRGB(40,40,40), Parent = optionHolder})

    create("TextLabel", {
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
        TextColor3 = Color3.new(1,1,1),
        Text = config.Name,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12*scale, 0, 8*scale),
        TextSize = 14*scale,
        Size = UDim2.new(1, -44*scale, 0, 20*scale),
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 10000,
        Parent = optionHolder
    })
    local closeBtn = create("TextButton", {
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold),
        Text = "X", TextColor3 = Color3.fromRGB(170,170,170), TextSize = 14*scale,
        BackgroundColor3 = Color3.fromRGB(24,24,24), AutoButtonColor = false,
        Position = UDim2.new(1, -25*scale, 0, 5*scale),
        Size = UDim2.new(0, 18*scale, 0, 18*scale),
        ZIndex = 10002,
        Parent = optionHolder
    })
    create("UICorner", {CornerRadius = UDim.new(1,0), Parent = closeBtn})

    local optionScroll = create("ScrollingFrame", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0,0,0,30*scale),
        Size = UDim2.new(1,0,1,-35*scale),
        ScrollBarThickness = 0,
        ZIndex = 10000,
        Parent = optionHolder
    })
    local optionContainer = create("Frame", {BackgroundTransparency=1, Size=UDim2.new(1,-6*scale,0,0), ZIndex=10000, Parent=optionScroll})

    local maxHeight = 220 * scale
    local positionConn = nil
    local connections = {}

    local function updateOptions()
        for _, child in pairs(optionContainer:GetChildren()) do
            if child:IsA("Frame") or child:IsA("TextButton") then child:Destroy() end
        end
        local optY = 0
        for _, opt in ipairs(options) do
            local isSelected = selected[opt] == true
            local row = create("Frame", {
                BackgroundTransparency = 1, Position = UDim2.new(0,0,0,optY),
                Size = UDim2.new(1,0,0,22*scale), ZIndex = 10001,
                Parent = optionContainer
            })
            local checkbox = create("Frame", {
                BackgroundColor3 = isSelected and accentColor or Color3.fromRGB(32,32,32),
                Position = UDim2.new(0, 12*scale, 0.5, -8*scale),
                Size = UDim2.new(0, 16*scale, 0, 16*scale),
                ZIndex = 10002, Parent = row
            })
            create("UICorner", {CornerRadius = UDim.new(0,4), Parent = checkbox})
            local checkImg = create("ImageLabel", {
                Image = "rbxassetid://10709790644", ImageColor3 = Color3.new(1,1,1),
                ImageTransparency = isSelected and 0 or 1, BackgroundTransparency = 1,
                Position = UDim2.new(0.5,0,0.5,0), AnchorPoint = Vector2.new(0.5,0.5),
                Size = UDim2.new(0, 12*scale, 0, 12*scale), ZIndex = 10003, Parent = checkbox
            })
            local optLabel = create("TextLabel", {
                FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
                TextColor3 = isSelected and accentColor or Color3.fromRGB(124,124,124),
                Text = opt, BackgroundTransparency = 1, Position = UDim2.new(0, 34*scale, 0, 0),
                TextSize = 14*scale, Size = UDim2.new(1, -46*scale, 1, 0),
                TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 10002, Parent = row
            })
            local rowBtn = create("TextButton", {Text="", BackgroundTransparency=1, Size=UDim2.new(1,0,1,0), ZIndex=10004, Parent=row})
            table.insert(connections, rowBtn.MouseButton1Click:Connect(function()
                selected[opt] = not selected[opt]
                local now = selected[opt]
                tween_to(checkbox, {BackgroundColor3 = now and accentColor or Color3.fromRGB(32,32,32)}, 0.15)
                tween_to(checkImg, {ImageTransparency = now and 0 or 1}, 0.15)
                tween_to(optLabel, {TextColor3 = now and accentColor or Color3.fromRGB(124,124,124)}, 0.15)
                local newDisplay = getDisplayText()
                selectedLabel.Text = newDisplay
                local newWidth = math.max(85*scale, measure_text_width(newDisplay, 12*scale, Enum.Font.GothamSemibold) + 35*scale)
                tween_to(buttonFrame, {Size = UDim2.new(0, newWidth, 0, 21*scale), Position = UDim2.new(1, -newWidth - 10*scale, 0, yPos)}, 0.15)
                if config.Callback then config.Callback(getSelectedArray()) end
            end))
            table.insert(connections, rowBtn.MouseEnter:Connect(function()
                if not selected[opt] then
                    tween_to(optLabel, {TextColor3 = Color3.fromRGB(180,180,180)}, 0.15)
                    tween_to(checkbox, {BackgroundColor3 = Color3.fromRGB(48,48,48)}, 0.15)
                end
            end))
            table.insert(connections, rowBtn.MouseLeave:Connect(function()
                if not selected[opt] then
                    tween_to(optLabel, {TextColor3 = Color3.fromRGB(124,124,124)}, 0.15)
                    tween_to(checkbox, {BackgroundColor3 = Color3.fromRGB(32,32,32)}, 0.15)
                end
            end))
            optY = optY + 24 * scale
        end
        optionContainer.Size = UDim2.new(1, -6*scale, 0, optY)
        optionScroll.CanvasSize = UDim2.new(0,0,0,optY)
        if isOpen then
            local targetH = math.min((38 + optY/scale) * scale, maxHeight)
            tween_to(optionHolder, {Size = UDim2.new(0, popupWidth, 0, targetH)}, 0.14)
        end
    end

    local function closeMultiDropdown(instant)
        isOpen = false
        if positionConn then positionConn(); positionConn = nil end
        if instant then
            optionHolder.Size = UDim2.new(0, popupWidth, 0, 0)
            optionHolder.Visible = false
            arrow.Rotation = 0
            buttonFrame.BackgroundColor3 = Color3.fromRGB(32,32,32)
            stroke.Color = Color3.fromRGB(44,44,44)
            return
        end
        tween_to(optionHolder, {Size = UDim2.new(0, popupWidth, 0, 0)}, 0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
        tween_to(arrow, {Rotation = 0}, 0.2)
        tween_to(buttonFrame, {BackgroundColor3 = Color3.fromRGB(32,32,32)}, 0.18)
        tween_to(stroke, {Color = Color3.fromRGB(44,44,44)}, 0.18)
        task.delay(0.22, function()
            if not isOpen and optionHolder.Parent then optionHolder.Visible = false end
        end)
    end

    local function updatePosition()
        local absPos = buttonFrame.AbsolutePosition
        local absSize = buttonFrame.AbsoluteSize
        local screenSize = get_safe_viewport_size()
        local popupH = optionHolder.AbsoluteSize.Y
        local rawX = absPos.X
        local rawY = absPos.Y + absSize.Y + 5
        if rawY + popupH > screenSize.Y - 5 then rawY = math.max(5, absPos.Y - popupH - 5) end
        local clampedX = math.clamp(rawX, 5, math.max(5, screenSize.X - popupWidth - 5))
        optionHolder.Position = UDim2.new(0, clampedX, 0, rawY)
    end

    local function openMultiDropdown()
        isOpen = true
        updatePosition()
        optionHolder.Visible = true
        updateOptions()
        local contentH = (38 + (#options * 24)) * scale
        local height = math.min(contentH, maxHeight)
        tween_to(optionHolder, {Size = UDim2.new(0, popupWidth, 0, height)}, 0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        tween_to(arrow, {Rotation = 180}, 0.24)
        if positionConn then positionConn() end
        positionConn = RunService.RenderStepped:Connect(function()
            if isOpen then updatePosition() end
        end)
    end

    table.insert(connections, closeBtn.MouseButton1Click:Connect(function() closeMultiDropdown(false) end))
    table.insert(connections, closeBtn.MouseEnter:Connect(function()
        tween_to(closeBtn, {BackgroundColor3 = Color3.fromRGB(44,44,44), TextColor3 = Color3.fromRGB(220,220,220)}, 0.12)
    end))
    table.insert(connections, closeBtn.MouseLeave:Connect(function()
        tween_to(closeBtn, {BackgroundColor3 = Color3.fromRGB(24,24,24), TextColor3 = Color3.fromRGB(138,138,138)}, 0.12)
    end))

    local dropdownButton = create("TextButton", {Text="", BackgroundTransparency=1, Size=UDim2.new(1,0,1,0), Parent=buttonFrame})
    table.insert(connections, dropdownButton.MouseButton1Click:Connect(function()
        if isOpen then closeMultiDropdown(false) else openMultiDropdown() end
    end))
    table.insert(connections, dropdownButton.MouseEnter:Connect(function()
        tween_to(buttonFrame, {BackgroundColor3 = Color3.fromRGB(48,48,48)}, 0.2)
        tween_to(stroke, {Color = Color3.fromRGB(83,83,83)}, 0.2)
    end))
    table.insert(connections, dropdownButton.MouseLeave:Connect(function()
        if not isOpen then
            tween_to(buttonFrame, {BackgroundColor3 = Color3.fromRGB(32,32,32)}, 0.2)
            tween_to(stroke, {Color = Color3.fromRGB(44,44,44)}, 0.2)
        end
    end))

    updateOptions()

    local api = {
        Set = function(values, silent)
            selected = {}
            if type(values) == "table" then
                for _, v in ipairs(values) do
                    if table.find(options, v) then selected[v] = true end
                end
            end
            local newDisplay = getDisplayText()
            selectedLabel.Text = newDisplay
            local newWidth = math.max(85*scale, measure_text_width(newDisplay, 12*scale, Enum.Font.GothamSemibold) + 35*scale)
            buttonFrame.Size = UDim2.new(0, newWidth, 0, 21*scale)
            buttonFrame.Position = UDim2.new(1, -newWidth - 10*scale, 0, yPos)
            updateOptions()
            if not silent and config.Callback then config.Callback(getSelectedArray()) end
        end,
        Get = getSelectedArray,
        Value = getSelectedArray(),
        _updateAccent = function(newColor)
            accentColor = newColor
            updateOptions()
        end,
        UpdateOptions = function(newOptions)
            options = normalize_dropdown(newOptions)
            local kept = {}
            for opt, sel in pairs(selected) do
                if sel and table.find(options, opt) then kept[opt] = true end
            end
            selected = kept
            local newDisplay = getDisplayText()
            selectedLabel.Text = newDisplay
            local newWidth = math.max(85*scale, measure_text_width(newDisplay, 12*scale, Enum.Font.GothamSemibold) + 35*scale)
            buttonFrame.Size = UDim2.new(0, newWidth, 0, 21*scale)
            buttonFrame.Position = UDim2.new(1, -newWidth - 10*scale, 0, yPos)
            updateOptions()
        end,
        SetValues = function(newOptions)
            api.UpdateOptions(newOptions)
        end,
        Close = function()
            closeMultiDropdown(true)
            for _, conn in ipairs(connections) do conn:Disconnect() end
            label:Destroy(); buttonFrame:Destroy(); optionHolder:Destroy()
        end
    }
    return api
end

-- ------------------------------------------------------------
-- Elemen: KEYBIND (single key)
-- ------------------------------------------------------------
local function CreateKeybind(parent, config, scale, accentColor)
    scale = scale or 1
    local key = config.Default or Enum.KeyCode.Unknown
    local mode = string.lower(tostring(config.Mode or "toggle")) == "hold" and "Hold" or "Toggle"
    local isListening = false
    local holdActive = false
    local yPos = config.yPosition or 0

    local label = create("TextLabel", {
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
        TextColor3 = Color3.fromRGB(124,124,124),
        Text = config.Name,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10*scale, 0, yPos),
        TextSize = 14.6*scale,
        Size = UDim2.new(0, 145*scale, 0, 20*scale),
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Parent = parent
    })

    local function getKeyText() return key == Enum.KeyCode.Unknown and "None" or key.Name end
    local keyText = getKeyText()
    local keyWidth = math.max(48*scale, measure_text_width(keyText, 12*scale, Enum.Font.GothamSemibold) + 30*scale)

    local buttonFrame = create("Frame", {
        BackgroundColor3 = Color3.fromRGB(32,32,32),
        Position = UDim2.new(1, -keyWidth - 10*scale, 0, yPos),
        Size = UDim2.new(0, keyWidth, 0, 22*scale), Active = true,
        Parent = parent
    })
    create("UICorner", {CornerRadius = UDim.new(1,0), Parent = buttonFrame})
    create("UIStroke", {Color = Color3.fromRGB(40,40,40), Parent = buttonFrame})
    local keyLabel = create("TextLabel", {
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
        TextColor3 = Color3.fromRGB(113,113,113),
        Text = keyText,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 2*scale, 0, 0),
        TextSize = 12.8*scale,
        Size = UDim2.new(1, -24*scale, 1, 0),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = buttonFrame
    })
    create("UIPadding", {PaddingLeft = UDim.new(0, 2*scale), Parent = keyLabel})
    create("ImageLabel", {
        ImageColor3 = Color3.fromRGB(76,76,76),
        Image = "rbxassetid://10723416765",
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -18*scale, 0.5, -7.5*scale),
        Size = UDim2.new(0, 15*scale, 0, 15*scale),
        Parent = buttonFrame
    })

    local button = create("TextButton", {Text="", BackgroundTransparency=1, Size=UDim2.new(1,0,1,0), Active=true, Parent=buttonFrame})
    local connections = {}
    local function updateKeySize(text)
        local newWidth = math.max(48*scale, measure_text_width(text, 12*scale, Enum.Font.GothamSemibold) + 30*scale)
        tween_to(buttonFrame, {Size = UDim2.new(0, newWidth, 0, 22*scale), Position = UDim2.new(1, -newWidth - 10*scale, 0, yPos)}, 0.15)
    end

    local function setKey(newKey, silent)
        if holdActive then
            if mode == "Hold" then
                holdActive = false
                if config.Callback then config.Callback(false) end
            end
        end
        key = newKey
        local newText = getKeyText()
        keyLabel.Text = newText
        updateKeySize(newText)
        if not silent and config.ChangedCallback then config.ChangedCallback(key) end
    end

    local function setMode(newMode, silent)
        local newModeNorm = string.lower(tostring(newMode)) == "hold" and "Hold" or "Toggle"
        if newModeNorm == mode then return end
        if holdActive then
            holdActive = false
            if config.Callback then config.Callback(false) end
        end
        mode = newModeNorm
        if not silent and config.ModeChangedCallback then config.ModeChangedCallback(mode) end
    end

    table.insert(connections, button.MouseButton1Click:Connect(function()
        isListening = true
        keyLabel.Text = "..."
        updateKeySize("...")
        tween_to(buttonFrame, {BackgroundColor3 = Color3.fromRGB(48,48,48)}, 0.2)
    end))

    local inputBeganConn = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if isListening then
            if input.UserInputType == Enum.UserInputType.Keyboard then
                isListening = false
                setKey(input.KeyCode, false)
                tween_to(buttonFrame, {BackgroundColor3 = Color3.fromRGB(32,32,32)}, 0.2)
            end
        elseif not gameProcessed and input.UserInputType == Enum.UserInputType.Keyboard then
            if input.KeyCode == key and key ~= Enum.KeyCode.Unknown then
                if mode == "Hold" then
                    if not holdActive then
                        holdActive = true
                        if config.Callback then config.Callback(true) end
                    end
                else
                    if config.Callback then config.Callback() end
                end
            end
        end
    end)
    table.insert(connections, inputBeganConn)

    local inputEndedConn = UserInputService.InputEnded:Connect(function(input)
        if mode == "Hold" and holdActive and input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == key then
            holdActive = false
            if config.Callback then config.Callback(false) end
        end
    end)
    table.insert(connections, inputEndedConn)

    table.insert(connections, button.MouseEnter:Connect(function()
        if not isListening then tween_to(buttonFrame, {BackgroundColor3 = Color3.fromRGB(48,48,48)}, 0.2) end
    end))
    table.insert(connections, button.MouseLeave:Connect(function()
        if not isListening then tween_to(buttonFrame, {BackgroundColor3 = Color3.fromRGB(32,32,32)}, 0.2) end
    end))

    local api = {
        Set = setKey,
        Get = function() return key end,
        SetMode = setMode,
        GetMode = function() return mode end,
        _updateAccent = function(newColor) end,
        Close = function()
            isListening = false
            if holdActive then
                holdActive = false
                if config.Callback then config.Callback(false) end
            end
            for _, conn in ipairs(connections) do conn:Disconnect() end
            label:Destroy(); buttonFrame:Destroy()
        end
    }
    return api
end

-- ------------------------------------------------------------
-- Elemen: KEYBIND TOGGLE (key + toggle)
-- ------------------------------------------------------------
local function CreateKeybindToggle(parent, config, scale, accentColor)
    scale = scale or 1
    accentColor = accentColor or Color3.fromRGB(0,133,255)
    local key = config.Default or Enum.KeyCode.Unknown
    local toggleState = config.ToggleDefault == true
    local isListening = false
    local yPos = config.yPosition or 0

    local label = create("TextLabel", {
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
        TextColor3 = Color3.fromRGB(124,124,124),
        Text = config.Name,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10*scale, 0, yPos),
        TextSize = 14.6*scale,
        Size = UDim2.new(0, 115*scale, 0, 20*scale),
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Parent = parent
    })

    local keyText = key == Enum.KeyCode.Unknown and "None" or key.Name
    local keyWidth = math.max(48*scale, measure_text_width(keyText, 12*scale, Enum.Font.GothamSemibold) + 30*scale)

    local keyButtonFrame = create("Frame", {
        BackgroundColor3 = Color3.fromRGB(32,32,32),
        Position = UDim2.new(1, -keyWidth - 10*scale, 0, yPos),
        Size = UDim2.new(0, keyWidth, 0, 22*scale),
        Parent = parent
    })
    create("UICorner", {CornerRadius = UDim.new(1,0), Parent = keyButtonFrame})
    create("UIStroke", {Color = Color3.fromRGB(40,40,40), Parent = keyButtonFrame})
    local keyLabel = create("TextLabel", {
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
        TextColor3 = Color3.fromRGB(113,113,113),
        Text = keyText,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 6*scale, 0, 0),
        TextSize = 12.8*scale,
        Size = UDim2.new(1, -24*scale, 1, 0),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = keyButtonFrame
    })
    local keyIcon = create("ImageLabel", {
        ImageColor3 = Color3.fromRGB(76,76,76),
        Image = "rbxassetid://10723416765",
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -18*scale, 0.5, -7.5*scale),
        Size = UDim2.new(0, 15*scale, 0, 15*scale),
        Parent = keyButtonFrame
    })

    local toggleSwitch = create("Frame", {
        BackgroundColor3 = toggleState and accentColor or Color3.fromRGB(32,32,32),
        Position = UDim2.new(1, -keyWidth - 48*scale, 0, yPos),
        Size = UDim2.new(0, 36*scale, 0, 22*scale),
        Parent = parent
    })
    create("UICorner", {CornerRadius = UDim.new(1,0), Parent = toggleSwitch})
    local toggleKnob = create("Frame", {
        BackgroundColor3 = toggleState and Color3.new(1,1,1) or Color3.fromRGB(75,75,75),
        Position = toggleState and UDim2.new(0.462, 0, 0.143, 0) or UDim2.new(0.0104, 0, 0.143, 0),
        Size = UDim2.new(0, 16*scale, 0, 16*scale),
        Parent = toggleSwitch
    })
    create("UICorner", {CornerRadius = UDim.new(1,0), Parent = toggleKnob})

    local toggleButton = create("TextButton", {Text="", BackgroundTransparency=1, Size=UDim2.new(1,0,1,0), Parent=toggleSwitch})
    local keyButton = create("TextButton", {Text="", BackgroundTransparency=1, Size=UDim2.new(1,0,1,0), Parent=keyButtonFrame})

    local connections = {}
    local function setToggle(newState, silent)
        toggleState = newState == true
        if toggleState then
            tween_to(toggleSwitch, {BackgroundColor3 = accentColor}, 0.2)
            tween_to(toggleKnob, {Position = UDim2.new(0.462, 0, 0.143, 0), BackgroundColor3 = Color3.new(1,1,1)}, 0.2, Enum.EasingStyle.Back)
        else
            tween_to(toggleSwitch, {BackgroundColor3 = Color3.fromRGB(32,32,32)}, 0.2)
            tween_to(toggleKnob, {Position = UDim2.new(0.0104, 0, 0.143, 0), BackgroundColor3 = Color3.fromRGB(75,75,75)}, 0.2, Enum.EasingStyle.Back)
        end
        if not silent and config.ToggleCallback then config.ToggleCallback(toggleState) end
    end

    local function updateKeySize(text)
        local newWidth = math.max(48*scale, measure_text_width(text, 12*scale, Enum.Font.GothamSemibold) + 30*scale)
        tween_to(keyButtonFrame, {Size = UDim2.new(0, newWidth, 0, 22*scale), Position = UDim2.new(1, -newWidth - 10*scale, 0, yPos)}, 0.15)
        tween_to(toggleSwitch, {Position = UDim2.new(1, -newWidth - 48*scale, 0, yPos)}, 0.15)
    end

    local function setKey(newKey, silent)
        key = newKey
        local newText = key == Enum.KeyCode.Unknown and "None" or key.Name
        keyLabel.Text = newText
        updateKeySize(newText)
        if not silent and config.ChangedCallback then config.ChangedCallback(key) end
    end

    table.insert(connections, toggleButton.MouseButton1Click:Connect(function() setToggle(not toggleState, false) end))
    table.insert(connections, keyButton.MouseButton1Click:Connect(function()
        isListening = true
        keyLabel.Text = "..."
        updateKeySize("...")
        tween_to(keyButtonFrame, {BackgroundColor3 = Color3.fromRGB(48,48,48)}, 0.2)
    end))

    local inputBeganConn = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if isListening then
            if input.UserInputType == Enum.UserInputType.Keyboard then
                isListening = false
                setKey(input.KeyCode, false)
                tween_to(keyButtonFrame, {BackgroundColor3 = Color3.fromRGB(32,32,32)}, 0.2)
            end
        elseif not gameProcessed and input.UserInputType == Enum.UserInputType.Keyboard then
            if input.KeyCode == key and toggleState then
                if config.Callback then config.Callback() end
            end
        end
    end)
    table.insert(connections, inputBeganConn)

    table.insert(connections, keyButton.MouseEnter:Connect(function()
        if not isListening then tween_to(keyButtonFrame, {BackgroundColor3 = Color3.fromRGB(48,48,48)}, 0.2) end
    end))
    table.insert(connections, keyButton.MouseLeave:Connect(function()
        if not isListening then tween_to(keyButtonFrame, {BackgroundColor3 = Color3.fromRGB(32,32,32)}, 0.2) end
    end))

    local api = {
        SetToggle = setToggle,
        GetToggle = function() return toggleState end,
        SetKey = setKey,
        GetKey = function() return key end,
        _updateAccent = function(newColor)
            accentColor = newColor
            if toggleState then
                toggleSwitch.BackgroundColor3 = newColor
            end
        end,
        Close = function()
            isListening = false
            for _, conn in ipairs(connections) do conn:Disconnect() end
            label:Destroy(); keyButtonFrame:Destroy(); toggleSwitch:Destroy()
        end
    }
    return api
end

-- ------------------------------------------------------------
-- Elemen: BUTTON
-- ------------------------------------------------------------
local function CreateButton(parent, config, scale, accentColor)
    scale = scale or 1
    local yPos = config.yPosition or 0
    local isLocked = config.Locked == true
    local mainFrame = create("Frame", {
        BackgroundColor3 = isLocked and Color3.fromRGB(24,24,24) or Color3.fromRGB(32,32,32),
        Position = UDim2.new(0, 10*scale, 0, yPos),
        Size = UDim2.new(1, -20*scale, 0, 28*scale),
        Parent = parent
    })
    create("UICorner", {CornerRadius = UDim.new(1,0), Parent = mainFrame})
    local stroke = create("UIStroke", {
        Color = isLocked and Color3.fromRGB(32,32,32) or Color3.fromRGB(48,48,48),
        Parent = mainFrame
    })
    local iconX = 8
    if config.Icon then
        create("ImageLabel", {
            ImageColor3 = isLocked and Color3.fromRGB(50,50,50) or Color3.fromRGB(125,125,125),
            Image = config.Icon,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 8*scale, 0.5, -8*scale),
            Size = UDim2.new(0, 16*scale, 0, 16*scale),
            Parent = mainFrame
        })
        iconX = 30
    end
    local label = create("TextLabel", {
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
        TextColor3 = isLocked and Color3.fromRGB(46,46,46) or Color3.fromRGB(120,120,120),
        Text = config.Name .. (isLocked and " (locked)" or ""),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, iconX*scale, 0, 0),
        TextSize = 14*scale,
        Size = UDim2.new(1, -iconX*scale - 10, 1, 0),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = mainFrame
    })
    local btn = create("TextButton", {Text="", BackgroundTransparency=1, Size=UDim2.new(1,0,1,0), Parent=mainFrame})
    local connections = {}
    if not isLocked then
        table.insert(connections, btn.MouseButton1Click:Connect(config.Callback))
        table.insert(connections, btn.MouseEnter:Connect(function()
            tween_to(mainFrame, {BackgroundColor3 = Color3.fromRGB(40,40,40)}, 0.2)
        end))
        table.insert(connections, btn.MouseLeave:Connect(function()
            tween_to(mainFrame, {BackgroundColor3 = Color3.fromRGB(32,32,32)}, 0.2)
        end))
    end
    local api = {
        _updateAccent = function(newColor) end,
        Close = function()
            for _, conn in ipairs(connections) do conn:Disconnect() end
            mainFrame:Destroy()
        end
    }
    return api
end

-- ------------------------------------------------------------
-- Elemen: LABEL
-- ------------------------------------------------------------
local function CreateLabel(parent, config, scale)
    scale = scale or 1
    local yPos = config.yPosition or 0
    local text = config.Text or "Label"
    local wrap = config.Wrap == true
    local maxWidth = 238 * scale
    local textSize = 14 * scale
    local bounds = TextService:GetTextSize(text, textSize, Enum.Font.GothamSemibold, Vector2.new(maxWidth, wrap and math.huge or textSize+4))
    local height = wrap and math.max(20*scale, bounds.Y) or (20*scale)
    local label = create("TextLabel", {
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
        TextColor3 = Color3.fromRGB(124,124,124),
        Text = text,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10*scale, 0, yPos),
        TextSize = textSize,
        Size = UDim2.new(0, maxWidth, 0, height),
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        TextWrapped = wrap,
        RichText = config.RichText ~= false,
        ClipsDescendants = true,
        Parent = parent
    })
    local api = {
        SetText = function(newText) label.Text = tostring(newText) end,
        SetVisible = function(vis) label.Visible = vis end,
        _updateAccent = function(newColor) end,
        Close = function() label:Destroy() end
    }
    return api
end

-- ------------------------------------------------------------
-- Elemen: TEXT INPUT
-- ------------------------------------------------------------
local function CreateTextInput(parent, config, scale, accentColor)
    scale = scale or 1
    local yPos = config.yPosition or 0
    local label = create("TextLabel", {
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
        TextColor3 = Color3.fromRGB(124,124,124),
        Text = config.Name,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10*scale, 0, yPos),
        TextSize = 14.6*scale,
        Size = UDim2.new(0, 80*scale, 0, 20*scale),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = parent
    })
    local inputFrame = create("Frame", {
        BackgroundColor3 = Color3.fromRGB(32,32,32),
        Position = UDim2.new(0, 10*scale, 0, yPos + 23*scale),
        Size = UDim2.new(0, 240*scale, 0, 28*scale),
        Parent = parent
    })
    create("UICorner", {CornerRadius = UDim.new(0,6), Parent = inputFrame})
    create("UIStroke", {Color = Color3.fromRGB(44,44,44), Parent = inputFrame})
    local textBox = create("TextBox", {
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
        PlaceholderText = config.Placeholder or "Enter text...",
        PlaceholderColor3 = Color3.fromRGB(80,80,80),
        Text = tostring(config.Default or ""),
        TextColor3 = Color3.fromRGB(200,200,200),
        TextSize = 13.8*scale,
        BackgroundTransparency = 1,
        ClearTextOnFocus = false,
        Position = UDim2.new(0, 8*scale, 0, 0),
        Size = UDim2.new(1, -16*scale, 1, 0),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = inputFrame
    })
    local numeric = config.Numeric == true
    if numeric then textBox.ClearTextOnFocus = true end
    local finishedOnly = config.Finished == true

    local connections = {}
    table.insert(connections, textBox.Focused:Connect(function()
        tween_to(inputFrame, {BackgroundColor3 = Color3.fromRGB(40,40,40)}, 0.2)
    end))
    table.insert(connections, textBox.FocusLost:Connect(function(enterPressed)
        tween_to(inputFrame, {BackgroundColor3 = Color3.fromRGB(32,32,32)}, 0.2)
        if finishedOnly and not enterPressed then return end
        if config.Callback then config.Callback(textBox.Text, enterPressed) end
    end))

    local api = {
        Set = function(txt) textBox.Text = tostring(txt or "") end,
        Get = function() return textBox.Text end,
        SetValue = function(txt, silent)
            textBox.Text = tostring(txt or "")
            if not silent and config.Callback then config.Callback(textBox.Text, false) end
        end,
        GetValue = function() return textBox.Text end,
        ResetValue = function() textBox.Text = tostring(config.Default or "") end,
        _updateAccent = function(newColor) end,
        Close = function()
            for _, conn in ipairs(connections) do conn:Disconnect() end
            label:Destroy(); inputFrame:Destroy()
        end
    }
    return api
end

-- ------------------------------------------------------------
-- Elemen: DIVIDER
-- ------------------------------------------------------------
local function CreateDivider(parent, config, scale)
    scale = scale or 1
    local yPos = (config and config.yPosition) or 0
    local line = create("Frame", {
        BackgroundColor3 = Color3.fromRGB(36,36,36),
        Position = UDim2.new(0, 10*scale, 0, yPos + 4*scale),
        Size = UDim2.new(0.92, 0, 0, 1),
        Parent = parent
    })
    create("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(108,108,108)),
            ColorSequenceKeypoint.new(0.514, Color3.new(1,1,1)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(108,108,108))
        }),
        Parent = line
    })
    local api = { 
        _updateAccent = function(newColor) end,
        Close = function() line:Destroy() end 
    }
    return api
end

-- ------------------------------------------------------------
-- Elemen: COLOR PICKER (Full HSV - seperti original)
-- ------------------------------------------------------------
local function CreateColorPicker(parent, config, scale, accentColor, dropdownHolder)
    scale = scale or 1
    accentColor = accentColor or Color3.fromRGB(0,133,255)
    local color = config.Default or Color3.fromRGB(255,100,150)
    local isOpen = false
    local yPos = config.yPosition or 0
    
    -- Helper: RGB to HSV
    local function rgbToHsv(c)
        local r, g, b = c.R, c.G, c.B
        local max, min = math.max(r, g, b), math.min(r, g, b)
        local h, s, v = 0, 0, max
        local d = max - min
        s = max == 0 and 0 or d / max
        if max ~= min then
            if max == r then h = (g - b) / d + (g < b and 6 or 0)
            elseif max == g then h = (b - r) / d + 2
            elseif max == b then h = (r - g) / d + 4 end
            h = h / 6
        end
        return h, s, v
    end
    
    -- Helper: HSV to RGB
    local function hsvToRgb(h, s, v)
        local r, g, b
        local i = math.floor(h * 6)
        local f = h * 6 - i
        local p = v * (1 - s)
        local q = v * (1 - f * s)
        local t = v * (1 - (1 - f) * s)
        i = i % 6
        if i == 0 then r, g, b = v, t, p
        elseif i == 1 then r, g, b = q, v, p
        elseif i == 2 then r, g, b = p, v, t
        elseif i == 3 then r, g, b = p, q, v
        elseif i == 4 then r, g, b = t, p, v
        else r, g, b = v, p, q end
        return Color3.new(r, g, b)
    end
    
    local currentH, currentS, currentV = rgbToHsv(color)
    
    -- Label
    local label = create("TextLabel", {
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
        TextColor3 = Color3.fromRGB(124,124,124),
        Text = config.Name,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10*scale, 0, yPos),
        TextSize = 14*scale,
        Size = UDim2.new(0, 100*scale, 0, 20*scale),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = parent
    })
    
    -- Preview button
    local preview = create("Frame", {
        BackgroundColor3 = color,
        Position = UDim2.new(1, -40*scale, 0, yPos),
        Size = UDim2.new(0, 30*scale, 0, 20*scale),
        Parent = parent
    })
    create("UICorner", {CornerRadius = UDim.new(0,6), Parent = preview})
    create("UIStroke", {Color = Color3.fromRGB(60,60,60), Parent = preview})
    
    -- Picker popup
    local pickerWidth = 200 * scale
    local pickerFrame = create("Frame", {
        BackgroundColor3 = Color3.fromRGB(24,24,24),
        Size = UDim2.new(0, pickerWidth, 0, 0),
        ClipsDescendants = true, Visible = false, ZIndex = 9999,
        Parent = dropdownHolder
    })
    create("UICorner", {CornerRadius = UDim.new(0,8), Parent = pickerFrame})
    create("UIStroke", {Color = Color3.fromRGB(50,50,50), Parent = pickerFrame})
    
    -- SV Box (Saturation/Value)
    local svBox = create("Frame", {
        BackgroundColor3 = Color3.fromHSV(currentH, 1, 1),
        Position = UDim2.new(0, 10*scale, 0, 10*scale),
        Size = UDim2.new(1, -20*scale, 0, 100*scale),
        ZIndex = 10000,
        Parent = pickerFrame
    })
    create("UICorner", {CornerRadius = UDim.new(0,6), Parent = svBox})
    
    -- White to transparent gradient (saturation)
    create("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.new(1,1,1)),
            ColorSequenceKeypoint.new(1, Color3.new(1,1,1))
        }),
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(1, 1)
        }),
        Parent = svBox
    })
    
    -- Black overlay for value
    local valueOverlay = create("Frame", {
        BackgroundColor3 = Color3.new(0,0,0),
        Size = UDim2.new(1,0,1,0),
        ZIndex = 10001,
        Parent = svBox
    })
    create("UICorner", {CornerRadius = UDim.new(0,6), Parent = valueOverlay})
    create("UIGradient", {
        Color = ColorSequence.new(Color3.new(0,0,0)),
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(1, 0)
        }),
        Rotation = 90,
        Parent = valueOverlay
    })
    
    -- SV Cursor
    local svCursor = create("Frame", {
        BackgroundTransparency = 1,
        Position = UDim2.new(currentS, -6*scale, 1 - currentV, -6*scale),
        Size = UDim2.new(0, 12*scale, 0, 12*scale),
        ZIndex = 10003,
        Parent = svBox
    })
    create("UICorner", {CornerRadius = UDim.new(1,0), Parent = svCursor})
    create("UIStroke", {Color = Color3.new(1,1,1), Thickness = 2, Parent = svCursor})
    
    -- Hue Slider
    local hueSlider = create("Frame", {
        BackgroundColor3 = Color3.new(1,1,1),
        Position = UDim2.new(0, 10*scale, 0, 120*scale),
        Size = UDim2.new(1, -20*scale, 0, 14*scale),
        ZIndex = 10000,
        Parent = pickerFrame
    })
    create("UICorner", {CornerRadius = UDim.new(1,0), Parent = hueSlider})
    create("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromHSV(0,1,1)),
            ColorSequenceKeypoint.new(0.167, Color3.fromHSV(0.167,1,1)),
            ColorSequenceKeypoint.new(0.333, Color3.fromHSV(0.333,1,1)),
            ColorSequenceKeypoint.new(0.5, Color3.fromHSV(0.5,1,1)),
            ColorSequenceKeypoint.new(0.667, Color3.fromHSV(0.667,1,1)),
            ColorSequenceKeypoint.new(0.833, Color3.fromHSV(0.833,1,1)),
            ColorSequenceKeypoint.new(1, Color3.fromHSV(1,1,1))
        }),
        Parent = hueSlider
    })
    
    -- Hue Cursor
    local hueCursor = create("Frame", {
        BackgroundColor3 = Color3.new(1,1,1),
        Position = UDim2.new(currentH, -7*scale, 0.5, -7*scale),
        Size = UDim2.new(0, 14*scale, 0, 14*scale),
        ZIndex = 10001,
        Parent = hueSlider
    })
    create("UICorner", {CornerRadius = UDim.new(1,0), Parent = hueCursor})
    create("UIStroke", {Color = Color3.fromRGB(40,40,40), Thickness = 2, Parent = hueCursor})
    
    -- Preset colors (10 colors)
    local presetColors = {
        Color3.fromRGB(38,70,83), Color3.fromRGB(42,157,143),
        Color3.fromRGB(233,196,106), Color3.fromRGB(244,162,97),
        Color3.fromRGB(231,111,81), Color3.fromRGB(190,49,49),
        Color3.fromRGB(40,55,114), Color3.fromRGB(68,114,196),
        Color3.fromRGB(78,166,206), Color3.fromRGB(108,225,226)
    }
    
    local presetY = 145 * scale
    local presetConnections = {}
    for i, preset in ipairs(presetColors) do
        local col = (i - 1) % 5
        local row = math.floor((i - 1) / 5)
        local presetBtn = create("Frame", {
            BackgroundColor3 = preset,
            Position = UDim2.new(0, 10*scale + col * 38*scale, 0, presetY + row * 28*scale),
            Size = UDim2.new(0, 32*scale, 0, 22*scale),
            ZIndex = 10000,
            Parent = pickerFrame
        })
        create("UICorner", {CornerRadius = UDim.new(1,0), Parent = presetBtn})
        
        local presetClick = create("TextButton", {
            Text = "", BackgroundTransparency = 1,
            Size = UDim2.new(1,0,1,0),
            ZIndex = 10001,
            Parent = presetBtn
        })
        table.insert(presetConnections, presetClick.MouseButton1Click:Connect(function()
            currentH, currentS, currentV = rgbToHsv(preset)
            color = preset
            preview.BackgroundColor3 = color
            svBox.BackgroundColor3 = Color3.fromHSV(currentH, 1, 1)
            svCursor.Position = UDim2.new(currentS, -6*scale, 1 - currentV, -6*scale)
            hueCursor.Position = UDim2.new(currentH, -7*scale, 0.5, -7*scale)
            if config.Callback then config.Callback(color) end
        end))
    end
    
    local function updateColor()
        color = Color3.fromHSV(currentH, currentS, currentV)
        preview.BackgroundColor3 = color
        svBox.BackgroundColor3 = Color3.fromHSV(currentH, 1, 1)
        if config.Callback then config.Callback(color) end
    end
    
    -- SV Box interaction
    local svDragging = false
    local svClickBtn = create("TextButton", {
        Text = "", BackgroundTransparency = 1,
        Size = UDim2.new(1,0,1,0),
        ZIndex = 10002,
        Parent = svBox
    })
    
    svClickBtn.MouseButton1Down:Connect(function() svDragging = true end)
    
    local inputEndedConn = UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            svDragging = false
        end
    end)
    
    local inputChangedConn = UserInputService.InputChanged:Connect(function(input)
        if svDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local absPos, absSize = svBox.AbsolutePosition, svBox.AbsoluteSize
            currentS = math.clamp((input.Position.X - absPos.X) / absSize.X, 0, 1)
            currentV = math.clamp(1 - (input.Position.Y - absPos.Y) / absSize.Y, 0, 1)
            svCursor.Position = UDim2.new(currentS, -6*scale, 1 - currentV, -6*scale)
            updateColor()
        end
    end)
    
    -- Hue Slider interaction
    local hueDragging = false
    local hueClickBtn = create("TextButton", {
        Text = "", BackgroundTransparency = 1,
        Size = UDim2.new(1,0,1,0),
        ZIndex = 10002,
        Parent = hueSlider
    })
    
    hueClickBtn.MouseButton1Down:Connect(function() hueDragging = true end)
    
    local hueEndedConn = UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            hueDragging = false
        end
    end)
    
    local hueChangedConn = UserInputService.InputChanged:Connect(function(input)
        if hueDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local absPos, absSize = hueSlider.AbsolutePosition, hueSlider.AbsoluteSize
            currentH = math.clamp((input.Position.X - absPos.X) / absSize.X, 0, 1)
            hueCursor.Position = UDim2.new(currentH, -7*scale, 0.5, -7*scale)
            updateColor()
        end
    end)
    
    -- Open/Close picker
    local positionConn = nil
    local connections = {}
    
    local function closePicker(instant)
        isOpen = false
        if positionConn then positionConn(); positionConn = nil end
        if instant then
            pickerFrame.Size = UDim2.new(0, pickerWidth, 0, 0)
            pickerFrame.Visible = false
            return
        end
        tween_to(pickerFrame, {Size = UDim2.new(0, pickerWidth, 0, 0)}, 0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
        task.delay(0.2, function()
            if not isOpen and pickerFrame.Parent then pickerFrame.Visible = false end
        end)
    end
    
    local function updatePosition()
        local absPos = preview.AbsolutePosition
        local absSize = preview.AbsoluteSize
        local screenSize = get_safe_viewport_size()
        local totalH = 210 * scale
        local rawX = absPos.X - 160*scale
        local rawY = absPos.Y + absSize.Y + 5
        if rawY + totalH > screenSize.Y - 5 then
            rawY = math.max(5, absPos.Y - totalH - 5)
        end
        pickerFrame.Position = UDim2.new(0, rawX, 0, rawY)
    end
    
    local function openPicker()
        isOpen = true
        updatePosition()
        pickerFrame.Visible = true
        tween_to(pickerFrame, {Size = UDim2.new(0, pickerWidth, 0, 210*scale)}, 0.26, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        if positionConn then positionConn() end
        positionConn = RunService.RenderStepped:Connect(function()
            if isOpen then updatePosition() end
        end)
    end
    
    local pickerButton = create("TextButton", {
        Text = "", BackgroundTransparency = 1,
        Size = UDim2.new(1,0,1,0),
        Parent = preview
    })
    
    table.insert(connections, pickerButton.MouseButton1Click:Connect(function()
        if isOpen then closePicker(false) else openPicker() end
    end))
    
    local api = {
        Set = function(newColor, silent)
            color = newColor
            currentH, currentS, currentV = rgbToHsv(color)
            preview.BackgroundColor3 = color
            svBox.BackgroundColor3 = Color3.fromHSV(currentH, 1, 1)
            svCursor.Position = UDim2.new(currentS, -6*scale, 1 - currentV, -6*scale)
            hueCursor.Position = UDim2.new(currentH, -7*scale, 0.5, -7*scale)
            if not silent and config.Callback then config.Callback(color) end
        end,
        Get = function() return color end,
        _updateAccent = function(newColor) end,
        Close = function()
            closePicker(true)
            for _, conn in ipairs(connections) do conn:Disconnect() end
            for _, conn in ipairs(presetConnections) do conn:Disconnect() end
            inputEndedConn:Disconnect()
            inputChangedConn:Disconnect()
            hueEndedConn:Disconnect()
            hueChangedConn:Disconnect()
            label:Destroy(); preview:Destroy(); pickerFrame:Destroy()
        end
    }
    return api
end

-- ------------------------------------------------------------
-- EXPORT MODULE
-- ------------------------------------------------------------
local Elements = {
    -- Core utilities (exposed for Main.lua)
    Font = Font,
    apply_font = apply_font,
    get_safe_viewport_size = get_safe_viewport_size,
    
    -- UI Elements
    CreateToggle = CreateToggle,
    CreateSlider = CreateSlider,
    CreateDropdown = CreateDropdown,
    CreateMultiDropdown = CreateMultiDropdown,
    CreateKeybind = CreateKeybind,
    CreateKeybindToggle = CreateKeybindToggle,
    CreateButton = CreateButton,
    CreateLabel = CreateLabel,
    CreateTextInput = CreateTextInput,
    CreateDivider = CreateDivider,
    CreateColorPicker = CreateColorPicker
}

return Elements
