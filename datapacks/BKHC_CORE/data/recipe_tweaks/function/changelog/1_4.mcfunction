scoreboard players reset @s recipe_tweaks.changelog.1_4
tellraw @s [{"text":"'Recipe Tweaks' (v1.4) changelog","color":"gold","bold":true}]
tellraw @s [{"text":""}]



tellraw @s [{"text":"Additions","underlined":true,"bold":true,"color":"yellow"}]

tellraw @s [{"text":"Added Packed Mud stonecutting recipes","color":"gray"},{"text":" * ","color":"blue","hover_event":{"action":"show_text","value":{"text":"","extra":[{"color":"blue","text":"Packed Mud can now be used in the Stonecutter to craft any Mud Brick block; these recipes are unlocked by obtaining Packed Mud"}]}}}]
tellraw @s [{"text":""}]


tellraw @s [{"text":"Changes:","underlined":true,"bold":true,"color":"yellow"}]

tellraw @s [{"text":"Updated to 1.21.4","color":"gray"},{"text":" * ","color":"blue","hover_event":{"action":"show_text","value":{"text":"","extra":[{"color":"blue","text":"which means the new stair recipes now work the same as the rest in the pack"}]}}}]
tellraw @s [{"text":"The 'CHANGELOGS' text on the console is now gray","color":"dark_gray"}]
tellraw @s [{"text":"Chainmail armor recipe results are now common","color":"gray"},{"text":" * ","color":"blue","hover_event":{"action":"show_text","value":{"text":"","extra":[{"color":"blue","text":"Chainmail armor is uncommon by default"}]}}}]
tellraw @s [{"text":"The Creaking Heart recipe is now shapeless and only requires 1 Pale Oak Log","color":"dark_gray"}]
tellraw @s [{"text":"The Jack o'Lantern recipe is now shapeless","color":"gray"}]
tellraw @s [{"text":"Grouped 1.21 Waxed Copper recipes","color":"dark_gray"},{"text":" * ","color":"blue","hover_event":{"action":"show_text","value":{"text":"","extra":[{"color":"blue","text":"only grouped results that had more than 1 recipe; now all Copper Bulb recipes are in the Redstone category due to this change"}]}}}]
tellraw @s [{"text":""}]

tellraw @s [{"bold":true,"text":"[","color":"dark_gray"},{"bold":false,"color":"gray","text":"Bring up the console","hover_event":{"action":"show_text","value":{"text":"","extra":[{"color":"dark_purple","bold":true,"text":"Click here "},{"color":"yellow","text":""}]}},"click_event":{"action":"run_command",command:"/trigger recipe_tweaks.console"}},{"bold":true,"text":"]","color":"dark_gray"}]