-- defines levelTable, objTable, eventTable, messages hero
-- everything that makes up the actual map is in "levels"
require("levels")

-- next steps:
--  1) implement choices on the text box events 
--   done! 
--   Subtasks a) make responsive to hero position
--            b) show another text box after choice, push hero off event  
--  2) implement a simple inventory
--  3) pick up a key, add it to the inventory, open a locked door

-- efficiency changes to do:
--  * Code text box coordinates in load event, not every frame in draw

-- define globals and constants
level = 1
fogOfWar = {} 
message = ""

ROOMWIDTH = 20
ROOMHEIGHT = 20

textBox = {}
  textBox.status = false
  textBox.choiceStatus = 0
  textBox.choice1 = ""
  textBox.choice2 = ""
  textBox.eventID = ""
  textBox.text = eventTable[1][1][4]
  textBox.WIDTH = 250
  textBox.HEIGHT = 75
  textBox.X = (300 - textBox.WIDTH) / 2
  textBox.Y = textBox.X + 10
  textBox.BORDER = 2

KEYTABLE = {
  ["left"]  = {-1, 0},
  ["up"]    = { 0,-1},
  ["right"] = { 1, 0},
  ["down"]  = { 0, 1},
  ["Z"]     = { 0, 0}
}


function love.load()
  -- window settings
  love.graphics.setDefaultFilter("nearest", "nearest", 1)
  love.window.setTitle("Custom RPG Engine")

  -- set font
  font = love.graphics.newFont("cmd.ttf", 16)
  love.graphics.setFont(font)
  
  -- initialize fog of war
  for i = 1, ROOMHEIGHT do
    local row = {}
    for j = 1, ROOMWIDTH do
      table.insert(row, 1)
    end
    table.insert(fogOfWar,row)
  end
  
  updateWorldState()
end

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


function love.update()  
end

function updateWorldState()
  -- since this game is turn based, the state only needs
  -- to update on movement or when the game starts
  
  -- update message
  local code = levelTable[level][hero.y][hero.x]
  message = msgTable[level][code]
  
  --update fog of war
  for i = -1, 1 do
    for j = -1, 1 do
      local x,y = hero.x+j,hero.y+i
      if x >= 1 and x <= ROOMWIDTH and 
        y >= 1 and y <= ROOMHEIGHT then
        fogOfWar[y][x] = 0
      end
    end
  end
  
  --update events
  do 
    local checkEvents = function (i,v)
      if hero.x == v[2] and hero.y == v[3] then
        textBox.eventID = i
        if v[1] == "textBox" then
          textBox.text = eventTable[level][i][4]
          textBox.status = true
        elseif v[1] == "choiceBox" then
          textBox.text = eventTable[level][i][4]
          textBox.choice1 = eventTable[level][i][5]
          textBox.choice2 = eventTable[level][i][6]
          textBox.choiceStatus = 1
          textBox.status = true
        end
      end
    end
    iterateTable(eventTable[level],checkEvents)
  end 
end


function setColor(c)
  love.graphics.setColor(COLORTABLE[c][1],COLORTABLE[c][2],COLORTABLE[c][3])
end

function drawTextBox(text, x, y, w, h, b)  
  setColor("black")
  love.graphics.rectangle("fill",x-b-1,y-b-1,w+(b*2)+2,h+(b*2)+2)
  setColor("white")
  love.graphics.rectangle("fill",x-b,y-b,w+(b*2),h+(b*2))
  setColor("black")
  love.graphics.rectangle("fill",x,y,w,h)
  setColor("white")
  love.graphics.printf(text,x+10,y+10,w-20,"left")
end

