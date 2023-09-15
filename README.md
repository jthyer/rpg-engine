# rpg-engine
Tiny 80's-style RPG engine in Love2D.

Current goal is to make one fully featured dungeon. 

Functional:
- Exploring maps.
- Basic events, text boxes, locked doors and keys.
- Battle system, leveling.

To implement:


Battle System Requirements:
- Visible hero stats are LV, HP, STR, EXP. 
- Monster stats are LV, HP, STR. Only HP is visible.
- Attack damage = Attacker.Str - (Target.Str / 2) + Variance. (At least one damage on hit.)
- 1/10 Miss chance on attack. 1/5 Miss chance on enemy attacks.
- No status effects.
- STR Boost Item. 
- Magic attacks ignore defense and evasion. Enemies can only Attack.
- Inventory of Potions, Fire Staffs, Inferno Staffs, STR Seed.
- Bronze Sword, Iron Sword, Silver Sword. Strength increases.