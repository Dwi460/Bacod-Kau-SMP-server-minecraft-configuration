race_events:
    type: world
    debug: false
    events:
        on player joins:
        - if <player.flag[race_origin]||none> == fairy:
            - flag player race_origin:fae
            - flag player race_destiny:!
            - flag player race_branch:!
            - if <player.flag[race]||none> == fairy:
                - flag player race:fae
            - if <player.flag[race]||none> == high_fairy:
                - flag player race:high_fae
        - if !<player.has_flag[race]>:
            - define races <script[race_config].data_key[races]>
            - define roll <util.random.int[1].to[100]>
            - define cumulative 0
            - define selected none
            - foreach <[races].keys> as:race:
                - define race_data <[races].get[<[race]>]>
                - define cumulative:<[cumulative].add[<[race_data].get[chance]>]>
                - if <[selected]> == none && <[roll]> <= <[cumulative]>:
                    - define selected <[race]>
            - flag player race:<[selected]>
            - flag player race_origin:<[selected]>
            - flag player race_tier:1
            - narrate "<&6>[Ras] <&f>Primary Race-mu: <&e><[selected]><&f>! Gunakan /race untuk melihat detail." targets:<player>
        - run race_claim_unique_slot def.player:<player> def.race:<player.flag[race]>
        - run race_set_progress def.player:<player>
        - run race_apply def.player:<player>

        on player respawns:
        - wait 1t
        - run race_apply def.player:<player>

        on player kills entity:
        - if !<player.has_flag[race]>:
            - stop
        - define action_target <context.entity.entity_type.to_lowercase>
        - run race_track_action def.player:<player> def.action_type:kill def.action_target:<[action_target]>

        on player breaks block:
        - if !<player.has_flag[race]>:
            - stop
        - define action_target <context.material.name.to_lowercase>
        - run race_track_action def.player:<player> def.action_type:break def.action_target:<[action_target]>

race_set_progress:
    type: task
    debug: false
    definitions: player
    script:
    - define tier <[player].flag[race_tier]||1>
    - define max_tier <script[race_config].data_key[maximum_tier]>
    - if <[tier]> >= <[max_tier]>:
        - flag <[player]> race_next:Tier maksimum
    - else:
        - define paths <script[race_config].data_key[evolutions]>
        - define destiny <[player].flag[race_destiny]||null>
        - if <[destiny]> != null:
            - define current <[player].flag[race]>
            - define destiny_index 0
            - define path_index 0
            - foreach <[destiny]> as:path_race:
                - define path_index:<[path_index].add[1]>
                - if <[path_race]> == <[current]>:
                    - define destiny_index <[path_index]>
            - define next_index <[destiny_index].add[1]>
            - flag <[player]> race_next:<[destiny].get[<[next_index]>]||Tier maksimum>
            - stop
        - define next <[paths].get[<[player].flag[race]>]||<list[]>>
        - flag <[player]> race_next:<[next]>

race_clear_action_progress:
    type: task
    debug: false
    definitions: player
    script:
    - define evolved <script[race_config].data_key[evolved_races]>
    - foreach <[evolved].keys> as:target:
        - define flag_name race_action_<[target]>
        - flag <[player]> <[flag_name]>:!

race_track_action:
    type: task
    debug: false
    definitions: player|action_type|action_target
    script:
    - define current <[player].flag[race]||none>
    - define paths <script[race_config].data_key[evolutions]>
    - define destiny <[player].flag[race_destiny]||null>
    - if <[destiny]> == null || !<[destiny].contains[<[current]>]>:
        - stop
    - define destiny_index 0
    - define path_index 0
    - foreach <[destiny]> as:path_race:
        - define path_index:<[path_index].add[1]>
        - if <[path_race]> == <[current]>:
            - define destiny_index <[path_index]>
    - define next_index <[destiny_index].add[1]>
    - define next_race <[destiny].get[<[next_index]>]||null>
    - define next <list[]>
    - if <[next_race]> != null:
        - define next <[next].include[<[next_race]>]>
    - foreach <[next]> as:target:
        - define next_tier <[player].flag[race_tier].add[1]>
        - run race_prepare_requirements def.player:<[player]> def.target:<[target]> def.tier:<[next_tier]>
        - define requirement_flag race_requirements_<[target]>
        - define requirements <[player].flag[<[requirement_flag]>]||null>
        - if <[requirements]> != null && <[requirements].contains[action]>:
            - define action <[requirements].get[action]>
            - if <[action].get[type]> == <[action_type]> && <[action].get[target]> == <[action_target]>:
                - define flag_name race_action_<[target]>
                - flag <[player]> <[flag_name]>:+:1

race_player_head:
    type: procedure
    debug: false
    definitions: player
    script:
    - define texture <[player].skin_blob.before[;]||>
    - if <[texture].is_truthy>:
        - determine <item[player_head].with[skull_skin=<[player].uuid>|<[texture]>|<[player].name>]>
    - determine <item[player_head]>

race_gui:
    type: task
    debug: false
    definitions: player
    script:
    - if !<[player].has_flag[race]>:
        - narrate "<&c>Kamu belum memiliki ras." targets:<[player]>
        - stop
    - define current <[player].flag[race]>
    - define tier <[player].flag[race_tier]||1>
    - define origin <[player].flag[race_origin]||<[current]>>
    - define max_tier 1
    - define destiny <[player].flag[race_destiny]||null>
    - if <[destiny]> != null:
        - define final_race <[destiny].get[<[destiny].size>]>
        - define final_profile <script[race_config].data_key[evolved_races].get[<[final_race]>]||null>
        - define max_tier <[final_profile].get[tier]||1>
    - else:
        - define evolved <script[race_config].data_key[evolved_races]>
        - foreach <[evolved].keys> as:evolved_race:
            - define evolved_profile <[evolved].get[<[evolved_race]>]>
            - if <[evolved_profile].get[origin]||none> == <[origin]>:
                - define evolved_tier <[evolved_profile].get[tier]||1>
                - if <[evolved_tier]> > <[max_tier]>:
                    - define max_tier <[evolved_tier]>
    - define tier_names <list[Primary Race|Sub-Race|Sub-Type|Final Form|Divine Form]>
    - define tier_name <[tier_names].get[<[tier]>]>
    - define profile <script[race_config].data_key[races].get[<[current]>]||null>
    - if <[profile]> == null:
        - define profile <script[race_config].data_key[evolved_races].get[<[current]>]||null>
    - define filler <item[black_stained_glass_pane].with_single[display=<&8> ]>
    - inventory open d:generic[size=27;title=Informasi<&sp>Ras]
    - foreach <list[0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26]> as:slot:
        - inventory set d:<[player].open_inventory> o:<[filler]> slot:<[slot].add[1]>
    - define head <proc[race_player_head].context[<[player]>]>
    - define profile_item <[head].with_single[display=<&e>Profil Pemain].with_single[lore=<list[<&7>Nama: <[player].name>|<&7>Ras saat ini: <[current]>|<&7><[tier_name]> (<[tier]>/<[max_tier]>)|<&8>Klik untuk melihat benefit rasmu.]>]>
    - inventory set d:<[player].open_inventory> o:<[profile_item]> slot:11
    - define races_item <item[emerald].with_single[display=<&a>Daftar Ras Awal].with_single[lore=<list[<&7>Lihat semua pilihan ras awal.|<&7>Termasuk ciri dan jalur evolusinya.|<&e>Klik untuk membuka daftar.]>]>
    - inventory set d:<[player].open_inventory> o:<[races_item]> slot:13
    - define progress_item <item[ender_eye].with_single[display=<&b>Progress Evolusi].with_single[lore=<list[<&7>Ras saat ini: <[current]>|<&7><[tier_name]> (<[tier]>/<[max_tier]>)|<&7>Lihat jalur, syarat, dan benefit yang terbuka.|<&e>Klik untuk melihat jalur ras.]>]>
    - inventory set d:<[player].open_inventory> o:<[progress_item]> slot:15
    - define coming_soon_item <item[obsidian].with_single[display=<&c>Coming Soon]>
    - inventory set d:<[player].open_inventory> o:<[coming_soon_item]> slot:17

