---------------------------------------------------------
-- BATTLE EVENTS
--   A battle is a kind of recursive event. In a sense, it's just a choice box that calls a new choice box continuously until the battle is over.
--   
--   
--  Make a battle init that defines the monster parameters.
--------------------------------------------------------- 
function initBattleEvent()
  local event = 
    { "choiceBranch", "THE ENEMY APPROACHES!", "FIGHT", "RUN",
      {
        { "textBox", "YOU STRIKE THE FOE FOR DAMAGE!" } ,
        { "battle" } ,
      } ,
      {
        { "textBox", "YOU FLEE!" } ,
      }
    }
  return event
end