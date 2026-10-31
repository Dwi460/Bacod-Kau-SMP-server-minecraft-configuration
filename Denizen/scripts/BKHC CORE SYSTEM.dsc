# =============================================================================
#  BACODKAU HARDCORE (BKHC) - FILE 1: CORE SYSTEM
#  Letakkan di: plugins/Denizen/scripts/BKHC_Core.dsc
#
#  Isi:
#    1.  config_bkhc      semua angka dan pesan inti
#    2.  random_tp_task, random_teleport_on_spawn   teleport acak
#    3.  death_listener, void_*    mati -> dimensi void -> teleport
#    4.  totem_listener, givetotem_command, totemevent_command   totem
#    5.  mendingvillager_listener, fishing_mending_listener   mending
#    6.  hide_nametag_listener, local_chat_listener   nametag & chat radius
#    7.  gameplay_handler          ancient debris, pesan join/quit
#    8.  frisk_*                   penggeledahan (menu, aman Bedrock)
#    9.  stack_golden_apple, item_cooldown, mace_cooldown, disable_explode
#   10.  compass_handler, tab_*    kompas dan tab list
# =============================================================================


# =============================================================================
#  1. CONFIG
# =============================================================================
config_bkhc:
    type: data
    rtp location: "5000"
    world border: "10000"
    world nether border: "1250"
    world the_end border: "1000"
    void border: "1000"
    rtp world name: "world"
    rtp max attempts: "10"
    rtp protect duration: "20s"
    compass target: "100000,100,100000,world"
    void world name: "void"
    void spawn: "0,100,0"
    void base minutes: "5"
    void extra minutes: "5"
    chat radius: "8"
    max stack golden apple: "12"
    ender pearl cooldown: "10s"
    trident cooldown: "30s"
    mending fishing chance: "20"
    mending villager chance: "50"
    heavy core pickup denominator: "8"
    message:
        prefix: "<&4><&l>BacodKau HC <&5>/"
        disable chat: "<&4>Chat Disable"
        mati: "Anda telah mati"
        req inventory: "<&f>Kamu telah mengirimkan izin untuk penggeledahan"
        reject req inventory: "<&f>Penggeledahan ditolak"
        get req inventory:
            1: "<&f>Kamu ingin digeledah. Apakah kamu mengizinkannya"
            2: "Ya"
            3: "TIDAK!!!"

diamond_bank_command:
    type: command
    name: diamondbank
    description: Deposit or withdraw diamonds from your bank.
    usage: /diamondbank <deposit|withdraw> <amount>
    debug: false
    script:
    - if <context.args.size> != 2:
        - narrate "<&c>Gunakan: /diamondbank <deposit|withdraw> <jumlah>"
        - stop
    - if !<context.args.get[2].is_integer>:
        - narrate "<&c>Jumlah harus berupa bilangan bulat positif."
        - stop
    - define action <context.args.get[1].to_lowercase>
    - define amount <context.args.get[2].as_int>
    - if <[amount]> <= 0:
        - narrate "<&c>Jumlah harus lebih dari 0."
        - stop
    - define balance <player.flag[diamond_bank]||0>
    - choose <[action]>:
        - case deposit:
            - if <player.inventory.quantity[diamond]> < <[amount]>:
                - narrate "<&c>Diamond di inventory tidak cukup."
                - stop
            - take item:diamond quantity:<[amount]>
            - flag <player> diamond_bank:<[balance].add[<[amount]>]>
            - narrate "<&a>Berhasil deposit <[amount]> diamond. Saldo: <player.flag[diamond_bank]>."
        - case withdraw:
            - if <[balance]> < <[amount]>:
                - narrate "<&c>Saldo Diamond Bank tidak cukup."
                - stop
            - flag <player> diamond_bank:<[balance].sub[<[amount]>]>
            - give diamond quantity:<[amount]>
            - narrate "<&a>Berhasil withdraw <[amount]> diamond. Saldo: <player.flag[diamond_bank]>."
        - default:
            - narrate "<&c>Gunakan: /diamondbank <deposit|withdraw> <jumlah>"

