schedule function recipe_tweaks:technical/1s 1s

scoreboard players reset recipe_tweaks.failsafe recipe_tweaks.loaded

###Everything
scoreboard players enable @a recipe_tweaks.reload_message.disable
scoreboard players enable @a recipe_tweaks.reload_message.enable
scoreboard players enable @a recipe_tweaks.console
scoreboard players enable @a recipe_tweaks.links
scoreboard players enable @a recipe_tweaks.changelogs
#Versions
scoreboard players enable @a recipe_tweaks.changelog.1_1
scoreboard players enable @a recipe_tweaks.changelog.1_2
scoreboard players enable @a recipe_tweaks.changelog.1_2_1
scoreboard players enable @a recipe_tweaks.changelog.1_3
scoreboard players enable @a recipe_tweaks.changelog.1_4
scoreboard players enable @a recipe_tweaks.changelog.1_5
scoreboard players enable @a recipe_tweaks.changelog.1_5_1
scoreboard players enable @a recipe_tweaks.changelog.1_6
scoreboard players enable @a recipe_tweaks.changelog.1_6_1

execute as @p[scores={recipe_tweaks.reload_message.disable=1..}] run function recipe_tweaks:reload_message/disable
execute as @p[scores={recipe_tweaks.reload_message.enable=1..}] run function recipe_tweaks:reload_message/enable
execute as @p[scores={recipe_tweaks.console=1..}] run function recipe_tweaks:console
execute as @p[scores={recipe_tweaks.links=1..}] run function recipe_tweaks:links
execute as @p[scores={recipe_tweaks.changelogs=1..}] run function recipe_tweaks:changelog/main
#Versions
execute as @p[scores={recipe_tweaks.changelog.1_1=1..}] run function recipe_tweaks:changelog/1_1
execute as @p[scores={recipe_tweaks.changelog.1_2=1..}] run function recipe_tweaks:changelog/1_2
execute as @p[scores={recipe_tweaks.changelog.1_2_1=1..}] run function recipe_tweaks:changelog/1_2_1
execute as @p[scores={recipe_tweaks.changelog.1_3=1..}] run function recipe_tweaks:changelog/1_3
execute as @p[scores={recipe_tweaks.changelog.1_4=1..}] run function recipe_tweaks:changelog/1_4
execute as @p[scores={recipe_tweaks.changelog.1_5=1..}] run function recipe_tweaks:changelog/1_5
execute as @p[scores={recipe_tweaks.changelog.1_5_1=1..}] run function recipe_tweaks:changelog/1_5_1
execute as @p[scores={recipe_tweaks.changelog.1_6=1..}] run function recipe_tweaks:changelog/1_6
execute as @p[scores={recipe_tweaks.changelog.1_6_1=1..}] run function recipe_tweaks:changelog/1_6_1