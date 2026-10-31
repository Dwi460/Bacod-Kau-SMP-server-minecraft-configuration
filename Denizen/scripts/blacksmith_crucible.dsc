crucible_command:
    type: command
    debug: false
    name: crucible
    description: Sistem progres perlengkapan Blacksmith Crucible.
    usage: /crucible <tempa|nilai|pemurnian>
    permission: blacksmith.crucible.use
    script:
    - define action <context.args.get[1].if_null[help]>
    - if <[action]> == tempa:
        - define action forge
    - else if <[action]> == nilai:
        - define action identify
    - else if <[action]> == pemurnian:
        - define action refine
    - if <[action]> == help:
        - narrate "<&6>[Crucible] <&e>/crucible tempa <&7>- daftarkan perlengkapan di tangan."
        - narrate "<&6>[Crucible] <&e>/crucible nilai <&7>- ungkapkan rank kualitasnya."
        - narrate "<&6>[Crucible] <&e>/crucible pemurnian <&7>- buka GUI refine."
        - stop
    - if <player.item_in_hand.material> == m@air:
        - narrate "<&6>[Crucible] <&c>Pegang perlengkapan terlebih dahulu."
        - stop
    - if <[action]> == forge:
        - if <player.item_in_hand.has_flag[crucible.level]>:
            - narrate "<&6>[Crucible] <&c>Item ini sudah terdaftar."
            - stop
        - define material <player.item_in_hand.material>
        - define eligible false
        - if <[material].contains_text[sword]>:
            - define eligible true
        - if <[material].contains_text[pickaxe]>:
            - define eligible true
        - if <[material].contains_text[axe]>:
            - define eligible true
        - if <[material].contains_text[shovel]>:
            - define eligible true
        - if <[material].contains_text[hoe]>:
            - define eligible true
        - if <[material].contains_text[helmet]>:
            - define eligible true
        - if <[material].contains_text[chestplate]>:
            - define eligible true
        - if <[material].contains_text[leggings]>:
            - define eligible true
        - if <[material].contains_text[boots]>:
            - define eligible true
        - if <[eligible]> == false:
            - narrate "<&6>[Crucible] <&c>Item tersebut bukan perlengkapan yang didukung."
            - stop
        - define magnitude <util.random.decimal[0.2].to[0.5]>
        - if <[material].contains_text[copper]>:
            - define magnitude <util.random.decimal[1].to[2]>
        - else if <[material].contains_text[gold]>:
            - define magnitude <util.random.decimal[1].to[2]>
        - else if <[material].contains_text[iron]>:
            - define magnitude 3.2
        - else if <[material].contains_text[diamond]>:
            - define magnitude 5
        - else if <[material].contains_text[netherite]>:
            - define magnitude 6.5
        - if <util.random.int[1].to[2]> == 1:
            - define magnitude <[magnitude].mul[-1]>
        - inventory flag slot:hand crucible.level:1
        - inventory flag slot:hand crucible.exp:0
        - inventory flag slot:hand crucible.refine:0
        - inventory flag slot:hand crucible.potential:<[magnitude]>
        - inventory flag slot:hand crucible.identified:false
        - run crucible_refresh player:<player>
        - narrate "<&6>[Crucible] <&a>Perlengkapan berhasil didaftarkan. Potensinya tersembunyi sampai diperiksa."
        - stop
    - if <[action]> == identify:
        - if !<player.item_in_hand.has_flag[crucible.level]>:
            - narrate "<&6>[Crucible] <&c>Item ini belum terdaftar."
            - stop
        - inventory flag slot:hand crucible.identified:true
        - run crucible_refresh player:<player>
        - narrate "<&6>[Crucible] <&a>Pemeriksaan kualitas selesai."
        - stop
    - if <[action]> == refine:
        - if !<player.item_in_hand.has_flag[crucible.level]>:
            - narrate "<&6>[Crucible] <&c>Item ini belum terdaftar."
            - stop
        - define refine <player.item_in_hand.flag[crucible.refine].if_null[0].as_int>
        - if <[refine]> >= <script[crucible_config].data_key[refine_max].as_int>:
            - narrate "<&6>[Crucible] <&e>Item ini sudah mencapai refine maksimum."
            - stop
        - define target <[refine].add[1]>
        - inventory open d:generic[size=27;title=<&8>Pemurnian Crucible]
        - if <[target]> <= 5:
            - define catalyst <script[crucible_config].data_key[catalyst_a_material]>
            - define catalyst_name <script[crucible_config].data_key[catalyst_a_name]>
        - else if <[target]> <= 10:
            - define catalyst <script[crucible_config].data_key[catalyst_b_material]>
            - define catalyst_name <script[crucible_config].data_key[catalyst_b_name]>
        - else:
            - define catalyst <script[crucible_config].data_key[catalyst_c_material]>
            - define catalyst_name <script[crucible_config].data_key[catalyst_c_name]>
        - define chance <script[crucible_config].data_key[chance_<[target]>].as_int>
        - define catalyst_item <item[<[catalyst]>].with[display=<[catalyst_name]>]>
        - inventory set o:<[catalyst_item]> slot:13 d:<player.open_inventory>
        - inventory adjust slot:13 "lore:<list[<&7>Untuk refine +<[target]>|<&7>Peluang sukses: <[chance]>%|<&7>Biaya: 1 katalis dan 5 level EXP]>" d:<player.open_inventory>
        - inventory set o:anvil slot:22 d:<player.open_inventory>
        - inventory adjust slot:22 "display_name:<&a>Klik untuk mencoba refine" d:<player.open_inventory>
        - inventory adjust slot:22 "lore:<list[<&7>Target: +<[target]>|<&7>Gagal dapat menurunkan refine atau menghancurkan item]>" d:<player.open_inventory>
        - flag player crucible.refine_gui:true expire:5m
        - narrate "<&6>[Crucible] <&e>GUI refine terbuka. Biaya setiap percobaan adalah 1 katalis dan 5 level EXP."
        - stop
    - narrate "<&6>[Crucible] <&c>Subperintah tidak dikenal. Gunakan /crucible untuk bantuan."

