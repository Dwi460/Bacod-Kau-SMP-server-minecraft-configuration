scoreboard players reset @s recipe_tweaks.changelog.1_6_1
tellraw @s [{"text":"'Recipe Tweaks' (v1.6.1) changelog","color":"gold","bold":true}]
tellraw @s [{"text":""}]



tellraw @s [{"text":"Additions","underlined":true,"bold":true,"color":"yellow"}]

tellraw @s [{"text":"Added a Copper Nautilus Armor crafting recipe","color":"gray"},{"text":" * ","color":"blue","hover_event":{"action":"show_text","value":{"text":"","extra":[{"color":"blue","text":"shaped; 6 Copper Ingots; unlocked when picking up a Pufferfish/Copper Nautilus Armor"}]}}}]
tellraw @s [{"text":"Added an Iron Nautilus Armor crafting recipe","color":"dark_gray"},{"text":" * ","color":"blue","hover_event":{"action":"show_text","value":{"text":"","extra":[{"color":"blue","text":"shaped; 6 Iron Ingots; unlocked when picking up a Pufferfish/Iron Nautilus Armor"}]}}}]
tellraw @s [{"text":"Added a Golden Nautilus Armor crafting recipe","color":"gray"},{"text":" * ","color":"blue","hover_event":{"action":"show_text","value":{"text":"","extra":[{"color":"blue","text":"shaped; 6 Gold Ingots; unlocked when picking up a Gold Ingot/Golden Nautilus Armor"}]}}}]
tellraw @s [{"text":"Added a Diamond Nautilus Armor crafting recipe","color":"dark_gray"},{"text":" * ","color":"blue","hover_event":{"action":"show_text","value":{"text":"","extra":[{"color":"blue","text":"shaped; 6 Diamonds; unlocked when picking up a Diamond/Diamond Nautilus Armor"}]}}}]
tellraw @s [{"text":""}]


tellraw @s [{"text":"Changes:","underlined":true,"bold":true,"color":"yellow"}]

tellraw @s [{"text":"Updated to 1.21.11","color":"gray"}]
tellraw @s [{"text":""}]


#tellraw @s [{"text":"Fixes","underlined":true,"bold":true,"color":"yellow"}]

#tellraw @s [{"text":"","color":"gray"}]
#tellraw @s [{"text":"","color":"dark_gray"}]
#tellraw @s [{"text":""}]


###tellraw @s [{"text":"Known issues","underlined":true,"bold":true,"color":"yellow"}]

###tellraw @s [{"text":"","color":"gray"}]
###tellraw @s [{"text":"","color":"dark_gray"}]
###tellraw @s [{"text":""}]

tellraw @s [{"bold":true,"text":"[","color":"dark_gray"},{"bold":false,"color":"gray","text":"Bring up the console","hover_event":{"action":"show_text","value":{"text":"","extra":[{"color":"dark_purple","bold":true,"text":"Click here "},{"color":"yellow","text":""}]}},"click_event":{"action":"run_command",command:"/trigger recipe_tweaks.console"}},{"bold":true,"text":"]","color":"dark_gray"}]