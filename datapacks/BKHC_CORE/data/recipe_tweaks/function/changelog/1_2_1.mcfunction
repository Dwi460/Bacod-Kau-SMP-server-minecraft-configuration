scoreboard players reset @s recipe_tweaks.changelog.1_2_1
tellraw @s [{"text":"'Recipe Tweaks' (v1.2.1) changelog","color":"gold","bold":true}]
tellraw @s [{"text":""}]



tellraw @s [{"text":"Additions","underlined":true,"bold":true,"color":"yellow"}]

tellraw @s [{"text":"Added Modrinth to 'LINKS'","color":"gray"}]
#tellraw @s [{"text":"","color":"dark_gray"}]
tellraw @s [{"text":""}]



tellraw @s [{"text":"Changes:","underlined":true,"bold":true,"color":"yellow"}]

tellraw @s [{"text":"Updated to 1.20.5","color":"gray"}]
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