gameplay_command:
    type: command
    name: bkhcgameplay
    description: active command
    usage: /bkhcgameplay
    permission: bkhc.gameplay.admin
    debug: false
    script:
        - if <context.source_type> != PLAYER:
            - narrate "<&c>Command ini hanya bisa dijalankan oleh player."
            - stop
        - define world <player.location.world>
        - define nama <[world].name>
        - define pusat <location[0,0,0,<[nama]>]>
        - choose <[nama]>:
            - case world:
                - worldborder <[world]> center:<[pusat]> size:<script[config_bkhc].parsed_key[world border]> duration:1s
                - gamerule <[world]> reduced_debug_info true
                - gamerule <[world]> show_advancement_messages false
                - gamerule <[world]> show_death_messages false
                - gamerule <[world]> allow_entering_nether_using_portals false
                - gamerule <[world]> immediate_respawn true
                - gamerule <[world]> locator_bar false
                - gamerule <[world]> spawn_phantoms false
                - adjust <[world]> difficulty:hard
                - narrate "<&a>Configurasi selesai pada Overworld"
            - case world_nether:
                - worldborder <[world]> center:<[pusat]> size:<script[config_bkhc].parsed_key[world nether border]> duration:1s
                - gamerule <[world]> reduced_debug_info true
                - gamerule <[world]> show_advancement_messages false
                - gamerule <[world]> show_death_messages false
                - gamerule <[world]> immediate_respawn true
                - gamerule <[world]> locator_bar false
                - gamerule <[world]> spawn_phantoms false
                - adjust <[world]> difficulty:hard
                - narrate "<&a>Configurasi selesai pada Nether"
            - case world_the_end:
                - worldborder <[world]> center:<[pusat]> size:<script[config_bkhc].parsed_key[world the_end border]> duration:1s
                - gamerule <[world]> reduced_debug_info true
                - gamerule <[world]> show_advancement_messages false
                - gamerule <[world]> show_death_messages false
                - gamerule <[world]> allow_entering_nether_using_portals false
                - gamerule <[world]> immediate_respawn true
                - gamerule <[world]> locator_bar false
                - gamerule <[world]> spawn_phantoms false
                - adjust <[world]> difficulty:hard
                - narrate "<&a>Configurasi selesai pada The End"
            - case void:
                - worldborder <[world]> center:<[pusat]> size:<script[config_bkhc].parsed_key[void border]> duration:1s
                - gamerule <[world]> reduced_debug_info true
                - gamerule <[world]> show_advancement_messages false
                - gamerule <[world]> show_death_messages false
                - gamerule <[world]> allow_entering_nether_using_portals false
                - gamerule <[world]> immediate_respawn true
                - gamerule <[world]> locator_bar false
                - gamerule <[world]> spawn_phantoms false
                - adjust <[world]> difficulty:peaceful
                - narrate "<&a>Configurasi selesai pada void"
            - default:
                - narrate "<&c>World <[nama]> tidak punya konfigurasi di script ini."

# =============================================================================
#  2. TELEPORT ACAK
# =============================================================================
random_tp_task:
    type: task
    debug: false
    script:
    - define cfg <script[config_bkhc]>
    - define world <[cfg].data_key[rtp world name]>
    - define wt <world[<[world]>]>
    - define protect <[cfg].data_key[rtp protect duration]>
    - cast RESISTANCE duration:<[protect]> amplifier:100 hide_particles no_icon no_ambient
    - define range <[cfg].data_key[rtp location]>
    - define half <[wt].border_size.div[2].sub[100].round_down>
    - if <[half]> < <[range]>:
        - define range <[half]>
    - define cx <[wt].border_center.x>
    - define cz <[wt].border_center.z>
    - wait 1s
    - stop if:!<player.is_online>
    - define found false
    - repeat <[cfg].data_key[rtp max attempts]>:
        - define x <util.random.int[-<[range]>].to[<[range]>].add[<[cx]>]>
        - define z <util.random.int[-<[range]>].to[<[range]>].add[<[cz]>]>
        - define spot <location[<[x]>,100,<[z]>,<[world]>]>
        - chunkload <[spot].chunk> duration:1m
        - define ground <[spot].highest>
        - define bad_ground <list[magma_block|cactus|campfire|soul_campfire].contains[<[ground].material.name>]>
        - define bad_above <list[water|lava|fire|soul_fire|powder_snow|cactus].contains[<[ground].above.material.name>]>
        - if <[ground].y> > 0 && <[bad_ground]> == false && <[bad_above]> == false:
            - define found true
            - repeat stop
    - if <[found]>:
        - define target <[ground].above[2].add[0.5,0,0.5]>
    - else:
        - define target <[wt].spawn_location>
    - teleport <player> <[target]>
    - adjust <player> fall_distance:0
    - cast RESISTANCE duration:<[protect]> amplifier:100 hide_particles no_icon no_ambient
    - announce to_console "[RTP] <player.name> -> <[target].simple> (found=<[found]>)"

