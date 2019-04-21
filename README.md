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

- <kbd>F4</kbd> (dashboard key) to display/hide spootlight\n
- <kbd>F4</kbd> (dashboard key") to super if hold


 #### super key

- <details><summary> <kbd>super</kbd> + <kbd>M</kbd> = switch between light and dark mode in mojave </summary></details>
- <kbd>super</kbd> + <kbd>D</kbd> = display/hide month's calendar upfront
- <kbd>super</kbd> + <kbd>F</kbd> = launch facebook
- <kbd>super</kbd> + <kbd>N</kbd> = launch google news
- <kbd>super</kbd> + <kbd>Q</kbd> = quit all visible apps
- <kbd>super</kbd> + <kbd>R</kbd> = Reload hammerspoon config
- <kbd>super</kbd> + <kbd>T</kbd> = launch Terminal
- <kbd>super</kbd> + <kbd>→</kbd> = go to end of line
- <kbd>super</kbd> + <kbd>←</kbd> = go to beginning of line
- <kbd>super</kbd> + <kbd>cmd ⌘</kbd> + <kbd>←</kbd> <kbd>→</kbd> <kbd>↓</kbd> <kbd>↑</kbd> = resize window to left/right/down/up half screen
- <kbd>super</kbd> + <kbd>cmd ⌘</kbd> + <kbd>@</kbd> = resize to whole screen

 #### other
 
- <kbd>cmd ⌘</kbd>+<kbd>ctrl</kbd>+<kbd>L</kbd>= gtranslate window 

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

- <kbd>F3</kbd> (spaces) <kbd>F11</kbd> (show desktop)
- <kbd>F4</kbd> (dashboard) to <kbd>F18</kbd> (soon to be super)

## Credit: some of the script, spoons and modules were adapted from

- https://github.com/Hammerspoon/Spoons ( WinWin, Calendar, Bingdaily )
- https://github.com/pasiaj/Translate-for-Hammerspoon ( gtranslate )
- https://github.com/skamsie/hs-weather (weather)
- https://github.com/scottcs/dot_hammerspoon (caffeine, appwindows )
- https://github.com/lodestone/hyper-hacks/tree/master/hammerspoon ( key bindings )
- wheather icons by RNS, Freepik, Vectors Market, Yannick at http://www.flaticon.com
