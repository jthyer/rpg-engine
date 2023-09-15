-------------------------------------------------------------------------------
-- BATTLE EVENTS
--   A battle is a kind of recursive event. In a sense, it's just a choice box 
--   that calls a new choice box continuously until the battle is over.
-------------------------------------------------------------------------------

battleExec = {}

local battleActive = false
local MONSTERDATA = require("gamedata.monsterdata")
local monster = {} 

function getBattleActive()
  return battleActive
end

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
        { "textBox", "PRINCE ATTACKS " .. monster.name .. "!" } ,
        { "randomBranch", 5 ,
          {
            { "battle" , "attack" } ,
          } ,
          { 
            { "textBox", "PRINCE MISSES!" } ,
            { "battle", "enemyAttack" } ,
          } ,
        } ,
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
    { "textBox", monster.name .. " ATTACKS!" } ,
    { "textBox" , "PRINCE TAKES " .. tostring(damage) .. " DAMAGE!" } ,
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
  local exp = math.ceil((monster.level / hero.level ) * 20)
  local message = monster.name .. " DEFEATED! GAINED " ..
    tostring(exp) .. " EXP!" 
  
  for i = 1, exp do
    hero.exp = hero.exp + 1
    if hero.exp == 100 then
      message = message .. "\nPRINCE GROWS STRONGER!"
      hero.level = hero.level + 1
      if hero.level % 3 == 0 then
        hero.maxHealth = hero.maxHealth + 10
        hero.health = hero.health + 5
        hero.strength = hero.strength + 5
        message = message .. "\nSTRENGTH INCREASES! HEALTH INCREASES!"
      elseif hero.level % 2 == 0 then
        hero.strength = hero.strength + 5
        message = message .. "\nSTRENGTH INCREASES!"
      else
        hero.maxHealth = hero.maxHealth + 10
        hero.health = hero.health + 5
        message = message .. "\nHEALTH INCREASES!"
      end
      hero.exp = 0
    end
  end
  
  hero.expDisplay = math.ceil(hero.exp * 0.66)
  
  local event = {
    { "textBox", message} ,
    { "battle" , "end" }
  } 
  
  return event
end

battleExec["end"] = function()
  battleActive = false
  
  return {}
end

function calcEXP(currentEXP,currentLevel,monsterLevel)

  local levelDiff = current
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