function love.draw()
  -- set scale to x2
  love.graphics.push()
  love.graphics.scale(2, 2)
  
  -- draw dungeon window
  love.graphics.push()
  love.graphics.translate(50,25)
  
  -- draw pink border and black background
  setColor("pink")
  love.graphics.rectangle("fill",-5,-5,(ROOMWIDTH*10)+10,(ROOMHEIGHT*10)+10)
  setColor("black")
  love.graphics.rectangle("fill",0,0,(ROOMWIDTH*10),(ROOMHEIGHT*10))

  -- draw objects
  do
    local drawObject = function(i,v)
      local x = (v[2]-1) * 10
      local y = (v[3]-1) * 10
      if v[1] == "doorV" then
        love.graphics.line(x+4,y,x+4,y+10)
        love.graphics.line(x+6,y,x+6,y+10)
      end
      if v[1] == "doorH" then
        love.graphics.line(x,y+4,x+10,y+4)
        love.graphics.line(x,y+6,x+10,y+6)
      end
    end
 
    setColor("pink")
    iterateTable(objTable[level],drawObject)
  end

  -- draw events
  do
    local drawEvent = function (i,v)
      if v[1] ~= "NULL" then
        love.graphics.rectangle("fill", (v[2] - 1) * 10+3, (v[3] - 1) * 10 + 3, 4, 4)
      end
    end
    
    setColor("pink")    
    iterateTable(eventTable[level], drawEvent)
  end

  -- draw walls, fog of war, hero
  do 
    local drawRect = function (x,y,w)
      if w == 1 then
        love.graphics.rectangle("fill", (x - 1) * 10, (y - 1) * 10, 10, 10)
      end
    end
    
    setColor("white")
    iterate2DTable(levelTable[level],drawRect)
    setColor("grey")
    iterate2DTable(fogOfWar,drawRect)
    setColor("yellow")
    drawRect(hero.x,hero.y,1)
  end

  -- draw room text
  setColor("white")
  love.graphics.printf(message,-50,ROOMHEIGHT*10+8,300,"center")
  
  -- end dungeon window drawing
  love.graphics.pop()
  
  --draw text box
  if textBox.status then
    local y_offset 
    if hero.y > 10 then 
      y_offset = 0
    else 
      y_offset = 180 - textBox.HEIGHT
    end

    drawTextBox(textBox.text, textBox.X, textBox.Y + y_offset, 
      textBox.WIDTH, textBox.HEIGHT,textBox.BORDER)

    if textBox.choiceStatus > 0 then
      local choiceOffset = 0
      local w,h = 20, 20
      local c1, c2 = textBox.choice1, textBox.choice2 
      if textBox.choiceStatus == 1 then
        c1 = "<" .. textBox.choice1 .. ">"
        c2 = "  " .. textBox.choice2 .. " "
      else
        c1 = "  " .. textBox.choice1 .. " "
        c2 = "<" .. textBox.choice2 .. ">"
      end
      setColor("black")
      drawTextBox(c1 .. "\n" .. c2, 
          textBox.X, textBox.Y + y_offset - 60, 60, 50, 2)
    end
  end
  
  love.graphics.pop()
end


function love.keypressed(key, scancode, isrepeat)
  if textBox.status then
    if textBox.choiceStatus > 0 then
      if key == "up" then 
        textBox.choiceStatus = 1
      elseif key == "down" then
        textBox.choiceStatus = 2
      elseif key == "z" then
        textBox.choiceStatus = 0
        textBox.status = false
        print("Setting eventID " .. textBox.eventID .. " to NULL!")
        eventTable[level][textBox.eventID][1] = "NULL"
      end
      return
    else  
      textBox.status = false
    end
  end  
  
  if KEYTABLE[key] == nil then
    return
  end  
  
  -- move hero if no walls in the way
  local move_x = hero.x + KEYTABLE[key][1]
  local move_y = hero.y + KEYTABLE[key][2]
  
  if move_x > 0 and move_x <= ROOMWIDTH and
    move_y > 0 and move_y <= ROOMHEIGHT then
    if levelTable[level][move_y][move_x] ~= 1 then
      hero.x = move_x
      hero.y = move_y
    end
  end
  
  updateWorldState()
end