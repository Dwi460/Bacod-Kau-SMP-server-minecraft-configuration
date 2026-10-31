scoreboard players reset @s recipe_tweaks.changelog.1_5_1
tellraw @s [{"text":"'Recipe Tweaks' (v1.5.1) changelog","color":"gold","bold":true}]
tellraw @s [{"text":""}]



tellraw @s [{"text":"Additions","underlined":true,"bold":true,"color":"yellow"}]

tellraw @s [{"text":"Added a button to disable the reload message in the resources","color":"gray"},{"text":" * ","color":"blue","hover_event":{"action":"show_text","value":{"text":"","extra":[{"color":"blue","text":"if the reload message is disabled the button in the resources changes to allow you to reenable the reload message"}]}}}]
tellraw @s [{"text":""}]


tellraw @s [{"text":"Changes:","underlined":true,"bold":true,"color":"yellow"}]

tellraw @s [{"text":"Updated to 1.21.6","color":"gray"}]
tellraw @s [{"text":"The Crying Obsidian recipe now requires 4 Ghast Tears instead of 8","color":"dark_gray"}]
tellraw @s [{"text":"Removed the 'v's from the changelog version titles","color":"gray"}]
tellraw @s [{"text":"Removed 'Dyebolical' challenge ('Overskip' compatibility)","color":"dark_gray"}]
tellraw @s [{"text":""}]


tellraw @s [{"text":"Fixes","underlined":true,"bold":true,"color":"yellow"}]

tellraw @s [{"text":"The Calcite recipe is now unlocked by obtaining Coal/Bone Meal instead of Coal Blocks/Bone Blocks","color":"gray"}]
tellraw @s [{"text":"The Stick from Saplings recipe now only unlocks when picking up a Sapling item","color":"dark_gray"}]
tellraw @s [{"text":""}]

tellraw @s [{"bold":true,"text":"[","color":"dark_gray"},{"bold":false,"color":"gray","text":"Bring up the console","hover_event":{"action":"show_text","value":{"text":"","extra":[{"color":"dark_purple","bold":true,"text":"Click here "},{"color":"yellow","text":""}]}},"click_event":{"action":"run_command",command:"/trigger recipe_tweaks.console"}},{"bold":true,"text":"]","color":"dark_gray"}]