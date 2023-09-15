-- EVENTDATA should be immutable. These tables are not edited anywhere, only referenced.

function RESTEVENT()
  return 
    {  
      { "choiceBranch", "REST?", "YES", "NO", 
        {
          { "randomBranch", 5, 
            {
              { "healHero" } ,
              { "textBox", "YOU FEEL REFRESHED." } ,
            } , 
            { 
              { "textBox", "ATTACKED!" } ,
              { "callEvent", "randomBattle" } ,
            } ,          
          } 
        } , 
        { 
        } ,          
      } 
    } 
end

local EVENTDATA = {
  { -- level 1
    ["restHero"] = RESTEVENT() ,
    ["randomBattle"] = { { "battleInit", "Snake" } } ,
    
    ["deadPriest"] = { 
      { "textBox", "AN UNCONSCIOUS PRIEST LIES ON THE STONE FLOOR, WHEEZING FAINTLY. A MASSIVE BLOODY GASH CARVES ACROSS HIS TORSO." } ,
      { "textBox", "HE'S GRIPPING A SMALL POUCH IN HIS HAND." } ,
      { "choiceBranch", "TAKE THE POUCH?", "YES", "NO",
        {
          { "battleInit", "Snake" } ,
          { "textBox", "THERE'S SNAKE REPELLANT IN THE POUCH." } ,
          { "textBox", "THERE'S SNAKE REPELLANT IN THE POUCH. 2" } ,
          { "textBox", "THERE'S SNAKE REPELLANT IN THE POUCH. 3" } ,
          { "flagSet", "snakeRepellant" } ,
          { "erase" } ,
        } ,
        {
          { "push" , 0, 1 } ,
          { "textBox", "THE PRIEST GETS UP AND PUSHES YOU BACK, THEN COLLAPSES BACK TO THE FLOOR." } ,
        }
      }
    } ,
    ["fearfulDog"] = {
      { "textBox", "A SMALL DOG WHIMPERS NEAR THE BODY OF A NUN WITH A CAVED-IN SKULL." } ,
      { "choiceBranch", "COMFORT THE DOG?", "YES", "NO",
        {
          { "textBox", "YOU MURMUR SOOTHINGLY TO THE FRIGHTENED ANIMAL. HE SEEMS TO CALM DOWN." } ,
          { "choiceBranch", "PET THE DOG?", "YES", "NO",
            { 
              { "textBox", "YOU REACH OUT TO STROKE THE DOG'S FUR." } ,
              { "flash" } ,
              { "textBox", "HE QUICKLY SNARLS, AND BEFORE YOU CAN PULL AWAY HE GIVES YOU A NASTY BITE." } ,
              { "textBox", "THE DOG RUNS OFF, BARKING." } ,
              { "erase" }
            } ,
            {
            } 
          } ,
          { "textBox", "OH SHIT IT'S WORKING" } ,
        } ,
        {
        }
      } 
    } ,
    [ "snakes" ] = {
      { "flagBranch" , "snakeRepellant",
        {
          { "push", 0, 1 } ,
          { "textBox", "YOU SPRAY DOWN THE ROOM WITH SNAKE REPELLANT. ALL THE SNAKES FLEE IN TERROR." } ,
          { "erase" } ,
        } ,
        {
          { "push", 0, 1 } ,
          { "textBox", "THIS ROOM IS FULL OF SNAKES. YOU BACK AWAY, SLOWLY." } ,
        }
      } ,
      { "textBox", "HAHAHA WORKING!" } ,
    } ,
    [ "snakeTrap" ] = {
      { "textBox", "YOU SEE A LARGE OAK CHEST." } ,
      { "choiceBranch", "OPEN THE CHEST?", "YES", "NO",
        {
          { "textBox", "A SNAKE LUNGES AT YOU FROM INSIDE THE CHEST!" } ,
          { "battleInit", "Snake" } ,
          --{ "erase" } ,
        } ,
        {
        } ,
      }
    }
  }
}  

return EVENTDATA