crucible_gui_events:
    type: world
    debug: false
    events:
        on player clicks in inventory:
        - if <context.inventory.title.contains_text[Pemurnian Crucible]> != true:
            - stop
        - determine cancelled
        - if <context.raw_slot> != 22:
            - stop
        - inventory close
        - run crucible_refine_attempt player:<player>

        on player drags in inventory:
        - if <context.inventory.title.contains_text[Pemurnian Crucible]>:
            - determine cancelled

crucible_refine_attempt:
    type: task
    debug: false
    script:
    - if !<player.item_in_hand.has_flag[crucible.level]>:
        - narrate "<&6>[Crucible] <&c>Pegang item Crucible terdaftar sebelum menekan tombol refine."
        - stop
    - define refine <player.item_in_hand.flag[crucible.refine].if_null[0].as_int>
    - define target <[refine].add[1]>
    - if <[target]> > <script[crucible_config].data_key[refine_max].as_int>:
        - narrate "<&6>[Crucible] <&e>Item ini sudah mencapai refine maksimum."
        - stop
    - if <[target]> <= 5:
        - define catalyst <script[crucible_config].data_key[catalyst_a_material]>
        - define catalyst_name <script[crucible_config].data_key[catalyst_a_name]>
    - else if <[target]> <= 10:
        - define catalyst <script[crucible_config].data_key[catalyst_b_material]>
        - define catalyst_name <script[crucible_config].data_key[catalyst_b_name]>
    - else:
        - define catalyst <script[crucible_config].data_key[catalyst_c_material]>
        - define catalyst_name <script[crucible_config].data_key[catalyst_c_name]>
    - define catalyst_item <item[<[catalyst]>].with[display=<[catalyst_name]>]>
    - define chance <script[crucible_config].data_key[chance_<[target]>].as_int>
    - define cost <script[crucible_config].data_key[refine_exp_cost].as_int>
    - if <player.inventory.quantity_item[<[catalyst_item]>]> < 1:
        - narrate "<&6>[Crucible] <&c>Katalis <[catalyst]> tidak ditemukan di inventori."
        - stop
    - if <player.xp_level> < <[cost]>:
        - narrate "<&6>[Crucible] <&c>Kamu membutuhkan <[cost]> level EXP pemain."
        - stop
    - take item:<[catalyst_item]> quantity:1
    - experience take level <[cost]>
    - if <util.random.int[1].to[100]> <= <[chance]>:
        - inventory flag slot:hand crucible.refine:<[target]>
        - narrate "<&6>[Crucible] <&a>Refine berhasil: +<[target]>!"
    - else:
        - define new_refine <[refine]>
        - if <[target]> <= 3:
            - narrate "<&6>[Crucible] <&c>Refine gagal. Item tetap utuh."
        - else if <[target]> <= 6:
            - define new_refine <[refine].sub[1]>
            - if <[new_refine]> < 0:
                - define new_refine 0
            - narrate "<&6>[Crucible] <&c>Refine gagal dan turun satu level."
        - else if <[target]> < 15:
            - define new_refine <[refine].sub[2]>
            - if <[new_refine]> < 0:
                - define new_refine 0
            - narrate "<&6>[Crucible] <&c>Korosi! Refine turun dua level."
        - else:
            - if <util.random.int[1].to[100]> <= 20:
                - take iteminhand
                - narrate "<&6>[Crucible] <&c>Item hancur saat percobaan refine +15."
                - stop
            - define new_refine 0
            - narrate "<&6>[Crucible] <&c>Refine gagal. Level refine kembali ke +0."
        - inventory flag slot:hand crucible.refine:<[new_refine]>
    - run crucible_refresh player:<player>

