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
    { "deadPriest", 1 } ,
    { "fearfulDog", 1 } ,
    { "snakes", 0 } ,
    { "snakeTrap", 1 } ,
  }
}

MAP.eventLocTable = {
  { -- level 1
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
     [6] = "DISTRICT ENTRANCE",
     [7] = "STREET",
     [8] = "GREAT OAK TREE",
     [9] = "INN",
     [10] = "MAIN SQUARE",
     [11] = "FOUNTAIN",
     [12] = "",
     [13] = "",
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