flagTable = {
  { -- level 1
    false, -- first branch test
    false,
    false,
    false,
    false    
  }
}


eventTable = {
  { -- level 1
    { "deadPriest2", -- event name
      5, 4,          -- event x and y
      {              -- event log
        { "textBox", "THE PRIEST'S CORPSE LEANS AGAINST THE WALL NEXT TO HIS BED." } ,
        { "textBox", "AN ARROW STICKS OUT OF HIS CHEST." } ,
        { "choiceBranch", "PET THE DOG?", "YES", "NO",
          {
            { "textBox", "BRANCH YES." } ,
            { "textBox", "BRANCH YES 2." } ,
            { "choiceBranch", "PET THE CAT?", "YES", "NO",
              {
                { "textBox", "BRANCH YES CAT." } ,
                { "textBox", "BRANCH YES 2 CAT." } ,
                { "textBox", "BRANCH YES 3 CAT." }
              } ,
              {
                { "textBox", "BRANCH NO CAT." }  
              }
            } 
          } ,
          {
            { "textBox", "BRANCH NO." }  
          }
        } ,
        { "choiceBranch", "PET THE DOG?", "YES", "NO",
          {
            { "textBox", "BRANCH YES." } ,
            { "textBox", "BRANCH YES 2." } ,
            { "textBox", "BRANCH YES 3." }
          } ,
          {
            { "textBox", "BRANCH NO." }  
          }
        } ,
        { "flagBranch", flagTable[1][1], 
          {
            { "textBox", "BRANCH TRUE." } ,
            { "textBox", "BRANCH TRUE 2." } ,
            { "textBox", "BRANCH TRUE 3." }
          } ,
          {
            { "textBox", "BRANCH FALSE." }  
          }
        }
      }
    } ,  
    { "deadPriest", -- event name
      15, 4,         -- event x and y
      {              -- event log
        { "textBox", "THE PRIEST'S CORPSE LEANS AGAINST THE WALL NEXT TO HIS BED." } ,
        { "textBox", "AN ARROW STICKS OUT OF HIS CHEST." } ,
        { "textBox", "IT'S VERY SAD." } --,
       -- { "textBox", "THE PRIEST WAS YOUR DAD, PLOT TWIST." } ,
       -- { "textBox", "WOW I CAN REALLY PUT AS MANY OF" }
      }
    }
  }
}  
     
     --{ "textBox", 10, 3,
     --  "THE SANCTUARY'S STATUE OF THE GODDESS LAYS TOPPLED AND BROKEN ON THE FLOOR." },
    -- { "choiceBox", --5,4,--18, 2,
       --"YOU FIND A SMALL HEALING POTION IN THE LOOTED TREATMENT ROOM. TAKE IT?", "YES", "NO" }
