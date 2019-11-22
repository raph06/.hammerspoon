--- === BingDaily ===
---
--- Use Bing daily picture as your wallpaper, automatically.
--- adapted from
--- Download: [https://github.com/Hammerspoon/Spoons/raw/master/Spoons/BingDaily.spoon.zip](https://github.com/Hammerspoon/Spoons/raw/master/Spoons/BingDaily.spoon.zip)

local keys=require("api_keys")
local obj={}
obj.__index = obj

-- Metadata
obj.name = "BingDaily"
obj.version = "1.0"
obj.author = "ashfinal <ashfinal@gmail.com>"
obj.homepage = "https://github.com/Hammerspoon/Spoons"
obj.license = "MIT - https://opensource.org/licenses/MIT"

local function setBingIcon(app)
  local iconPath = './BingDaily/media/bing.png'
  local size = {w=17,h=17}
  if iconPath ~= nil then
    app:setIcon(hs.image.imageFromPath(iconPath):setSize(size))
  else
    obj.menubar:setTitle("B")
  end
end

local function curl_callback(exitCode, stdOut, stdErr)
    if exitCode == 0 then
        obj.task = nil
        --obj.last_pic = hs.http.urlParts(obj.full_url).lastPathComponent
        --local localpath = os.getenv("HOME") .. "/.Trash/" .. hs.http.urlParts(obj.full_url).lastPathComponent
        --hs.screen.mainScreen():desktopImageURL("file://" .. path)
    else
        print(stdOut, stdErr)
    end
end

function obj:bingRequest()
    local user_agent_str = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/603.2.4 (KHTML, like Gecko) Version/10.1.1 Safari/603.2.4"
    local json_req_url = "http://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1"
    hs.http.asyncGet(json_req_url, {["User-Agent"]=user_agent_str}, function(stat,body,header)
        if stat == 200 then
            if pcall(function() hs.json.decode(body) end) then
                local decode_data = hs.json.decode(body)
                local pic_url = decode_data.images[1].url
                obj.copyright=decode_data.images[1].copyright

                obj.menubar:setTooltip(obj.copyright)

                    obj.full_url = "https://www.bing.com" .. pic_url
                    if obj.task then
                        obj.task:terminate()
                        obj.task = nil
                    end
                    local localpath = os.getenv("HOME") .. "/.hammerspoon/BingDaily/media/bing.jpeg"
                    obj.task = hs.task.new("/usr/bin/curl", curl_callback, {"-A", user_agent_str, obj.full_url, "-o", localpath})
                    obj.task:start()
                            --local localpath = os.getenv("HOME") .. "/.Hammerspoon/BingDaily/media/" .. hs.http.urlParts(obj.full_url).lastPathComponent
                            hs.screen.mainScreen():desktopImageURL("file://" .. localpath)


            end
        else
            print("Bing URL request failed!")
        end
    end)
end


---------------------
function obj:nasaRequest()
    local user_agent_str = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/603.2.4 (KHTML, like Gecko) Version/10.1.1 Safari/603.2.4"
  local json_req_url="https://api.nasa.gov/planetary/apod?api_key="..keys.nasa
hs.http.asyncGet(json_req_url, {["User-Agent"]=user_agent_str}, function(stat,body,header)
            if pcall(function() hs.json.decode(body) end) then
                local decode_data = hs.json.decode(body)
                obj.title=decode_data.title
                obj.url=decode_data.url
                --for i,v in ipairs(decode_data) do print(v) end
                  --for k in pairs(decode_data) do print(k) end
                obj.desc=decode_data.explanation
                obj.menubar:setTooltip(obj.title .. '\n' .. obj.desc)
                --print('debug',obj.url)
                if obj.task then
                    obj.task:terminate()
                    obj.task = nil
                end
                local localpath2 = os.getenv("HOME") .. "/.hammerspoon/BingDaily/media/" .. "nasa.jpeg"
                obj.task = hs.task.new("/usr/bin/curl", curl_callback, {"-A", user_agent_str, obj.url, "-o", localpath2})
                obj.task:start()
                hs.screen.mainScreen():desktopImageURL("file://" .. localpath2)
        end

    end)
    end
---------------------

function obj:earthRequest()
  local user_agent_str = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/603.2.4 (KHTML, like Gecko) Version/10.1.1 Safari/603.2.4"
url_earth="http://www.opentopia.com/images/data/sunlight/world_sunlight_map_rectangular.jpg"
if obj.task then
    obj.task:terminate()
    obj.task = nil
end
local localpath3 = os.getenv("HOME") .. "/.hammerspoon/BingDaily/media/" .. hs.http.urlParts(url_earth).lastPathComponent
obj.task = hs.task.new("/usr/bin/curl", curl_callback, {"-A", user_agent_str, url_earth, "-o", localpath3})
obj.task:start()
-- hs.screen.mainScreen():desktopImageURL("file://" .. localpath3)
-- hs.timer.doEvery(3600, function () hs.screen.mainScreen():desktopImageURL("file://" .. localpath3) end)
-- obj.menubar:setTooltip("Computer-generated illustration of the earth's patterns of sunlight and darkness.\nThe clouds are updated daily with current weather satellite imagery.")


end
---------------------
function obj:unInfo()
local file = io.open( "BingDaily/info.txt", "r" )
info = file:read()
file:close()
return info
end

function obj:unRequest(query,url)
  local user_agent_str = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/603.2.4 (KHTML, like Gecko) Version/10.1.1 Safari/603.2.4"
if obj.task then
    obj.task:terminate()
    obj.task = nil
end
local localpath_un = os.getenv("HOME") .. "/.hammerspoon/BingDaily/media/unsplashed.jpeg"
obj.task = hs.task.new("/usr/bin/curl", curl_callback(localpath_un), {"-A", user_agent_str, url, "-o", localpath_un})
obj.task:start()
hs.timer.doAfter(3,function() hs.screen.mainScreen():desktopImageURL("file://" .. localpath_un)end)
--unsplash_deskt=hs.timer.delayed.new(7, function() hs.screen.mainScreen():desktopImageURL("file://" .. localpath_un)end))
--unsplash_deskt:start()
end
---------------------

