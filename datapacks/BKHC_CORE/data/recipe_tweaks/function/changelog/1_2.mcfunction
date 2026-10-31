scoreboard players reset @s recipe_tweaks.changelog.1_2
tellraw @s [{"text":"'Recipe Tweaks' (v1.2) changelog","color":"gold","bold":true}]
tellraw @s [{"text":""}]



tellraw @s [{"text":"Additions","underlined":true,"bold":true,"color":"yellow"}]

tellraw @s [{"text":"Added categories to all recipes, making them always appear in the proper recipe book tabs","color":"gray"}]
tellraw @s [{"text":"Added in-game changelogs and the console","color":"dark_gray"}]
tellraw @s [{"text":""}]



tellraw @s [{"text":"Changes:","underlined":true,"bold":true,"color":"yellow"}]

tellraw @s [{"text":"Updated to 1.20.2","color":"gray"},{"text":" * ","color":"blue","hover_event":{"action":"show_text","value":{"text":"","extra":[{"color":"blue","text":"which means the new stair recipes now work the same as the rest in the pack"}]}}}]
tellraw @s [{"text":"The Bundle recipe and advancement have been removed","color":"dark_gray"}]
tellraw @s [{"text":"Changed the Calcite recipe","color":"gray"},{"text":" * ","color":"blue","hover_event":{"action":"show_text","value":{"text":"","extra":[{"color":"blue","text":"now 2 Bone Meal and 2 Coal in a 2x2 cross pattern"}]}}}]
tellraw @s [{"text":"The Calibrated Sculk Sensor recipe is now shapeless","color":"dark_gray"}]
tellraw @s [{"text":"Clicking the asterisk in the /reload message now shows a console with links and changelogs instead of just links","color":"gray"}]
tellraw @s [{"text":"Changed the format of all triggers","color":"dark_gray"},{"text":" * ","color":"blue","hover_event":{"action":"show_text","value":{"text":"","extra":[{"color":"blue","text":"example - iRT_Links --> recipe_tweaks.links"}]}}}]
tellraw @s [{"text":""}]



#tellraw @s [{"text":"Fixes","underlined":true,"bold":true,"color":"yellow"}]

#tellraw @s [{"text":"","color":"gray"}]
#tellraw @s [{"text":"","color":"dark_gray"}]
#tellraw @s [{"text":""}]



#####tellraw @s [{"text":"Known issues","underlined":true,"bold":true,"color":"yellow"}]

#####tellraw @s [{"text":"","color":"gray"}]
#####tellraw @s [{"text":"","color":"dark_gray"}]
#####tellraw @s [{"text":""}]

tellraw @s [{"bold":true,"text":"[","color":"dark_gray"},{"bold":false,"color":"gray","text":"Bring up the console","hover_event":{"action":"show_text","value":{"text":"","extra":[{"color":"dark_purple","bold":true,"text":"Click here "},{"color":"yellow","text":""}]}},"click_event":{"action":"run_command",command:"/trigger recipe_tweaks.console"}},{"bold":true,"text":"]","color":"dark_gray"}]