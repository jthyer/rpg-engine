---------------------------------------------------------
-- BATTLE EVENTS
--   A battle is a kind of recursive event. In a sense, it's just a choice box that calls a new choice box continuously until the battle is over.
--   
--   
--  Make a battle init that defines the monster parameters.
--------------------------------------------------------- 

battleExec = {}

local battleActive = false

local MONSTERDATA = require("monsterData")
local monster = {} 

function battleInit(monsterName)
  monster = deepcopy(MONSTERDATA[monsterName])
  monster.health = monster.maxHealth
  
  battleActive = true
  
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
        { "battleEnd" }
      } ,
    } ,
  }  
  
  return event
end

function battleAttack()
  local damage = hero.strength - math.floor(monster.strength / 2)
  local variance = math.random(1,5) - 3 
  damage = damage + variance
  if damage < 1 then damage = 1 end

  monster.health = monster.health - damage

  local event = { 
    { "textBox" , "SNAKE TAKES " .. tostring(damage) .. " DAMAGE!" } 
  }
  
  if monster.health > 0 then 
    table.insert(event,{ "textBox", "SNAKE ATTACKS!" } )
    table.insert(event,{ "battleEnemyAttack" } )
  else
    monster.health = 0
    table.insert(event, { "battleEXP" } )
  end
  
  return event
end

function battleEXP()
  hero.exp = hero.exp + monster.exp
  local event = {
    { "textBox", "SNAKE DEFEATED! GAINED " .. tostring(monster.exp) .. " EXP!" } ,
    { "battleEnd" }
  }
  
  return event
end

function battleEnd()
  battleActive = false
  
  return {}
end

function battleEnemyAttack()
  local damage = monster.strength - math.floor(hero.strength / 2)
  local variance = math.random(1,5) - 3 
  damage = damage + variance
  if damage < 1 then damage = 1 end
  hero.health = hero.health - damage
  
  local event = { 
    { "textBox" , "PRINCE TAKES " .. tostring(damage) .. " DAMAGE!" } 
  }
  
  if hero.health > 0 then 
    table.insert(event,{ "battleUpdate" } )
  else
    hero.health = 0
    table.insert(event, { "textBox", "PRINCE DEFEATED!" } )
    table.insert(event, { "textBox", "-GAME OVER-" } )
    table.insert(event, { "battleEnd" } )
  end
  
  return event
end

function getBattleActive()
  return battleActive
end

function getMonsterMaxHealth()
  return monster.maxHealth
end

function getMonsterHealth()
  return monster.health
end