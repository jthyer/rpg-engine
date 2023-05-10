-- constants
local UI_WIDTH = 76
local LEVELBOX_Y = 130-- 0
local LEVELNAME_Y = 11
local LEVELNAME_HEIGHT = 50
local STATUSBOX_Y = 0--62
local STATUSBOX_HEIGHT = 118
local STATUS_X = 5
local STATUS_Y = STATUSBOX_Y + 20
local METER_HEIGHT = 12
local METER_OFFSET = 15
local ITEM_OFFSET = 32
local MAX_EXP = UI_WIDTH - (STATUS_X*2)

-- values before adding "PRINCE"
--local UI_WIDTH = 76
--local LEVELBOX_Y = 130-- 0
--local LEVELNAME_Y = 11
--local LEVELNAME_HEIGHT = 50
--local STATUSBOX_Y = 0--62
--local STATUSBOX_HEIGHT = 118
--local STATUS_X = 5
--local STATUS_Y = STATUSBOX_Y + 10
--local METER_HEIGHT = 12
--local METER_OFFSET = 15
--local ITEM_OFFSET = 34
--local MAX_EXP = UI_WIDTH - (STATUS_X*2)

function drawLevelName()
  drawBorder(0,LEVELBOX_Y,UI_WIDTH,LEVELNAME_HEIGHT)
  love.graphics.printf("RUINED CHURCH",0,LEVELBOX_Y + LEVELNAME_Y,UI_WIDTH,"center")
end

function drawStatus()
  drawBorder(0,STATUSBOX_Y,UI_WIDTH,STATUSBOX_HEIGHT)
  love.graphics.printf("-PRINCE-",0,2,UI_WIDTH,"center")
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

function drawMonster()
  if getBattleActive() then -- function in battle.lua

    drawBorder(-109,0,96,118)
    if (getMonsterHealth()) > 0 then
      love.graphics.draw(spr_snake,-109,0)
    end
    drawBorder(-192,0,70,56)
    love.graphics.printf("-SNAKE-",-192,2,70,"center")  
    love.graphics.printf("HEALTH",-192+STATUS_X,STATUS_Y,UI_WIDTH,"left")
    love.graphics.rectangle("fill",-192+STATUS_X,STATUS_Y+METER_OFFSET,getMonsterMaxHealth()+2,METER_HEIGHT+2)
    setColor("darkTeal")
    love.graphics.rectangle("fill",-192+STATUS_X+1,STATUS_Y+METER_OFFSET+1,getMonsterMaxHealth(),METER_HEIGHT)
    setColor("pink")
    love.graphics.rectangle("fill",-192+STATUS_X+1,STATUS_Y+METER_OFFSET+1,getMonsterHealth(),METER_HEIGHT)
  end
end

function drawUI()
  drawLevelName()
  drawMonster()
  drawStatus()
end