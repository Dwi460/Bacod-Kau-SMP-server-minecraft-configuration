scoreboard players reset @s recipe_tweaks.changelog.1_3
tellraw @s [{"text":"'Recipe Tweaks' (v1.3) changelog","color":"gold","bold":true}]
tellraw @s [{"text":""}]



tellraw @s [{"text":"Additions","underlined":true,"bold":true,"color":"yellow"}]

tellraw @s [{"text":"Added a failsafe feature","color":"gray"},{"text":" * ","color":"blue","hover_event":{"action":"show_text","value":{"text":"","extra":[{"color":"blue","text":"If the function that runs every second failed to reschedule due to an update, the pack will now reschedule it & start working properly again"}]}}}]
tellraw @s [{"text":"Added the vanilla Dispenser recipe back","color":"dark_gray"},{"text":" * ","color":"blue","hover_event":{"action":"show_text","value":{"text":"","extra":[{"color":"blue","text":"The 'Recipe Tweaks' recipe now exists as an alternative & is unlocked by getting 1 Stick/String/Bow/Dispenser; both recipes are now in the new 'dispenser' group"}]}}}]
tellraw @s [{"text":""}]



tellraw @s [{"text":"Changes:","underlined":true,"bold":true,"color":"yellow"}]

tellraw @s [{"text":"Updated to 1.21","color":"gray"},{"text":" * ","color":"blue","hover_event":{"action":"show_text","value":{"text":"","extra":[{"color":"blue","text":"which means the new stair recipes now work the same as the rest in the pack"}]}}}]
tellraw @s [{"text":"The Shulker Box recipe is now shapeless","color":"dark_gray"}]
tellraw @s [{"text":"You can now get Cobble(stone/d Deepslate) from Stonecutting Stone/Deepslate","color":"gray"}]
tellraw @s [{"text":"Tuff/Diorite/Andesite/Granite/(Red) Sandstone can now be used as Cobble(stone/d Deepslate) & Blackstone in crafting recipes","color":"dark_gray"}]
tellraw @s [{"text":"Polished Tuff/Diorite/Andesite/Granite (Slabs) & Smooth (Red) Sandstone (Slabs) can now be used to craft Armor Stands, Blast Furnaces, Stonecutters & Grindstones","color":"gray"}]
tellraw @s [{"text":"The Copper Trapdoor recipe is now consistent with Iron Trapdoors","color":"dark_gray"},{"text":" * ","color":"blue","hover_event":{"action":"show_text","value":{"text":"","extra":[{"color":"blue","text":"Changed from 3x2 Ingots for 2 Trapdoors to 2x2 Ingots for 1 Trapdoor"}]}}}]
tellraw @s [{"text":""}]



tellraw @s [{"text":"Fixes","underlined":true,"bold":true,"color":"yellow"}]

tellraw @s [{"text":"Stonecutters are now crafted with Deepslate instead of Polished Deepslate","color":"gray"}]
#tellraw @s [{"text":"","color":"dark_gray"}]
tellraw @s [{"text":""}]

tellraw @s [{"bold":true,"text":"[","color":"dark_gray"},{"bold":false,"color":"gray","text":"Bring up the console","hover_event":{"action":"show_text","value":{"text":"","extra":[{"color":"dark_purple","bold":true,"text":"Click here "},{"color":"yellow","text":""}]}},"click_event":{"action":"run_command",command:"/trigger recipe_tweaks.console"}},{"bold":true,"text":"]","color":"dark_gray"}]