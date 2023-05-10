-------------------------------------------------------------------------------
-- BATTLE EVENTS
--   A battle is a kind of recursive event. In a sense, it's just a choice box 
--   that calls a new choice box continuously until the battle is over.
-------------------------------------------------------------------------------

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
    { "battle" , "update" } ,
  }
  
  return event
end

battleExec["update"] = function()
  local event = {
    { "choiceBranch", "COMMAND?", "FIGHT", "RUN",
      {
        { "textBox", "PRINCE ATTACKS SNAKE!" } ,
        { "battle" , "attack" } ,
      } ,
      {
        { "textBox", "PRINCE FLEES!" } ,
        { "battle" , "end" }
      } ,
    } ,
  }  
  
  return event
end

battleExec["attack"] = function()
  local damage = calcDamage(hero.strength, monster.strength)
  monster.health = monster.health - damage

  local event = { 
    { "textBox" , "SNAKE TAKES " .. tostring(damage) .. " DAMAGE!" } 
  }
  
  if monster.health > 0 then 
    table.insert(event,{ "textBox", "SNAKE ATTACKS!" } )
    table.insert(event,{ "battle" , "enemyAttack" } )
  else
    monster.health = 0
    table.insert(event, { "battle", "EXP" } )
  end
  
  return event
end

battleExec["enemyAttack"] = function()
  local damage = calcDamage(monster.strength, hero.strength)
  hero.health = hero.health - damage
  
  local event = { 
    { "textBox" , "PRINCE TAKES " .. tostring(damage) .. " DAMAGE!" } 
  }
  
  if hero.health > 0 then 
    table.insert(event,{ "battle" , "update" } )
  else
    hero.health = 0
    table.insert(event, { "textBox", "PRINCE DEFEATED!" } )
    table.insert(event, { "textBox", "-GAME OVER-" } )
    table.insert(event, { "battle" , "end" } )
  end
  
  return event
end

battleExec["EXP"] = function()
  hero.exp = hero.exp + monster.exp
  local event = {
    { "textBox", "SNAKE DEFEATED! GAINED " .. tostring(monster.exp) .. " EXP!" } ,
    { "battle" , "end" }
  }
  
  return event
end

battleExec["end"] = function()
  battleActive = false
  
  return {}
end

function calcDamage(attackerStrength, targetStrength)
  local damage = attackerStrength - math.floor(targetStrength / 2)
  local variance = math.random(1,5) - 3 
  damage = damage + variance
  if damage < 1 then damage = 1 end

  return damage
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