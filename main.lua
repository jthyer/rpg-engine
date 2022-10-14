require("levels")
-- defines levelTable, objTable, hero

-- TEST COMMENT TO SEE CHANGES ON GITHUB

-- define globals
level = 1
fogOfWar = {}
key = false
message = ""

ROOMWIDTH = 20
ROOMHEIGHT = 20

KEYTABLE = {
  ["left"]  = {-1, 0},
  ["up"]    = { 0,-1},
  ["right"] = { 1, 0},
  ["down"]  = { 0, 1}
}

-- main functions
function love.load()
  -- window settings
  love.graphics.setDefaultFilter("nearest", "nearest", 1)
  love.window.setTitle("tower rpg")
  love.window.setMode(600, 500)
  font = love.graphics.newFont("cmd.ttf", 16)
  love.graphics.setFont(font)
  
  message = getMessage(level, hero.x,hero.y) 
  
  -- set fog of war
  for i = 1, ROOMHEIGHT do
    local row = {}
    for j = 1, ROOMWIDTH do
      table.insert(row, 1)
    end
    table.insert(fogOfWar,row)
  end
end

function love.update()
  -- update fog of war
  fogOfWar[hero.y-1][hero.x-1] = 0
  fogOfWar[hero.y-1][hero.x]   = 0
  fogOfWar[hero.y-1][hero.x+1] = 0
  fogOfWar[hero.y]  [hero.x-1] = 0
  fogOfWar[hero.y]  [hero.x]   = 0
  fogOfWar[hero.y]  [hero.x+1] = 0
  fogOfWar[hero.y+1][hero.x-1] = 0  
  fogOfWar[hero.y+1][hero.x]   = 0
  fogOfWar[hero.y+1][hero.x+1] = 0
  
  -- check for object interactions with hero
  for i, v in ipairs(objTable[level]) do
    if hero.x == v[2] and hero.y == v[3] then
      if v[1] == "key" then
        table.remove(objTable[level],i)
        key = true
      end
      if v[1] == "door" then
        table.remove(objTable[level],i)
      end
    end
  end
end

function love.draw()
  -- set scale to x2
  love.graphics.push()
  love.graphics.scale(2, 2)
  
  -- draw dungeon window
  love.graphics.push()
  love.graphics.translate(50,25)
  
  -- draw pink border and black background
  love.graphics.setColor(1,0,1)
  love.graphics.rectangle("fill",-5,-5,(ROOMWIDTH*10)+10,(ROOMHEIGHT*10)+10)
  love.graphics.setColor(0,0,0)
  love.graphics.rectangle("fill",0,0,(ROOMWIDTH*10),(ROOMHEIGHT*10))
  love.graphics.setColor(1,1,1)

  -- draw objects
  for i, v in ipairs(objTable[level]) do
    love.graphics.setColor(1,0,1)
    if v[1] == "doorV" then
      local x = (v[2]-1) * 10
      local y = (v[3]-1) * 10
      love.graphics.line(x+4,y,x+4,y+10)
      love.graphics.line(x+6,y,x+6,y+10)
    end
    if v[1] == "doorH" then
      local x = (v[2]-1) * 10
      local y = (v[3]-1) * 10
      love.graphics.line(x,y+4,x+10,y+4)
      love.graphics.line(x,y+6,x+10,y+6)
    end
  end  
  love.graphics.setColor(1,1,1)

  -- draw walls
  for i, v in ipairs(levelTable[level]) do
    for j, v2 in ipairs(levelTable[level][i]) do
      if v2 == 1 then
        love.graphics.rectangle("fill", (j - 1) * 10, (i - 1) * 10, 10, 10)
      end
    end
  end  
  
  -- draw fog of war
  love.graphics.setColor(.8,.8,.8)
  for i, v in ipairs(fogOfWar) do
    for j, v2 in ipairs(fogOfWar[i]) do
      if v2 == 1 then
        love.graphics.rectangle("fill", (j - 1) * 10, (i - 1) * 10, 10, 10)
      end
    end
  end  
  love.graphics.setColor(1,1,1)
  
  -- draw hero
  love.graphics.setColor(1,1,0)
  love.graphics.rectangle("fill", (hero.x - 1) * 10, (hero.y - 1) * 10, 10, 10)
  love.graphics.setColor(1,1,1)
  
  -- draw room text
  love.graphics.printf(message,-50,ROOMHEIGHT*10+8,300,"center")
  
  love.graphics.pop()
  love.graphics.pop()
end

function checkLockedDoor(x, y)
  -- check for locked door collision
  for i, v in ipairs(objTable[level]) do
    if v[1] == "lockedDoor" and v[2] == x and v[3] == y then
      if key then
        key = false
        table.remove(objTable[level],i)
        return false
      else 
        return true
      end
    end
  end
  return false
end

function getMessage (l, x, y)
  -- reads levelTable and msgTable
  local code = levelTable[l][y][x]
  print(msgTable[l][code])
  
  return msgTable[l][code]
end

-- event functions
function love.keypressed(key, scancode, isrepeat)
  if KEYTABLE[key] == nil then
    return
  end
  -- move hero if no walls or doors in the way
  local move_x = hero.x + KEYTABLE[key][1]
  local move_y = hero.y + KEYTABLE[key][2]

  if levelTable[level][move_y][move_x] == 1 or checkLockedDoor(move_x, move_y) then
    return
  end
  
  if move_x > 0 and move_x <= ROOMWIDTH and
     move_y > 0 and move_y <= ROOMHEIGHT then
    hero.x = move_x
    hero.y = move_y
  end
  
  message = getMessage(level, hero.x,hero.y) 
end
