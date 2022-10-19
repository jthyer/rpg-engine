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


hero = {
  x = 5 ,
  y = 2
}