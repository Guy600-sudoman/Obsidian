-- Define the repository for Obsidian UI Library
local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

-- Create the main window
local Window = Library:CreateWindow({
    Title = "mspaint example",
    Footer = "version: example",
    Icon = 95816097006870,
    NotifySide = "Right",
    ShowCustomCursor = true,
})

-- Tabs
local Tabs = {
    Main = Window:AddTab("Main", "house"),
    ["UI Settings"] = Window:AddTab("UI & Settings", "settings")
}

-- Groupboxes
local LeftGroupbox = Tabs.Main:AddLeftGroupbox("Functions")
local RightGroupbox = Tabs.Main:AddRightGroupbox("Text Elements")

-- Buttons
local Button = LeftGroupbox:AddButton({
    Text = "Main Button",
    Tooltip = "Prints Main Button Clicked",
    Func = function()
        print("Main Button Clicked!")
    end
})

Button:AddButton({
    Text = "Sub Button",
    Tooltip = "Prints Sub-Button Clicked",
    Func = function()
        print("Sub-button clicked!")
    end
})

-- Slider
LeftGroupbox:AddSlider("Slider", {
    Text = "Example Slider",
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Tooltip = "Prints the slider's value",
    Callback = function(Value)
        print("Slider changed to:", Value)
    end,
})

-- Toggle
LeftGroupbox:AddToggle("MyToggle", {
    Text = "Example Toggle",
    Default = false,
    Tooltip = "Prints the state of the toggle (on/off)",
    Callback = function(Value)
        print(Value and "Toggle is On" or "Toggle is Off")
    end,
})

-- Checkbox
LeftGroupbox:AddCheckbox("MyCheckbox", {
    Text = "Example Checkbox",
    Default = false,
    Tooltip = "Prints whether the checkbox is checked or unchecked",
    Callback = function(Value)
        print(Value and "Checkbox is checked!" or "Checkbox is unchecked!")
    end,
})

-- Textbox
LeftGroupbox:AddInput("MyInput", {
    Text = "Text/Input Example",
    Default = "",
    Numeric = false,
    Finished = true,
    Tooltip = "Prints whatever you type. Must press Enter",
    Placeholder = "Enter text here",
    Callback = function(Text)
        print(Text)
    end,
})

-- Dropdown
LeftGroupbox:AddDropdown("Dropdown", {
    Values = {"Option 1", "Option 2", "Option 3"},
    Default = 1,
    Multi = false,
    Text = "Example Dropdown",
    Tooltip = "Prints the selected option",
    Callback = function(Value)
        print("Selected Option:", Value)
    end,
})

-- Color Picker
LeftGroupbox:AddLabel("Color Picker Example\n(Prints the color)"):AddColorPicker("ColorPicker", {
    Default = Color3.new(255, 0, 0),
    Title = "Color",
    Transparency = 0,
    Callback = function(Value)
        print("Color changed to: R: " .. math.floor(Value.R * 255) .. ", G: " .. math.floor(Value.G * 255) .. ", B: " .. math.floor(Value.B * 255))
    end,
})

-- Right Groupbox Labels
RightGroupbox:AddLabel("This is a label")
RightGroupbox:AddLabel({
    Text = "This is a wrapped label that will break into multiple lines!",
    DoesWrap = true
})

-- Config and Theme Setup
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

-- Ignore theme-related settings
SaveManager:IgnoreThemeSettings()

-- Ignore menu keybind for configs
SaveManager:SetIgnoreIndexes({ "MenuKeybind" })

-- Folder structure for themes and configs
ThemeManager:SetFolder("MyScriptHub")
SaveManager:SetFolder("MyScriptHub/specific-game")
SaveManager:SetSubFolder("specific-place") -- optional

-- Build config and theme sections in the settings tab
SaveManager:BuildConfigSection(Tabs["UI Settings"])
ThemeManager:ApplyToTab(Tabs["UI Settings"])

-- Load autoload config
SaveManager:LoadAutoloadConfig()