race_gui_profile:
    type: task
    debug: false
    definitions: player
    script:
    - define current <[player].flag[race]||null>
    - if <[current]> == null:
        - narrate "<&c>Kamu belum memiliki ras." targets:<[player]>
        - stop
    - define profile <script[race_config].data_key[races].get[<[current]>]||null>
    - if <[profile]> == null:
        - define profile <script[race_config].data_key[evolved_races].get[<[current]>]||null>
    - if <[profile]> == null:
        - narrate "<&c>Data ras <[current]> tidak ditemukan." targets:<[player]>
        - stop
    - define base_profile <script[race_config].data_key[races].get[<[player].flag[race_origin]||<[current]>>]||<[profile]>>
    - define profile_health <[profile].get[health]||<[base_profile].get[health]>>
    - define profile_speed <[profile].get[speed]||<[base_profile].get[speed]>>
    - define profile_damage <[profile].get[damage]||<[base_profile].get[damage]>>
    - define profile_size <[profile].get[size]||<[base_profile].get[size]>>
    - define profile_trait <[profile].get[trait]||<[base_profile].get[trait]>>
    - define profile_fly_speed <[profile].get[fly_speed]||<[base_profile].get[fly_speed]||0.05>>
    - define profile_can_fly <[profile].get[can_fly]||<[base_profile].get[can_fly]||false>>
    - define tier <[player].flag[race_tier]||1>
    - define tier_names <list[Primary Race|Sub-Race|Sub-Type|Final Form|Divine Form]>
    - define tier_name <[tier_names].get[<[tier]>]>
    - inventory open d:generic[size=27;title=Profil<&sp>Pemain]
    - define filler <item[black_stained_glass_pane].with_single[display=<&8> ]>
    - foreach <list[0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26]> as:slot:
        - inventory set d:<[player].open_inventory> o:<[filler]> slot:<[slot].add[1]>
    - define head <proc[race_player_head].context[<[player]>]>
    - define current_display <[profile].get[display_name]||<[current].replace[_].with[<&sp>].to_titlecase>>
    - define race_item <[head].with_single[display=<&e><[current_display]>].with_single[lore=<list[<&7>Ras saat ini|<&7><[tier_name]> (<[tier]>)]>]>
    - inventory set d:<[player].open_inventory> o:<[race_item]> slot:5
    - define health_item <item[heart_of_the_sea].with_single[display=<&c>Ketahanan].with_single[lore=<list[<&7>Max HP: <[profile_health]>]>]>
    - inventory set d:<[player].open_inventory> o:<[health_item]> slot:11
    - define flight_lore "Tidak dapat terbang"
    - if <[profile_can_fly]>:
        - define flight_lore "Kecepatan terbang: <[profile_fly_speed]>"
    - define speed_item <item[sugar].with_single[display=<&b>Kecepatan].with_single[lore=<list[<&7>Kecepatan jalan: <[profile_speed]>|<&7><[flight_lore]>]>]>
    - inventory set d:<[player].open_inventory> o:<[speed_item]> slot:13
    - define damage_item <item[iron_sword].with_single[display=<&6>Serangan].with_single[lore=<list[<&7>Pengali damage: <[profile_damage]>x]>]>
    - inventory set d:<[player].open_inventory> o:<[damage_item]> slot:15
    - define size_item <item[amethyst_shard].with_single[display=<&d>Ukuran Ras].with_single[lore=<list[<&7>Ukuran: <[profile_size]>x]>]>
    - inventory set d:<[player].open_inventory> o:<[size_item]> slot:17
    - define trait_item <item[enchanted_book].with_single[display=<&5>Ciri Ras].with_single[lore=<list[<&7><[profile_trait]>]>]>
    - inventory set d:<[player].open_inventory> o:<[trait_item]> slot:23
    - define attribute_overrides <[profile].get[attribute_overrides]||<[base_profile].get[attribute_overrides]||<map[]>>>
    - define movement_attribute <[attribute_overrides].get[movement_speed]||<[profile_speed].mul[0.5]>>
    - define flying_attribute <[attribute_overrides].get[flying_speed]||<[profile_fly_speed]>>
    - define attribute_values <map[max_health=<[profile_health]>;armor=<[attribute_overrides].get[armor]||0>;armor_toughness=<[attribute_overrides].get[armor_toughness]||0>;knockback_resistance=<[attribute_overrides].get[knockback_resistance]||0>;movement_speed=<[movement_attribute]>;flying_speed=<[flying_attribute]>;jump_strength=<[attribute_overrides].get[jump_strength]||0.42>;step_height=<[attribute_overrides].get[step_height]||0.6>;gravity=<[attribute_overrides].get[gravity]||0.08>;safe_fall_distance=<[attribute_overrides].get[safe_fall_distance]||3.0>;fall_damage_multiplier=<[attribute_overrides].get[fall_damage_multiplier]||1.0>;attack_damage=<[attribute_overrides].get[attack_damage]||1.0>;attack_speed=<[attribute_overrides].get[attack_speed]||4.0>;attack_knockback=<[attribute_overrides].get[attack_knockback]||0>;submerged_mining_speed=<[attribute_overrides].get[submerged_mining_speed]||0.2>;sweeping_damage_ratio=<[attribute_overrides].get[sweeping_damage_ratio]||1.0>;block_break_speed=<[attribute_overrides].get[block_break_speed]||1.0>;entity_interaction_range=<[attribute_overrides].get[entity_interaction_range]||3.0>;block_interaction_range=<[attribute_overrides].get[block_interaction_range]||4.5>;luck=<[attribute_overrides].get[luck]||0>;scale=<[attribute_overrides].get[scale]||<[profile_size]>>;mining_efficiency=<[attribute_overrides].get[mining_efficiency]||0>;sneaking_speed=<[attribute_overrides].get[sneaking_speed]||0.3>]>
    - define attribute_defaults <map[max_health=20;armor=0;armor_toughness=0;knockback_resistance=0;movement_speed=0.1;flying_speed=0.05;jump_strength=0.42;step_height=0.6;gravity=0.08;safe_fall_distance=3;fall_damage_multiplier=1;attack_damage=1;attack_speed=4;attack_knockback=0;submerged_mining_speed=0.2;sweeping_damage_ratio=1;block_break_speed=1;entity_interaction_range=3;block_interaction_range=4.5;luck=0;scale=1;mining_efficiency=0;sneaking_speed=0.3]>
    - define attribute_labels <map[max_health=Max health;armor=Armor;armor_toughness=Armor toughness;knockback_resistance=Knockback resistance;movement_speed=Movement speed;flying_speed=Flying speed;jump_strength=Jump strength;step_height=Step height;gravity=Gravity;safe_fall_distance=Safe fall distance;fall_damage_multiplier=Fall damage multiplier;attack_damage=Attack damage;attack_speed=Attack speed;attack_knockback=Attack knockback;submerged_mining_speed=Submerged mining speed;sweeping_damage_ratio=Sweeping damage ratio;block_break_speed=Block break speed;entity_interaction_range=Entity interaction range;block_interaction_range=Block interaction range;luck=Luck;scale=Scale;mining_efficiency=Mining efficiency;sneaking_speed=Sneaking speed]>
    - define attribute_lore <list[]>
    - foreach <[attribute_values].keys> as:attribute:
        - define difference <[attribute_values].get[<[attribute]>].sub[<[attribute_defaults].get[<[attribute]>]>]>
        - if <[difference]> != 0:
            - define difference_display <[difference]>
            - if <[difference]> > 0:
                - define difference_display +<[difference]>
            - define attribute_label <[attribute_labels].get[<[attribute]>]>
            - define attribute_lore <[attribute_lore].include[<&7><[attribute_label]>: <[difference_display]>]>
    - define attribute_item <item[book].with_single[display=<&b>Atribut Ras].with_single[lore=<[attribute_lore]>]>
    - inventory set d:<[player].open_inventory> o:<[attribute_item]> slot:25
    - define back_item <item[arrow].with_single[display=<&c>Kembali].with_single[lore=<list[<&7>Kembali ke informasi ras.]>]>
    - inventory set d:<[player].open_inventory> o:<[back_item]> slot:27

race_gui_races:
    type: task
    debug: false
    definitions: player
    script:
    - define race_data <script[race_config].data_key[races]>
    - define race_slots <list[12|14|16|21|23|25|30|32|34|39|41|43]>
    - define race_names <list[goblin|human|elf|orc|dwarf|beastkin|undead|demonkin|dragonkin|fae|angel|merfolk]>
    - define filler <item[black_stained_glass_pane].with_single[display=<&8> ]>
    - inventory open d:generic[size=54;title=Daftar<&sp>Ras<&sp>Awal]
    - foreach <list[0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36|37|38|39|40|41|42|43|44|45|46|47|48|49|50|51|52|53]> as:slot:
        - inventory set d:<[player].open_inventory> o:<[filler]> slot:<[slot].add[1]>
    - flag <[player]> race_gui_catalog:true
    - define index 1
    - foreach <[race_names]> as:race:
        - define slot <[race_slots].get[<[index]>]>
        - define profile <[race_data].get[<[race]>]>
        - define icon <script[race_config].data_key[race_icons].get[<[race]>]||emerald>
        - define race_display <[race].replace[_].with[<&sp>].to_titlecase>
        - define flight_lore "Tidak dapat terbang"
        - if <[profile].get[can_fly]||false>:
            - define flight_lore "Kecepatan terbang: <[profile].get[fly_speed]>"
        - flag <[player]> race_gui_target_<[slot]>:<[race]>
        - define race_item <item[<[icon]>].with_single[display=<&a><[race_display]>].with_single[lore=<list[<&7>Ras awal|<&7>Max HP: <[profile].get[health]>|<&7>Kecepatan jalan: <[profile].get[speed]>|<&7><[flight_lore]>|<&7>Damage: <[profile].get[damage]>x|<&7>Ciri: <[profile].get[trait]>|<&e>Klik untuk melihat jalur evolusi.]>]>
        - inventory set d:<[player].open_inventory> o:<[race_item]> slot:<[slot]>
        - define index:<[index].add[1]>
    - define back_item <item[arrow].with_single[display=<&c>Kembali].with_single[lore=<list[<&7>Kembali ke menu informasi ras.]>]>
    - inventory set d:<[player].open_inventory> o:<[back_item]> slot:50

race_gui_progress:
    type: task
    debug: false
    definitions: player
    script:
    - if !<[player].has_flag[race]>:
        - narrate "<&c>Kamu belum memiliki ras." targets:<[player]>
        - stop
    - define origin <[player].flag[race_origin]||<[player].flag[race]>>
    - run race_open_path def.player:<[player]> def.origin:<[origin]> def.catalog:false

race_open_path:
    type: task
    debug: false
    definitions: player|origin|catalog
    script:
    - run race_show_path def.player:<[player]> def.origin:<[origin]> def.catalog:<[catalog]>

