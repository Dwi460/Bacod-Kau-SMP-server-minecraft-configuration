race_config:
    type: data
    maximum_tier: 5
    gacha_chances:
        tier_2: 30
        tier_3: 18
        tier_4: 8
        tier_5: 3
    races:
        goblin:
            chance: 8
            health: 16
            speed: 0.26
            damage: 1.1
            size: 0.55
            attribute_overrides:
                jump_strength: 0.45
                safe_fall_distance: 4.0
                attack_speed: 4.2
                sneaking_speed: 0.36
            trait: "Makhluk hijau bertubuh kecil."
        human:
            chance: 50
            health: 20
            speed: 0.2
            damage: 1.0
            size: 1.0
            trait: "Makhluk serbaguna yang mudah beradaptasi."
        elf:
            chance: 5
            health: 18
            speed: 0.23
            damage: 1.0
            size: 0.95
            trait: "Makhluk bertelinga panjang dengan hubungan kuat pada alam."
        orc:
            chance: 5
            health: 28
            speed: 0.18
            damage: 1.2
            size: 1.2
            attribute_overrides:
                armor: 4.0
                armor_toughness: 1.0
                knockback_resistance: 0.25
                attack_damage: 1.2
                attack_knockback: 0.5
            trait: "Makhluk petarung bertubuh besar."
        dwarf:
            chance: 5
            health: 28
            speed: 0.18
            damage: 1.2
            size: 0.64
            attribute_overrides:
                armor: 5.0
                armor_toughness: 2.0
                knockback_resistance: 0.35
                step_height: 0.75
            trait: "Makhluk tangguh yang tinggal di bawah tanah."
        beastkin:
            chance: 5
            health: 20
            speed: 0.25
            damage: 1.15
            size: 1.0
            attribute_overrides:
                jump_strength: 0.48
                attack_speed: 4.2
            trait: "Makhluk dengan ciri dan naluri hewan."
        undead:
            chance: 4
            health: 24
            speed: 0.19
            damage: 1.15
            size: 1.0
            trait: "Makhluk yang bangkit dari kematian."
        demonkin:
            chance: 3
            health: 22
            speed: 0.22
            damage: 1.2
            size: 1.0
            attribute_overrides:
                armor: 2.0
                armor_toughness: 0.5
                attack_damage: 1.2
                attack_knockback: 0.2
            trait: "Makhluk dari garis keturunan iblis."
        dragonkin:
            chance: 2
            health: 28
            speed: 0.19
            damage: 1.2
            size: 1.25
            attribute_overrides:
                armor: 4.0
                armor_toughness: 2.0
                knockback_resistance: 0.2
                safe_fall_distance: 4.0
                fall_damage_multiplier: 0.75
            trait: "Makhluk bersisik dengan darah naga."
        fae:
            chance: 3
            health: 12
            speed: 0.15
            damage: 0.85
            size: 0.2
            can_fly: true
            fly_speed: 0.32
            attribute_overrides:
                jump_strength: 0.55
                gravity: 0.06
                safe_fall_distance: 6.0
                fall_damage_multiplier: 0.5
            trait: "Makhluk mungil yang bisa terbang."
        angel:
            chance: 5
            health: 18
            speed: 0.19
            damage: 1.1
            size: 0.9
            can_fly: true
            fly_speed: 0.17
            attribute_overrides:
                jump_strength: 0.46
                safe_fall_distance: 6.0
                fall_damage_multiplier: 0.5
            trait: "Makhluk bersayap dengan kekuatan suci."
        merfolk:
            chance: 5
            health: 20
            speed: 0.21
            damage: 1.05
            size: 1.0
            attribute_overrides:
                submerged_mining_speed: 0.75
                block_break_speed: 1.1
                block_interaction_range: 4.75
            trait: "Makhluk laut dengan kemampuan berenang."
    evolved_races:
        hobgoblin:
            origin: goblin
            tier: 2
            display_name: Hobgoblin
        goblina:
            origin: goblin
            tier: 2
            display_name: Goblina
        goblin_orc:
            origin: goblin
            tier: 3
            display_name: Orc (Goblin-Orc)
        female_orc:
            origin: goblin
            tier: 3
            display_name: Female Orc
        goblin_king:
            origin: goblin
            tier: 4
            slot_limit: 1
            display_name: Goblin King
        goblin_queen:
            origin: goblin
            tier: 4
            slot_limit: 1
            display_name: Goblin Queen
        goblin_overlord:
            origin: goblin
            tier: 5
            slot_limit: 1
            display_name: Goblin Overlord
            trait: "Dewa para Goblin."
        goblin_empress:
            origin: goblin
            tier: 5
            slot_limit: 1
            display_name: Goblin Empress
        human_vanguard:
            origin: human
            tier: 2
            display_name: Vanguard
        human_arcanist:
            origin: human
            tier: 2
            display_name: Arcanist
        human_champion:
            origin: human
            tier: 3
            display_name: Champion
        archmage:
            origin: human
            tier: 3
            display_name: Archmage
        human_warlord:
            origin: human
            tier: 4
            slot_limit: 1
            display_name: Warlord
        human_grandmaster:
            origin: human
            tier: 4
            slot_limit: 1
            display_name: Grandmaster
        god_of_war:
            origin: human
            tier: 5
            slot_limit: 1
            display_name: God of War
        grand_mage:
            origin: human
            tier: 4
            slot_limit: 1
            display_name: Grand Mage
        sage_supreme:
            origin: human
            tier: 5
            slot_limit: 1
            display_name: Sage Supreme
        wood_elf:
            origin: elf
            tier: 2
            display_name: Wood Elf
        high_elf:
            origin: elf
            tier: 2
            display_name: High Elf
        elder_wood_elf:
            origin: elf
            tier: 3
            display_name: Elder Wood Elf
        star_elf:
            origin: elf
            tier: 3
            display_name: Star Elf
        sylph_elf:
            origin: elf
            tier: 4
            slot_limit: 1
            display_name: Sylph Elf
        astral_elf:
            origin: elf
            tier: 4
            slot_limit: 1
            display_name: Astral Elf
        world_tree_avatar:
            origin: elf
            tier: 5
            slot_limit: 1
            display_name: World Tree Avatar
        celestial_monarch:
            origin: elf
            tier: 5
            slot_limit: 1
            display_name: Celestial Monarch
        berserker:
            origin: orc
            tier: 2
            display_name: Berserker
        shaman:
            origin: orc
            tier: 2
            display_name: Shaman
        orc_warlord:
            origin: orc
            tier: 3
            display_name: Warlord
        shaman_spirit_caller:
            origin: orc
            tier: 3
            display_name: Spirit Caller
        doom_bringer:
            origin: orc
            tier: 4
            slot_limit: 1
            display_name: Doom Bringer
        ancestral_oracle:
            origin: orc
            tier: 4
            slot_limit: 1
            display_name: Ancestral Oracle
        world_destroyer:
            origin: orc
            tier: 5
            slot_limit: 1
            display_name: World Destroyer
        spirit_god:
            origin: orc
            tier: 5
            slot_limit: 1
            display_name: Spirit God
        iron_dwarf:
            origin: dwarf
            tier: 2
            display_name: Iron Dwarf
        rune_dwarf:
            origin: dwarf
            tier: 2
            display_name: Rune Dwarf
        mountain_king:
            origin: dwarf
            tier: 3
            display_name: Mountain King
        rune_lord:
            origin: dwarf
            tier: 3
            display_name: Rune Lord
        titan_forge_master:
            origin: dwarf
            tier: 4
            slot_limit: 1
            display_name: Titan Forge Master
        ancient_runesmith:
            origin: dwarf
            tier: 4
            slot_limit: 1
            display_name: Ancient Runesmith
        colossus_lord:
            origin: dwarf
            tier: 5
            slot_limit: 1
            display_name: Colossus Lord
        primeval_architect:
            origin: dwarf
            tier: 5
            slot_limit: 1
            display_name: Primeval Architect
        wolfkin:
            origin: beastkin
            tier: 2
            display_name: Wolfkin
        catkin:
            origin: beastkin
            tier: 2
            display_name: Catkin
        alpha_wolf:
            origin: beastkin
            tier: 3
            display_name: Alpha Wolf
        beast_lord:
            origin: beastkin
            tier: 3
            display_name: Beast Lord
        fenrir_bloodline:
            origin: beastkin
            tier: 4
            slot_limit: 1
            display_name: Fenrir Bloodline
        apex_predator:
            origin: beastkin
            tier: 4
            slot_limit: 1
            display_name: Apex Predator
        beast_emperor:
            origin: beastkin
            tier: 5
            slot_limit: 1
            display_name: Beast Emperor
        wild_sovereign:
            origin: beastkin
            tier: 5
            slot_limit: 1
            display_name: Wild Sovereign
        ghoul:
            origin: undead
            tier: 2
            display_name: Ghoul
        skeleton:
            origin: undead
            tier: 2
            display_name: Skeleton
        death_knight:
            origin: undead
            tier: 3
            display_name: Death Knight
        lich:
            origin: undead
            tier: 3
            display_name: Lich
        dread_lord:
            origin: undead
            tier: 4
            slot_limit: 1
            display_name: Dread Lord
        archlich:
            origin: undead
            tier: 4
            slot_limit: 1
            display_name: Archlich
        lord_of_the_damned:
            origin: undead
            tier: 5
            slot_limit: 1
            display_name: Lord of the Damned
        god_of_death:
            origin: undead
            tier: 5
            slot_limit: 1
            display_name: God of Death
        imp:
            origin: demonkin
            tier: 2
            display_name: Imp
        demon:
            origin: demonkin
            tier: 2
            display_name: Demon
        fiend:
            origin: demonkin
            tier: 3
            display_name: Fiend
        archdemon:
            origin: demonkin
            tier: 3
            display_name: Archdemon
        greater_fiend:
            origin: demonkin
            tier: 4
            slot_limit: 1
            display_name: Greater Fiend
        sovereign_demon:
            origin: demonkin
            tier: 4
            slot_limit: 1
            display_name: Sovereign Demon
        abyssal_lord:
            origin: demonkin
            tier: 5
            slot_limit: 1
            display_name: Abyssal Lord
        nether_emperor:
            origin: demonkin
            tier: 5
            slot_limit: 1
            display_name: Nether Emperor
        drake:
            origin: dragonkin
            tier: 2
            display_name: Drake
        wyvern:
            origin: dragonkin
            tier: 2
            display_name: Wyvern
        dragon:
            origin: dragonkin
            tier: 3
            display_name: Dragon
        elder_wyvern:
            origin: dragonkin
            tier: 3
            display_name: Elder Wyvern
        ancient_dragon:
            origin: dragonkin
            tier: 4
            slot_limit: 1
            display_name: Ancient Dragon
        sky_sovereign:
            origin: dragonkin
            tier: 4
            slot_limit: 1
            display_name: Sky Sovereign
        dragon_ancestor:
            origin: dragonkin
            tier: 5
            slot_limit: 1
            display_name: Dragon Ancestor
        the_stormbringer:
            origin: dragonkin
            tier: 5
            slot_limit: 1
            display_name: The Stormbringer
        pixie:
            origin: fae
            tier: 2
            display_name: Pixie
        dryad:
            origin: fae
            tier: 2
            display_name: Dryad
        high_fae:
            origin: fae
            tier: 3
            display_name: High Fae
        ancient_dryad:
            origin: fae
            tier: 3
            display_name: Ancient Dryad
        arch_fae:
            origin: fae
            tier: 4
            slot_limit: 1
            display_name: Arch Fae
        nature_sovereign:
            origin: fae
            tier: 4
            slot_limit: 1
            display_name: Nature Sovereign
        fae_queen:
            origin: fae
            tier: 5
            slot_limit: 1
            display_name: Fae Queen
        world_heart_spirit:
            origin: fae
            tier: 5
            slot_limit: 1
            display_name: World Heart Spirit
        archangel:
            origin: angel
            tier: 2
            display_name: Archangel
        fallen_angel:
            origin: angel
            tier: 2
            display_name: Fallen Angel
        seraphim:
            origin: angel
            tier: 3
            display_name: Seraphim
        fallen_archangel:
            origin: angel
            tier: 3
            display_name: Fallen Archangel
        archseraph:
            origin: angel
            tier: 4
            slot_limit: 1
            display_name: Archseraph
        archfiend_of_fall:
            origin: angel
            tier: 4
            slot_limit: 1
            display_name: Archfiend of Fall
        the_virtues:
            origin: angel
            tier: 5
            slot_limit: 1
            display_name: The Virtues
        the_calamity:
            origin: angel
            tier: 5
            slot_limit: 1
            display_name: The Calamity
        siren:
            origin: merfolk
            tier: 2
            display_name: Siren
        triton:
            origin: merfolk
            tier: 2
            display_name: Triton
        ocean_siren:
            origin: merfolk
            tier: 3
            display_name: Ocean Siren
        leviathan:
            origin: merfolk
            tier: 3
            display_name: Leviathan
        deep_siren_queen:
            origin: merfolk
            tier: 4
            slot_limit: 1
            display_name: Deep Siren Queen
        sea_colossus:
            origin: merfolk
            tier: 4
            slot_limit: 1
            display_name: Sea Colossus
        abyssal_empress:
            origin: merfolk
            tier: 5
            slot_limit: 1
            display_name: Abyssal Empress
        ocean_king:
            origin: merfolk
            tier: 5
            slot_limit: 1
            display_name: Ocean King
    evolutions:
        goblin: [hobgoblin, goblina]
        hobgoblin: [goblin_orc]
        goblin_orc: [goblin_king]
        goblin_king: [goblin_overlord]
        goblina: [female_orc]
        female_orc: [goblin_queen]
        goblin_queen: [goblin_empress]
        human: [human_vanguard, human_arcanist]
        human_vanguard: [human_champion]
        human_champion: [human_warlord, human_grandmaster]
        human_warlord: [god_of_war]
        human_grandmaster: [god_of_war]
        human_arcanist: [archmage]
        archmage: [grand_mage]
        grand_mage: [sage_supreme]
        elf: [wood_elf, high_elf]
        wood_elf: [elder_wood_elf]
        elder_wood_elf: [sylph_elf]
        sylph_elf: [world_tree_avatar]
        high_elf: [star_elf]
        star_elf: [astral_elf]
        astral_elf: [celestial_monarch]
        orc: [berserker, shaman]
        berserker: [orc_warlord]
        orc_warlord: [doom_bringer]
        doom_bringer: [world_destroyer]
        shaman: [shaman_spirit_caller]
        shaman_spirit_caller: [ancestral_oracle]
        ancestral_oracle: [spirit_god]
        dwarf: [iron_dwarf, rune_dwarf]
        iron_dwarf: [mountain_king]
        mountain_king: [titan_forge_master]
        titan_forge_master: [colossus_lord]
        rune_dwarf: [rune_lord]
        rune_lord: [ancient_runesmith]
        ancient_runesmith: [primeval_architect]
        beastkin: [wolfkin, catkin]
        wolfkin: [alpha_wolf]
        alpha_wolf: [fenrir_bloodline]
        fenrir_bloodline: [beast_emperor]
        catkin: [beast_lord]
        beast_lord: [apex_predator]
        apex_predator: [wild_sovereign]
        undead: [ghoul, skeleton]
        ghoul: [death_knight]
        death_knight: [dread_lord]
        dread_lord: [lord_of_the_damned]
        skeleton: [lich]
        lich: [archlich]
        archlich: [god_of_death]
        demonkin: [imp, demon]
        imp: [fiend]
        fiend: [greater_fiend]
        greater_fiend: [abyssal_lord]
        demon: [archdemon]
        archdemon: [sovereign_demon]
        sovereign_demon: [nether_emperor]
        dragonkin: [drake, wyvern]
        drake: [dragon]
        dragon: [ancient_dragon]
        ancient_dragon: [dragon_ancestor]
        wyvern: [elder_wyvern]
        elder_wyvern: [sky_sovereign]
        sky_sovereign: [the_stormbringer]
        fae: [pixie, dryad]
        pixie: [high_fae]
        high_fae: [arch_fae]
        arch_fae: [fae_queen]
        dryad: [ancient_dryad]
        ancient_dryad: [nature_sovereign]
        nature_sovereign: [world_heart_spirit]
        angel: [archangel, fallen_angel]
        archangel: [seraphim]
        seraphim: [archseraph]
        archseraph: [the_virtues]
        fallen_angel: [fallen_archangel]
        fallen_archangel: [archfiend_of_fall]
        archfiend_of_fall: [the_calamity]
        merfolk: [siren, triton]
        siren: [ocean_siren]
        ocean_siren: [deep_siren_queen]
        deep_siren_queen: [abyssal_empress]
        triton: [leviathan]
        leviathan: [sea_colossus]
        sea_colossus: [ocean_king]
    race_icons:
        goblin: slime_ball
        human: iron_chestplate
        elf: oak_sapling
        orc: iron_axe
        dwarf: copper_ingot
        beastkin: bone
        undead: rotten_flesh
        demonkin: magma_cream
        dragonkin: dragon_breath
        fae: glowstone_dust
        angel: feather
        merfolk: prismarine_shard
        hobgoblin: iron_helmet
        goblina: pink_tulip
        goblin_orc: iron_sword
        female_orc: shield
        goblin_king: golden_helmet
        goblin_queen: golden_apple
        goblin_overlord: netherite_axe
        goblin_empress: end_crystal
        human_vanguard: shield
        human_arcanist: blaze_rod
        human_champion: iron_sword
        archmage: enchanted_book
        human_warlord: netherite_sword
        human_grandmaster: diamond_sword
        god_of_war: nether_star
        grand_mage: end_crystal
        sage_supreme: book
        wood_elf: oak_sapling
        high_elf: glow_berries
        elder_wood_elf: oak_leaves
        star_elf: ender_eye
        sylph_elf: feather
        astral_elf: end_crystal
        world_tree_avatar: oak_log
        celestial_monarch: nether_star
        berserker: stone_axe
        shaman: amethyst_shard
        orc_warlord: iron_axe
        shaman_spirit_caller: soul_lantern
        doom_bringer: wither_skeleton_skull
        ancestral_oracle: dragon_head
        world_destroyer: netherite_axe
        spirit_god: beacon
        iron_dwarf: iron_ingot
        rune_dwarf: enchanted_book
        mountain_king: gold_block
        rune_lord: amethyst_cluster
        titan_forge_master: anvil
        ancient_runesmith: smithing_table
        colossus_lord: netherite_block
        primeval_architect: lodestone
        wolfkin: wolf_spawn_egg
        catkin: cat_spawn_egg
        alpha_wolf: bone
        beast_lord: iron_sword
        fenrir_bloodline: blue_ice
        apex_predator: crossbow
        beast_emperor: golden_helmet
        wild_sovereign: heart_of_the_sea
        ghoul: bone
        skeleton: skeleton_skull
        death_knight: netherite_sword
        lich: skeleton_skull
        dread_lord: wither_skeleton_skull
        archlich: enchanted_book
        lord_of_the_damned: nether_star
        god_of_death: sculk_catalyst
        imp: blaze_powder
        demon: magma_block
        fiend: fire_charge
        archdemon: netherite_axe
        greater_fiend: blaze_rod
        sovereign_demon: nether_star
        abyssal_lord: obsidian
        nether_emperor: netherite_block
        drake: firework_rocket
        wyvern: phantom_membrane
        dragon: dragon_breath
        elder_wyvern: dragon_head
        ancient_dragon: dragon_egg
        sky_sovereign: elytra
        dragon_ancestor: dragon_egg
        the_stormbringer: trident
        pixie: glowstone_dust
        dryad: oak_sapling
        high_fae: amethyst_shard
        ancient_dryad: flowering_azalea
        arch_fae: ender_eye
        nature_sovereign: heart_of_the_sea
        fae_queen: golden_apple
        world_heart_spirit: nether_star
        archangel: feather
        fallen_angel: soul_lantern
        seraphim: golden_apple
        fallen_archangel: wither_skeleton_skull
        archseraph: nether_star
        archfiend_of_fall: netherite_axe
        the_virtues: beacon
        the_calamity: end_crystal
        siren: nautilus_shell
        triton: trident
        ocean_siren: prismarine_crystals
        leviathan: heart_of_the_sea
        deep_siren_queen: conduit
        sea_colossus: prismarine_bricks
        abyssal_empress: dark_prismarine
        ocean_king: sea_lantern