random_teleport_on_spawn:
    type: world
    debug: false
    events:
        after player joins:
        - if !<player.has_flag[ulang]>:
            - flag <player> death:!
            - flag <player> ulang
        - if !<player.has_flag[first]>:
            - flag <player> first
            - run random_tp_task
        - else if <player.has_flag[in_void]>:
            - run void_enter
        - else if <player.has_flag[need_tp]> && <player.health> > 0:
            - run void_release
        - compass <script[config_bkhc].data_key[compass target]>
        after player respawns:
        - if <player.has_flag[in_void]>:
            - run void_enter
        - else if <player.has_flag[need_tp]>:
            - run void_release


# =============================================================================
#  3. KEMATIAN -> VOID
# =============================================================================
death_listener:
    type: world
    debug: false
    events:
        after player death:
        - define cfg <script[config_bkhc]>
        - flag <player> death:++
        - define deaths <player.flag[death]>
        - if <proc[event_active].context[void_maintenance|<player>]>:
            - define minutes 1
        - else:
            - define minutes <[cfg].data_key[void base minutes].add[<[deaths].sub[1].mul[<[cfg].data_key[void extra minutes]>]>]>
        - flag <player> in_void expire:<[minutes]>m
        - flag <player> void_total:<[minutes].mul[60]>
        - flag <player> need_tp
        - announce to_console "[DEATH] <player.name> <player.location.simple> | <context.message> | void <[minutes]> menit"
        - narrate "Kamu mati! Selamat menunggu di void selama <[minutes]> menit"
        - if !<server.has_flag[first]>:
            - flag server first
            - announce "<&4><&l>BKHC<&e><&l>/ <&f><player.name> AWKAOWKAOK mati, cupu banget. Silahkan tunggu <[minutes]> menit di Void"

void_enter:
    type: task
    debug: false
    script:
    - wait 1s
    - stop if:!<player.is_online>
    - if <player.health> <= 0:
        - stop
    - define cfg <script[config_bkhc]>
    - if !<player.has_flag[void_original_can_fly]>:
        - flag <player> void_original_can_fly:<player.can_fly>
        - flag <player> void_original_fly_speed:<player.fly_speed>
    - define vworld <[cfg].data_key[void world name]>
    - if <server.worlds.parse[name].contains[<[vworld]>]>:
        - define parts <[cfg].data_key[void spawn].split[,]>
        - teleport <player> <location[<[parts].get[1]>,<[parts].get[2]>,<[parts].get[3]>,<[vworld]>]>
    - else:
        - if !<player.has_flag[void_fallback_gamemode]>:
            - flag <player> void_fallback_gamemode:<player.gamemode>
        - flag <player> void_fallback
        - adjust <player> gamemode:spectator
    - adjust <player> can_fly:true
    - adjust <player> fly_speed:0.1
    - adjust <player> flying:true
    - run void_wait_task

void_wait_task:
    type: task
    debug: false
    script:
    - if <player.has_flag[void_loop]>:
        - stop
    - define id void_<player.uuid>
    - while <player.is_online> && <player.has_flag[in_void]>:
        - flag <player> void_loop expire:3s
        - define left <player.flag_expiration[in_void].from_now>
        - define total <player.flag[void_total].if_null[600]>
        - define progress <[left].in_seconds.div[<[total]>]>
        - if <[progress]> > 1:
            - define progress 1
        - bossbar <[id]> players:<player> "title:<&b>⚡Void <&8>- <&f><[left].formatted>" progress:<[progress]> color:blue
        - wait 1s
    - if <player.is_online>:
        - bossbar remove <[id]> players:<player>
    - flag <player> void_loop:!
    - if <player.is_online> && !<player.has_flag[in_void]>:
        - run void_release

void_release:
    type: task
    debug: false
    script:
    - flag <player> need_tp:!
    - flag <player> in_void:!
    - flag <player> void_total:!
    - define restore_can_fly <player.flag[race_can_fly]||<player.flag[void_original_can_fly]||false>>
    - define restore_fly_speed <player.flag[race_fly_speed]||<player.flag[void_original_fly_speed]||0.05>>
    - if <player.has_flag[void_fallback]>:
        - define fallback_gamemode <player.flag[void_fallback_gamemode]||survival>
        - flag <player> void_fallback:!
        - flag <player> void_fallback_gamemode:!
        - adjust <player> gamemode:<[fallback_gamemode]>
    - adjust <player> flying:false
    - adjust <player> can_fly:<[restore_can_fly]>
    - adjust <player> fly_speed:<[restore_fly_speed]>
    - flag <player> void_original_can_fly:!
    - flag <player> void_original_fly_speed:!
    - define bed <player.bed_spawn||null>
    - if <[bed]> != null:
        - teleport <player> <[bed]>
    - else:
        - run random_tp_task