race_show_path:
    type: task
    debug: false
    definitions: player|origin|catalog
    script:
    - define paths <script[race_config].data_key[evolutions]>
    - define stage_ids <list[<[origin]>]>
    - define third_stage_ids <list[]>
    - define fourth_stage_ids <list[]>
    - define fifth_stage_ids <list[]>
    - define first_options <[paths].get[<[origin]>]||<list[]>>
    - foreach <[first_options]> as:branch:
        - define stage_ids <[stage_ids].include[<[branch]>]>
        - foreach <[paths].get[<[branch]>]||<list[]>> as:third_stage:
            - if !<[third_stage_ids].contains[<[third_stage]>]>:
                - define third_stage_ids <[third_stage_ids].include[<[third_stage]>]>
            - foreach <[paths].get[<[third_stage]>]||<list[]>> as:fourth_stage:
                - if !<[fourth_stage_ids].contains[<[fourth_stage]>]>:
                    - define fourth_stage_ids <[fourth_stage_ids].include[<[fourth_stage]>]>
                - foreach <[paths].get[<[fourth_stage]>]||<list[]>> as:fifth_stage:
                    - if !<[fifth_stage_ids].contains[<[fifth_stage]>]>:
                        - define fifth_stage_ids <[fifth_stage_ids].include[<[fifth_stage]>]>
    - foreach <[third_stage_ids]> as:third_stage:
        - define stage_ids <[stage_ids].include[<[third_stage]>]>
    - foreach <[fourth_stage_ids]> as:fourth_stage:
        - define stage_ids <[stage_ids].include[<[fourth_stage]>]>
    - foreach <[fifth_stage_ids]> as:fifth_stage:
        - define stage_ids <[stage_ids].include[<[fifth_stage]>]>
    - define profiles <script[race_config].data_key[races]>
    - define evolved <script[race_config].data_key[evolved_races]>
    - define current <[player].flag[race]||none>
    - define current_tier <[player].flag[race_tier]||1>
    - define tier_names <list[Primary Race|Sub-Race|Sub-Type|Final Form|Divine Form]>
    - define stage_slots <list[14|21|25|30|34|39|41|43]>
    - define destiny <[player].flag[race_destiny]||null>
    - define path_destined false
    - if !<[catalog]> && <[destiny]> != null:
        - if <[destiny].contains[<[origin]>]>:
            - define stage_ids <[destiny]>
            - define path_destined true
            - define stage_slots <list[18|20|22|24|26]>
            - if <[stage_ids].size> == 4:
                - define stage_slots <list[19|21|23|25]>
            - else if <[stage_ids].size> == 3:
                - define stage_slots <list[20|22|24]>
            - else if <[stage_ids].size> == 2:
                - define stage_slots <list[21|23]>
            - else if <[stage_ids].size> == 1:
                - define stage_slots <list[22]>
    - if !<[catalog]> && !<[path_destined]>:
        - define stage_ids <list[<[origin]>]>
        - foreach <[first_options]> as:branch:
            - define stage_ids <[stage_ids].include[<[branch]>]>
        - define stage_slots <list[13|21|23]>
        - if <[stage_ids].size> == 2:
            - define stage_slots <list[13|22]>
        - else if <[stage_ids].size> == 4:
            - define stage_slots <list[13|20|22|24]>
    - foreach <list[13|14|18|19|20|21|22|23|24|25|26|27|28|30|34|39|41|43]> as:slot:
        - flag <[player]> race_gui_target_<[slot]>:!
    - flag <[player]> race_gui_origin:<[origin]>
    - flag <[player]> race_gui_catalog:<[catalog]>
    - inventory open d:generic[size=45;title=Jalur<&sp>Evolusi<&sp>Ras]
    - define filler <item[black_stained_glass_pane].with_single[display=<&8> ]>
    - foreach <list[0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36|37|38|39|40|41|42|43|44]> as:slot:
        - inventory set d:<[player].open_inventory> o:<[filler]> slot:<[slot].add[1]>
    - define next_stages <[player].flag[race_next]||<list[]>>
    - define stage_index 1
    - foreach <[stage_ids]> as:stage:
        - define profile <[profiles].get[<[stage]>]||null>
        - if <[profile]> == null:
            - define profile <[evolved].get[<[stage]>]||null>
        - define stage_origin <[profile].get[origin]||<[origin]>>
        - define base_profile <[profiles].get[<[stage_origin]>]||<[profile]>>
        - define stage_health <[profile].get[health]||<[base_profile].get[health]>>
        - define stage_speed <[profile].get[speed]||<[base_profile].get[speed]>>
        - define stage_damage <[profile].get[damage]||<[base_profile].get[damage]>>
        - define stage_size <[profile].get[size]||<[base_profile].get[size]>>
        - define stage_trait <[profile].get[trait]||<[base_profile].get[trait]>>
        - define stage_tier <[profile].get[tier]||1>
        - define stage_label <[tier_names].get[<[stage_tier]>]>
        - define stage_display <[profile].get[display_name]||<[stage].replace[_].with[<&sp>].to_titlecase>>
        - define stage_parent null
        - foreach <[stage_ids]> as:possible_parent:
            - if <[stage_parent]> == null:
                - if <[paths].get[<[possible_parent]>]||<list[]>>.contains[<[stage]>]:
                    - define stage_parent <[possible_parent]>
        - define reached false
        - if <[stage]> == <[origin]>:
            - define reached true
        - if !<[catalog]> && <[path_destined]>:
            - define current_path_index 0
            - define path_scan_index 0
            - foreach <[stage_ids]> as:path_stage:
                - define path_scan_index:<[path_scan_index].add[1]>
                - if <[path_stage]> == <[current]>:
                    - define current_path_index <[path_scan_index]>
            - if <[current_path_index]> > 0 && <[stage_index]> <= <[current_path_index]>:
                - define reached true
        - else if !<[catalog]> && <[player].flag[race_origin]||none> == <[origin]>:
            - if <[stage]> == <[current]>:
                - define reached true
            - foreach <[paths].get[<[stage]>]||<list[]>> as:next_stage:
                - if <[next_stage]> == <[current]>:
                    - define reached true
                - foreach <[paths].get[<[next_stage]>]||<list[]>> as:third_stage:
                    - if <[third_stage]> == <[current]>:
                        - define reached true
                    - foreach <[paths].get[<[third_stage]>]||<list[]>> as:fourth_stage:
                        - if <[fourth_stage]> == <[current]>:
                            - define reached true
        - define lore <list[<&7><[stage_label]>: <[stage_display]>]>
        - if <[stage]> != <[origin]>:
            - define origin_display <[origin].replace[_].with[<&sp>].to_titlecase>
            - if <[stage_parent]> != null:
                - define parent_profile <[profiles].get[<[stage_parent]>]||<[evolved].get[<[stage_parent]>]||null>>
                - define parent_display <[parent_profile].get[display_name]||<[stage_parent].replace[_].with[<&sp>].to_titlecase>>
                - define parent_tier <[parent_profile].get[tier]||<[stage_tier].sub[1]>>
                - define lore <[lore].include[<&7>Jalur Setelah: Tier <[parent_tier]>: <[parent_display]>]>
            - else:
                - define lore <[lore].include[<&c>Syarat ras belum dikonfigurasi.]>
        - if <[reached]>:
            - if <[stage]> == <[current]>:
                - define lore <[lore].include[<&a>Ras saat ini]>
            - else:
                - define lore <[lore].include[<&a>Benefit terbuka]>
            - define lore <[lore].include[<&7>Max HP: <[stage_health]>]>
            - define lore <[lore].include[<&7>Kecepatan jalan: <[stage_speed]>]>
            - if <[profile].get[can_fly]||<[base_profile].get[can_fly]||false>>:
                - define lore <[lore].include[<&7>Kecepatan terbang: <[profile].get[fly_speed]||<[base_profile].get[fly_speed]>>]>
            - define lore <[lore].include[<&7>Damage: <[stage_damage]>x]>
            - define lore <[lore].include[<&7>Ukuran: <[stage_size]>x]>
            - define lore <[lore].include[<&7>Ciri: <[stage_trait]>]>
        - else:
            - define lore <[lore].include[<&c>Belum dicapai]>
            - define is_next_stage false
            - foreach <[next_stages]> as:next_stage:
                - if <[next_stage]> == <[stage]>:
                    - define is_next_stage true
            - if <[is_next_stage]>:
                - define lore <[lore].include[<&e>Klik untuk melihat syarat evolusi berikutnya.]>
        - if <[stage_index]> <= <[stage_slots].size>:
            - define icon <script[race_config].data_key[race_icons].get[<[stage]>]||emerald>
            - define stage_item <item[<[icon]>].with_single[display=<&b><[stage_display]>].with_single[lore=<[lore]>]>
            - define stage_slot <[stage_slots].get[<[stage_index]>]>
            - flag <[player]> race_gui_target_<[stage_slot]>:<[stage]>
            - inventory set d:<[player].open_inventory> o:<[stage_item]> slot:<[stage_slot]>
            - if <[path_destined]> && <[stage_index]> < <[stage_ids].size>:
                - define path_arrow <item[gray_stained_glass_pane].with_single[display=<&8>→]>
                - inventory set d:<[player].open_inventory> o:<[path_arrow]> slot:<[stage_slot].add[1]>
        - define stage_index:<[stage_index].add[1]>
    - define back_item <item[arrow].with_single[display=<&c>Kembali].with_single[lore=<list[<&7>Kembali ke GUI ras.]>]>
    - inventory set d:<[player].open_inventory> o:<[back_item]> slot:44

race_open_stage_details:
    type: task
    debug: false
    definitions: player|origin|selected|catalog
    script:
    - if <[catalog]>:
        - narrate "<&c>Detail evolusi ras lain tidak dapat dilihat." targets:<[player]>
        - stop
    - define next_stages <[player].flag[race_next]||<list[]>>
    - define allowed_next false
    - foreach <[next_stages]> as:next_stage:
        - if <[next_stage]> == <[selected]>:
            - define allowed_next true
    - if !<[allowed_next]>:
        - narrate "<&c>Kamu hanya dapat melihat syarat evolusi berikutnya." targets:<[player]>
        - stop
    - define paths <script[race_config].data_key[evolutions]>
    - define profiles <script[race_config].data_key[races]>
    - define evolved <script[race_config].data_key[evolved_races]>
    - define selected_profile <[profiles].get[<[selected]>]||<[evolved].get[<[selected]>]||null>>
    - define selected_tier <[selected_profile].get[tier]||1>
    - define first_options <[paths].get[<[origin]>]||<list[]>>
    - define stage_two <[first_options].get[1]||null>
    - define stage_three null
    - define stage_four null
    - define stage_five null
    - if <[selected_tier]> == 1 && <[stage_two]> != null:
        - define stage_three <[paths].get[<[stage_two]>].get[1]||null>
        - if <[stage_three]> != null:
            - define stage_four <[paths].get[<[stage_three]>].get[1]||null>
    - if <[selected_tier]> == 2:
        - define stage_two <[selected]>
        - define stage_three <[paths].get[<[stage_two]>].get[1]||null>
        - if <[stage_three]> != null:
            - define stage_four <[paths].get[<[stage_three]>].get[1]||null>
    - if <[selected_tier]> == 3:
        - foreach <[first_options]> as:option:
            - if <[paths].get[<[option]>]||<list[]>>.contains[<[selected]>]:
                - define stage_two <[option]>
                - define stage_three <[selected]>
                - define stage_four <[paths].get[<[selected]>].get[1]||null>
    - if <[selected_tier]> == 4:
        - foreach <[first_options]> as:option:
            - foreach <[paths].get[<[option]>]||<list[]>> as:third_stage:
                - if <[paths].get[<[third_stage]>]||<list[]>>.contains[<[selected]>]:
                    - define stage_two <[option]>
                    - define stage_three <[third_stage]>
                    - define stage_four <[selected]>
    - if <[selected_tier]> == 5:
        - foreach <[first_options]> as:option:
            - foreach <[paths].get[<[option]>]||<list[]>> as:third_stage:
                - foreach <[paths].get[<[third_stage]>]||<list[]>> as:fourth_stage:
                    - if <[paths].get[<[fourth_stage]>]||<list[]>>.contains[<[selected]>]:
                        - define stage_two <[option]>
                        - define stage_three <[third_stage]>
                        - define stage_four <[fourth_stage]>
                        - define stage_five <[selected]>
    - define destiny <[player].flag[race_destiny]||null>
    - if !<[catalog]> && <[destiny]> != null && <[destiny].contains[<[selected]>]>:
        - define stage_two <[destiny].get[2]||null>
        - define stage_three <[destiny].get[3]||null>
        - define stage_four <[destiny].get[4]||null>
        - define stage_five <[destiny].get[5]||null>
    - if <[stage_two]> == null:
        - narrate "<&c>[Ras] Jalur evolusi untuk <[selected]> tidak lengkap." targets:<[player]>
        - stop
    - run race_show_details def.player:<[player]> def.origin:<[origin]> def.stage_two:<[stage_two]> def.stage_three:<[stage_three]> def.stage_four:<[stage_four]> def.stage_five:<[stage_five]> def.selected:<[selected]> def.catalog:<[catalog]>

