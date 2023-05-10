-- MONSTERDATA should be immutable. These tables are not edited anywhere, only referenced.
-- Monster structure: { <name> , <HP> , <STRENGTH> , <EXP> }
-- Add item drop and percentage later.

local monsters = {}

monsters.Snake = {}
monsters.Snake.health = 10
monsters.Snake.strength = 3
monsters.Snake.exp = 10

return monsters