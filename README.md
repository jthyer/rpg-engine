# rpg-engine
Tiny 80's-style RPG engine in Love2D.



eventTable = {
  { -- level 1
    { "deadPriest", -- event name
      5, 4,        -- event x and y
      {              -- event log
        { "textBox", "THE PRIEST'S CORPSE LEANS AGAINST THE WALL NEXT TO HIS BED." } ,
        { "textBox", "AN ARROW STICKS OUT OF HIS CHEST." } ,
        { "textBox", "IT'S VERY SAD." }
      }
    }
  }
}  

eventTable = table address of all events
eventTable[1] = table address of all events in level 1
eventTable[1][1] = table address first event in level 1
eventTable[1][1][4] = table address of event log of first event in level 1
eventTable[1][1][4][1] = table address of first subevent of event log of first event in level 1
eventTable[1][1][4][1][1] = "textBox"
eventTable[1][1][4][1][2] = "THE PRIEST'S CORPSE LEANS AGAINST THE WALL NEXT TO HIS BED."