function obj:natRequest()
  local user_agent_str = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/603.2.4 (KHTML, like Gecko) Version/10.1.1 Safari/603.2.4"
json_req_url_nat="https://www.nationalgeographic.com/photography/photo-of-the-day/_jcr_content/.gallery.json"
hs.http.asyncGet(json_req_url_nat, {["User-Agent"]=user_agent_str}, function(stat,body,header)
            if pcall(function() hs.json.decode(body) end) then

                obj.decode_data = hs.json.decode(body)
                print('oooooooooook')
                --print(obj.decode_data.items[1].image.id)

                --for i,v in ipairs(decode_data.items[1]) do print(v) end
                  -- for k in pairs(decode_data.items) do print(k) end

                obj.caption=obj.decode_data.items[1].image.alt_text
                print(obj.caption)
                obj.caption=obj.caption:gsub("<p>","")
                obj.caption=obj.caption:gsub("</p>","")
                obj.caption=obj.caption:gsub("&quot;","'")
				print(obj.caption)
                obj.picurla = obj.decode_data.items[1].image.uri
                --obj.picurlb = obj.decode_data.items[1].image.originalUrl
            	print(obj.picurla)
                --url= obj.picurla .. obj.picurlb
                url= obj.picurla
                print(url)
                obj.title=obj.decode_data.items[1].image.title
            	obj.credit=obj.decode_data.items[1].image.credit

                obj.menubar:setTooltip(obj.title .. '\n' .. obj.caption .. '\n' .. obj.credit)
                if obj.task then
                    obj.task:terminate()
                    obj.task = nil
                end
                local localpath4 = os.getenv("HOME") .. "/.hammerspoon/BingDaily/media/nat_geo.jpeg"
                obj.task = hs.task.new("/usr/bin/curl", curl_callback, {url, "-o", localpath4})
                obj.task:start()
                hs.timer.doAfter(3,function() hs.screen.mainScreen():desktopImageURL("file://" .. localpath4) end)
        end

    end)
    end

