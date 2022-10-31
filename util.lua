-----------------------------------------------------------
-- Misc. utility constants and functions used everywhere 
-----------------------------------------------------------

KEYTABLE = {
  ["left"]  = {-1, 0},
  ["up"]    = { 0,-1},
  ["right"] = { 1, 0},
  ["down"]  = { 0, 1},
  ["Z"]     = { 0, 0}
}

COLORTABLE = {
  ["white"]      = { 1,1,1 },
  ["grey"]       = {.75,.75,.75 },
  ["teal"]       = { 0,1,1 },
  ["darkTeal"]   = { 0,.5,.5 },
  ["pink"]       = { 1,0,1 },
  ["darkPink"]   = { .5,0,5 },
  ["blue"]       = { 0,0,1 },
  ["darkBlue"]   = { 0,0,.5 },
  ["yellow"]     = { 1,1,0 },
  ["darkYellow"] = { .5,.5,0 },
  ["green"]        = { 0,1,0 },
  ["darkGreen"]    = { 0,.5,0 },
  ["red"]        = { 1,0,0 },
  ["darkRed"]    = { .5,0,0 },
  ["darkGrey"]   = { .5,.5,.5 },
  ["black"]      = { 0,0,0 },
}

-- iterating tables used by map and event functions
function iterateTable(T, func)
  for i, v in ipairs(T) do
    func(i,v)
  end
end

function iterate2DTable(T, func)
  for i, v in ipairs(T) do
    for j, w in ipairs(T[i]) do
      func(j,i,w,v)
    end
  end
end

-- draw borders
function drawBorder(x, y, w, h)
  setColor("black")
  love.graphics.rectangle("fill",x-4,y-4,w+8,h+8)
  setColor("white")
  love.graphics.rectangle("fill",x-3,y-3,w+6,h+6)
  setColor("black")
  love.graphics.rectangle("fill",x-1,y-1,w+2,h+2)
  setColor("white")  
end

-- used by all draw events
function setColor(c)
  love.graphics.setColor(COLORTABLE[c][1],COLORTABLE[c][2],COLORTABLE[c][3])
end