crucible_refresh:
    type: task
    debug: false
    script:
    - define item <player.item_in_hand>
    - define level <[item].flag[crucible.level].if_null[1]>
    - define exp <[item].flag[crucible.exp].if_null[0]>
    - define refine <[item].flag[crucible.refine].if_null[0]>
    - define potential <[item].flag[crucible.potential].if_null[0]>
    - define rank "??? (Periksa ke Penilai)"
    - if <[item].flag[crucible.identified].if_null[false]> == true:
        - if <[potential]> >= 4.5:
            - define rank SS
        - else if <[potential]> >= 4:
            - define rank S
        - else if <[potential]> >= 3:
            - define rank A
        - else if <[potential]> >= 1:
            - define rank B
        - else if <[potential]> >= -1.2:
            - define rank C
        - else if <[potential]> >= -2.4:
            - define rank D
        - else if <[potential]> >= -3.7:
            - define rank E
        - else:
            - define rank F
    - inventory adjust slot:hand "lore:<list[<&7>Level: <[level]>/10|<&7>EXP Penguasaan: <[exp]>/100|<&7>Refine: +<[refine]>|<&7>Kualitas: <[rank]>]>"

crucible_anvil_fusion:
    type: world
    debug: false
    events:
        on player prepares anvil craft item:
        - define anvil <context.inventory>
        - define left <[anvil].slot[1]>
        - define right <[anvil].slot[2]>
        - if !<[left].has_flag[crucible.level]> || !<[right].has_flag[crucible.level]>:
            - stop
        - if <[left].material> != <[right].material>:
            - stop
        - define left_potential <[left].flag[crucible.potential].if_null[0].as_decimal>
        - define right_potential <[right].flag[crucible.potential].if_null[0].as_decimal>
        - define level <[left].flag[crucible.level].if_null[1]>
        - define exp <[left].flag[crucible.exp].if_null[0]>
        - define refine <[left].flag[crucible.refine].if_null[0]>
        - define identified false
        - if <[left].flag[crucible.identified].if_null[false]> == true || <[right].flag[crucible.identified].if_null[false]> == true:
            - define identified true
        - define outcome <util.random.int[1].to[100]>
        - if <[outcome]> <= 10:
            - determine result:i@air
            - stop
        - define potential 0
        - if <[outcome]> <= 25:
            - define potential <[left_potential].max[<[right_potential]>].mul[1.05]>
        - else if <[outcome]> <= 75:
            - define potential <[left_potential].add[<[right_potential]>].div[2]>
        - else:
            - define potential <[left_potential].add[<[right_potential]>].div[2].sub[<util.random.decimal[0.5].to[1.5]>]>
        - define rank "??? (Periksa ke Penilai)"
        - if <[identified]> == true:
            - if <[potential]> >= 4.5:
                - define rank SS
            - else if <[potential]> >= 4:
                - define rank S
            - else if <[potential]> >= 3:
                - define rank A
            - else if <[potential]> >= 1:
                - define rank B
            - else if <[potential]> >= -1.2:
                - define rank C
            - else if <[potential]> >= -2.4:
                - define rank D
            - else if <[potential]> >= -3.7:
                - define rank E
            - else:
                - define rank F
        - define result <context.item>
        - flag <[result]> crucible.level:<[level]>
        - flag <[result]> crucible.exp:<[exp]>
        - flag <[result]> crucible.refine:<[refine]>
        - flag <[result]> crucible.potential:<[potential]>
        - flag <[result]> crucible.identified:<[identified]>
        - define lore <list[<&7>Level: <[level]>/10|<&7>EXP Penguasaan: <[exp]>/100|<&7>Refine: +<[refine]>|<&7>Kualitas: <[rank]>]>
        - define result <[result].with[lore=<[lore]>]>
        - determine result:<[result]>