race_show_details:
    type: task
    debug: false
    definitions: player|origin|stage_two|stage_three|stage_four|stage_five|selected|catalog
    script:
    - define paths <script[race_config].data_key[evolutions]>
    - define profiles <script[race_config].data_key[races]>
    - define evolved <script[race_config].data_key[evolved_races]>
    - define profile <[profiles].get[<[selected]>]||null>
    - if <[profile]> == null:
        - define profile <[evolved].get[<[selected]>]||null>
    - if <[profile]> == null:
        - narrate "<&c>Data ras <[selected]> tidak ditemukan." targets:<[player]>
        - stop
    - define profile_origin <[profile].get[origin]||<[origin]>>
    - define base_profile <[profiles].get[<[profile_origin]>]||<[profile]>>
    - define profile_health <[profile].get[health]||<[base_profile].get[health]>>
    - define profile_speed <[profile].get[speed]||<[base_profile].get[speed]>>
    - define profile_damage <[profile].get[damage]||<[base_profile].get[damage]>>
    - define profile_size <[profile].get[size]||<[base_profile].get[size]>>
    - define profile_trait <[profile].get[trait]||<[base_profile].get[trait]>>
    - define selected_tier <[profile].get[tier]||1>
    - define current_tier <[player].flag[race_tier]||1>
    - define reached false
    - if <[selected]> == <[origin]>:
        - define reached true
    - if <[selected]> == <[player].flag[race]||none>:
        - define reached true
    - define stage_ids <list[<[origin]>]>
    - if <[stage_two]> != null:
        - define stage_ids <[stage_ids].include[<[stage_two]>]>
    - if <[stage_three]> != null:
        - define stage_ids <[stage_ids].include[<[stage_three]>]>
    - if <[stage_four]> != null:
        - define stage_ids <[stage_ids].include[<[stage_four]>]>
    - if <[stage_five]> != null:
        - define stage_ids <[stage_ids].include[<[stage_five]>]>
    - define current_index 0
    - define selected_index 0
    - define path_index 0
    - foreach <[stage_ids]> as:path_stage:
        - define path_index:<[path_index].add[1]>
        - if <[path_stage]> == <[player].flag[race]||none>:
            - define current_index <[path_index]>
        - if <[path_stage]> == <[selected]>:
            - define selected_index <[path_index]>
    - if <[current_index]> > 0 && <[selected_index]> > 0 && <[selected_index]> <= <[current_index]>:
        - define reached true
    - flag <[player]> race_gui_origin:<[origin]>
    - flag <[player]> race_gui_stage_two:<[stage_two]>
    - flag <[player]> race_gui_stage_three:<[stage_three]>
    - flag <[player]> race_gui_stage_four:<[stage_four]>
    - flag <[player]> race_gui_stage_five:<[stage_five]>
    - flag <[player]> race_gui_catalog:<[catalog]>
    - foreach <list[9|10|11|12|13|14|15|16|17|18]> as:slot:
        - flag <[player]> race_gui_target_<[slot]>:!
    - inventory open d:generic[size=54;title=Detail<&sp>Evolusi<&sp>Ras]
    - define filler <item[black_stained_glass_pane].with_single[display=<&8> ]>
    - foreach <list[0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36|37|38|39|40|41|42|43|44|45|46|47|48|49|50|51|52|53]> as:slot:
        - inventory set d:<[player].open_inventory> o:<[filler]> slot:<[slot].add[1]>
    - define target_display <[profile].get[display_name]||<[selected].replace[_].with[<&sp>].to_titlecase>>
    - define target_icon <script[race_config].data_key[race_icons].get[<[selected]>]||emerald>
    - define stage_slots <list[9|11|13|15|17]>
    - if <[stage_ids].size> == 4:
        - define stage_slots <list[10|12|14|16]>
    - else if <[stage_ids].size> == 3:
        - define stage_slots <list[11|13|15]>
    - else if <[stage_ids].size> == 2:
        - define stage_slots <list[12|14]>
    - else if <[stage_ids].size> == 1:
        - define stage_slots <list[13]>
    - define stage_index 1
    - foreach <[stage_ids]> as:stage:
        - define stage_profile <[profiles].get[<[stage]>]||null>
        - if <[stage_profile]> == null:
            - define stage_profile <[evolved].get[<[stage]>]||<map[trait=Tidak diketahui|health=20|speed=0.2|damage=1|size=1]>>
        - define stage_origin <[stage_profile].get[origin]||<[origin]>>
        - define base_stage_profile <[profiles].get[<[stage_origin]>]||<[stage_profile]>>
        - define stage_health <[stage_profile].get[health]||<[base_stage_profile].get[health]>>
        - define stage_speed <[stage_profile].get[speed]||<[base_stage_profile].get[speed]>>
        - define stage_damage <[stage_profile].get[damage]||<[base_stage_profile].get[damage]>>
        - define stage_fly_speed <[stage_profile].get[fly_speed]||<[base_stage_profile].get[fly_speed]||0.05>>
        - define stage_slot <[stage_slots].get[<[stage_index]>]>
        - define icon <script[race_config].data_key[race_icons].get[<[stage]>]||emerald>
        - define stage_display <[stage_profile].get[display_name]||<[stage].replace[_].with[<&sp>].to_titlecase>>
        - define stage_lore <list[<&7>Tier: <[stage_profile].get[tier]||1>]>
        - if <[stage_index]> <= <[current_index]> && <[current_index]> > 0:
            - define stage_lore <[stage_lore].include[<&7>Max HP: <[stage_health]>]>
            - define stage_lore <[stage_lore].include[<&7>Kecepatan jalan: <[stage_speed]>]>
            - define stage_lore <[stage_lore].include[<&7>Damage: <[stage_damage]>x]>
            - if <[stage_profile].get[can_fly]||<[base_stage_profile].get[can_fly]||false>>:
                - define stage_lore <[stage_lore].include[<&7>Kecepatan terbang: <[stage_fly_speed]>]>
        - if <[stage]> != <[origin]>:
            - define parent_index <[stage_index].sub[1]>
            - define stage_parent <[stage_ids].get[<[parent_index]>]||null>
            - if <[stage_parent]> != null:
                - define parent_profile <[profiles].get[<[stage_parent]>]||<[evolved].get[<[stage_parent]>]||null>>
                - define parent_display <[parent_profile].get[display_name]||<[stage_parent].replace[_].with[<&sp>].to_titlecase>>
                - define parent_tier <[parent_profile].get[tier]||<[parent_index]>>
                - define stage_lore <[stage_lore].include[<&7>Jalur Setelah: Tier <[parent_tier]>: <[parent_display]>]>
            - else:
                - define stage_lore <[stage_lore].include[<&c>Syarat ras belum dikonfigurasi.]>
        - flag <[player]> race_gui_target_<[stage_slot]>:<[stage]>
        - define stage_reached false
        - if <[stage_index]> <= <[current_index]> && <[current_index]> > 0:
            - define stage_reached true
        - if <[stage_reached]>:
            - define stage_item <item[<[icon]>].with_single[display=<&e>Tier <[stage_index]>: <[stage_display]>].with_single[lore=<[stage_lore].include[<&a>Sudah dicapai].include[<&e>Klik untuk melihat benefit.]>]>
        - else:
            - define stage_item <item[<[icon]>].with_single[display=<&c>Tier <[stage_index]>: <[stage_display]>].with_single[lore=<[stage_lore].include[<&c>Belum dicapai].include[<&e>Klik untuk melihat syarat.]>]>
        - inventory set d:<[player].open_inventory> o:<[stage_item]> slot:<[stage_slot].add[1]>
        - if <[stage_index]> < <[stage_ids].size>:
            - define path_arrow <item[gray_stained_glass_pane].with_single[display=<&8>→]>
            - inventory set d:<[player].open_inventory> o:<[path_arrow]> slot:<[stage_slot].add[2]>
        - define stage_index:<[stage_index].add[1]>
    - define back_item <item[arrow].with_single[display=<&c>Kembali].with_single[lore=<list[<&7>Kembali ke menu informasi ras.]>]>
    - inventory set d:<[player].open_inventory> o:<[back_item]> slot:50
    - if <[reached]>:
        - define next_races <script[race_config].data_key[evolutions].get[<[selected]>]||<list[]>>
        - define destiny <[player].flag[race_destiny]||null>
        - if <[destiny]> != null && <[destiny].contains[<[selected]>]>:
            - define next_index <[selected_index].add[1]>
            - define destined_next <[destiny].get[<[next_index]>]||null>
            - if <[destined_next]> != null:
                - define next_races <list[<[destined_next]>]>
        - define next_display <[next_races].comma_separated||Tidak ada>
        - define benefit_slots <list[28|30|32|34|36|38|40|42|44]>
        - define benefit_items <list[heart_of_the_sea|sugar|iron_sword|amethyst_shard|enchanted_book|compass|nether_star|ender_pearl|golden_carrot]>
        - define benefit_names <list[Ketahanan|Kecepatan|Serangan|Ukuran ras|Ciri ras|Garis keturunan|Tingkat|Evolusi berikutnya|Status]>
        - define lineage_lore "<&7>Ras ini adalah ras utama."
        - if <[selected_tier]> > 1:
            - define primary_display <[origin].replace[_].with[<&sp>].to_titlecase>
            - define lineage_lore "<&7>Ras utama: <[primary_display]>"
        - define benefit_lore <list[<&7>Max HP: <[profile_health]>|<&7>Kecepatan jalan: <[profile_speed]>|<&7>Pengali damage: <[profile_damage]>x|<&7>Ukuran karakter: <[profile_size]>x.|<&7><[profile_trait]>; deskripsi, bukan skill otomatis.|<[lineage_lore]>|<&7>Tier ras ini: <[selected_tier]>|<&7><[next_display]>|<&a>Benefit ras ini sudah dimiliki.]>
        - define benefit_index 1
        - foreach <[benefit_slots]> as:slot:
            - define item_type <[benefit_items].get[<[benefit_index]>]>
            - define item_name <[benefit_names].get[<[benefit_index]>]>
            - define lore_line <[benefit_lore].get[<[benefit_index]>]>
            - define benefit_item <item[<[item_type]>].with_single[display=<&b><[item_name]>].with_single[lore=<list[<[lore_line]>]>]>
            - inventory set d:<[player].open_inventory> o:<[benefit_item]> slot:<[slot].add[1]>
            - define benefit_index:<[benefit_index].add[1]>
    - else:
        - run race_prepare_requirements def.player:<[player]> def.target:<[selected]> def.tier:<[selected_tier]>
        - define requirement_flag race_requirements_<[selected]>
        - define requirements <[player].flag[<[requirement_flag]>]||null>
        - define xp_cost <[requirements].get[xp_levels]||<[requirements].get[XP_LEVELS]||0>>
        - define xp_item <item[experience_bottle].with_single[display=<&b>Syarat XP].with_single[lore=<list[<&7>Level yang dibutuhkan: <[xp_cost]>|<&7>Level saat ini: <[player].xp_level>]>]>
        - inventory set d:<[player].open_inventory> o:<[xp_item]> slot:29
        - if <[requirements]> != null:
            - define materials <[requirements].get[materials]||<[requirements].get[MATERIALS]||<map[]>>>
            - define material_slots <list[29|30|31|32|33|34|35|36|37|38|39|40|41|42|43|44|45|46]>
            - define material_index 1
            - foreach <[materials].keys> as:material:
                - if <[material_index]> <= <[material_slots].size>:
                    - define material_slot <[material_slots].get[<[material_index]>]>
                    - define required <[materials].get[<[material]>]>
                    - define material_id <[material].to_lowercase>
                    - define owned <[player].inventory.quantity_item[<[material_id]>]>
                    - define material_item <item[<[material_id]>].with_single[display=<&e><[material]>].with_single[lore=<list[<&7>Dibutuhkan: <[required]>|<&7>Dimiliki: <[owned]>|<&e>Syarat evolusi.]>]>
                    - inventory set d:<[player].open_inventory> o:<[material_item]> slot:<[material_slot].add[1]>
                - define material_index:<[material_index].add[1]>
            - define action_line "Tidak ada objective tambahan."
            - define action <[requirements].get[action]||<[requirements].get[ACTION]||null>>
            - if <[action]> != null:
                - define action_flag race_action_<[selected]>
                - define action_progress <[player].flag[<[action_flag]>]||0>
                - define action_label <[action].get[label]||<[action].get[LABEL]||null>>
                - if <[action_label]> == null:
                    - define action_type <[action].get[type]||<[action].get[TYPE]||objective>>
                    - define action_target <[action].get[target]||<[action].get[TARGET]||>>
                    - define action_label <[action_type]> <[action_target]>
                - define action_amount <[action].get[amount]||<[action].get[AMOUNT]||0>>
                - define action_line "<[action_label]> (<[action_progress]>/<[action_amount]>)"
            - define action_item <item[paper].with_single[display=<&d>Objective].with_single[lore=<list[<&7><[action_line]>]>]>
            - inventory set d:<[player].open_inventory> o:<[action_item]> slot:48
            - define next_tier <[selected_tier]>
            - define chance_key tier_<[next_tier]>
            - define default_chance <script[race_config].data_key[gacha_chances].get[<[chance_key]>]||10>
            - define chance <[requirements].get[success_chance]||<[requirements].get[SUCCESS_CHANCE]||<[default_chance]>>>
            - define chance_item <item[clock].with_single[display=<&6>Peluang Evolusi].with_single[lore=<list[<&7>Peluang berhasil: <[chance]>%]>]>
            - inventory set d:<[player].open_inventory> o:<[chance_item]> slot:49
            - define failure_item <item[barrier].with_single[display=<&c>Risiko Evolusi].with_single[lore=<list[<&7>Jika gagal, biaya dan progress objective dikorbankan.]>]>
            - inventory set d:<[player].open_inventory> o:<[failure_item]> slot:53
            - define required_race null
            - foreach <[stage_ids]> as:possible_parent:
                - if <[required_race]> == null:
                    - if <[paths].get[<[possible_parent]>]||<list[]>>.contains[<[selected]>]:
                        - define required_race <[possible_parent]>
            - define required_race_display <[required_race].replace[_].with[<&sp>].to_titlecase>
            - define status_item <item[book].with_single[display=<&e>Syarat ras: <[required_race_display]>].with_single[lore=<list[<&7>Ras saat ini: <[player].flag[race]||belum ada>|<&8>Semua syarat harus terpenuhi.]>]>
            - inventory set d:<[player].open_inventory> o:<[status_item]> slot:54
        - else:
            - define missing_item <item[barrier].with_single[display=<&c>Syarat ras: tidak tersedia].with_single[lore=<list[<&7>Persyaratan evolusi belum dapat dibuat.]>]>
            - inventory set d:<[player].open_inventory> o:<[missing_item]> slot:54