# =============================================================================
#  4. TOTEM
# =============================================================================
totem_listener:
    type: world
    debug: false
    events:
        on evoker death:
        - if <server.has_flag[totem_event]>:
            - define keep <list>
            - foreach <context.drops> as:drop:
                - if <[drop]> !matches totem_of_undying:
                    - define keep:->:<[drop]>
            - define limit <server.flag[totem_event_limit]||0>
            - define count <server.flag[totem_event_count]||0>
            - if <[limit]> == 0 || <[count]> < <[limit]>:
                - if <util.random.int[1].to[10000]> <= <server.flag[totem_event].mul[100]>:
                    - define count <[count].add[1]>
                    - flag server totem_event_count:<[count]>
                    - define keep:->:<item[totem_of_undying]>
                    - announce to_console "[TOTEMEVENT] totem jatuh (<[count]>/<[limit]>)"
                    - narrate "totem jatuh!"
                    - if <[limit]> > 0 && <[count]> >= <[limit]>:
                        - flag server "totem_event_reason:batas totem tercapai"
                        - flag server totem_event:!
                        - run totem_event_finish
            - if <[keep].is_empty>:
                - determine no_drops
            - else:
                - determine <[keep]>
        on server start:
        - if <server.has_flag[totem_event_started]>:
            - run totem_event_watch
        on reload scripts:
        - if <server.has_flag[totem_event_started]>:
            - run totem_event_watch

givetotem_command:
    type: command
    name: givetotem
    debug: false
    description: Memberi Totem of Undying kepada pemain.
    usage: /givetotem pemain [jumlah]
    permission: bkhc.totem.admin.give
    permission message: <&c>Kamu tidak punya izin untuk ini (<[permission]>).
    script:
    - define target <server.match_player[<context.args.get[1]||>]||null>
    - if <[target]> == null:
        - narrate "<&c>Pemain tidak ditemukan. Pakai: /givetotem pemain [jumlah]"
        - stop
    - define amount <context.args.get[2]||1>
    - if !<[amount].is_integer> || <[amount]> < 1 || <[amount]> > 64:
        - narrate "<&c>Jumlah harus angka 1 sampai 64."
        - stop
    - give totem_of_undying quantity:<[amount]> to:<[target].inventory>
    - narrate "<&a>Memberi <[amount]> Totem of Undying ke <[target].name>."
    - narrate "<&a>Kamu menerima <[amount]> Totem of Undying dari admin." targets:<[target]>
    - announce to_console "[TOTEM] <player.name||console> memberi <[amount]> totem ke <[target].name>"
    - announce "<&a>[Berkah Dewa] <[target].name> mendapat berkah berupa <[amount]> totem"

totem_event_watch:
    type: task
    debug: false
    script:
    - if <server.has_flag[totem_watch]>:
        - stop
    - while <server.has_flag[totem_event_started]>:
        - flag server totem_watch expire:15s
        - if !<server.has_flag[totem_event]>:
            - run totem_event_finish
        - wait 5s
    - flag server totem_watch:!

totem_event_finish:
    type: task
    debug: false
    script:
    - if !<server.has_flag[totem_event_started]>:
        - stop
    - define total <server.flag[totem_event_count]||0>
    - define reason <server.flag[totem_event_reason]||null>
    - if <[reason]> == null:
        - define reason "waktu habis"
    - flag server totem_event_started:!
    - flag server totem_event:!
    - flag server totem_event_count:!
    - flag server totem_event_limit:!
    - flag server totem_event_reason:!
    - announce "<&6>[Berkah Dewa] <&e>Event Totem selesai (<[reason]>). Total totem terkumpul: <&f><[total]><&e>."
    - announce to_console "[TOTEMEVENT] selesai (<[reason]>), total totem: <[total]>"

