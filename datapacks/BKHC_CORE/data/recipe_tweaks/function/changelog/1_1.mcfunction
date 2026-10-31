scoreboard players reset @s recipe_tweaks.changelog.1_1
tellraw @s [{"text":"'Recipe Tweaks' (v1.1) changelog","color":"gold","bold":true}]
tellraw @s [{"text":""}]



tellraw @s [{"text":"Additions","underlined":true,"bold":true,"color":"yellow"}]

tellraw @s [{"text":"Added a new Paper recipe","color":"gray"},{"text":" * ","color":"blue","hover_event":{"action":"show_text","value":{"text":"","extra":[{"color":"blue","text":"1 Explorer/Buried Treasure/Player-generated Filled Map into 8 Paper; unlocked by receiving a Filled Map"}]}}}]
tellraw @s [{"text":"Added a new Stick recipe","color":"dark_gray"},{"text":" * ","color":"blue","hover_event":{"action":"show_text","value":{"text":"","extra":[{"color":"blue","text":"1 Sapling (including the Mangrove Propagule) into 1 Stick; unlocked by receiving any Sapling (including the Mangrove Propagule)"}]}}}]
tellraw @s [{"text":""}]



tellraw @s [{"text":"Changes:","underlined":true,"bold":true,"color":"yellow"}]

tellraw @s [{"text":"Updated to 1.19","color":"gray"},{"text":" * ","color":"blue","hover_event":{"action":"show_text","value":{"text":"","extra":[{"color":"blue","text":"which means the new stair recipes now work the same as the rest in the pack"}]}}}]
tellraw @s [{"text":"Moved the Yellow Dye from Glowstone Dust recipe and advancement back to 'Overskip'","color":"dark_gray"}]
tellraw @s [{"text":"Moved the Brown Dye from Rotten Flesh recipe and advancement back to 'Overskip' and changed it","color":"gray"},{"text":" * ","color":"blue","hover_event":{"action":"show_text","value":{"text":"","extra":[{"color":"blue","text":"it was moved to 'Recipe Tweaks' from that pack in v1.0; now it's a Furnace/Smoker/(Soul) Campfire recipe and gives 0.1 experience"}]}}}]
tellraw @s [{"text":"The links no longer require access to cheats to see an can be viewed by running an `iRT_Links` trigger command","color":"dark_gray"}]
tellraw @s [{"text":""}]



tellraw @s [{"text":"Fixes","underlined":true,"bold":true,"color":"yellow"}]

tellraw @s [{"text":"The 'prismarine_brick_slab_from_prismarine_stonecutting' recipe now yields 2 Slabs instead of 1 like in v1.0 as it should","color":"gray"}]
tellraw @s [{"text":"The Stone blocks and Sticks have switched places in the Grindstone recipe to better match the block model","color":"dark_gray"}]
tellraw @s [{"text":""}]



#####tellraw @s [{"text":"Known issues","underlined":true,"bold":true,"color":"yellow"}]

#####tellraw @s [{"text":"","color":"gray"}]
#####tellraw @s [{"text":"","color":"dark_gray"}]
#####tellraw @s [{"text":""}]

tellraw @s [{"bold":true,"text":"[","color":"dark_gray"},{"bold":false,"color":"gray","text":"Bring up the console","hover_event":{"action":"show_text","value":{"text":"","extra":[{"color":"dark_purple","bold":true,"text":"Click here "},{"color":"yellow","text":""}]}},"click_event":{"action":"run_command",command:"/trigger recipe_tweaks.console"}},{"bold":true,"text":"]","color":"dark_gray"}]