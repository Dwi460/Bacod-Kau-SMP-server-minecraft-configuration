###One function to rule them all
###by iNkoR_the_2nd

###Failsafe
execute unless score recipe_tweaks.failsafe recipe_tweaks.loaded matches 61 run scoreboard players add recipe_tweaks.failsafe recipe_tweaks.loaded 1
execute if score recipe_tweaks.failsafe recipe_tweaks.loaded matches 61 run function recipe_tweaks:technical/failsafe