totemevent_command:
    type: command
    name: totemevent
    debug: false
    description: Memulai event totem: evoker menjatuhkan totem dengan peluang tertentu.
    usage: /totemevent chance waktu [batas] | stop | status
    permission: bkhc.totem.event
    permission message: <&c>Kamu tidak punya izin untuk ini (<[permission]>).
    script:
    - define sub <context.args.get[1]||status>
    - if <[sub]> == status:
        - if !<server.has_flag[totem_event]>:
            - narrate "<&7>Tidak ada Event Totem yang berjalan."
            - stop
        - define left <server.flag_expiration[totem_event].from_now.formatted>
        - define limit <server.flag[totem_event_limit]||0>
        - define count <server.flag[totem_event_count]||0>
        - define limit_text <[limit]>
        - if <[limit]> == 0:
            - define limit_text "tanpa batas"
        - narrate "<&6>Event Totem: <&e><server.flag[totem_event]>% <&7>| sisa <&f><[left]> <&7>| totem <&f><[count]>/<[limit_text]>"
        - stop
    - if <[sub]> == stop:
        - if !<server.has_flag[totem_event_started]>:
            - narrate "<&7>Tidak ada Event Totem yang berjalan."
            - stop
        - flag server "totem_event_reason:dihentikan admin"
        - run totem_event_finish
        - stop
    - define chance <[sub]>
    - if !<[chance].is_decimal>:
        - narrate "<&c>Pakai: /totemevent chance waktu [batas] | stop | status"
        - stop
    - if <[chance]> <= 0 || <[chance]> > 100:
        - narrate "<&c>Chance harus lebih dari 0 dan paling besar 100 (persen)."
        - stop
    - define dur_text <context.args.get[2]||null>
    - if <[dur_text]> == null || <[dur_text].contains_text[-]>:
        - narrate "<&c>Waktu wajib diisi, contoh: 30m, 1h, 1d, 2w (tanpa rentang)."
        - stop
    - define dur <duration[<[dur_text]>]||null>
    - if <[dur]> == null:
        - narrate "<&c>Waktu tidak valid. Satuan: t s m h d w y (contoh 1d)."
        - stop
    - if <[dur].in_seconds> <= 0:
        - narrate "<&c>Waktu harus lebih dari 0."
        - stop
    - define limit <context.args.get[3]||0>
    - if !<[limit].is_integer> || <[limit]> < 0:
        - narrate "<&c>Batas totem harus angka bulat 0 atau lebih (0 = tanpa batas)."
        - stop
    - if <server.has_flag[totem_event_started]>:
        - if <server.has_flag[totem_event]>:
            - narrate "<&c>Event Totem masih berjalan. Pakai /totemevent stop dulu."
            - stop
        - run totem_event_finish
    - flag server totem_event:<[chance]> expire:<[dur]>
    - flag server totem_event_started
    - flag server totem_event_count:0
    - if <[limit]> > 0:
        - flag server totem_event_limit:<[limit]>
    - else:
        - flag server totem_event_limit:!
    - run totem_event_watch
    - define until <util.time_now.add[<[dur]>].to_zone[Asia/Jakarta].format[d/MM HH:mm]>
    - announce "<&6>[Berkah Dewa] <&e>Event Totem dimulai! Evoker menjatuhkan totem dengan peluang <[chance]>% selama <[dur].formatted> (sampai <[until]> WIB)."
    - announce to_console "[TOTEMEVENT] <player.name||console> chance=<[chance]> durasi=<[dur].formatted> batas=<[limit]>"


# =============================================================================
#  5. MENDING
# =============================================================================
mendingvillager_listener:
    type: world
    debug: false
    events:
        on player right clicks villager:
        - run mending_villager_clean def:<context.entity>
        after villager acquires trade:
        - define result <context.trade.result>
        - if <[result].material.name> != enchanted_book || !<[result].enchantment_map.contains[mending]>:
            - stop
        - define villager <context.entity>
        - inject mending_villager_roll
        after player trades with merchant:
        - define result <context.trade.result>
        - if <[result].material.name> != enchanted_book || !<[result].enchantment_map.contains[mending]>:
            - stop
        - flag <context.merchant> mending_sold
        - inventory close
        - run mending_villager_clean def:<context.merchant>
        - narrate "<&7>Stock Mendingku sudah habis, kamu bisa mencari itu ke villager lain."

# PERGESERAN PELUANG: ditambah event_mending_shift dari BKHC_Event.dsc (mending_boost/mending_nerf).
mending_villager_roll:
    type: task
    debug: false
    script:
    - define chance <script[config_bkhc].data_key[mending villager chance].add[<proc[event_mending_shift].context[none]>]>
    - if <[chance]> < 0:
        - define chance 0
    - if <[chance]> > 100:
        - define chance 100
    - flag <[villager]> mending_ok:!
    - flag <[villager]> mending_no:!
    - if <util.random.int[1].to[100]> <= <[chance]>:
        - flag <[villager]> mending_ok
    - else:
        - flag <[villager]> mending_no

mending_villager_clean:
    type: task
    debug: false
    definitions: villager
    script:
    - define has_mending false
    - foreach <[villager].trades> as:t:
        - define r <[t].result>
        - if <[r].material.name> == enchanted_book && <[r].enchantment_map.contains[mending]>:
            - define has_mending true
    - if <[has_mending]> && !<[villager].has_flag[mending_ok]> && !<[villager].has_flag[mending_no]>:
        - inject mending_villager_roll
    - define blocked <[villager].has_flag[mending_sold]>
    - if <[villager].has_flag[mending_no]>:
        - define blocked true
    - define keep <list>
    - define found false
    - define changed false
    - foreach <[villager].trades> as:trade:
        - define result <[trade].result>
        - if <[result].material.name> == enchanted_book && <[result].enchantment_map.contains[mending]>:
            - if <[blocked]> || <[found]>:
                - define changed true
            - else:
                - define found true
                - define keep:->:<[trade].with[max_uses=1]>
        - else:
            - define keep:->:<[trade]>
    - if <[changed]> || <[found]>:
        - adjust <[villager]> trades:<[keep]>

