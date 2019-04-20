# .hammerspoon
hammerspoon config

### Weather menubar icon 

> Edit hs-weather/config.json to set location

Weather data: [Yahoo Weather API](https://developer.yahoo.com/weather/) requires an api key.  
Air Quality Indice: From http://aqicn.org/ requires API key

### Caffeine menubar icon 

### Desktop image chooser menubar icon
Chose between:

1. Bing (IOTD: image of the day)
2. Nasa apod (IOTD)
    - Doesn't work when IOTD is a video
    - Can mirror flip image
    - Require api key
3. National geographic (IOTD)
    - Require api key
4. Go Pro (*IOTD*) 
    - Not very active
5. Unsplash (Random or query)
    - Require api key
6. Flickr (Random or 1280*800)
    - Require api key
7. User's picture
    - set your favorite desktop image as .hammerspoon/BingDaily/media/userpic.jpeg
    - can show picture in finder
8. User's folder
    - display your favorite images in a folder and let them switch every 15 mins 
    - adds update real time earth map http://www.opentopia.com/images/data/sunlight/world_sunlight_map_rectangular.jpg
    - can show folder in finder

### Key Bindings

 #### Mackeys

- F4 (dashboard key) to display/hide spootlight\n
- F4 (dashboard key") to super if hold

 #### super key

- super+M = switch between light and dark mode in mojave
- super+D = display/hide month's calendar upfront
- super+F = launch facebook
- super+N = launch google news
- super+Q = quit all visible apps
- super+R = Reload hammerspoon config
- super+T = launch Terminal
- super+rightarrow = go to end of line
- super+leftarrow = go to beginning of line
- super+cmd+left or right or down or up = resize window to left/right/down/up half screen
- super+cmd+@ = resize to whole screen

 #### other
 
- cmd+ctrl+L= gtranslate window 

### Installation

Copy .hammerspoon in your home dir

Create a file called api_keys.lua in .hammerspoon and complete as follow
```
local keys = {}

keys.nasa='your_key'

keys.flickr='your_key'

keys.unsplash_applicationId="your_key"
keys.unsplash_secret="your_key"
keys.unsplash_callbackUrl="your_key"

keys.translate="your_key"

keys.air="your_key"

keys.weather_app='your_key'
keys.weather_user='your_key'
keys.weather_secret='your_key'

return keys
```
 #### Requirements
- May require npm packages for IOTDs 
 
 #### Karabiner-element mappings 

- F3 (spaces) F11 (show desktop)
- F4 (dashboard) to F18 (soon to be super)

## Credit: some of the script, spoons and modules were adapted from

- https://github.com/Hammerspoon/Spoons ( WinWin, Calendar, Bingdaily )
- https://github.com/pasiaj/Translate-for-Hammerspoon ( gtranslate )
- https://github.com/skamsie/hs-weather (weather)
- https://github.com/scottcs/dot_hammerspoon (caffeine, appwindows )
- https://github.com/lodestone/hyper-hacks/tree/master/hammerspoon ( key bindings )
- wheather icons by RNS, Freepik, Vectors Market, Yannick at http://www.flaticon.com
