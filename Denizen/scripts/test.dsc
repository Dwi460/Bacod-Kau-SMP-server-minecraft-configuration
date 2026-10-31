heavy_core_nerf_listener:
    type: world
    debug: false
    events:
        on loot dispenses from vault:
        - define chance <script[config_brutal_legend].data_key[heavy core vault chance]||3>
        - define replacements <list[flow_armor_trim_smithing_template|enchanted_golden_apple|diamond|ominous_bottle|music_disc_creator|flow_banner_pattern|wind_charge]>
        - define new_loot <list>
        - define changed false
        - foreach <context.loot> as:loot_item:
            - if <[loot_item].material.name> == heavy_core && <util.random.int[1].to[100]> > <[chance]>:
                - define new_loot:->:<item[<[replacements].random>]>
                - define changed true
            - else:
                - define new_loot:->:<[loot_item]>
        - if <[changed]>:
            - determine LOOT:<[new_loot]>