# PERGESERAN PELUANG: peluang gagal (ganti pufferfish) dikurangi oleh event_mending_shift.
fishing_mending_listener:
    type: world
    debug: false
    events:
        on player fishes while caught_fish:
        - if <context.item.enchantment_map.contains[mending]>:
            - define chance <script[config_bkhc].data_key[mending fishing chance].sub[<proc[event_mending_shift].context[<player>]>]>
            - if <[chance]> < 0:
                - define chance 0
            - if <[chance]> > 100:
                - define chance 100
            - if <util.random.int[1].to[100]> <= <[chance]>:
                - determine caught:pufferfish


# =============================================================================
#  6. NAMETAG DAN CHAT
# =============================================================================
hide_nametag_listener:
    type: world
    debug: false
    events:
        after player joins:
        - team name:hidden_nametag option:name_tag_visibility status:never add:<player>

local_chat_listener:
    type: world
    debug: false
    events:
        on player chats:
        - define radius <script[config_bkhc].data_key[chat radius]>
        - define hearers <player.location.find_players_within[<[radius]>].include[<player>].deduplicate>
        - if <[hearers].size> <= 1:
            - narrate "<&7>Tidak ada seorangpun dalam radius <[radius]> blok yang mendengarmu."
            - announce to_console "[CC] <player.name>: <context.message>"
            - determine cancelled
        - else:
            - narrate "<&7><context.message>" targets:<[hearers]>
            - announce to_console "[CHAT] <player.name>: <context.message>"
            - determine cancelled


# =============================================================================
#  7. GAMEPLAY
# =============================================================================
gameplay_handler:
    type: world
    debug: false
    events:
        on player breaks ancient_debris:
        - narrate "<&4>Disable"
        - determine cancelled
        on player quits bukkit_priority:HIGHEST:
        - determine none
        on player joins bukkit_priority:HIGHEST:
        - determine none


# =============================================================================
#  8. PENGGELEDAHAN INVENTORY (kompatibel Bedrock)
# =============================================================================
frisk_start_task:
    type: task
    debug: false
    definitions: target
    script:
    - define cfg <script[config_bkhc]>
    - define prefix <[cfg].parsed_key[message.prefix]>
    - if !<[target].is_player||false>:
        - stop
    - if <[target].name> == <player.name>:
        - stop
    - if <[target].has_flag[frisk_by]>:
        - narrate "<[prefix]> <&f>Pemain itu masih memilih permintaan lain."
        - stop
    - flag <[target]> frisk_by:<player> expire:30s
    - narrate "<[prefix]> <[cfg].parsed_key[message.req inventory]>"
    - narrate "<[prefix]> <&e><player.name> <[cfg].parsed_key[message.get req inventory.1]>" targets:<[target]>
    - narrate "<[prefix]> <&7>Menu tidak muncul? Ketik <&a>/izinkangeledah<&7> atau <&c>/tolakgeledah<&7>." targets:<[target]>
    - inventory open d:frisk_request_gui player:<[target]>

inventory_check:
    type: world
    debug: false
    events:
        on player right clicks player:
        - ratelimit <player> 1t
        - if !<player.is_sneaking> || <player.item_in_hand> !matches air:
            - stop
        - run frisk_start_task def:<context.entity>

geledah_command:
    type: command
    name: geledah
    debug: false
    description: Meminta izin menggeledah inventory pemain lain.
    usage: /geledah pemain
    script:
    - if !<player.is_player||false>:
        - stop
    - define target <server.match_player[<context.args.get[1]||>]||null>
    - if <[target]> == null:
        - narrate "<&c>Pemain tidak ditemukan. Pakai: /geledah pemain"
        - stop
    - if <player.world> != <[target].world>:
        - narrate "<&c>Kamu harus berada dekat pemain itu."
        - stop
    - if <player.location.distance[<[target].location>]> > 4:
        - narrate "<&c>Kamu harus berada dalam jarak 4 blok dari pemain itu."
        - stop
    - run frisk_start_task def:<[target]>

frisk_yes_button:
    type: item
    material: lime_wool
    display name: <&a><&l>IZINKAN
    lore:
    - <&7>Izinkan inventory-mu digeledah.