race_apply_attributes:
    type: task
    debug: false
    definitions: player|profile|health|speed|size|fly_speed
    script:
    - define overrides <[profile].get[attribute_overrides]||<map[]>>
    - define movement_speed <[overrides].get[movement_speed]||<[speed].mul[0.5]>>
    - define flying_speed <[overrides].get[flying_speed]||<[fly_speed]>>
    - if <[player].has_attribute[minecraft:max_health]>:
        - adjust <[player]> attribute_base_values:<map[minecraft:max_health=<[health]>]>
    - if <[player].has_attribute[minecraft:armor]>:
        - adjust <[player]> attribute_base_values:<map[minecraft:armor=<[overrides].get[armor]||0>]> 
    - if <[player].has_attribute[minecraft:armor_toughness]>:
        - adjust <[player]> attribute_base_values:<map[minecraft:armor_toughness=<[overrides].get[armor_toughness]||0>]>
    - if <[player].has_attribute[minecraft:knockback_resistance]>:
        - adjust <[player]> attribute_base_values:<map[minecraft:knockback_resistance=<[overrides].get[knockback_resistance]||0>]>
    - if <[player].has_attribute[minecraft:movement_speed]>:
        - adjust <[player]> attribute_base_values:<map[minecraft:movement_speed=<[movement_speed]>]>
    - if <[player].has_attribute[minecraft:flying_speed]>:
        - adjust <[player]> attribute_base_values:<map[minecraft:flying_speed=<[flying_speed]>]>
    - if <[player].has_attribute[minecraft:jump_strength]>:
        - adjust <[player]> attribute_base_values:<map[minecraft:jump_strength=<[overrides].get[jump_strength]||0.42>]>
    - if <[player].has_attribute[minecraft:step_height]>:
        - adjust <[player]> attribute_base_values:<map[minecraft:step_height=<[overrides].get[step_height]||0.6>]>
    - if <[player].has_attribute[minecraft:gravity]>:
        - adjust <[player]> attribute_base_values:<map[minecraft:gravity=<[overrides].get[gravity]||0.08>]>
    - if <[player].has_attribute[minecraft:safe_fall_distance]>:
        - adjust <[player]> attribute_base_values:<map[minecraft:safe_fall_distance=<[overrides].get[safe_fall_distance]||3.0>]>
    - if <[player].has_attribute[minecraft:fall_damage_multiplier]>:
        - adjust <[player]> attribute_base_values:<map[minecraft:fall_damage_multiplier=<[overrides].get[fall_damage_multiplier]||1.0>]>
    - if <[player].has_attribute[minecraft:attack_damage]>:
        - adjust <[player]> attribute_base_values:<map[minecraft:attack_damage=<[overrides].get[attack_damage]||1.0>]>
    - if <[player].has_attribute[minecraft:attack_speed]>:
        - adjust <[player]> attribute_base_values:<map[minecraft:attack_speed=<[overrides].get[attack_speed]||4.0>]>
    - if <[player].has_attribute[minecraft:attack_knockback]>:
        - adjust <[player]> attribute_base_values:<map[minecraft:attack_knockback=<[overrides].get[attack_knockback]||0>]>
    - if <[player].has_attribute[minecraft:submerged_mining_speed]>:
        - adjust <[player]> attribute_base_values:<map[minecraft:submerged_mining_speed=<[overrides].get[submerged_mining_speed]||0.2>]>
    - if <[player].has_attribute[minecraft:sweeping_damage_ratio]>:
        - adjust <[player]> attribute_base_values:<map[minecraft:sweeping_damage_ratio=<[overrides].get[sweeping_damage_ratio]||1.0>]>
    - if <[player].has_attribute[minecraft:block_break_speed]>:
        - adjust <[player]> attribute_base_values:<map[minecraft:block_break_speed=<[overrides].get[block_break_speed]||1.0>]>
    - if <[player].has_attribute[minecraft:entity_interaction_range]>:
        - adjust <[player]> attribute_base_values:<map[minecraft:entity_interaction_range=<[overrides].get[entity_interaction_range]||3.0>]>
    - if <[player].has_attribute[minecraft:block_interaction_range]>:
        - adjust <[player]> attribute_base_values:<map[minecraft:block_interaction_range=<[overrides].get[block_interaction_range]||4.5>]>
    - if <[player].has_attribute[minecraft:luck]>:
        - adjust <[player]> attribute_base_values:<map[minecraft:luck=<[overrides].get[luck]||0>]>
    - if <[player].has_attribute[minecraft:scale]>:
        - adjust <[player]> attribute_base_values:<map[minecraft:scale=<[overrides].get[scale]||<[size]>>]>
    - if <[player].has_attribute[minecraft:mining_efficiency]>:
        - adjust <[player]> attribute_base_values:<map[minecraft:mining_efficiency=<[overrides].get[mining_efficiency]||0>]>
    - if <[player].has_attribute[minecraft:sneaking_speed]>:
        - adjust <[player]> attribute_base_values:<map[minecraft:sneaking_speed=<[overrides].get[sneaking_speed]||0.3>]>

