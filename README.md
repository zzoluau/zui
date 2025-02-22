# zui
An experimental Roblox UI library

ℹ - zui is my first UI library, if it has any issues this is the reason. You may help me fix bugs, unintentional behaviours, mistakes or any performance eating issues by creating a pull request!! Any kind of help is welcome :)

## How do I use this?

First step is to require the main module file inside the repository, `main.luau` by:
1. Copying the code and inserting it into a ModuleScript in your game then within another LocalScript, require that ModuleScript by inserting: ```local zuiLib = require(Path.To.Your.ModuleScript)``` (Using this method will not auto update zui.)
2. Requiring using ```game:GetService("HttpService"):GetAsync('https://raw.githubusercontent.com/zzoluau/zui/refs/heads/main/main.luau')``` or ```loadstring(game:HttpGet('https://raw.githubusercontent.com/zzoluau/zui/refs/heads/main/main.luau'))()```, and inserting into a LocalScript using ```local zuiLib = (one of the requiring methods)```

Next, initializing the UI using
```
local zui = zuiLib.initialize({
	-- All these are optional, can remove and leave as an empty table.
	accent = Color3.fromRGB(R, G, B),
	bg = Color3.fromRGB(R, G, B),
	darkBg = Color3.fromRGB(R, G, B),
	keybinds = {
		toggleVis = Enum.KeyCode.RightAlt
	}
})
```
### Tabs

Create a tab for all your elements to stay in. The name is optional and you can leave an empty table to make a default tab.

```
local tab = zui.makeTab({
	-- All these are optional, can remove and leave as an empty table.
	name = "Ts Pmo"
})
```

#### Buttons

Buttons can have callbacks, a function that is called after hitting the button. The name and callback are also optional and you can leave an empty table to create a default button.

```
local button = tab.newButton({
	-- All these are optional, can remove and leave as an empty table.
	name = "Hello!",
	callback = function()
		print("I've been clicked!")
	end,
})
```

#### Toggles

Toggles are like buttons, but can only set values true or false upon toggling. The name and callback are optional.

```
local toggle = tab.newToggle({
	-- All these are optional, can remove and leave as an empty table.
	name = "Hai",
	callback = function(value)
		print("I'm now " .. tostring(value) .. "!")
	end
})
```

#### Sliders

Sliders can set values for numbers or integers. Every option is optional.

```
local slider = tab.newSlider({
	-- All these are optional, can remove and leave as an empty table.
	name = "Hewwo!!",
	minValue = 0,
	maxValue = 10,
	value = 5,
	callback = function(v)
		print(v)
	end,
})
```
