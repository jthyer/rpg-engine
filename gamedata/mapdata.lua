-- MAPDATA should be immutable. These tables are not edited anywhere, only referenced.

local json = require("lib.json")

local MAP = {}
MAP.levelTable = {}
MAP.objTable = {}
table.insert(MAP.levelTable,{})
table.insert(MAP.objTable,{})

local raw = love.filesystem.read("maps/ruinedChurch.json")
local jsonData = json.decode(raw)
    
for i = 1, 30 do
  local row = {}
  for i2 = 1, 30 do
    local cell = jsonData["layers"][1]["data"][i2+((i-1)*30)]
    if cell == -1 then 
      cell = 7 
    elseif cell == 3 then 
      table.insert(MAP.objTable[1], { "doorV", i2, i })
      cell = 7
    elseif cell == 4 then 
      table.insert(MAP.objTable[1], { "doorH", i2, i })
      cell = 7
    end
    table.insert(row,cell)
  end
  table.insert(MAP.levelTable[1],row)
end

-- initial event status
-- 1 = show, 0 = hide, -1 = erase
MAP.eventStatus = {
  { -- level 1
    { "forestBlockD", 0 } ,
    { "forestBlockR", 0 } ,
    { "graveBlock" , 0 } ,
    
    { "deadPriest", 1 } ,
    { "fearfulDog", 1 } ,
    { "snakes", 0 } ,
    { "snakeTrap", 1 } ,
  }
}

MAP.eventLocTable = {
  { -- level 1
    { "forestBlockD", 22, 1 } ,   
    { "forestBlockD", 23, 1 } ,
    { "forestBlockD", 24, 1 } ,
    { "forestBlockD", 25, 1 } ,
    { "forestBlockD", 26, 1 } ,
    { "forestBlockD", 27, 1 } ,
    { "forestBlockD", 28, 1 } ,
    { "forestBlockD", 29, 1 } ,
    { "forestBlockR", 30, 2 } ,   
    { "forestBlockR", 30, 3 } ,
    { "forestBlockR", 30, 4 } ,
    { "forestBlockR", 30, 5 } ,
    { "forestBlockR", 30, 6 } ,
    { "forestBlockR", 30, 7 } ,
    { "forestBlockR", 30, 8 } ,
    { "graveBlock", 30, 21 } ,    
    { "graveBlock", 30, 22 } ,    
    { "graveBlock", 30, 23 } ,    
    { "graveBlock", 30, 24 } ,    
    { "graveBlock", 30, 25 } ,
    { "deadPriest", 2, 5 } ,
    { "fearfulDog", 13, 3 } ,
    { "snakes", 15, 3 } ,
    { "snakeTrap", 8, 3} ,
  }
}

MAP.msgTable = {
  { -- level 1
     [0] = "" ,
     [1] = "SANCTUARY",
     [2] = "PULPIT",
     [3] = "NUNS' QUARTERS",
     [4] = "HEAD PRIEST'S QUARTERS",
     [5] = "PARK",
     [6] = "VILLAGE ENTRANCE",
     [7] = "STREET",
     [8] = "GREAT OAK TREE",
     [9] = "INN",
     [10] = "MAIN SQUARE",
     [11] = "FOUNTAIN",
     [12] = "KEEPER'S QUARTERS",
     [13] = "GRAVEYARD",
     [14] = "",
     [15] = "",
     [16] = "",
     [17] = "LYRA'S ROOM", -- MAKE OTHER ROOM
     [18] = "GENERAL STORE",
     [19] = "",
     [20] = "",
     [21] = "",
     [22] = "",
     [23] = "",
     [24] = "",
     [25] = "",
  }
}

return MAP