race_apply:
    type: task
    debug: false
    definitions: player
    script:
    - define race <[player].flag[race]||null>
    - if <[race]> == null:
        - stop
    - define profile <script[race_config].data_key[races].get[<[race]>]||null>
    - if <[profile]> == null:
        - define profile <script[race_config].data_key[evolved_races].get[<[race]>]||null>
    - if <[profile]> == null:
        - narrate "<&c>[Ras] Profil <[race]> tidak ditemukan di race_config.dsc." targets:<[player]>
        - stop
    - define origin <[player].flag[race_origin]||<[race]>>
    - define base_profile <script[race_config].data_key[races].get[<[origin]>]||<[profile]>>
    - define overrides <[profile].get[attribute_overrides]||<[base_profile].get[attribute_overrides]||<map[]>>>
    - define health <[overrides].get[max_health]||<[profile].get[health]||<[base_profile].get[health]>>>
    - define speed <[profile].get[speed]||<[base_profile].get[speed]>>
    - define damage <[profile].get[damage]||<[base_profile].get[damage]>>
    - define size <[profile].get[size]||<[base_profile].get[size]>>
    - define trait <[profile].get[trait]||<[base_profile].get[trait]>>
    - define can_fly <[profile].get[can_fly]||<[base_profile].get[can_fly]||false>>
    - define fly_speed <[profile].get[fly_speed]||<[base_profile].get[fly_speed]||0.05>>
    - define old_health <[player].health>
    - adjust <[player]> max_health:<[health]>
    - if <[old_health]> > <[health]>:
        - adjust <[player]> health:<[health]>
    - adjust <[player]> walk_speed:<[speed]>
    - adjust <[player]> fly_speed:<[fly_speed]>
    - adjust <[player]> can_fly:<[can_fly]>
    - run race_apply_attributes def.player:<[player]> def.profile:<[base_profile]> def.health:<[health]> def.speed:<[speed]> def.size:<[size]> def.fly_speed:<[fly_speed]>
    - flag <[player]> race_health:<[health]>
    - flag <[player]> race_speed:<[speed]>
    - flag <[player]> race_can_fly:<[can_fly]>
    - flag <[player]> race_fly_speed:<[fly_speed]>
    - flag <[player]> race_damage:<[damage]>
    - flag <[player]> race_size:<[size]>
    - flag <[player]> race_trait:<[trait]>

race_sync_unique_slot:
    type: task
    debug: false
    definitions: race
    script:
    - define profile <script[race_config].data_key[evolved_races].get[<[race]>]||<map[tier=1]>>
    - define tier <[profile].get[tier]||1>
    - define slot_limit <[profile].get[slot_limit]||1>
    - if <[tier]> < 4 || <[slot_limit]> <= 0:
        - stop
    - define server_flag race_occupants_<[race]>
    - define occupants <server.flag[<[server_flag]>]||<list[]>>
    - foreach <server.online_players> as:occupant_player:
        - if <[occupant_player].flag[race]||none> == <[race]>:
            - if !<[occupants].contains[<[occupant_player].uuid>]>:
                - define occupants <[occupants].include[<[occupant_player].uuid>]>
    - flag server <[server_flag]>:<[occupants]>

race_check_unique_slot:
    type: task
    debug: false
    definitions: player|race
    script:
    - flag <[player]> race_slot_available:true
    - define profile <script[race_config].data_key[evolved_races].get[<[race]>]||<map[tier=1]>>
    - define tier <[profile].get[tier]||1>
    - define slot_limit <[profile].get[slot_limit]||1>
    - if <[tier]> < 4 || <[slot_limit]> <= 0:
        - stop
    - run race_sync_unique_slot def.race:<[race]>
    - define server_flag race_occupants_<[race]>
    - define occupants <server.flag[<[server_flag]>]||<list[]>>
    - if !<[occupants].contains[<[player].uuid>]> && <[occupants].size> >= <[slot_limit]>:
        - flag <[player]> race_slot_available:false

race_claim_unique_slot:
    type: task
    debug: false
    definitions: player|race
    script:
    - define profile <script[race_config].data_key[evolved_races].get[<[race]>]||<map[tier=1]>>
    - define tier <[profile].get[tier]||1>
    - define slot_limit <[profile].get[slot_limit]||1>
    - if <[tier]> < 4 || <[slot_limit]> <= 0:
        - stop
    - run race_sync_unique_slot def.race:<[race]>
    - define server_flag race_occupants_<[race]>
    - define occupants <server.flag[<[server_flag]>]||<list[]>>
    - if <[occupants].contains[<[player].uuid>]>:
        - stop
    - if <[occupants].size> >= <[slot_limit]>:
        - narrate "<&c>[Ras] Slot unik untuk <[race]> sudah terisi. Hubungi admin jika ini data lama yang bentrok." targets:<[player]>
        - stop
    - flag server <[server_flag]>:<[occupants].include[<[player].uuid>]>

race_release_unique_slot:
    type: task
    debug: false
    definitions: player|race
    script:
    - define profile <script[race_config].data_key[evolved_races].get[<[race]>]||<map[tier=1]>>
    - define tier <[profile].get[tier]||1>
    - if <[tier]> < 4:
        - stop
    - define server_flag race_occupants_<[race]>
    - define occupants <server.flag[<[server_flag]>]||<list[]>>
    - if !<[occupants].contains[<[player].uuid>]>:
        - stop
    - define remaining <list[]>
    - foreach <[occupants]> as:occupant:
        - if <[occupant]> != <[player].uuid>:
            - define remaining <[remaining].include[<[occupant]>]>
    - flag server <[server_flag]>:<[remaining]>

race_create_destiny:
    type: task
    debug: false
    definitions: player|origin|first_branch
    script:
    - define paths <script[race_config].data_key[evolutions]>
    - define max_tier <script[race_config].data_key[maximum_tier]>
    - define destiny <list[<[origin]>|<[first_branch]>]>
    - define cursor <[first_branch]>
    - define path_complete false
    - repeat <[max_tier].sub[2]>:
        - if !<[path_complete]>:
            - define children <[paths].get[<[cursor]>]||<list[]>>
            - if <[children].size> == 0:
                - define path_complete true
            - else:
                - define next_race none
                - if <[children].size> == 1:
                    - define next_race <[children].get[1]>
                - else:
                    - define total_weight 0
                    - foreach <[children]> as:option:
                        - define option_profile <script[race_config].data_key[evolved_races].get[<[option]>]||<map[gacha_weight=1]>>
                        - define option_weight <[option_profile].get[gacha_weight]||1>
                        - define total_weight:<[total_weight].add[<[option_weight]>]>
                    - define gacha_roll <util.random.int[1].to[<[total_weight]>]>
                    - define cumulative_weight 0
                    - foreach <[children]> as:option:
                        - define option_profile <script[race_config].data_key[evolved_races].get[<[option]>]||<map[gacha_weight=1]>>
                        - define option_weight <[option_profile].get[gacha_weight]||1>
                        - define cumulative_weight:<[cumulative_weight].add[<[option_weight]>]>
                        - if <[next_race]> == none && <[gacha_roll]> <= <[cumulative_weight]>:
                            - define next_race <[option]>
                - define destiny <[destiny].include[<[next_race]>]>
                - define cursor <[next_race]>
    - flag <[player]> race_destiny:<[destiny]>
    - define path_tier 1
    - foreach <[destiny]> as:destiny_race:
        - define path_tier:<[path_tier].add[1]>
        - if <[path_tier]> > 1:
            - run race_prepare_requirements def.player:<[player]> def.target:<[destiny_race]> def.tier:<[path_tier]>
    - flag <[player]> race_branch:<[first_branch]>

race_prepare_requirements:
    type: task
    debug: false
    definitions: player|target|tier
    script:
    - define requirement_flag race_requirements_<[target]>
    - if <[player].has_flag[<[requirement_flag]>]>:
        - stop
    - if <[tier]> == 2:
        - define xp_min 20
        - define xp_max 50
        - define material_choices <list[iron_ingot|gold_ingot|lapis_lazuli|emerald]>
        - define amount_min 8
        - define amount_max 24
        - define action_targets <list[zombie|skeleton|creeper|spider]>
        - define action_min 10
        - define action_max 25
    - else if <[tier]> == 3:
        - define xp_min 60
        - define xp_max 120
        - define material_choices <list[diamond|blaze_rod|ender_pearl|obsidian]>
        - define amount_min 12
        - define amount_max 32
        - define action_targets <list[blaze|enderman|ravager|evoker]>
        - define action_min 30
        - define action_max 75
    - else if <[tier]> == 4:
        - define xp_min 150
        - define xp_max 300
        - define material_choices <list[netherite_ingot|ender_eye|beacon|nether_star]>
        - define amount_min 2
        - define amount_max 8
        - define action_targets <list[wither|ender_dragon|warden]>
        - define action_min 100
        - define action_max 200
    - else:
        - define xp_min 350
        - define xp_max 600
        - define material_choices <list[netherite_block|dragon_egg|nether_star|enchanted_golden_apple]>
        - define amount_min 1
        - define amount_max 4
        - define action_targets <list[wither|ender_dragon|warden]>
        - define action_min 250
        - define action_max 500
    - define xp_cost <util.random.int[<[xp_min]>].to[<[xp_max]>]>
    - define material <[material_choices].random>
    - define material_amount <util.random.int[<[amount_min]>].to[<[amount_max]>]>
    - if <[material]> == dragon_egg:
        - define material_amount 1
    - define materials <map[<[material]>=<[material_amount]>]>
    - define action_target <[action_targets].random>
    - define action_amount <util.random.int[<[action_min]>].to[<[action_max]>]>
    - define action_label "Bunuh <[action_amount]> <[action_target].replace[_].with[<&sp>].to_titlecase>"
    - define action <map[type=kill|target=<[action_target]>|amount=<[action_amount]>|label=<[action_label]>]>
    - define chance_key tier_<[tier]>
    - define success_chance <script[race_config].data_key[gacha_chances].get[<[chance_key]>]||10>
    - define requirements <map[xp_levels=<[xp_cost]>|materials=<[materials]>|action=<[action]>|success_chance=<[success_chance]>]>
    - flag <[player]> <[requirement_flag]>:<[requirements]>

