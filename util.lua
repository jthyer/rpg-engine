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
  ["white"]  = { 1,1,1 },
  ["black"]  = { 0,0,0 },
  ["pink"]   = { 1,0,1 },
  ["yellow"] = { 1,1,0 },
  ["red"]    = { 1,0,0 },
  ["grey"] = {.8,.8,.8 }
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

-- used by all draw events
function setColor(c)
  love.graphics.setColor(COLORTABLE[c][1],COLORTABLE[c][2],COLORTABLE[c][3])
end
