local eventData = {}

eventData.flagTable = {
  { -- level 1
    false, -- first branch test
    false,
    false,
    false,
    false    
  }
}

eventData.eventTable = {
  { -- level 1
    ["deadPriest"] = { 
      { "textBox", "AN UNCONSCIOUS PRIEST LIES ON THE STONE FLOOR, WHEEZING FAINTLY. A MASSIVE BLOODY GASH CARVES ACROSS HIS TORSO." } ,
      { "textBox", "HE'S GRIPPING A SMALL POUCH IN HIS HAND." } ,
      { "choiceBranch", "TAKE THE POUCH?", "YES", "NO",
        {
          { "textBox", "THERE'S 20 GOLD IN THE POUCH." } ,
          { "erase" }
        } ,
        {
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
    } 
  }
}  

return eventData
