local LOGLEVEL = 'debug'
local keys=require("api_keys")

-- List of modules to load (found in modules/ dir)
local modules = {
  'appwindows',
  'caffeine',
}



if not hspoon_list then
    hspoon_list = {
        "WinWin",
    }
end

-- Load those Spoons
for _, v in pairs(hspoon_list) do
    hs.loadSpoon(v)
end

-- global modules namespace (short for easy console use)
hsm = {}

-- load module configuration
local cfg = require('config')
hsm.cfg = cfg.global

-- global log
hsm.log = hs.logger.new(hs.host.localizedName(), LOGLEVEL)

-- load a module from modules/ dir, and set up a logger for it
local function loadModuleByName(modName)
  hsm[modName] = require('modules.' .. modName)
  hsm[modName].name = modName
  hsm[modName].log = hs.logger.new(modName, LOGLEVEL)
  hsm.log.i(hsm[modName].name .. ': module loaded')
end

-- save the configuration of a module in the module object
local function configModule(mod)
  mod.cfg = mod.cfg or {}
  if (cfg[mod.name]) then
    for k,v in pairs(cfg[mod.name]) do mod.cfg[k] = v end
    hsm.log.i(mod.name .. ': module configured')
  end
end

-- start a module
local function startModule(mod)
  if mod.start == nil then return end
  mod.start()
  hsm.log.i(mod.name .. ': module started')
end

-- stop a module
local function stopModule(mod)
  if mod.stop == nil then return end
  mod.stop()
  hsm.log.i(mod.name .. ': module stopped')
end

-- load, configure, and start each module
hs.fnutils.each(modules, loadModuleByName)
hs.fnutils.each(hsm, configModule)
hs.fnutils.each(hsm, startModule)

-- global function to stop modules and reload hammerspoon config
function hs_reload()
  hs.fnutils.each(hsm, stopModule)
  hs.reload()
end

-- load and bind key bindings
-- A global variable for the Hyper Mode
k = hs.hotkey.modal.new({}, "F17")

-- HYPER+F: Open news.google.com in the default browser
ffun = function()
  news = "app = Application.currentApplication(); app.includeStandardAdditions = true; app.doShellScript('open http://facebook.com')"
  hs.osascript.javascript(news)
  k.triggered = true
end
k:bind('', 'f', nil, ffun)



-- HYPER+N: Open news.google.com in the default browser
nfun = function()
  --java
  news = "app = Application.currentApplication(); app.includeStandardAdditions = true; app.doShellScript('open http://news.google.com')"
  hs.osascript.javascript(news)
  k.triggered = true
end
k:bind('', 'n', nil, nfun)

-- HYPER+M: Switch light dar mode mojave
mfun = function()
  local mode='tell application "System Events" \n tell appearance preferences \n set dark mode to not dark mode \n end tell \n end tell'
  hs.osascript.applescript(mode)
  k.triggered = true
end
k:bind('', 'm', nil, mfun)


--- cal
---
local cal=require("Calendar")
cal.init()
-- HYPER+d: calendar
dfun = function()
cal.canvas:show()
cal.canvas:hide(200)
k.triggered = true
end
k:bind({}, 'd', nil, dfun)

-- HYPER+E: Act like ⌃e and move to end of line.
efun = function()
  hs.eventtap.keyStroke({'⌃'}, 'e')
  k.triggered = true
end
k:bind({}, 'right', nil, efun)

-- HYPER+A: Act like ⌃a and move to beginning of line.
afun = function()
  hs.eventtap.keyStroke({'⌃'}, 'a')
  k.triggered = true
end
k:bind({}, 'left', nil, afun)



-- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
pressedF18 = function()
  k.triggered = false
  k:enter()
end

-- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
--   send spotlight if no other keys are pressed.
releasedF18 = function()
  k:exit()
  if not k.triggered then
    hs.eventtap.keyStroke({"control"}, 'SPACE')
  end
end

-- Bind the Hyper key
f18 = hs.hotkey.bind({}, 'F18', pressedF18, releasedF18)


-- Disable all window animations
hs.window.animationDuration = 0
hs.alert.show( ( hs.execute(os.getenv("HOME") .. "/.hammerspoon/scripts/stats") ) )
-- 'Hammerspoon Config Loaded', 1)
local gtranslate = require "gtranslate/gtranslate"
gtranslate.init(keys.translate, "en", "fr", {"cmd", "ctrl"}, 'L')

--- Weather
local weather = require("hs-weather")
weather.start()

----Terminal launch

k:bind({}, 't', function ()
    os.execute('/usr/bin/open -a Terminal ~')
    k.triggered = true

end)

----Quick quit

k:bind({}, 'q', function ()
    os.execute("open ".. os.getenv("HOME") .."/.hammerspoon/scripts/Quick_quit.app")
    k.triggered = true

end)

----Reload config

rfun = function()
hs.reload()
end
k:bind('', 'r', nil, rfun)

----Desktop image

local img=require("BingDaily")


----Window move and resize
moveL = function()
spoon.WinWin:moveAndResize("halfleft")
k.triggered = true
end
k:bind('cmd', "left", nil, moveL)

moveR = function()
spoon.WinWin:moveAndResize("halfright")
k.triggered = true
end
k:bind('cmd', 'right', nil, moveR)

moveu = function()
spoon.WinWin:moveAndResize("halfup")
k.triggered = true
end
k:bind('cmd', 'up', nil, moveu)

moved = function()
spoon.WinWin:moveAndResize("halfdown")
k.triggered = true
end
k:bind('cmd', 'down', nil, moved)

out = function()
spoon.WinWin:moveAndResize("fullscreen")
k.triggered = true
end
k:bind("cmd", "@", nil, out)