function obj:goRequest()
  local user_agent_str = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/603.2.4 (KHTML, like Gecko) Version/10.1.1 Safari/603.2.4"
json_req_url_go="https://api.gopro.com/v2/channels/feed/playlists/photo-of-the-day?platform=web"
--print("debug",json_req_url_go)
hs.http.asyncGet(json_req_url_go, {["User-Agent"]=user_agent_str}, function(stat,body,header)
            if pcall(function() hs.json.decode(body) end) then

                obj.decode_data = hs.json.decode(body)
                print(obj.decode_data.media[1].thumbnails.xl.image)
                local urlgo=obj.decode_data.media[1].thumbnails.xl.image
                local copyright=obj.decode_data.media[1].author ..', ' .. obj.decode_data.media[1].permalink .. "\n" .. obj.decode_data.media[1].description
                obj.menubar:setTooltip(copyright)
                if obj.task then
                    obj.task:terminate()
                    obj.task = nil
                end
                local localpath5 = os.getenv("HOME") .. "/.Hammerspoon/BingDaily/media/gopro.jpeg"
                obj.task = hs.task.new("/usr/bin/curl", curl_callback, {urlgo, "-o", localpath5})
                obj.task:start()
                hs.timer.doAfter(3,function() hs.screen.mainScreen():desktopImageURL("file://" .. localpath5) end)
              end
                end)
                end

