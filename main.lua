--<>--
local plrs, ts, d, uis = game:GetService("Players"), game:GetService("TweenService"), game:GetService("Debris"), game:GetService("UserInputService")
local plr = plrs.LocalPlayer
local mouse = plr:GetMouse()

local plrGui = plr:WaitForChild("PlayerGui")

local zuiLib = {
	elements = {},
	settings = {},
	connections = {},
	temp_globals = {}
}

local zui = zuiLib.elements
local _tg = zuiLib.temp_globals
local global = {
	elementCounter = 0
}

local function checkOptional(t, default)
	if typeof(t) == "nil" then
		t = default
		return
	end

	for name, value in pairs(default) do
		if t[name] == nil or typeof(t[name]) ~= typeof(value) then
			t[name] = value
		end
	end
end

zuiLib.initialize = function(s)
	local zuiClass = {}
	local self = zuiLib

	checkOptional(s, {
		accent = Color3.fromRGB(255, 178, 241),
		bg = Color3.fromRGB(50, 50, 50),
		darkBg = Color3.fromRGB(25, 25, 25),
		keybinds = {
			toggleVis = Enum.KeyCode.RightAlt
		}
	})

	self.settings = s

	local function _()
		-- StarterGui._zui
		zui["1"] = Instance.new("ScreenGui", plrGui);
		zui["1"]["Name"] = [[_zui]];
		zui["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;

		zui["2"] = Instance.new("Frame", zui["1"]);
		zui["2"]["BorderSizePixel"] = 0;
		zui["2"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		zui["2"]["Size"] = UDim2.new(1, 0, 1, 0);
		zui["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		zui["2"]["Name"] = [[zMain]];
		zui["2"]["BackgroundTransparency"] = 1;

		-- StarterGui._zui.zMain.UIPadding
		zui["23"] = Instance.new("UIPadding", zui["2"]);
		zui["23"]["PaddingTop"] = UDim.new(0, 10);
		zui["23"]["PaddingLeft"] = UDim.new(0, 10);

		-- StarterGui._zui.zMain.UIListLayout
		zui["3"] = Instance.new("UIListLayout", zui["2"]);
		zui["3"]["Wraps"] = true;
		zui["3"]["Padding"] = UDim.new(0, 10);
		zui["3"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
		zui["3"]["FillDirection"] = Enum.FillDirection.Horizontal;

		do --> TOAST
			-- StarterGui._zui.zToast
			zui["28"] = Instance.new("Frame", zui["1"]);
			zui["28"]["BorderSizePixel"] = 0;
			zui["28"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			zui["28"]["AnchorPoint"] = Vector2.new(1, 0);
			zui["28"]["Size"] = UDim2.new(0.5, 0, 1, 0);
			zui["28"]["Position"] = UDim2.new(1, 0, 0, 0);
			zui["28"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			zui["28"]["Name"] = [[zToast]];
			zui["28"]["BackgroundTransparency"] = 1;

			-- StarterGui._zui.zToast.UIPadding
			zui["29"] = Instance.new("UIPadding", zui["28"]);
			zui["29"]["PaddingRight"] = UDim.new(0, 10);
			zui["29"]["PaddingBottom"] = UDim.new(0, 10);

			-- StarterGui._zui.zToast.UIListLayout
			zui["2a"] = Instance.new("UIListLayout", zui["28"]);
			zui["2a"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Right;
			zui["2a"]["Padding"] = UDim.new(0, 10);
			zui["2a"]["VerticalAlignment"] = Enum.VerticalAlignment.Bottom;
			zui["2a"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

			-- StarterGui._zui.zAssets
			zui["2b"] = Instance.new("Folder", zui["1"]);
			zui["2b"]["Name"] = [[zAssets]];

			-- StarterGui._zui.zAssets.Notification
			zui["2c"] = Instance.new("Frame", zui["2b"]);
			zui["2c"]["Visible"] = false;
			zui["2c"]["BorderSizePixel"] = 0;
			zui["2c"]["BackgroundColor3"] = Color3.fromRGB(51, 51, 51);
			zui["2c"]["AutomaticSize"] = Enum.AutomaticSize.Y;
			zui["2c"]["Size"] = UDim2.new(0.5, 0, 0, 0);
			zui["2c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			zui["2c"]["Name"] = [[Notification]];

			-- StarterGui._zui.zAssets.Notification.Title
			zui["2d"] = Instance.new("TextLabel", zui["2c"]);
			zui["2d"]["BorderSizePixel"] = 0;
			zui["2d"]["TextSize"] = 14;
			zui["2d"]["BackgroundColor3"] = Color3.fromRGB(255, 179, 242);
			zui["2d"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			zui["2d"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			zui["2d"]["Size"] = UDim2.new(1, 0, 0, 20);
			zui["2d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			zui["2d"]["Text"] = [[Notification]];
			zui["2d"]["Name"] = [[Title]];

			-- StarterGui._zui.zAssets.Notification.UIListLayout
			zui["2e"] = Instance.new("UIListLayout", zui["2c"]);
			zui["2e"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

			-- StarterGui._zui.zAssets.Notification.Duration
			zui["2f"] = Instance.new("Frame", zui["2c"]);
			zui["2f"]["BorderSizePixel"] = 0;
			zui["2f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			zui["2f"]["Size"] = UDim2.new(1, 0, 0, 2);
			zui["2f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			zui["2f"]["Name"] = [[Duration]];
			zui["2f"]["LayoutOrder"] = 100;
			zui["2f"]["BackgroundTransparency"] = 1;

			-- StarterGui._zui.zAssets.Notification.Duration.Filler
			zui["30"] = Instance.new("Frame", zui["2f"]);
			zui["30"]["BorderSizePixel"] = 0;
			zui["30"]["BackgroundColor3"] = Color3.fromRGB(255, 179, 242);
			zui["30"]["Size"] = UDim2.new(1, 0, 1, 0);
			zui["30"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			zui["30"]["Name"] = [[Filler]];

			-- StarterGui._zui.zAssets.Notification.ContentContainer
			zui["31"] = Instance.new("Frame", zui["2c"]);
			zui["31"]["BorderSizePixel"] = 0;
			zui["31"]["BackgroundColor3"] = Color3.fromRGB(255, 179, 242);
			zui["31"]["AutomaticSize"] = Enum.AutomaticSize.Y;
			zui["31"]["Size"] = UDim2.new(1, 0, 0, 40);
			zui["31"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			zui["31"]["Name"] = [[ContentContainer]];
			zui["31"]["BackgroundTransparency"] = 1;

			-- StarterGui._zui.zAssets.Notification.ContentContainer.Content
			zui["32"] = Instance.new("TextLabel", zui["31"]);
			zui["32"]["TextWrapped"] = true;
			zui["32"]["BorderSizePixel"] = 0;
			zui["32"]["TextSize"] = 14;
			zui["32"]["BackgroundColor3"] = Color3.fromRGB(255, 179, 242);
			zui["32"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			zui["32"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			zui["32"]["BackgroundTransparency"] = 1;
			zui["32"]["Size"] = UDim2.new(1, 0, 0, 40);
			zui["32"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			zui["32"]["Text"] = [[Please don't eat chalkboards]];
			zui["32"]["AutomaticSize"] = Enum.AutomaticSize.Y;
			zui["32"]["Name"] = [[Content]];

			-- StarterGui._zui.zAssets.Notification.ContentContainer.NotificationIcon
			zui["33"] = Instance.new("ImageLabel", zui["31"]);
			zui["33"]["BorderSizePixel"] = 0;
			zui["33"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			zui["33"]["ScaleType"] = Enum.ScaleType.Fit;
			zui["33"]["ImageColor3"] = Color3.fromRGB(255, 179, 242);
			zui["33"]["Image"] = [[rbxassetid://10723415903]];
			zui["33"]["Size"] = UDim2.new(0, 20, 0, 20);
			zui["33"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			zui["33"]["BackgroundTransparency"] = 1;
			zui["33"]["LayoutOrder"] = -1;
			zui["33"]["Name"] = [[NotificationIcon]];

			-- StarterGui._zui.zAssets.Notification.ContentContainer.UIListLayout
			zui["34"] = Instance.new("UIListLayout", zui["31"]);
			zui["34"]["HorizontalFlex"] = Enum.UIFlexAlignment.Fill;
			zui["34"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
			zui["34"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
			zui["34"]["FillDirection"] = Enum.FillDirection.Horizontal;

			-- StarterGui._zui.zAssets.Notification.ContentContainer.UIPadding
			zui["35"] = Instance.new("UIPadding", zui["31"]);
			zui["35"]["PaddingLeft"] = UDim.new(0, 10);
		end
	end; _()

	zuiClass.makeTab = function(tabConfig)
		local tab = {}
		checkOptional(tabConfig, {
			name = "New Tab",
		})

		tab.myId = global.elementCounter
		global.elementCounter += 1

		local function _()
			-- StarterGui._zui.zMain.zTab
			zui["4"] = Instance.new("Frame", zui["2"]);
			zui["4"]["BorderSizePixel"] = 0;
			zui["4"]["BackgroundColor3"] = Color3.fromRGB(51, 51, 51);
			zui["4"]["AutomaticSize"] = Enum.AutomaticSize.Y;
			zui["4"]["Size"] = UDim2.new(0.125, 0, 0, 0);
			zui["4"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			zui["4"]["Name"] = [[zTab]];
			tab.tabFrame = zui["4"]

			-- StarterGui._zui.zMain.zTab.Title
			zui["5"] = Instance.new("TextLabel", zui["4"]);
			zui["5"]["BorderSizePixel"] = 0;
			zui["5"]["TextSize"] = 14;
			zui["5"]["BackgroundColor3"] = Color3.fromRGB(255, 179, 242);
			zui["5"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			zui["5"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			zui["5"]["Size"] = UDim2.new(1, 0, 0, 20);
			zui["5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			zui["5"]["Name"] = [[Title]];
			zui["5"]["Text"] = tabConfig.name

			-- StarterGui._zui.zMain.zTab.UIListLayout
			zui["6"] = Instance.new("UIListLayout", zui["4"]);
			zui["6"]["Wraps"] = true;
			zui["6"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
			zui["6"]["FillDirection"] = Enum.FillDirection.Horizontal;
		end; _()

		tab.newSection = function(sectionConfig)
			local section = {}
			checkOptional(sectionConfig, {
				name = "New Section"
			})

			section.myId = global.elementCounter
			global.elementCounter += 1

			section.init = function()
				-- StarterGui._zui.zMain.zTab.Section
				zui["7"] = Instance.new("Frame", zui["4"]);
				zui["7"]["BorderSizePixel"] = 0;
				zui["7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				zui["7"]["ClipsDescendants"] = true;
				zui["7"]["AutomaticSize"] = Enum.AutomaticSize.Y;
				zui["7"]["Size"] = UDim2.new(1, -5, 0, 0);
				zui["7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				zui["7"]["Name"] = [[Section]];
				zui["7"]["BackgroundTransparency"] = 1;


				-- StarterGui._zui.zMain.zTab.Section.SectionName
				zui["8"] = Instance.new("TextLabel", zui["7"]);
				zui["8"]["TextWrapped"] = true;
				zui["8"]["TextTruncate"] = Enum.TextTruncate.AtEnd;
				zui["8"]["BorderSizePixel"] = 0;
				zui["8"]["TextSize"] = 10;
				zui["8"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				zui["8"]["BackgroundColor3"] = Color3.fromRGB(255, 179, 242);
				zui["8"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
				zui["8"]["TextColor3"] = Color3.fromRGB(171, 171, 171);
				zui["8"]["BackgroundTransparency"] = 1;
				zui["8"]["Size"] = UDim2.new(0, 0, 0, 12);
				zui["8"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				zui["8"]["Text"] = sectionConfig.name;
				zui["8"]["AutomaticSize"] = Enum.AutomaticSize.XY;
				zui["8"]["Name"] = [[SectionName]];


				-- StarterGui._zui.zMain.zTab.Section.SectionName.UIPadding
				zui["9"] = Instance.new("UIPadding", zui["8"]);
				zui["9"]["PaddingLeft"] = UDim.new(0, 10);


				-- StarterGui._zui.zMain.zTab.Section.UIListLayout
				zui["a"] = Instance.new("UIListLayout", zui["7"]);
				zui["a"]["Padding"] = UDim.new(0, 5);
				zui["a"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
				zui["a"]["ItemLineAlignment"] = Enum.ItemLineAlignment.Center;
				zui["a"]["FillDirection"] = Enum.FillDirection.Horizontal;


				-- StarterGui._zui.zMain.zTab.Section.UIPadding
				zui["b"] = Instance.new("UIPadding", zui["7"]);
				zui["b"]["PaddingTop"] = UDim.new(0, 6);


				-- StarterGui._zui.zMain.zTab.Section.Divider
				zui["c"] = Instance.new("Frame", zui["7"]);
				zui["c"]["BorderSizePixel"] = 0;
				zui["c"]["BackgroundColor3"] = Color3.fromRGB(171, 171, 171);
				zui["c"]["Size"] = UDim2.new(1, 100, 0, 1);
				zui["c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				zui["c"]["Name"] = [[Divider]];

				section.sectionObj = zui["7"]
			end

			section.updateProperties = function(config)
				checkOptional(config, sectionConfig)
				sectionConfig = config
			end

			section.destroy = function()
				if section.sectionObj then
					section.sectionObj:Destroy()
				else
					warn("z: No section to destroy")
				end
			end			

			section.init()
			return section
		end

		tab.newToggle = function(toggleConfig)
			local toggle = {
				enabled = false
			}

			checkOptional(toggleConfig, {
				name = "New Toggle",
				enabled = toggle.enabled or false,
				callback = function(n) end,
			})

			toggle.myId = global.elementCounter
			global.elementCounter += 1

			function toggle.init()
				do
					-- StarterGui._zui.zMain.zTab.Toggle
					zui["d"] = Instance.new("Frame", zui["4"]);
					zui["d"]["BorderSizePixel"] = 0;
					zui["d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					zui["d"]["AutomaticSize"] = Enum.AutomaticSize.Y;
					zui["d"]["Size"] = UDim2.new(1, 0, 0, 0);
					zui["d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					zui["d"]["Name"] = [[Toggle]];
					zui["d"]["BackgroundTransparency"] = 1;
					toggle.rootFrame = zui["d"]

					-- StarterGui._zui.zMain.zTab.Toggle.ToggleName
					zui["e"] = Instance.new("TextLabel", zui["d"]);
					zui["e"]["TextWrapped"] = true;
					zui["e"]["BorderSizePixel"] = 0;
					zui["e"]["TextSize"] = 14;
					zui["e"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					zui["e"]["BackgroundColor3"] = Color3.fromRGB(255, 179, 242);
					zui["e"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
					zui["e"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					zui["e"]["BackgroundTransparency"] = 1;
					zui["e"]["Size"] = UDim2.new(0.8, 0, 0, 0);
					zui["e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					zui["e"]["Text"] = toggleConfig.name;
					zui["e"]["AutomaticSize"] = Enum.AutomaticSize.Y;
					zui["e"]["Name"] = [[ToggleName]];


					-- StarterGui._zui.zMain.zTab.Toggle.ToggleName.UIPadding
					zui["f"] = Instance.new("UIPadding", zui["e"]);
					zui["f"]["PaddingLeft"] = UDim.new(0, 10);


					-- StarterGui._zui.zMain.zTab.Toggle.Toggler
					zui["10"] = Instance.new("Frame", zui["d"]);
					zui["10"]["BorderSizePixel"] = 0;
					zui["10"]["BackgroundColor3"] = Color3.fromRGB(26, 26, 26);
					zui["10"]["Size"] = UDim2.new(0, 20, 0, 20);
					zui["10"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					zui["10"]["Name"] = [[Toggler]];
					toggle.toggler = zui["10"]


					-- StarterGui._zui.zMain.zTab.Toggle.Toggler.ImageLabel
					zui["11"] = Instance.new("ImageLabel", zui["10"]);
					zui["11"]["BorderSizePixel"] = 0;
					zui["11"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					zui["11"]["ImageColor3"] = Color3.fromRGB(255, 179, 242);
					zui["11"]["Image"] = [[rbxassetid://6594749870]];
					zui["11"]["Size"] = UDim2.new(1, 0, 1, 0);
					zui["11"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					zui["11"]["BackgroundTransparency"] = 1;
					zui["11"]["Visible"] = toggleConfig.enabled or toggle.enabled
					toggle.togglerIcon = zui["11"]


					-- StarterGui._zui.zMain.zTab.Toggle.UIListLayout
					zui["12"] = Instance.new("UIListLayout", zui["d"]);
					zui["12"]["Padding"] = UDim.new(0, 10);
					zui["12"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
					zui["12"]["ItemLineAlignment"] = Enum.ItemLineAlignment.Center;
					zui["12"]["FillDirection"] = Enum.FillDirection.Horizontal;


					-- StarterGui._zui.zMain.zTab.Toggle.UIPadding
					zui["13"] = Instance.new("UIPadding", zui["d"]);
					zui["13"]["PaddingTop"] = UDim.new(0, 5);
					zui["13"]["PaddingBottom"] = UDim.new(0, 5);
				end

				local hover = false
				local debounce = false
				
				toggle.updateProperties = function(config)
					checkOptional(config, toggleConfig)
					toggleConfig = config
				end

				local mouseEnter = toggle.toggler.MouseEnter:Connect(function()
					hover = true

					mouse.Button1Down:Connect(function()
						if not hover then else
							if debounce then
								task.wait(0.1) ; debounce = false
							else
								toggle.enabled = not toggle.enabled
								toggle.togglerIcon.Visible = toggle.enabled
								toggleConfig.callback(toggle.enabled)

								debounce = true
								task.wait(0.1) ; debounce = false
							end
						end
					end)
				end)

				local mouseLeave = toggle.toggler.MouseLeave:Connect(function()
					hover = false
				end)

				zuiLib.connections["Toggle_" .. global.elementCounter] = {mouseEnter, mouseLeave}
			end

			toggle.destroy = function()
				if toggle.rootFrame then
					for index, connection in pairs(zuiLib.connections[toggleConfig.name]) do
						connection:Disconnect()
					end

					toggle.rootFrame:Destroy()
				else
					warn("z: No toggle to destroy")
				end
			end

			toggle.init()
			return toggle
		end

		tab.newButton = function(buttonConfig)
			local button = {}
			checkOptional(buttonConfig, {
				name = "New Button",
				callback = function() end,
			})

			button.myId = global.elementCounter
			global.elementCounter += 1

			function button.init()
				do
					-- StarterGui._zui.zMain.zTab.Button
					zui["1e"] = Instance.new("Frame", zui["4"]);
					zui["1e"]["BorderSizePixel"] = 0;
					zui["1e"]["BackgroundColor3"] = Color3.fromRGB(46, 46, 46);
					zui["1e"]["AutomaticSize"] = Enum.AutomaticSize.Y;
					zui["1e"]["Size"] = UDim2.new(1, 0, 0, 0);
					zui["1e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					zui["1e"]["Name"] = [[Button]];


					-- StarterGui._zui.zMain.zTab.Button.UIListLayout
					zui["1f"] = Instance.new("UIListLayout", zui["1e"]);
					zui["1f"]["HorizontalFlex"] = Enum.UIFlexAlignment.SpaceBetween;
					zui["1f"]["Padding"] = UDim.new(0, 8);
					zui["1f"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
					zui["1f"]["FillDirection"] = Enum.FillDirection.Horizontal;


					-- StarterGui._zui.zMain.zTab.Button.UIPadding
					zui["20"] = Instance.new("UIPadding", zui["1e"]);
					zui["20"]["PaddingTop"] = UDim.new(0, 5);
					zui["20"]["PaddingRight"] = UDim.new(0, 5);
					zui["20"]["PaddingLeft"] = UDim.new(0, 10);
					zui["20"]["PaddingBottom"] = UDim.new(0, 5);


					-- StarterGui._zui.zMain.zTab.Button.ButtonName
					zui["21"] = Instance.new("TextLabel", zui["1e"]);
					zui["21"]["TextWrapped"] = true;
					zui["21"]["BorderSizePixel"] = 0;
					zui["21"]["TextSize"] = 14;
					zui["21"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					zui["21"]["BackgroundColor3"] = Color3.fromRGB(255, 179, 242);
					zui["21"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
					zui["21"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					zui["21"]["BackgroundTransparency"] = 1;
					zui["21"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					zui["21"]["Text"] = buttonConfig.name;
					zui["21"]["AutomaticSize"] = Enum.AutomaticSize.Y;
					zui["21"]["Name"] = [[ButtonName]];
					zui["21"]["Size"] = UDim2.new(0, 120, 0, 0)


					-- StarterGui._zui.zMain.zTab.Button.ClickIndicator
					zui["22"] = Instance.new("ImageLabel", zui["1e"]);
					zui["22"]["BorderSizePixel"] = 0;
					zui["22"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					zui["22"]["ImageColor3"] = Color3.fromRGB(255, 179, 242);
					zui["22"]["Image"] = [[rbxassetid://12795925866]];
					zui["22"]["Size"] = UDim2.new(0, 20, 0, 20);
					zui["22"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					zui["22"]["BackgroundTransparency"] = 1;
					zui["22"]["Name"] = [[ClickIndicator]];
					zui["22"]["SizeConstraint"] = Enum.SizeConstraint.RelativeYY
				end

				local hover = false
				local debounce = false

				button.button = zui["1e"]
				
				button.updateProperties = function(config)
					checkOptional(config, buttonConfig)
					buttonConfig = config
				end
				
				local mouseEnter = button.button.MouseEnter:Connect(function()
					hover = true

					ts:Create(button.button, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = self.settings.darkBg}):Play()

					mouse.Button1Down:Connect(function()
						if not hover then else
							if debounce then
								task.wait(0.1) ; debounce = false
							else
								buttonConfig.callback()
								debounce = true
								task.wait(0.1) ; debounce = false
							end
						end
					end)
				end)

				local mouseLeave = button.button.MouseLeave:Connect(function()
					hover = false

					ts:Create(button.button, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(46,46,46)}):Play()
				end)

				zuiLib.connections["Button_" .. global.elementCounter] = {mouseEnter, mouseLeave}
			end

			button.destroy = function()
				if button.button then
					for index, connection in pairs(zuiLib.connections["Button_" .. button.myId]) do
						connection:Disconnect()
					end

					button.button:Destroy()
				else
					warn("z: No button to destroy")
				end
			end

			button.init()
			return button
		end

		tab.newSlider = function(sliderConfig)
			local slider = {
				value = -1,
				maxValue = -1,
				minValue = -5,
			}

			checkOptional(sliderConfig, {
				name = "New Slider",
				value = 0,
				minValue = 0,
				maxValue = 50,
				decimalPlaces = 0,
				callback = function(v) end,
			})

			slider.value = sliderConfig.value
			slider.maxValue = sliderConfig.maxValue
			slider.callback = sliderConfig.callback

			slider.init = function()
				do
					-- StarterGui._zui.zMain.zTab.Slider
					zui["14"] = Instance.new("Frame", zui["4"]);
					zui["14"]["BorderSizePixel"] = 0;
					zui["14"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					zui["14"]["AutomaticSize"] = Enum.AutomaticSize.Y;
					zui["14"]["Size"] = UDim2.new(1, 0, 0, 0);
					zui["14"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					zui["14"]["Name"] = [[Slider]];
					zui["14"]["BackgroundTransparency"] = 1;


					-- StarterGui._zui.zMain.zTab.Slider.UIListLayout
					zui["15"] = Instance.new("UIListLayout", zui["14"]);
					zui["15"]["Padding"] = UDim.new(0, 8);
					zui["15"]["SortOrder"] = Enum.SortOrder.LayoutOrder;


					-- StarterGui._zui.zMain.zTab.Slider.UIPadding
					zui["16"] = Instance.new("UIPadding", zui["14"]);
					zui["16"]["PaddingTop"] = UDim.new(0, 5);
					zui["16"]["PaddingLeft"] = UDim.new(0, 10);
					zui["16"]["PaddingBottom"] = UDim.new(0, 5);


					-- StarterGui._zui.zMain.zTab.Slider.Dragger
					zui["17"] = Instance.new("Frame", zui["14"]);
					zui["17"]["BorderSizePixel"] = 0;
					zui["17"]["BackgroundColor3"] = Color3.fromRGB(26, 26, 26);
					zui["17"]["Size"] = UDim2.new(1, -10, 0, 5);
					zui["17"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					zui["17"]["Name"] = [[Dragger]];
					slider.dragger = zui["17"]


					-- StarterGui._zui.zMain.zTab.Slider.Dragger.Filler
					zui["18"] = Instance.new("Frame", zui["17"]);
					zui["18"]["BorderSizePixel"] = 0;
					zui["18"]["BackgroundColor3"] = Color3.fromRGB(255, 179, 242);
					zui["18"]["Size"] = UDim2.new(0.5, 0, 1, 0);
					zui["18"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					zui["18"]["Name"] = [[Filler]];
					slider.filler = zui["18"]


					-- StarterGui._zui.zMain.zTab.Slider.NameContainer
					zui["19"] = Instance.new("Frame", zui["14"]);
					zui["19"]["BorderSizePixel"] = 0;
					zui["19"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					zui["19"]["AutomaticSize"] = Enum.AutomaticSize.Y;
					zui["19"]["Size"] = UDim2.new(1, 0, 0, 0);
					zui["19"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					zui["19"]["Name"] = [[NameContainer]];
					zui["19"]["LayoutOrder"] = -1;
					zui["19"]["BackgroundTransparency"] = 1;


					-- StarterGui._zui.zMain.zTab.Slider.NameContainer.SliderName
					zui["1a"] = Instance.new("TextLabel", zui["19"]);
					zui["1a"]["TextWrapped"] = true;
					zui["1a"]["BorderSizePixel"] = 0;
					zui["1a"]["TextSize"] = 14;
					zui["1a"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					zui["1a"]["BackgroundColor3"] = Color3.fromRGB(255, 179, 242);
					zui["1a"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
					zui["1a"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					zui["1a"]["BackgroundTransparency"] = 1;
					zui["1a"]["Size"] = UDim2.new(0, 100, 0, 0);
					zui["1a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					zui["1a"]["Text"] = sliderConfig.name;
					zui["1a"]["AutomaticSize"] = Enum.AutomaticSize.Y;
					zui["1a"]["Name"] = [[SliderName]];


					-- StarterGui._zui.zMain.zTab.Slider.NameContainer.UIListLayout
					zui["1b"] = Instance.new("UIListLayout", zui["19"]);
					zui["1b"]["HorizontalFlex"] = Enum.UIFlexAlignment.SpaceBetween;
					zui["1b"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
					zui["1b"]["FillDirection"] = Enum.FillDirection.Horizontal;


					-- StarterGui._zui.zMain.zTab.Slider.NameContainer.Value
					zui["1c"] = Instance.new("TextLabel", zui["19"]);
					zui["1c"]["TextWrapped"] = true;
					zui["1c"]["BorderSizePixel"] = 0;
					zui["1c"]["TextSize"] = 14;
					zui["1c"]["TextXAlignment"] = Enum.TextXAlignment.Right;
					zui["1c"]["TextScaled"] = true;
					zui["1c"]["BackgroundColor3"] = Color3.fromRGB(255, 179, 242);
					zui["1c"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
					zui["1c"]["TextColor3"] = Color3.fromRGB(171, 171, 171);
					zui["1c"]["BackgroundTransparency"] = 1;
					zui["1c"]["Size"] = UDim2.new(0, 40, 0, 14);
					zui["1c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					zui["1c"]["Text"] = slider.value;
					zui["1c"]["Name"] = [[Value]];
					slider.valueText = zui["1c"]


					-- StarterGui._zui.zMain.zTab.Slider.NameContainer.UIPadding
					zui["1d"] = Instance.new("UIPadding", zui["19"]);
					zui["1d"]["PaddingRight"] = UDim.new(0, 10);
				end

				local hover = false
				local dragging = false

				slider.update = function(value)
					local eq = value > 0 and value / sliderConfig.maxValue or 0

					slider.valueText.Text = value < sliderConfig.maxValue and value or sliderConfig.maxValue
					slider.filler.Size = UDim2.fromScale(eq <= 1 and eq or 1, 1)
					slider.value = value
				end

				slider.updateProperties = function(config)
					checkOptional(config, sliderConfig)
					sliderConfig = config
					slider.update(slider.value)
				end

				slider.valueText = zui["1c"]

				local mouseEnter = slider.dragger.MouseEnter:Connect(function()
					hover = true
				end)

				local mouseLeave = slider.dragger.MouseLeave:Connect(function()
					hover = false
				end)

				local mouseDrag = uis.InputBegan:Connect(function(io, gpe)
					if io.UserInputType == Enum.UserInputType.MouseButton1 or io.UserInputType == Enum.UserInputType.Touch and hover then
						if not hover then else
							dragging = true

							while dragging do
								local output = math.clamp(((Vector2.new(mouse.X, mouse.Y) - slider.dragger.AbsolutePosition) / slider.dragger.AbsoluteSize).X, 0, 1)
								local mapped = sliderConfig.minValue + (output * (sliderConfig.maxValue - sliderConfig.minValue))

								local value = tonumber(string.format("%." .. (sliderConfig.decimalPlaces or 0) .. "f", mapped))

								slider.valueText.Text = value
								slider.filler.Size = UDim2.fromScale(output, 1)
								slider.value = value
								sliderConfig.callback(value)

								task.wait()
							end
						end
					end
				end)

				local mouseEnd = uis.InputEnded:Connect(function(io, gpe)
					if io.UserInputType == Enum.UserInputType.MouseButton1 or io.UserInputType == Enum.UserInputType.Touch then
						dragging = false
					end
				end)

				zuiLib.connections["Slider_" .. global.elementCounter] = {mouseEnter, mouseLeave, mouseDrag, mouseEnd}
				slider.update(sliderConfig.value)
			end

			slider.init()
			return slider
		end
		
		tab.newDropdown = function(dropdownConfig)
			local dropdown = {}
			
			checkOptional(dropdownConfig, {
				name = "New Dropdown",
				options = {
					[1] = "Example 1",
					[2] = "Example 2"
				},
				default = 1,
				callback = function(choice)
					print(choice)	
				end,
			})
			
			dropdown.myId = global.elementCounter
			global.elementCounter += 1
			
			dropdown.init = function()
				do
					dropdown.objects = {}
					-- StarterGui._zui.zMain.zTab.Dropdown
					zui["94"] = Instance.new("Frame", zui["4"]);
					zui["94"]["BorderSizePixel"] = 0;
					zui["94"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					zui["94"]["AutomaticSize"] = Enum.AutomaticSize.Y;
					zui["94"]["Size"] = UDim2.new(1, 0, 0, 0);
					zui["94"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					zui["94"]["Name"] = [[Dropdown]];
					zui["94"]["BackgroundTransparency"] = 1;
					
					dropdown.objects.dropdown = zui["94"]


					-- StarterGui._zui.zMain.zTab.Dropdown.UIListLayout
					zui["95"] = Instance.new("UIListLayout", dropdown.objects.dropdown);
					zui["95"]["HorizontalFlex"] = Enum.UIFlexAlignment.SpaceBetween;
					zui["95"]["Padding"] = UDim.new(0, 5);
					zui["95"]["SortOrder"] = Enum.SortOrder.LayoutOrder;


					-- StarterGui._zui.zMain.zTab.Dropdown.UIPadding
					zui["96"] = Instance.new("UIPadding", dropdown.objects.dropdown);
					zui["96"]["PaddingTop"] = UDim.new(0, 10);
					zui["96"]["PaddingRight"] = UDim.new(0, 10);
					zui["96"]["PaddingLeft"] = UDim.new(0, 10);
					zui["96"]["PaddingBottom"] = UDim.new(0, 10);


					-- StarterGui._zui.zMain.zTab.Dropdown.DropdownContainer
					zui["97"] = Instance.new("Frame", dropdown.objects.dropdown);
					zui["97"]["BorderSizePixel"] = 0;
					zui["97"]["BackgroundColor3"] = Color3.fromRGB(47, 47, 47);
					zui["97"]["ClipsDescendants"] = true;
					zui["97"]["Size"] = UDim2.new(1, 0, 0, 25);
					zui["97"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					zui["97"]["Name"] = [[DropdownContainer]];
					zui["97"]["LayoutOrder"] = 1;
					dropdown.objects.container = zui["97"]
					dropdown.objects.options = {}


					-- StarterGui._zui.zMain.zTab.Dropdown.DropdownContainer.Selected
					for index, option in pairs(dropdownConfig.options) do
						dropdown.objects.options[index] = Instance.new("TextLabel", dropdown.objects.container);
						dropdown.objects.options[index]["TextWrapped"] = true;
						dropdown.objects.options[index]["BorderSizePixel"] = 0;
						dropdown.objects.options[index]["TextSize"] = 14;
						dropdown.objects.options[index]["BackgroundColor3"] = index == dropdownConfig.default and Color3.fromRGB(24, 24, 24) or Color3.fromRGB(31, 31, 31);
						dropdown.objects.options[index]["LayoutOrder"] = index
						dropdown.objects.options[index]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
						dropdown.objects.options[index]["TextColor3"] = Color3.fromRGB(255, 255, 255);
						dropdown.objects.options[index]["Size"] = UDim2.new(1, 0, 0, 25);
						dropdown.objects.options[index]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						dropdown.objects.options[index]["Text"] = option;
						dropdown.objects.options[index]["Name"] = option;
						if index == dropdownConfig.default then
							dropdown.objects.current = dropdown.objects.options[index]
						end
					end


					-- StarterGui._zui.zMain.zTab.Dropdown.DropdownContainer.UIListLayout
					zui["99"] = Instance.new("UIListLayout", zui["97"]);
					zui["99"]["HorizontalFlex"] = Enum.UIFlexAlignment.SpaceBetween;
					zui["99"]["SortOrder"] = Enum.SortOrder.LayoutOrder;


					-- StarterGui._zui.zMain.zTab.Dropdown.NameContainer
					zui["9b"] = Instance.new("Frame", dropdown.objects.dropdown);
					zui["9b"]["BorderSizePixel"] = 0;
					zui["9b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					zui["9b"]["AutomaticSize"] = Enum.AutomaticSize.Y;
					zui["9b"]["Size"] = UDim2.new(1, 0, 0, 0);
					zui["9b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					zui["9b"]["Name"] = [[NameContainer]];
					zui["9b"]["LayoutOrder"] = -1;
					zui["9b"]["BackgroundTransparency"] = 1;


					-- StarterGui._zui.zMain.zTab.Dropdown.NameContainer.UIListLayout
					zui["9c"] = Instance.new("UIListLayout", zui["9b"]);
					zui["9c"]["HorizontalFlex"] = Enum.UIFlexAlignment.SpaceBetween;
					zui["9c"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
					zui["9c"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
					zui["9c"]["FillDirection"] = Enum.FillDirection.Horizontal;


					-- StarterGui._zui.zMain.zTab.Dropdown.NameContainer.UIPadding
					zui["9d"] = Instance.new("UIPadding", zui["9b"]);
					zui["9d"]["PaddingRight"] = UDim.new(0, -3);

					-- StarterGui._zui.zMain.zTab.Dropdown.NameContainer.DropdownName
					zui["9f"] = Instance.new("TextLabel", zui["9b"]);
					zui["9f"]["TextWrapped"] = true;
					zui["9f"]["BorderSizePixel"] = 0;
					zui["9f"]["TextSize"] = 14;
					zui["9f"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					zui["9f"]["BackgroundColor3"] = Color3.fromRGB(255, 180, 243);
					zui["9f"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
					zui["9f"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					zui["9f"]["BackgroundTransparency"] = 1;
					zui["9f"]["Size"] = UDim2.new(0, 100, 0, 0);
					zui["9f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					zui["9f"]["Text"] = dropdownConfig.name;
					zui["9f"]["AutomaticSize"] = Enum.AutomaticSize.Y;
					zui["9f"]["Name"] = [[DropdownName]];
				end
				
				local hover = false
				local debounce = false
				local expanded = false			

				dropdown.refreshOptions = function()
					dropdown.objects.options = {}
					zuiLib.connections["DropdownOpt_" .. dropdown.myId] = {}
					
					for index, option in pairs(dropdown.objects.container:GetChildren()) do
						if option:IsA("TextLabel") then
							option:Destroy()
						end
					end
					
					for index, option in pairs(dropdownConfig.options) do
						dropdown.objects.options[index] = Instance.new("TextLabel", dropdown.objects.container);
						dropdown.objects.options[index]["TextWrapped"] = true;
						dropdown.objects.options[index]["BorderSizePixel"] = 0;
						dropdown.objects.options[index]["TextSize"] = 14;
						dropdown.objects.options[index]["BackgroundColor3"] = index == dropdownConfig.default and Color3.fromRGB(24, 24, 24) or Color3.fromRGB(31, 31, 31);
						dropdown.objects.options[index]["LayoutOrder"] = index
						dropdown.objects.options[index]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
						dropdown.objects.options[index]["TextColor3"] = Color3.fromRGB(255, 255, 255);
						dropdown.objects.options[index]["Size"] = UDim2.new(1, 0, 0, 25);
						dropdown.objects.options[index]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						dropdown.objects.options[index]["Text"] = option;
						dropdown.objects.options[index]["Name"] = option;
						if index == dropdownConfig.default then
							dropdown.objects.current = dropdown.objects.options[index]
						end

						zuiLib.connections["DropdownOpt_" .. dropdown.myId]["i" .. index] = {}
					end
					
					for index, option in pairs(dropdown.objects.options) do
						local o_hover = false
						local o_debounce = false

						local optionMouseEnter = option.MouseEnter:Connect(function()
							o_hover = true

							local click = mouse.Button1Down:Connect(function()
								task.wait()

								if o_hover and not expanded then
									if o_debounce then return end
									o_debounce = true

									dropdown.objects.current.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
									dropdown.objects.current.LayoutOrder = option.LayoutOrder

									dropdown.objects.current = option
									dropdown.objects.current.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
									option.LayoutOrder = 1

									dropdownConfig.callback(option.Text)

									task.wait(.1)
									o_debounce = false
								end
							end)
						end)

						local optionMouseLeave = option.MouseLeave:Connect(function()
							o_hover = false
						end)

						zuiLib.connections["DropdownOpt_" .. dropdown.myId]["i" .. index] = {optionMouseEnter, optionMouseLeave}
					end
				end
				
				dropdown.updateProperties = function(config)
					checkOptional(config, dropdownConfig)
					dropdownConfig = config
					dropdown.refreshOptions()
				end	
				
				local mouseEnter = dropdown.objects.container.MouseEnter:Connect(function()
					hover = true
					
					mouse.Button1Down:Connect(function()
						if debounce then return end
						debounce = true
						
						if not hover then else
							expanded = not expanded
							
							if expanded then
								dropdown.objects.container.Size = UDim2.new(1, 0, 0, #dropdown.objects.options * 25)
							else
								dropdown.objects.container.Size = UDim2.new(1, 0, 0, 25)
							end
						end
						
						task.wait(.1)
						debounce = false
					end)
				end)
				
				local mouseLeave = dropdown.objects.container.MouseLeave:Connect(function()
					hover = false
				end)
				
				dropdown.refreshOptions()
				zuiLib.connections["Dropdown_" .. dropdown.myId] = {mouseEnter, mouseLeave}
			end
			
			dropdown.destroy = function()
				if dropdown.objects.dropdown then
					for index, connection in pairs(zuiLib.connections["Dropdown_" .. dropdown.myId]) do
						connection:Disconnect()
					end
					
					for index, array in pairs(zuiLib.connections["DropdownOpt_" .. dropdown.myId]) do
						for index, connection in pairs(array) do
							connection:Disconnect()
						end
					end
					
					dropdown.objects.dropdown:Destroy()
				else
					warn("z: No dropdown to destroy")
				end
			end
			
			dropdown.init()
			return dropdown
		end

		return tab
	end

	zuiClass.makeNotification = function(notiConfig)
		local noti = {}
		checkOptional(notiConfig, {
			name = "Notification",
			content = "This is a notification!",
			icon = "rbxassetid://10723415903",
			duration = 5,
		})

		noti.myId = global.elementCounter
		global.elementCounter += 1

		local function init()
			local hover = false
			local newNotification = zui["2c"]:Clone()
			newNotification.Parent = zui["28"]
			newNotification.Visible = true

			local notiTitle = newNotification:WaitForChild("Title")

			local notiDuration = newNotification:WaitForChild("Duration")
			local notiHourglass = notiDuration:WaitForChild("Filler")

			local notiContent = newNotification:WaitForChild("ContentContainer")

			local notiTextContent = notiContent:FindFirstChild("Content")
			local notiIcon = notiContent:FindFirstChild("NotificationIcon")

			notiTitle.Text = notiConfig.name
			notiTextContent.Text = notiConfig.content
			notiIcon = notiConfig.icon

			d:AddItem(newNotification, notiConfig.duration)
			ts:Create(notiHourglass, TweenInfo.new(notiConfig.duration), {Size = UDim2.new(0, 0, 1, 0)}):Play()

			local hover = false
			local debounce = false

			local mouseEnter = newNotification.MouseEnter:Connect(function()
				hover = true

				mouse.Button1Down:Connect(function()
					if not hover then else
						if debounce then
							task.wait(0.1) ; debounce = false
						else
							noti.destroy()
							debounce = true
							task.wait(0.1) ; debounce = false
						end
					end
				end)
			end)

			local mouseLeave = newNotification.MouseLeave:Connect(function()
				hover = false
			end)

			zuiLib.connections["Notification_" .. noti.myId] = {mouseEnter, mouseLeave}

			noti.notiObj = newNotification
			noti.notiTitle = notiTitle
			noti.notiTextContent = notiTextContent
			noti.notiHourglass = notiHourglass
		end

		noti.destroy = function()
			if noti.notiObj then
				for index, connection in pairs(zuiLib.connections["Notification_" .. noti.myId]) do
					connection:Disconnect()
				end

				noti.notiObj:Destroy()
			else
				warn("z: No notification to destroy")
			end
		end

		init()
		return noti
	end

	uis.InputBegan:Connect(function(io, gpe)
		if io.KeyCode == s.keybinds.toggleVis then
			zui["2"]["Visible"] = not zui["2"]["Visible"]
		end
	end)

	return zuiClass
end

return zuiLib