frisk_no_button:
    type: item
    material: red_wool
    display name: <&c><&l>TOLAK
    lore:
    - <&7>Tolak penggeledahan.

frisk_info_item:
    type: item
    material: paper
    display name: <&e><&l>Permintaan Penggeledahan
    lore:
    - <&7>Seorang pemain meminta izin untuk
    - <&7>melihat dan mengambil isi inventory-mu.
    - <&7>Namanya ada di chat.

frisk_request_gui:
    type: inventory
    inventory: chest
    title: <&0>Izin Penggeledahan
    gui: true
    slots:
    - [] [] [] [] [] [] [] [] []
    - [] [] [frisk_yes_button] [] [frisk_info_item] [] [frisk_no_button] [] []
    - [] [] [] [] [] [] [] [] []

frisk_gui_handler:
    type: world
    debug: false
    events:
        on player clicks frisk_yes_button in frisk_request_gui:
        - inventory close
        - run frisk_accept_task
        on player clicks frisk_no_button in frisk_request_gui:
        - inventory close
        - run frisk_reject_task

frisk_accept_task:
    type: task
    debug: false
    script:
    - define requester <player.flag[frisk_by]||null>
    - flag <player> frisk_by:!
    - if <[requester]> == null:
        - narrate "<&7>Tidak ada permintaan penggeledahan, atau sudah kedaluwarsa."
        - stop
    - if !<[requester].is_online>:
        - narrate "<&7>Pemain itu sudah tidak online."
        - stop
    - inventory open d:<player.inventory> player:<[requester]>
    - flag <[requester]> frisking:<player> expire:10m
    - narrate "<&7>Kamu mengizinkan <[requester].name> menggeledahmu."
    - narrate "<&7><player.name> mengizinkan penggeledahan." targets:<[requester]>

frisk_reject_task:
    type: task
    debug: false
    script:
    - define requester <player.flag[frisk_by]||null>
    - flag <player> frisk_by:!
    - if <[requester]> == null:
        - narrate "<&7>Tidak ada permintaan penggeledahan, atau sudah kedaluwarsa."
        - stop
    - narrate "<&7>Kamu menolak penggeledahan."
    - if <[requester].is_online>:
        - define cfg <script[config_bkhc]>
        - narrate "<[cfg].parsed_key[message.prefix]> <[cfg].parsed_key[message.reject req inventory]>" targets:<[requester]>

frisk_izinkan_command:
    type: command
    name: izinkangeledah
    debug: false
    description: Mengizinkan penggeledahan inventory-mu.
    usage: /izinkangeledah
    script:
    - if !<player.is_player||false>:
        - stop
    - run frisk_accept_task

frisk_tolak_command:
    type: command
    name: tolakgeledah
    debug: false
    description: Menolak penggeledahan inventory-mu.
    usage: /tolakgeledah
    script:
    - if !<player.is_player||false>:
        - stop
    - run frisk_reject_task

frisk_done_listener:
    type: world
    debug: false
    events:
        after player closes inventory:
        - if !<player.has_flag[frisking]>:
            - stop
        - define target <player.flag[frisking]>
        - flag <player> frisking:!
        - define prefix <script[config_bkhc].parsed_key[message.prefix]>
        - narrate "<[prefix]> <&f>Kamu selesai menggeledah <&e><[target].name><&f>."
        - if <[target].is_online>:
            - narrate "<[prefix]> <&e><player.name> <&f>selesai menggeledah inventory-mu." targets:<[target]>
            - title "title:<&e>Penggeledahan selesai" "subtitle:<&7>oleh <player.name>" targets:<[target]>
        on player quits:
        - flag <player> frisking:!


# =============================================================================
#  9. ITEM (golden apple, cooldown, mace, anti-explode)
# =============================================================================
heavy_core_pickup_listener:
    type: world
    debug: false
    events:
        after player picks up heavy_core:
        - define denominator <script[config_bkhc].data_key[heavy core pickup denominator]>
        - if <util.random.int[1].to[<[denominator]>]> > 1:
            - take item:heavy_core quantity:1
            - narrate "<&c>Heavy Core gagal diamankan. Peluang mendapatkannya adalah 1 banding <[denominator]>."

mace_craft_limit:
    type: world
    debug: false
    events:
        on player crafts mace:
        - if <player.has_flag[mace_crafted]>:
            - determine cancelled
            - narrate "<&c>Kamu hanya dapat membuat Mace satu kali."
        - else:
            - flag <player> mace_crafted
            - narrate "<&a>Ini adalah Mace pertama dan satu-satunya yang dapat kamu craft."

