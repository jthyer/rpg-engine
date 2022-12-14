-- EVENTDATA should be immutable. These tables are not edited anywhere, only referenced.

local EVENTDATA = {
  { -- level 1
    ["deadPriest"] = { 
      { "textBox", "AN UNCONSCIOUS PRIEST LIES ON THE STONE FLOOR, WHEEZING FAINTLY. A MASSIVE BLOODY GASH CARVES ACROSS HIS TORSO." } ,
      { "textBox", "HE'S GRIPPING A SMALL POUCH IN HIS HAND." } ,
      { "choiceBranch", "TAKE THE POUCH?", "YES", "NO",
        {
          { "textBox", "THERE'S SNAKE REPELLANT IN THE POUCH." } ,
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
          }
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
    } ,
  }
}  

return EVENTDATA