race_evolve:
    type: task
    debug: false
    definitions: player
    script:
    - if !<[player].has_flag[race]>:
        - narrate "<&c>Kamu belum memiliki ras." targets:<[player]>
        - stop
    - define current <[player].flag[race]>
    - define origin <[player].flag[race_origin]||<[current]>>
    - define paths <script[race_config].data_key[evolutions]>
    - define evolved <script[race_config].data_key[evolved_races]>
    - define allowed <[paths].get[<[current]>]||<list[]>>
    - define tier <[player].flag[race_tier]||1>
    - if <[tier]> >= <script[race_config].data_key[maximum_tier]>:
        - narrate "<&c>Rasmu sudah mencapai tier maksimum." targets:<[player]>
        - stop
    - define destiny <[player].flag[race_destiny]||null>
    - define branch <[player].flag[race_branch]||<[player].flag[race_pending_evolution]||null>>
    - if <[destiny]> == null:
        - if <[tier]> == 1:
            - if <[branch]> == null || !<[allowed].contains[<[branch]>]>:
                - define total_weight 0
                - foreach <[allowed]> as:option:
                    - define option_profile <[evolved].get[<[option]>]||<map[gacha_weight=1]>>
                    - define option_weight <[option_profile].get[gacha_weight]||1>
                    - define total_weight:<[total_weight].add[<[option_weight]>]>
                - if <[total_weight]> <= 0:
                    - narrate "<&c>[Ras] Tidak ada cabang evolusi yang valid." targets:<[player]>
                    - stop
                - define gacha_roll <util.random.int[1].to[<[total_weight]>]>
                - define cumulative_weight 0
                - define branch none
                - foreach <[allowed]> as:option:
                    - define option_profile <[evolved].get[<[option]>]||<map[gacha_weight=1]>>
                    - define option_weight <[option_profile].get[gacha_weight]||1>
                    - define cumulative_weight:<[cumulative_weight].add[<[option_weight]>]>
                    - if <[branch]> == none && <[gacha_roll]> <= <[cumulative_weight]>:
                        - define branch <[option]>
                - if <[branch]> == none:
                    - narrate "<&c>[Ras] Gacha evolusi tidak menemukan hasil yang valid." targets:<[player]>
                    - stop
        - else if <[branch]> == null:
            - foreach <[paths].get[<[origin]>]||<list[]>> as:branch_candidate:
                - if <[branch_candidate]> == <[current]>:
                    - define branch <[branch_candidate]>
                - foreach <[paths].get[<[branch_candidate]>]||<list[]>> as:branch_second:
                    - if <[branch_second]> == <[current]>:
                        - define branch <[branch_candidate]>
                    - foreach <[paths].get[<[branch_second]>]||<list[]>> as:branch_third:
                        - if <[branch_third]> == <[current]>:
                            - define branch <[branch_candidate]>
                        - foreach <[paths].get[<[branch_third]>]||<list[]>> as:branch_fourth:
                            - if <[branch_fourth]> == <[current]>:
                                - define branch <[branch_candidate]>
        - if <[branch]> == null:
            - narrate "<&c>[Ras] Takdir jalur evolusimu tidak dapat dipulihkan." targets:<[player]>
            - stop
        - run race_create_destiny def.player:<[player]> def.origin:<[origin]> def.first_branch:<[branch]>
        - define destiny <[player].flag[race_destiny]||null>
        - run race_set_progress def.player:<[player]>
        - if <[tier]> == 1:
            - narrate "<&6>[Gacha Ras] Takdir jalurmu: <&e><[destiny].comma_separated><&6>. Jalur ini tetap sama meski percobaan evolusi gagal." targets:<[player]>
    - if !<[destiny].contains[<[current]>]>:
        - narrate "<&c>[Ras] Ras saat ini tidak berada pada jalur takdirmu." targets:<[player]>
        - stop
    - define current_index 0
    - define path_index 0
    - foreach <[destiny]> as:path_race:
        - define path_index:<[path_index].add[1]>
        - if <[path_race]> == <[current]>:
            - define current_index <[path_index]>
    - define next_index <[current_index].add[1]>
    - define target <[destiny].get[<[next_index]>]||null>
    - if <[target]> == null:
        - narrate "<&c>Rasmu sudah berada di akhir jalur takdir." targets:<[player]>
        - stop
    - define target_profile <[evolved].get[<[target]>]||null>
    - if <[target_profile]> == null || <[target_profile].get[tier]||0> != <[tier].add[1]>:
        - narrate "<&c>[Ras] Jalur takdir memiliki tahap yang tidak sesuai konfigurasi." targets:<[player]>
        - stop
    - flag <[player]> race_branch:<[destiny].get[2]>
    - flag <[player]> race_destiny_index:<[current_index]>
    - flag <[player]> race_pending_evolution:!
    - run race_prepare_requirements def.player:<[player]> def.target:<[target]> def.tier:<[next_tier]>
    - define requirement_flag race_requirements_<[target]>
    - define requirements <[player].flag[<[requirement_flag]>]||null>
    - if <[requirements]> == null:
        - narrate "<&c>Syarat evolusi <[target]> belum dikonfigurasi." targets:<[player]>
        - stop
    - define xp_cost <[requirements].get[xp_levels]||0>
    - if <[player].xp_level> < <[xp_cost]>:
        - narrate "<&c>Kamu membutuhkan <[xp_cost]> level XP untuk evolusi ini." targets:<[player]>
        - stop
    - define materials <[requirements].get[materials]||<map[]>>
    - foreach <[materials].keys> as:material:
        - define cost <[materials].get[<[material]>]>
        - if <[player].inventory.quantity_item[<[material]>]> < <[cost]>:
            - narrate "<&c>Kamu membutuhkan <[cost]> <[material]> untuk evolusi ini." targets:<[player]>
            - stop
    - if <[requirements].contains[action]>:
        - define action <[requirements].get[action]>
        - define action_flag race_action_<[target]>
        - define action_progress <[player].flag[<[action_flag]>]||0>
        - if <[action_progress]> < <[action].get[amount]>:
            - narrate "<&c>Objective belum terpenuhi: <[action].get[label]||<[action].get[type]> <[action].get[target]>> (<[action_progress]>/<[action].get[amount]>)." targets:<[player]>
            - stop
    - run race_check_unique_slot def.player:<[player]> def.race:<[target]>
    - if !<[player].flag[race_slot_available]||false>:
        - flag <[player]> race_slot_available:!
        - narrate "<&c>[Ras] Slot unik untuk <[target]> sedang ditempati. Takdirmu tetap tersimpan; coba lagi saat slot terbuka." targets:<[player]>
        - stop
    - flag <[player]> race_slot_available:!
    - define next_tier <[tier].add[1]>
    - define chance_key tier_<[next_tier]>
    - define default_chance <script[race_config].data_key[gacha_chances].get[<[chance_key]>]||10>
    - define chance <[requirements].get[success_chance]||<[default_chance]>>
    - if <[xp_cost]> > 0:
        - experience take level <[xp_cost]> player:<[player]>
    - foreach <[materials].keys> as:material:
        - define cost <[materials].get[<[material]>]>
        - take item:<[material]> quantity:<[cost]> from:<[player].inventory>
    - define roll <util.random.int[1].to[100]>
    - if <[roll]> > <[chance]>:
        - flag <[player]> race_action_<[target]>:!
        - playsound <[player]> sound:ENTITY_VILLAGER_NO volume:1 pitch:0.8
        - playeffect effect:SMOKE at:<[player].location.add[0,1,0]> quantity:18 offset:0.5 targets:<[player]>
        - narrate "<&c>[Ras] Evolusi ke <&e><[target]><&c> gagal! Biaya dan progress objective target dikorbankan, tetapi jalur takdirmu tidak berubah." targets:<[player]>
        - stop
    - run race_clear_action_progress def.player:<[player]>
    - run race_release_unique_slot def.player:<[player]> def.race:<[current]>
    - flag <[player]> race:<[target]>
    - flag <[player]> race_tier:<[next_tier]>
    - flag <[player]> race_destiny_index:<[next_index]>
    - run race_claim_unique_slot def.player:<[player]> def.race:<[target]>
    - run race_set_progress def.player:<[player]>
    - run race_apply def.player:<[player]>
    - define nearby_players <[player].location.find_players_within[16]>
    - playsound <[nearby_players]> sound:ENTITY_PLAYER_LEVELUP volume:1 pitch:1
    - playeffect effect:FIREWORKS_SPARK at:<[player].location.add[0,1,0]> quantity:30 offset:0.8 targets:<[nearby_players]>
    - playeffect effect:HAPPY_VILLAGER at:<[player].location.add[0,1,0]> quantity:20 offset:0.6 targets:<[nearby_players]>
    - define tier_names <list[Primary Race|Sub-Race|Sub-Type|Final Form|Divine Form]>
    - define tier_name <[tier_names].get[<[next_tier]>]>
    - narrate "<&6>[Ras] <&a>Evolusi berhasil! Ras barumu: <&e><[target]><&7> (<[tier_name]>). Hasil roll <&f><[roll]><&7> dari peluang berhasil <&f><[chance]>%." targets:<[player]>
    - if <[next_tier]> >= 4:
        - define awakening_name <[target_profile].get[display_name]||<[target].replace[_].with[<&sp>].to_titlecase>>
        - if <[target]> == goblin_king:
            - define awakening_name "Raja Goblin"
        - else if <[target]> == goblin_queen:
            - define awakening_name "Ratu Goblin"
        - announce "<&6>Sang <[awakening_name]> telah bangkit!"
        - playsound <[nearby_players]> sound:ENTITY_ENDER_DRAGON_GROWL volume:1 pitch:0.8
        - playeffect effect:PORTAL at:<[player].location.add[0,1,0]> quantity:80 offset:1.5 targets:<[nearby_players]>
        - playeffect effect:FIREWORKS_SPARK at:<[player].location.add[0,1,0]> quantity:60 offset:1.2 targets:<[nearby_players]>

race_command:
    type: command
    debug: false
    name: race
    description: Lihat informasi atau evolusikan ras.
    usage: /race [evolve]
    script:
    - if <context.args.size> == 0:
        - run race_gui def.player:<player>
        - stop
    - if <context.args.size> > 1 || <context.args.get[1].to_lowercase> != evolve:
        - narrate "<&c>Gunakan /race evolve."
        - stop
    - run race_evolve def.player:<player>

race_plural_command:
    type: command
    debug: false
    name: races
    description: Lihat informasi atau evolusikan ras.
    usage: /races [evolve]
    script:
    - if <context.args.size> == 0:
        - run race_gui def.player:<player>
        - stop
    - if <context.args.size> > 1 || <context.args.get[1].to_lowercase> != evolve:
        - narrate "<&c>Gunakan /races evolve."
        - stop
    - run race_evolve def.player:<player>