crucible_mastery:
    type: world
    debug: false
    events:
        on player damages entity:
        - if !<player.item_in_hand.has_flag[crucible.level]>:
            - stop
        - define material <player.item_in_hand.material>
        - define is_weapon false
        - if <[material].contains_text[sword]>:
            - define is_weapon true
        - if <[material].contains_text[axe]>:
            - define is_weapon true
        - if <[material].contains_text[mace]>:
            - define is_weapon true
        - if <[material].contains_text[trident]>:
            - define is_weapon true
        - if <[is_weapon]> == false:
            - stop
        - define exp <player.item_in_hand.flag[crucible.exp].if_null[0].as_int.add[2]>
        - define level <player.item_in_hand.flag[crucible.level].if_null[1].as_int>
        - if <[exp]> >= 100:
            - if <[level]> < 10:
                - define exp <[exp].sub[100]>
                - define level <[level].add[1]>
            - else:
                - define exp 0
        - inventory flag slot:hand crucible.exp:<[exp]>
        - inventory flag slot:hand crucible.level:<[level]>
        - run crucible_refresh player:<player>

        on player breaks block:
        - if !<player.item_in_hand.has_flag[crucible.level]>:
            - stop
        - define material <player.item_in_hand.material>
        - define block <context.material>
        - define gain 0
        - if <[material].contains_text[pickaxe]> || <[material].contains_text[shovel]>:
            - define gain 1
            - if <[block].contains_text[ore]> || <[block].contains_text[ancient_debris]>:
                - define gain 5
        - else if <[material].contains_text[axe]>:
            - if <[block].contains_text[log]> || <[block].contains_text[wood]> || <[block].contains_text[stem]> || <[block].contains_text[hyphae]>:
                - define gain 1
        - if <[gain]> == 0:
            - stop
        - define exp <player.item_in_hand.flag[crucible.exp].if_null[0].as_int.add[<[gain]>]>
        - define level <player.item_in_hand.flag[crucible.level].if_null[1].as_int>
        - if <[exp]> >= 100:
            - if <[level]> < 10:
                - define exp <[exp].sub[100]>
                - define level <[level].add[1]>
            - else:
                - define exp 0
        - inventory flag slot:hand crucible.exp:<[exp]>
        - inventory flag slot:hand crucible.level:<[level]>
        - run crucible_refresh player:<player>