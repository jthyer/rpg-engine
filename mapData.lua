levelTable = { 
  { -- level 1
    { 1,1,1,1,2,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1 } ,
    { 1,1,1,1,2,1,1,1,1,1, 1,1,1,1,6,6,6,6,1,1 } ,
    { 1,1,1,1,2,1,4,4,1,4, 1,4,4,1,6,6,6,6,1,1 } ,
    { 1,1,1,1,2,1,4,4,4,4, 4,4,4,1,5,1,1,1,1,1 } ,
    { 1,3,3,1,2,1,4,4,4,4, 4,4,4,1,5,1,0,0,0,1 } ,
    { 1,3,3,3,2,4,4,4,4,4, 4,4,4,4,5,1,0,0,0,1 } ,
    { 1,3,3,1,2,1,4,4,4,4, 4,4,4,1,5,1,0,0,0,1 } ,
    { 1,1,1,1,2,1,1,1,1,1, 1,1,1,1,5,1,1,5,1,1 } ,
    { 1,1,1,1,2,1,1,1,1,1, 1,1,1,1,5,5,5,5,1,1 } ,
    { 1,3,3,1,2,1,0,0,0,0, 0,0,0,1,1,1,1,5,1,1 } ,
    
    { 1,3,3,3,2,1,0,0,0,0, 0,0,0,0,0,0,1,5,1,1 } ,
    { 1,3,3,1,2,2,0,0,0,0, 0,0,0,0,0,0,1,5,1,1 } ,
    { 1,3,3,1,2,1,0,0,0,0, 0,0,0,0,0,0,1,5,1,1 } ,
    { 1,1,1,1,0,0,0,0,0,0, 0,0,0,0,0,0,1,5,1,1 } ,
    { 1,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,1,5,1,1 } ,
    { 1,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,1,5,1,1 } ,
    { 1,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,1,5,1,1 } ,
    { 1,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,1,5,1,1 } ,
    { 1,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,1 } ,
    { 1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1 }
  } ,
  { -- level 2
  }
}

objTable = { 
  { -- level 1
    { "doorH", 5, 1 } , 
    { "doorV", 4, 6 } ,
    { "doorV", 6, 6 } ,
    { "doorV", 4, 11 } ,
    { "doorV", 6, 12 } ,
    { "doorV", 14, 6 } ,
    { "doorH", 5, 13 } ,
    { "doorH", 18, 17 } ,
    { "doorH", 15, 4 }
  } ,
  { -- level 2
  } 
}

msgTable = {
  { -- level 1
     [0] = "" ,
     [2] = "---ENTRANCE HALL---",
     [3] = "---PRIEST'S QUARTERS---",
     [4] = "---SANCTUARY---",
     [5] = "---BLOODIED BACK HALLWAY---",
     [6] = "---RANSACKED DOCTOR'S ROOM---"
  }
}

flagTable = {
  { -- level 1
    false, -- first branch test
    false,
    false,
    false,
    false    
  }
}

-- should make it so events can be destructible, invisible
eventTable = {
  { -- level 1
    { "deadPriest2", -- event name
      5, 4,          -- event x and y
      {              -- event log
        { "textBox", "THE PRIEST'S CORPSE LEANS AGAINST THE WALL NEXT TO HIS BED." } ,
        { "textBox", "AN ARROW STICKS OUT OF HIS CHEST." } ,
        { "branch", true,--flagTable[1][1], 
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

hero = {
  x = 5 ,
  y = 2
}