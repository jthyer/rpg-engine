-- MONSTERDATA should be immutable. These tables are not edited anywhere, only referenced.
-- Monster structure: { <name> , <HP> , <STRENGTH> , <EXP> }
-- Add item drop and percentage later.

local monsters = {}

monsters.Snake = {}
monsters.Snake.maxHealth = 12
monsters.Snake.strength = 6
monsters.Snake.exp = 10

return monsters