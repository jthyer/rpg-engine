---------------------------------------------------------
-- BATTLE EVENTS
--   A battle is a kind of recursive event. In a sense, it's just a choice box that calls a new choice box continuously until the battle is over.
--   
--   
--  Make a battle init that defines the monster parameters.
--------------------------------------------------------- 

battleExec = {}

local MONSTERDATA = require("monsterData")
local monster = {} 

function battleInit(monsterName)
  monster = deepcopy(MONSTERDATA[monsterName])
  
  local event = {
    { "textBox" , "THE ENEMY APPROACHES!" } ,
    { "battleUpdate" } ,
  }
  
  return event
end

function battleUpdate()
  local event = {
    { "choiceBranch", "COMMAND?", "FIGHT", "RUN",
      {
        { "textBox", "PRINCE ATTACKS SNAKE!" } ,
        { "battleAttack" } ,
      } ,
      {
        { "textBox", "PRINCE FLEES!" } ,
      } ,
    } ,
  }  
  
  return event
end

function battleAttack()
  local damage = hero.strength - monster.strength
  
  local event
    
  event = {
    { "textBox" , "SNAKE TAKES " .. tostring(damage) .. " DAMAGE!" } ,
    { "battleUpdate" } ,
  }
  
  return event
end

function enemyAttack()
  local event
  
  event = {
    { "textBox" , "SNAKE TAKES 3 DAMAGE!" } ,
    { "battleUpdate" } ,
  }
  
  return event
end