function obj:flickrRequest_gr(query)
obj.group_url="https://api.flickr.com/services/rest/?method=flickr.groups.search&api_key="..keys.flickr.."&text="..query.."&format=json&nojsoncallback=1"
hs.http.asyncGet(obj.group_url, {["User-Agent"]=user_agent_str}, function(stat,body,header)
local decode_data_g = hs.json.decode(body)
  print(decode_data_g)
  selected_gr=math.random(1,#decode_data_g.groups.group)
gr_id=decode_data_g.groups.group[selected_gr].nsid
  --gr_tot=decode_data_g.groups.pages
  gr_tot=decode_data_g.groups.group[selected_gr].pool_count
  page=math.random(1,gr_tot)
file = io.open("BingDaily/flickr_group.txt", "w")
file:write(page.."\n")
file:write(gr_id)
file:close()
end)

end

function obj:flickrRequest(page_req,id_req)
    local user_agent_str = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/603.2.4 (KHTML, like Gecko) Version/10.1.1 Safari/603.2.4"
  local json_req_url="https://api.flickr.com/services/rest/?method=flickr.groups.pools.getPhotos&per_page=1&page="..page_req.."&api_key="..keys.flickr.."&extras=url_l&group_id="..id_req.."&format=json&nojsoncallback=1"
print(json_req_url)
hs.http.asyncGet(json_req_url, {["User-Agent"]=user_agent_str}, function(stat,body,header)
            if pcall(function() hs.json.decode(body) end) then
                local decode_data = hs.json.decode(body)
                  print(decode_data)
                obj.title=decode_data.photos.photo[1].title
                --for i,v in ipairs(decode_data.photos.photo) do print(v) end
                --for k in pairs(decode_data.photos.photo) do print(k) end
                obj.url=decode_data.photos.photo[1].url_l
                obj.menubar:setTooltip(obj.title)
                if obj.task then
                    obj.task:terminate()
                    obj.task = nil
                end
                local localpath_fl = os.getenv("HOME") .. "/.hammerspoon/BingDaily/media/" .. "flickr.jpeg"
                obj.task = hs.task.new("/usr/bin/curl", curl_callback, {"-A", user_agent_str, obj.url, "-o", localpath_fl})
                obj.task:start()
                hs.timer.doAfter(3,function() hs.screen.mainScreen():desktopImageURL("file://" .. localpath_fl) end)
        end

    end)
    end

function obj:redditRequest(query)
  local user_agent_str = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/603.2.4 (KHTML, like Gecko) Version/10.1.1 Safari/603.2.4"
  local json_req_url="https://www.reddit.com/r/".. query .."/.json"
  print(json_req_url)
hs.http.asyncGet(json_req_url, {["User-Agent"]=user_agent_str}, function(stat,body,header)
            if pcall(function() hs.json.decode(body) end) then
                local decode_data = hs.json.decode(body)
                --obj.title=decode_data.photos.photo[1].title
                --for i,v in ipairs(decode_data.data.children) do print(v) end
                --for k in pairs(decode_data.data.children) do print(k) end
                local i=1
                local hint=""
                while hint~='image' and i<10 do
                hint=decode_data.data.children[i].data.post_hint
                i=i+1
                end
                if i ~= 1 then i=i-1 end
                obj.url=decode_data.data.children[i].data.url
                obj.title=decode_data.data.children[i].data.title
                obj.menubar:setTooltip(query ..'\n'.. obj.title)
                if obj.task then
                    obj.task:terminate()
                    obj.task = nil
                end
                local localpath_red = os.getenv("HOME") .. "/.hammerspoon/BingDaily/media/" .. "reddit.jpg"
                obj.task = hs.task.new("/usr/bin/curl", curl_callback, {"-A", user_agent_str, obj.url, "-o", localpath_red})
                obj.task:start()
                hs.timer.doAfter(3,function() hs.screen.mainScreen():desktopImageURL("file://" .. localpath_red) end)
        end

    end)
end
--function obj:init()
--    if obj.timer == nil then
--        obj.timer = hs.timer.doEvery(60*60, function() obj:bingRequest() end)
--        obj.timer:setNextTrigger(5)
--    else
--        obj.timer:start()
--    end
--end
j=1
local line=""
local repo={}
file = io.open("BingDaily/repo.reddit.txt","r")
while line~=nil do
line = file:read("*l")
repo[j]=line
j=j+1
end
file:close()
print(#repo)

obj.menubar = hs.menubar.new()

setBingIcon(obj.menubar)
-- obj.menubar:setClickCallback(function() obj:bingRequest() end)
local localpathuser = os.getenv("HOME") .. "/.hammerspoon/BingDaily/media/userpic/userpic.jpeg"


local menuitems_table = {}
table.insert(menuitems_table, {
    title = "Bing",menu={
   { title = "save", fn = function()
   but1,name=hs.dialog.textPrompt('Save', 'Save file as', '','Ok')
   fun="cp " .. os.getenv("HOME") .. "/.hammerspoon/BingDaily/media/bing.jpeg " .. os.getenv("HOME") .. "/.hammerspoon/BingDaily/media/selection/".. name ..".jpeg"
   hs.execute(fun) end}},
  fn = function() obj:bingRequest() end
})
table.insert(menuitems_table, {
    title = "Nasa",
    menu={{ title = "save", fn = function()
    but1,name=hs.dialog.textPrompt('Save', 'Save file as', '','Ok')
    fun="cp " .. os.getenv("HOME") .. "/.hammerspoon/BingDaily/media/nasa.jpeg " .. os.getenv("HOME") .. "/.hammerspoon/BingDaily/media/selection/".. name ..".jpeg"
    hs.execute(fun) end},{title="flip", fn=function()
    hs.execute("cp BingDaily/media/nasa.jpeg BingDaily/media/nasa_f.jpeg")
    hs.execute("sips -f horizontal BingDaily/media/nasa_f.jpeg")
    hs.screen.mainScreen():desktopImageURL("file://"..os.getenv("HOME") .. "/.hammerspoon/BingDaily/media/nasa_f.jpeg")
    hs.execute("cp BingDaily/media/nasa_f.jpeg BingDaily/media/nasa.jpeg")
     end}},
    fn = function() obj:nasaRequest() end
})
table.insert(menuitems_table, {
    title = "National Geo",menu={
   { title = "save", fn = function()
   but1,name=hs.dialog.textPrompt('Save', 'Save file as', '','Ok')
   fun="cp " .. os.getenv("HOME") .. "/.hammerspoon/BingDaily/media/nat_geo.jpeg " .. os.getenv("HOME") .. "/.hammerspoon/BingDaily/media/selection/".. name ..".jpeg"
   hs.execute(fun) end}},
    fn = function()
    obj:natRequest();
    end
})
table.insert(menuitems_table, {
    title = "Go pro",menu={
   { title = "save", fn = function()
   but1,name=hs.dialog.textPrompt('Save', 'Save file as', '','Ok')
   fun="cp " .. os.getenv("HOME") .. "/.hammerspoon/BingDaily/media/gopro.jpeg " .. os.getenv("HOME") .. "/.hammerspoon/BingDaily/media/selection/".. name ..".jpeg"
   hs.execute(fun) end}},
    fn = function() obj:goRequest() end
})
table.insert(menuitems_table, {
    title = "Unsplash",menu={
   { title = "save", fn = function()
   but1,name=hs.dialog.textPrompt('Save', 'Save file as', '','Ok')
   fun="cp " .. os.getenv("HOME") .. "/.hammerspoon/BingDaily/media/unsplashed.jpeg " .. os.getenv("HOME") .. "/.hammerspoon/BingDaily/media/selection/".. name ..".jpeg"
   hs.execute(fun) end}},
    fn = function()
        but1,res=hs.dialog.textPrompt('Category search', "what's your mood today?", 'Enter a theme here...','Ok', 'Random')
        if res~='Enter a theme here...' then
        res=res:gsub(" ","%%20")
          str="BingDaily/RequestJSON.js -r " .. res .. " -k " .. keys.unsplash_applicationId .. " " .. keys.unsplash_secret .. " " .. keys.unsplash_callbackUrl
          hs.execute(str,true)
          local file = io.open( "BingDaily/JSONrequested.txt", "r" )
          contents = file:read()
          contents=contents:gsub('"','')
          file:close()
          obj:unRequest(res,contents)
          info=obj:unInfo()
          hs.timer.doAfter(4,function() obj.menubar:setTooltip(info)end)
        elseif (but1 ~= "Random") and (res=='Enter a theme here...' ) then
          local localpath_un = os.getenv("HOME") .. "/.hammerspoon/BingDaily/media/unsplashed.jpeg"
          hs.screen.mainScreen():desktopImageURL("file://" .. localpath_un)
          hs.timer.doAfter(4,function() obj.menubar:setTooltip(info)end)
        elseif (but1 == "Random") then
         str="BingDaily/RequestJSON.js -r -k " .. keys.unsplash_applicationId .. " " .. keys.unsplash_secret .. " " .. keys.unsplash_callbackUrl
         hs.execute(str,true)
         local file = io.open( "BingDaily/JSONrequestedRand.txt", "r" )
         content = file:read()
         content=content:gsub('"','')
         file:close()
         info=obj:unInfo()
         print('desc',info)
         obj:unRequest(res,content)
          hs.timer.doAfter(4,function() obj.menubar:setTooltip(info)end)

      end
    end
})
table.insert(menuitems_table, {
    title = "Flickr",
    menu={
   { title = "save", fn = function()
   but1,name=hs.dialog.textPrompt('Save', 'Save file as', '','Ok')
   fun="cp " .. os.getenv("HOME") .. "/.hammerspoon/BingDaily/media/flickr.jpeg " .. os.getenv("HOME") .. "/.hammerspoon/BingDaily/media/selection/".. name ..".jpeg"
   hs.execute(fun) end}},
     fn = function()

       but1,res=hs.dialog.textPrompt('Group search', "what's your mood today?", 'Enter a theme here...','Random', '1280x800')
         if (res~='Enter a theme here...') then res=res:gsub(" ","%%20") end
  if (res~='Enter a theme here...') and (but1 == "Random") then
    query=res
    obj:flickrRequest_gr(query)

  elseif but1 ~= "Random" then
    query=res
    obj:flickrRequest_gr("1280x800")
  else
    query=res
  end
   hs.timer.doAfter(5,function()
       local f=io.open("BingDaily/flickr_group.txt","r")
       if f~=nil then
       io.close(f)
       local file = io.open( "BingDaily/flickr_group.txt", "r" )
       page = file:read()
       group = file:read()
       file:close()
       	 hs.alert.show("Group" ..group.. " requested succesfully")

    obj:flickrRequest(page,group)
         hs.timer.doAfter(3,function()
        obj:flickrRequest(page,group)
end)
       else hs.alert.show("no file") end
end)
        end })
        --,
--        {title ="Request group", fn = function()
--but1,res=hs.dialog.textPrompt('Group search', "what's your mood today?", 'Enter a theme here...','Random', '1280x800')
--         if (res~='Enter a theme here...') then res=res:gsub(" ","%%20") end
--  if (res~='Enter a theme here...') and (but1 == "Random") then
--    query=res
--    obj:flickrRequest_gr(query)
--  elseif but1 ~= "Random" then
 --   query=res
 --   obj:flickrRequest_gr("1280x800")
 -- else
  --  query=res
  --end
    --    end}

   --,
    --fn = function()
    --end
--})
table.insert(menuitems_table, {
    title = "Reddit",menu={
   { title = "save", fn = function()
   but1,name=hs.dialog.textPrompt('Save', 'Save file as', '','Ok')
   fun="cp " .. os.getenv("HOME") .. "/.hammerspoon/BingDaily/media/reddit.jpg " .. os.getenv("HOME") .. "/.hammerspoon/BingDaily/media/selection/".. name ..".jpg"
   hs.execute(fun) end}, { title = "Subreddits...",fn = function()
   but1,query=hs.dialog.textPrompt('Random subreddits config', 'Enter a subreddit to add/remove', '...','Ok','Remove')
   if but1=='Remove' then
          file = io.open("BingDaily/repo.reddit.txt", "w")
          io.output(file)
          for i=1,#repo,1 do
          if repo[i]==query then
          print('erasing: '..repo[i])
        else
          io.write(repo[i]..'\n')
          end
        end
          file.close()
   else if but1=='Ok' and query~='...' then
     file = io.open("BingDaily/repo.reddit.txt", "a")
     io.output(file)
     io.write(query..'\n')
     io.close(file)
   end
end
end}}, fn = function()
       but1,res=hs.dialog.textPrompt('Category search', "Pic\nEarthPorn\nIconicImages\noldschoolcool\nTheWayWeWere\nabandonedporn\nitookapicture\nother...", 'Enter a subreddit here...','Ok','Random')
       if (res~='Enter a theme here...') and (but1 == "Ok") then
         obj:redditRequest(res)
       elseif (but1 == "Random") then
         print(#repo)
          sub=math.random(1,#repo)
         sub=math.random(1,#repo)
         obj:redditRequest(repo[sub])
       else
         local localpath_red = os.getenv("HOME") .. "/.hammerspoon/BingDaily/media/reddit.jpg"
         hs.screen.mainScreen():desktopImageURL("file://" .. localpath_red)     end
   end
})
table.insert(menuitems_table, {
    title = "User's file",
    fn = function() hs.screen.mainScreen():desktopImageURL("file://" .. localpathuser) obj.menubar:setTooltip("") end,
    menu={
   { title = "show", fn = function() hs.execute('open ./BingDaily/media/userpic') end }}
})
table.insert(menuitems_table, {
    title = "User's folder",
    fn = function()
    hs.execute("osascript '" .. os.getenv("HOME") .. "/.hammerspoon/BingDaily/wall.app'")
    obj.menubar:setTooltip("")
    hs.timer.doEvery(3600, function () obj:earthRequest()
    fun="cp " .. os.getenv("HOME") .. "/.hammerspoon/BingDaily/media/world_sunlight_map_rectangular.jpg " .. os.getenv("HOME") .. "/.hammerspoon/BingDaily/media/selection/earth.jpeg"
    hs.execute(fun)
    end)
  end,menu={
 { title = "show", fn = function() hs.execute('open ./BingDaily/media/selection') end }}})

obj.menubar:setMenu(menuitems_table)

return obj
