# rpg-engine
Tiny 80's-style RPG engine in Love2D.

 
Final Demo Requirements:
  1) The hero will walk around on a 32x32 grid and is blocked by solid walls, all drawn using the classic Windows 16 color font.
  2) A message at the bottom of the screen describing the current location.
  3) Some walls will be illusory and can be passed through.
  4) Door object are displayed between rooms and can be passed through.
  5) Doors can be locked and must be unlocked by interacting with a switch elsewhere.
  6) The player will step on Events which trigger text boxes.
  7) Events will allow multiple text boxes to be displayed in sequence.
  8) The player will select choices which branch text box sequences.
  9) The player will trigger a trap which flashes the screen and plays a sound.
 10) The player will meet a hallway full of snakes. They will not be able to pass until they trigger the "got snake repellant" flag on another event.
  
  
Remaining Features to Implement:
- make choice box responsive to hero position #8
- "push" subevent that pushes hero in a specific direction #10
- "flash" subevent #9
- "sound" subevent for opening doors and traps #9
- make tile code into strings #1
- turn message code into chars #2
- expand map to 32x32 #1
- add illusory walls ("---SECRET PASSAGE---") #3
- add locked door event that branches off flag #5
- allow events to be invisible #5
- "erase" subevent for erasing event #5
- change palette to use windows colors #1
  
Once all these features are done, I will be able to make a complete demo dungeon.

To build in later versions: 
- Combat (Random Encounters and red Boss Events), Leveling, Equipment, Inventory
- Text interludes between dungeons, map screen
- Save games - track character info, and then flags and fog of war for one dungeon only
- Title and Ending Screens
- Learn how to make maps with Ogmo

The final initial game will be five dungeons, linked together by text screens as the hero slowly tracks down the villain. 