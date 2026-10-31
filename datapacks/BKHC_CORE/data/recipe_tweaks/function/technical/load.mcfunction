scoreboard objectives add recipe_tweaks.loaded dummy {"text":"'Recipe Tweaks' loaded","color":"gold"}
execute unless score recipe_tweaks.loaded recipe_tweaks.loaded matches 1 run schedule function recipe_tweaks:technical/1s 1s
scoreboard players set recipe_tweaks.loaded recipe_tweaks.loaded 1

schedule function recipe_tweaks:technical/reload_message 1s

scoreboard objectives add recipe_tweaks.reload_message dummy {"text":"'Recipe Tweaks' Reload Message","color":"gold"}
scoreboard objectives add recipe_tweaks.reload_message.disable trigger {"text":"'Recipe Tweaks' Reload Message (disable)","color":"yellow"}
scoreboard objectives add recipe_tweaks.reload_message.enable trigger {"text":"'Recipe Tweaks' Reload Message (enable)","color":"yellow"}

scoreboard objectives add recipe_tweaks.console trigger {"text":"'Recipe Tweaks' console","color":"yellow"}
scoreboard objectives add recipe_tweaks.links trigger {"text":"'Recipe Tweaks' links","color":"yellow"}
scoreboard objectives add recipe_tweaks.changelogs trigger {"text":"'Recipe Tweaks' changelogs","color":"gold"}
#Versions
scoreboard objectives add recipe_tweaks.changelog.1_1 trigger {"text":"'Recipe Tweaks' (v1.1) changelog","color":"yellow"}
scoreboard objectives add recipe_tweaks.changelog.1_2 trigger {"text":"'Recipe Tweaks' (v1.2) changelog","color":"yellow"}
scoreboard objectives add recipe_tweaks.changelog.1_2_1 trigger {"text":"'Recipe Tweaks' (v1.2.1) changelog","color":"yellow"}
scoreboard objectives add recipe_tweaks.changelog.1_3 trigger {"text":"'Recipe Tweaks' (v1.3) changelog","color":"yellow"}
scoreboard objectives add recipe_tweaks.changelog.1_4 trigger {"text":"'Recipe Tweaks' (v1.4) changelog","color":"yellow"}
scoreboard objectives add recipe_tweaks.changelog.1_5 trigger {"text":"'Recipe Tweaks' (v1.5) changelog","color":"yellow"}
scoreboard objectives add recipe_tweaks.changelog.1_5_1 trigger {"text":"'Recipe Tweaks' (v1.5.1) changelog","color":"yellow"}
scoreboard objectives add recipe_tweaks.changelog.1_6 trigger {"text":"'Recipe Tweaks' (v1.6) changelog","color":"yellow"}
scoreboard objectives add recipe_tweaks.changelog.1_6_1 trigger {"text":"'Recipe Tweaks' (v1.6.1) changelog","color":"yellow"}