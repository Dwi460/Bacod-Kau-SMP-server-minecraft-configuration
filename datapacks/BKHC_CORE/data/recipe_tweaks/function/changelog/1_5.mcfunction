scoreboard players reset @s recipe_tweaks.changelog.1_5
tellraw @s [{"text":"'Recipe Tweaks' (v1.5) changelog","color":"gold","bold":true}]
tellraw @s [{"text":""}]



tellraw @s [{"text":"Additions","underlined":true,"bold":true,"color":"yellow"}]

tellraw @s [{"text":"Added a Dead Bush recipe","color":"gray"},{"text":" * ","color":"blue","hover_event":{"action":"show_text","value":{"text":"","extra":[{"color":"blue","text":"Smelting; ingredient - (Firefly) Bush; 2 times faster than most smelting recipes; unlocked by obtaining a (Firefly) Bush"}]}}}]
tellraw @s [{"text":"Added (Short/Tall) Dry Grass recipes","color":"dark_gray"},{"text":" * ","color":"blue","hover_event":{"action":"show_text","value":{"text":"","extra":[{"color":"blue","text":"Smelting; ingredient - (Short/Tall) Grass; 2 times faster than most smelting recipes; unlocked by obtaining (Short/Tall) (Dry) Grass"}]}}}]
tellraw @s [{"text":""}]


tellraw @s [{"text":"Changes:","underlined":true,"bold":true,"color":"yellow"}]

tellraw @s [{"text":"Updated to 1.21.5","color":"gray"}]
tellraw @s [{"text":"The Sponge & Leaf Litter recipes are now 2 times faster than before","color":"dark_gray"}]
tellraw @s [{"text":"The (Warped Fungus/Carrot) on a Stick recipes are now shapeless","color":"gray"}]
tellraw @s [{"text":""}]


tellraw @s [{"text":"Fixes","underlined":true,"bold":true,"color":"yellow"}]

tellraw @s [{"text":"Fixed the Bow Dispenser recipe only using Cobblestone","color":"gray"}]
tellraw @s [{"text":""}]

tellraw @s [{"bold":true,"text":"[","color":"dark_gray"},{"bold":false,"color":"gray","text":"Bring up the console","hover_event":{"action":"show_text","value":{"text":"","extra":[{"color":"dark_purple","bold":true,"text":"Click here "},{"color":"yellow","text":""}]}},"click_event":{"action":"run_command",command:"/trigger recipe_tweaks.console"}},{"bold":true,"text":"]","color":"dark_gray"}]