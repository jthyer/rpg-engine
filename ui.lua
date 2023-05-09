-- constants
local UI_WIDTH = 76
local LEVELNAME_Y = 11
local LEVELNAME_HEIGHT = 50
local STATUSBOX_Y = 62
local STATUSBOX_HEIGHT = 118
local STATUS_X = 5
local STATUS_Y = STATUSBOX_Y + 10
local METER_HEIGHT = 12
local METER_OFFSET = 15
local ITEM_OFFSET = 34
local MAX_EXP = UI_WIDTH - (STATUS_X*2)

function drawLevelName()
  drawBorder(0,0,UI_WIDTH,LEVELNAME_HEIGHT)
  love.graphics.printf("RUINED CHURCH",0,LEVELNAME_Y,UI_WIDTH,"center")
end

function drawStatus()
  drawBorder(0,STATUSBOX_Y,UI_WIDTH,STATUSBOX_HEIGHT)
  love.graphics.printf("HEALTH",STATUS_X,STATUS_Y,UI_WIDTH,"left")
  love.graphics.printf("STRENGTH",STATUS_X,STATUS_Y+ITEM_OFFSET,UI_WIDTH,"left")
  love.graphics.printf("EXP",STATUS_X,STATUS_Y+ITEM_OFFSET*2,UI_WIDTH,"left")
  love.graphics.rectangle("fill",STATUS_X,STATUS_Y+METER_OFFSET,hero.maxHealth+2,METER_HEIGHT+2)
  love.graphics.rectangle("fill",STATUS_X,STATUS_Y+METER_OFFSET+ITEM_OFFSET,hero.strength+2,METER_HEIGHT+2)
  love.graphics.rectangle("fill",STATUS_X,STATUS_Y+METER_OFFSET+ITEM_OFFSET*2,MAX_EXP,METER_HEIGHT+2)
  setColor("darkTeal")
  love.graphics.rectangle("fill",STATUS_X+1,STATUS_Y+METER_OFFSET+1,hero.maxHealth,METER_HEIGHT)
  love.graphics.rectangle("fill",STATUS_X+1,STATUS_Y+METER_OFFSET+ITEM_OFFSET+1,hero.strength,METER_HEIGHT)
  love.graphics.rectangle("fill",STATUS_X+1,STATUS_Y+METER_OFFSET+ITEM_OFFSET*2+1,MAX_EXP-2,METER_HEIGHT)
  setColor("pink")
  love.graphics.rectangle("fill",STATUS_X+1,STATUS_Y+METER_OFFSET+1,hero.health,METER_HEIGHT)
  love.graphics.rectangle("fill",STATUS_X+1,STATUS_Y+METER_OFFSET+ITEM_OFFSET+1,hero.strength,METER_HEIGHT)
  love.graphics.rectangle("fill",STATUS_X+1,STATUS_Y+METER_OFFSET+ITEM_OFFSET*2+1,hero.exp,METER_HEIGHT)
end

function drawUI()
  drawLevelName()
  drawStatus()
end