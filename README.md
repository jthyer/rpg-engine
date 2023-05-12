# rpg-engine
Tiny 80's-style RPG engine in Love2D.

Current goal is to make one fully featured dungeon.

Battle System Requirements:
- Visible hero stats are LV, HP, STR, DEF, EXP. Invisible static stats: EVA.
- Monster stats are LV, HP, STR, DEF, ACC, EVA. Only HP is visible.
- Attack damage = Attacker.Str - (Target.Def / 2). (At least one damage on hit.)
- Miss chance on attack. Random(1,100) < Target.Eva = Miss.
- No status effects, but stats can be lowered or boosted in combat.
- STR Boost Item. DEF Boost Item. Eagle Eye Item ("hit enemy without fail".)
- Separating strength and defense allows for weak enemies with high defense, etc.
- Evasion stat allows for enemies that are hard to hit.
- Magic attacks (only possible for hero with items) ignore defense and evasion.
- Inventory of healing items, STR/DEF/Accuracy Boost Items, Magic Attack item. Enemy weakening items are redundant in 1-on-1 fighting. 
- Other items with dungeon map applicability like "MAP"
