scoreboard players reset @s recipe_tweaks.changelog.1_6
tellraw @s [{"text":"'Recipe Tweaks' (v1.6) changelog","color":"gold","bold":true}]
tellraw @s [{"text":""}]



tellraw @s [{"text":"Additions","underlined":true,"bold":true,"color":"yellow"}]

tellraw @s [{"text":"Added a Copper Horse Armor crafting recipe","color":"gray"},{"text":" * ","color":"blue","hover_event":{"action":"show_text","value":{"text":"","extra":[{"color":"blue","text":"same shape as other Horse Armor recipes; unlocked when picking up a Copper Ingot"}]}}}]
tellraw @s [{"text":"Added new Soul/Copper Torch crafting recipes","color":"dark_gray"},{"text":" * ","color":"blue","hover_event":{"action":"show_text","value":{"text":"","extra":[{"color":"blue","text":"1 Torch Surrounded by 4 Soul Sand/Soil or Copper Nuggets; grouped & unlocked simultaneously with vanilla recipes"}]}}}]
tellraw @s [{"text":"Added (new Waxed) Copper Golem Statue crafting recipes","color":"gray"},{"text":" * ","color":"blue","hover_event":{"action":"show_text","value":{"text":"","extra":[{"color":"blue","text":"Carved Pumpkin/Jack o'Lantern on top of a Copper Block; new Waxed Copper Golem Statue recipes are grouped with the vanilla ones; unlocked when picking up the matching Copper blocks"}]}}}]
tellraw @s [{"text":"Added new Soul Campfire/Lantern crafting recipes","color":"dark_gray"},{"text":" * ","color":"blue","hover_event":{"action":"show_text","value":{"text":"","extra":[{"color":"blue","text":"1 Soul Sand/Soil with 1 Lantern/Campfire; grouped & unlocked simultaneously with vanilla recipes"}]}}}]
tellraw @s [{"text":""}]


tellraw @s [{"text":"Changes:","underlined":true,"bold":true,"color":"yellow"}]

tellraw @s [{"text":"Updated to 1.21.9","color":"gray"}]
tellraw @s [{"text":"Changed the Copper/Iron Chain recipes","color":"dark_gray"},{"text":" * ","color":"blue","hover_event":{"action":"show_text","value":{"text":"","extra":[{"color":"blue","text":"they now use 5 Nuggets instead of 1 Ingot and 2 Nuggets; no longer unlocked when picking up a Copper/Iron Ingot"}]}}}]
tellraw @s [{"text":"Removed the altered Copper Trapdoor recipe since it's now in vanilla","color":"gray"}]
tellraw @s [{"text":"Changed the Saddle recipe","color":"dark_gray"},{"text":" * ","color":"blue","hover_event":{"action":"show_text","value":{"text":"","extra":[{"color":"blue","text":"it's now 3 Leather, 2 String below and 2 Iron Nuggets below the String"}]}}}]
tellraw @s [{"text":"Improved the data pack description","color":"gray"},{"text":" * ","color":"blue","hover_event":{"action":"show_text","value":{"text":"","extra":[{"color":"blue","text":"all text from the 'pack.mcmeta' file should be displayed fully now"}]}}}]
tellraw @s [{"text":""}]

tellraw @s [{"bold":true,"text":"[","color":"dark_gray"},{"bold":false,"color":"gray","text":"Bring up the console","hover_event":{"action":"show_text","value":{"text":"","extra":[{"color":"dark_purple","bold":true,"text":"Click here "},{"color":"yellow","text":""}]}},"click_event":{"action":"run_command",command:"/trigger recipe_tweaks.console"}},{"bold":true,"text":"]","color":"dark_gray"}]