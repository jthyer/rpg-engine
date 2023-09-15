-- MONSTERDATA should be immutable. These tables are not edited anywhere, only referenced.
-- Monster structure: { <name> , <HP> , <STRENGTH> , <EXP> }
-- Add item drop and percentage later.

local monsters = {}

monsters.Snake = {}
monsters.Snake.name = "SNAKE"
monsters.Snake.maxHealth = 12
monsters.Snake.strength = 8
monsters.Snake.level = 2.63

return monsters