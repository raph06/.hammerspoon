--
-- Key binding setup for all modules and misc functionality
--
local bindings = {}

-- Hyper key in Sierra
local hyper = hs.hotkey.modal.new({}, 'F17')

-- Enter/Exit Hyper Mode when F18 is pressed/released
local pressedF18 = function() hyper:enter() end
local releasedF18 = function() hyper:exit() end

-- Bind the Hyper key
-- Also requires Karabiner-Elements to bind left_control to F18
hs.hotkey.bind({}, 'F18', pressedF18, releasedF18)
-- hs.hotkey.bind(mod.s, 'F18', pressedF18, releasedF18)


  local function maximizeFrontmost()
    local win = hs.application.frontmostApplication():focusedWindow()
    if not win:isFullScreen() then win:maximize() end
  end




return bindings