golden_apple_limit_task:
    type: task
    debug: false
    script:
    - define max <script[config_bkhc].data_key[max stack golden apple]>
    - foreach <player.inventory.find_all_items[golden_apple]> as:slot:
        - define qty <player.inventory.slot[<[slot]>].quantity>
        - inventory adjust slot:<[slot]> max_stack_size:<[max]>
        - if <[qty]> > <[max]>:
            - inventory adjust slot:<[slot]> quantity:<[max]>
            - give <item[golden_apple].with[max_stack_size=<[max]>]> quantity:<[qty].sub[<[max]>]>

stack_golden_apple:
    type: world
    debug: false
    events:
        after player joins:
        - run golden_apple_limit_task
        after player picks up golden_apple:
        - run golden_apple_limit_task
        after player clicks golden_apple in inventory:
        - run golden_apple_limit_task
        after player crafts golden_apple:
        - run golden_apple_limit_task

item_cooldown:
    type: world
    debug: false
    events:
        on player damages player:
        - define cooldown <script[config_bkhc].data_key[trident cooldown]>
        - if <player.inventory.contains_item[trident]>:
            - itemcooldown trident d:<[cooldown]>
        - if <context.entity.inventory.contains_item[trident]>:
            - itemcooldown trident d:<[cooldown]> player:<context.entity>
        after ender_pearl launched:
        - if <context.entity.shooter.is_player.if_null[false]>:
            - define thrower <context.entity.shooter>
            - wait 3t
            - itemcooldown ender_pearl d:<script[config_bkhc].data_key[ender pearl cooldown]> player:<[thrower]>

mace_cooldown:
    type: world
    debug: false
    events:
        on player damages entity with:mace:
        - if <player.has_flag[mace_cd]>:
            - determine cancelled
            - ratelimit <player> 1s
            - narrate "<&c>Mace masih cooldown <player.flag_expiration[mace_cd].from_now.formatted>."
            - stop
        - flag <player> mace_cd expire:5s
        - itemcooldown mace d:5s

disable_explode:
    type: world
    debug: false
    events:
        on player crafts respawn_anchor:
        - narrate "<&4>Disable"
        - determine cancelled
        on player crafts end_crystal:
        - narrate "<&4>Disable"
        - determine cancelled
        on player right clicks block with:respawn_anchor:
        - narrate "<&4>Disable"
        - determine cancelled
        on player right clicks block with:end_crystal:
        - narrate "<&4>Disable"
        - determine cancelled
        on player right clicks respawn_anchor with:glowstone:
        - narrate "<&4>Disable"
        - determine cancelled


# =============================================================================
#  10. KOMPAS DAN TAB LIST
# =============================================================================
compass_handler:
    type: world
    debug: false
    events:
        on player right clicks block with:compass:
        - compass <script[config_bkhc].data_key[compass target]>

#tab_listener:
#   type: world
#    debug: false
#    events:
#        on reload scripts:
#        - flag server HUD:!
#        - wait 2s
#        - run tab_loop
#        after player joins:
#        - if !<server.has_flag[HUD]>:
#            - run tab_loop
#
#tab_loop:
#    type: task
#    debug: false
#    script:
#    - flag server HUD:<queue.id>
#    - while <server.has_flag[HUD]> && <server.online_players.size.is[more].than[0]>:
#        - foreach <server.online_players> as:viewer:
#           - adjust <[viewer]> tab_list_info:<proc[tab_header]>|<proc[tab_footer].context[<[viewer]>]>
#       - wait 10t
#    - flag server HUD:!
#
#tab_header:
#    type: procedure
#    debug: false
#    script:
#    - define x:->:<&4><&l>BACODKAU
#    - define x:->:<&4><&l>HARDCORE
#    - define x:->:<&r>
#    - determine <[x].separated_by[<n>]>
#
#tab_footer:
#    type: procedure
#    debug: false
#    definitions: player
#    script:
#    - define x:->:<&r>
#    - define "x:->:<&c>PING<&7><&l>: <&7><[player].ping> • <&c>TPS<&7>: <&7><server.recent_tps.get[1].as_money>"
#    - define hidden <server.online_players.filter_tag[<[filter_value].is_vanished||false>]>
#    - define "x:->:<&c>Online Players<&7><&l>: <&7><server.online_players.size.sub[<[hidden].size>]>"
#    - define "x:->:<&c>Time<&7><&l>: <&7><util.time_now.to_zone[Asia/Jakarta].format[HH:mm]> WIB - <util.time_now.to_zone[Asia/Jakarta].format[d/MM/yyyy]>"
#    - define x:->:<&r>
#    - determine <[x].separated_by[<n>]>      