race_gui_click:
    type: world
    debug: false
    events:
        on player clicks in inventory:
        - if <context.inventory.title> == Informasi<&sp>Ras:
            - determine passively cancelled
            - if <context.raw_slot> == 11:
                - run race_gui_profile def.player:<player>
                - stop
            - if <context.raw_slot> == 13:
                - run race_gui_races def.player:<player>
                - stop
            - if <context.raw_slot> == 15:
                - run race_gui_progress def.player:<player>
                - stop
            - stop
        - if <context.inventory.title> == Profil<&sp>Pemain:
            - determine passively cancelled
            - if <context.raw_slot> == 27:
                - run race_gui def.player:<player>
            - stop
        - if <context.inventory.title> == Daftar<&sp>Ras<&sp>Awal:
            - determine passively cancelled
            - if <context.raw_slot> == 50:
                - run race_gui def.player:<player>
                - stop
            - define race_slots <list[12|14|16|21|23|25|30|32|34|39|41|43]>
            - if !<[race_slots].contains[<context.raw_slot>]>:
                - stop
            - define flag_name race_gui_target_<context.raw_slot>
            - define target <player.flag[<[flag_name]>]||null>
            - if <[target]> != null:
                - run race_open_path def.player:<player> def.origin:<[target]> def.catalog:true
            - stop
        - if <context.inventory.title> == Jalur<&sp>Evolusi<&sp>Ras:
            - determine passively cancelled
            - if <context.raw_slot> == 44:
                - if <player.flag[race_gui_catalog]||false>:
                    - run race_gui_races def.player:<player>
                - else:
                    - run race_gui def.player:<player>
                - stop
            - define path_slots <list[13|14|18|19|20|21|22|23|24|25|26|27|28|30|34|39|41|43]>
            - if !<[path_slots].contains[<context.raw_slot>]>:
                - stop
            - define flag_name race_gui_target_<context.raw_slot>
            - define target <player.flag[<[flag_name]>]||null>
            - if <[target]> != null:
                - define origin <player.flag[race_gui_origin]>
                - define catalog <player.flag[race_gui_catalog]||false>
                - run race_open_stage_details def.player:<player> def.origin:<[origin]> def.selected:<[target]> def.catalog:<[catalog]>
            - stop
        - if <context.inventory.title> == Detail<&sp>Evolusi<&sp>Ras:
            - determine passively cancelled
            - define slot <context.raw_slot.sub[1]>
            - define origin <player.flag[race_gui_origin]||null>
            - if <[origin]> == null:
                - stop
            - define catalog <player.flag[race_gui_catalog]||false>
            - if <[slot]> == 49:
                - wait 1t
                - run race_open_path def.player:<player> def.origin:<[origin]> def.catalog:<[catalog]>
                - stop
            - define detail_slots <list[9|10|11|12|13|14|15|16|17|18]>
            - if !<[detail_slots].contains[<[slot]>]>:
                - stop
            - define flag_name race_gui_target_<[slot]>
            - define target <player.flag[<[flag_name]>]||null>
            - if <[target]> != null:
                - wait 1t
                - run race_open_stage_details def.player:<player> def.origin:<[origin]> def.selected:<[target]> def.catalog:<[catalog]>
            - stop

race_admin_command:
    type: command
    debug: false
    name: raceadmin
    description: Kelola ras pemain.
    usage: /raceadmin set|evolve|remove player [race]
    permission: race.admin
    script:
    - if <context.args.size> < 2:
        - narrate "<&e>Gunakan: /raceadmin set player race, /raceadmin evolve player target_race, atau /raceadmin remove player."
        - stop
    - define action <context.args.get[1].to_lowercase>
    - define target_player <server.match_player[<context.args.get[2]>]||null>
    - if <[target_player]> == null:
        - narrate "<&c>Pemain tidak ditemukan atau sedang offline."
        - stop
    - if <[action]> == set:
        - if <context.args.size> < 3:
            - narrate "<&c>Gunakan /raceadmin set player race_id."
            - stop
        - define race_id <context.args.get[3].to_lowercase>
        - define profile <script[race_config].data_key[races].get[<[race_id]>]||null>
        - if <[profile]> == null:
            - define profile <script[race_config].data_key[evolved_races].get[<[race_id]>]||null>
        - if <[profile]> == null:
            - narrate "<&c>Race ID tidak dikenal. Periksa races dan evolved_races di race_config.dsc."
            - stop
        - run race_check_unique_slot def.player:<[target_player]> def.race:<[race_id]>
        - if !<[target_player].flag[race_slot_available]||false>:
            - flag <[target_player]> race_slot_available:!
            - narrate "<&c>Slot unik untuk <[race_id]> sudah terisi."
            - stop
        - flag <[target_player]> race_slot_available:!
        - if <[target_player].has_flag[race]>:
            - run race_release_unique_slot def.player:<[target_player]> def.race:<[target_player].flag[race]>
        - run race_clear_action_progress def.player:<[target_player]>
        - flag <[target_player]> race_pending_evolution:!
        - flag <[target_player]> race_branch:!
        - flag <[target_player]> race_destiny:!
        - flag <[target_player]> race_destiny_index:!
        - flag <[target_player]> race:<[race_id]>
        - flag <[target_player]> race_origin:<[profile].get[origin]||<[race_id]>>
        - flag <[target_player]> race_tier:<[profile].get[tier]||1>
        - run race_claim_unique_slot def.player:<[target_player]> def.race:<[race_id]>
        - run race_set_progress def.player:<[target_player]>
        - run race_apply def.player:<[target_player]>
        - define tier_names <list[Primary Race|Sub-Race|Sub-Type|Final Form|Divine Form]>
        - define tier_name <[tier_names].get[<[target_player].flag[race_tier]>]>
        - narrate "<&a>Ras <[target_player].name> diatur menjadi <[race_id]> (<[tier_name]>)."
        - stop
    - if <[action]> == evolve:
        - if <context.args.size> < 3:
            - narrate "<&c>Gunakan /raceadmin evolve player target_race."
            - stop
        - if !<[target_player].has_flag[race]>:
            - narrate "<&c>Pemain tersebut belum memiliki ras. Atur rasnya terlebih dahulu."
            - stop
        - define target_race <context.args.get[3].to_lowercase>
        - define current <[target_player].flag[race]>
        - define tier <[target_player].flag[race_tier]||1>
        - if <[tier]> >= <script[race_config].data_key[maximum_tier]>:
            - narrate "<&c>Pemain tersebut sudah mencapai tier maksimum."
            - stop
        - define origin <[target_player].flag[race_origin]||<[current]>>
        - define paths <script[race_config].data_key[evolutions]>
        - define destiny <[target_player].flag[race_destiny]||null>
        - if <[destiny]> == null:
            - define branch <[target_player].flag[race_branch]||null>
            - if <[tier]> == 1:
                - define allowed <[paths].get[<[current]>]||<list[]>>
                - if !<[allowed].contains[<[target_race]>]>:
                    - narrate "<&c>Target bukan cabang gacha yang tersedia dari ras saat ini."
                    - stop
                - define branch <[target_race]>
            - else if <[branch]> == null:
                - foreach <[paths].get[<[origin]>]||<list[]>> as:branch_candidate:
                    - if <[branch_candidate]> == <[current]>:
                        - define branch <[branch_candidate]>
                    - foreach <[paths].get[<[branch_candidate]>]||<list[]>> as:branch_second:
                        - if <[branch_second]> == <[current]>:
                            - define branch <[branch_candidate]>
                        - foreach <[paths].get[<[branch_second]>]||<list[]>> as:branch_third:
                            - if <[branch_third]> == <[current]>:
                                - define branch <[branch_candidate]>
                            - foreach <[paths].get[<[branch_third]>]||<list[]>> as:branch_fourth:
                                - if <[branch_fourth]> == <[current]>:
                                    - define branch <[branch_candidate]>
            - if <[branch]> == null:
                - narrate "<&c>Takdir jalur pemain tidak dapat dipulihkan."
                - stop
            - run race_create_destiny def.player:<[target_player]> def.origin:<[origin]> def.first_branch:<[branch]>
            - define destiny <[target_player].flag[race_destiny]||null>
        - if !<[destiny].contains[<[current]>]>:
            - narrate "<&c>Ras pemain tidak cocok dengan jalur takdirnya."
            - stop
        - define current_index 0
        - define path_index 0
        - foreach <[destiny]> as:path_race:
            - define path_index:<[path_index].add[1]>
            - if <[path_race]> == <[current]>:
                - define current_index <[path_index]>
        - define next_index <[current_index].add[1]>
        - define next_race <[destiny].get[<[next_index]>]||null>
        - if <[target_race]> != <[next_race]>:
            - narrate "<&c>Target harus mengikuti jalur takdir berikutnya: <[next_race]>."
            - stop
        - run race_check_unique_slot def.player:<[target_player]> def.race:<[target_race]>
        - if !<[target_player].flag[race_slot_available]||false>:
            - flag <[target_player]> race_slot_available:!
            - narrate "<&c>Slot unik untuk <[target_race]> sudah terisi."
            - stop
        - flag <[target_player]> race_slot_available:!
        - run race_clear_action_progress def.player:<[target_player]>
        - flag <[target_player]> race_pending_evolution:!
        - run race_release_unique_slot def.player:<[target_player]> def.race:<[current]>
        - flag <[target_player]> race_branch:<[destiny].get[2]>
        - flag <[target_player]> race:<[target_race]>
        - flag <[target_player]> race_tier:<[tier].add[1]>
        - flag <[target_player]> race_destiny_index:<[next_index]>
        - run race_claim_unique_slot def.player:<[target_player]> def.race:<[target_race]>
        - run race_set_progress def.player:<[target_player]>
        - run race_apply def.player:<[target_player]>
        - define tier_names <list[Primary Race|Sub-Race|Sub-Type|Final Form|Divine Form]>
        - define tier_name <[tier_names].get[<[target_player].flag[race_tier]>]>
        - narrate "<&a>Ras <[target_player].name> dipaksa mengikuti jalur takdir menjadi <[target_race]> (<[tier_name]>) tanpa syarat."
        - stop
    - if <[action]> == remove:
        - if <[target_player].has_flag[race]>:
            - run race_release_unique_slot def.player:<[target_player]> def.race:<[target_player].flag[race]>
        - run race_clear_action_progress def.player:<[target_player]>
        - foreach <list[race|race_origin|race_tier|race_next|race_health|race_speed|race_can_fly|race_fly_speed|race_damage|race_size|race_trait|race_pending_evolution|race_branch|race_destiny|race_destiny_index|race_slot_available]> as:flag_name:
            - flag <[target_player]> <[flag_name]>:!
        - foreach <list[20|21|22|23|24|25|26|27|28]> as:slot:
            - define flag_name race_gui_target_<[slot]>
            - flag <[target_player]> <[flag_name]>:!
        - adjust <[target_player]> max_health:20
        - if <[target_player].health> > 20:
            - adjust <[target_player]> health:20
        - adjust <[target_player]> walk_speed:0.2
        - adjust <[target_player]> can_fly:false
        - adjust <[target_player]> fly_speed:0.05
        - define default_profile <map[health=20|speed=0.2|size=1|fly_speed=0.05]>
        - run race_apply_attributes def.player:<[target_player]> def.profile:<[default_profile]> def.health:20 def.speed:0.2 def.size:1 def.fly_speed:0.05
        - narrate "<&a>Data ras <[target_player].name> dihapus. Ras baru akan dipilih acak saat pemain masuk kembali."
        - stop
    - narrate "<&c>Aksi tidak dikenal. Gunakan set, evolve, atau remove."

race_damage_event:
    type: world
    debug: false
    events:
        on player damages entity:
        - if <player.has_flag[race_damage]>:
            - determine <context.damage.mul[<player.flag[race_damage]>]>