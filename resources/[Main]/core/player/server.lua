Users = {}
commands = {}
commandSuggestions = {}
groups = {}
Group = {}
Group.__index = Group

local blockedItems = {
    ['hydra'] = true,
    ['cargoplane'] = true,
    ['jet'] = true,
    ['tug'] = true,
    ['dump'] = true,
    ['blimp'] = true,
    ['lazer'] = true,
    ['tanker'] = true,
    ['baller'] = true,
    ["hei_prop_carrier_radar_1_l1"] = true,
    ["v_res_mexball"] = true,
    ["prop_rock_1_a"] = true,
    ["prop_rock_1_b"] = true,
    ["prop_rock_1_c"] = true,
    ["prop_rock_1_d"] = true,
    ["prop_player_gasmask"] = true,
    ["prop_rock_1_e"] = true,
    ["prop_rock_1_f"] = true,
    ["prop_rock_1_g"] = true,
    ["prop_rock_1_h"] = true,
    ["prop_test_boulder_01"] = true,
    ["prop_test_boulder_02"] = true,
    ["prop_test_boulder_03"] = true,
    ["prop_test_boulder_04"] = true,
    ["apa_mp_apa_crashed_usaf_01a"] = true,
    ["ex_prop_exec_crashdp"] = true,
    ["apa_mp_apa_yacht_o1_rail_a"] = true,
    ["apa_mp_apa_yacht_o1_rail_b"] = true,
    ["apa_mp_h_yacht_armchair_01"] = true,
    ["apa_mp_h_yacht_armchair_03"] = true,
    ["apa_mp_h_yacht_armchair_04"] = true,
    ["apa_mp_h_yacht_barstool_01"] = true,
    ["apa_mp_h_yacht_bed_01"] = true,
    ["apa_mp_h_yacht_bed_02"] = true,
    ["apa_mp_h_yacht_coffee_table_01"] = true,
    ["apa_mp_h_yacht_coffee_table_02"] = true,
    ["apa_mp_h_yacht_floor_lamp_01"] = true,
    ["apa_mp_h_yacht_side_table_01"] = true,
    ["apa_mp_h_yacht_side_table_02"] = true,
    ["apa_mp_h_yacht_sofa_01"] = true,
    ["apa_mp_h_yacht_sofa_02"] = true,
    ["apa_mp_h_yacht_stool_01"] = true,
    ["apa_mp_h_yacht_strip_chair_01"] = true,
    ["apa_mp_h_yacht_table_lamp_01"] = true,
    ["apa_mp_h_yacht_table_lamp_02"] = true,
    ["apa_mp_h_yacht_table_lamp_03"] = true,
    ["prop_flag_columbia"] = true,
    ["apa_mp_apa_yacht_o2_rail_a"] = true,
    ["apa_mp_apa_yacht_o2_rail_b"] = true,
    ["apa_mp_apa_yacht_o3_rail_a"] = true,
    ["apa_mp_apa_yacht_o3_rail_b"] = true,
    ["apa_mp_apa_yacht_option1"] = true,
    ["proc_searock_01"] = true,
    ["apa_mp_h_yacht_"] = true,
    ["apa_mp_apa_yacht_option1_cola"] = true,
    ["apa_mp_apa_yacht_option2"] = true,
    ["apa_mp_apa_yacht_option2_cola"] = true,
    ["apa_mp_apa_yacht_option2_colb"] = true,
    ["apa_mp_apa_yacht_option3"] = true,
    ["apa_mp_apa_yacht_option3_cola"] = true,
    ["apa_mp_apa_yacht_option3_colb"] = true,
    ["apa_mp_apa_yacht_option3_colc"] = true,
    ["apa_mp_apa_yacht_option3_cold"] = true,
    ["apa_mp_apa_yacht_option3_cole"] = true,
    ["apa_mp_apa_yacht_jacuzzi_cam"] = true,
    ["apa_mp_apa_yacht_jacuzzi_ripple003"] = true,
    ["apa_mp_apa_yacht_jacuzzi_ripple1"] = true,
    ["apa_mp_apa_yacht_jacuzzi_ripple2"] = true,
    ["apa_mp_apa_yacht_radar_01a"] = true,
    ["apa_mp_apa_yacht_win"] = true,
    ["prop_crashed_heli"] = true,
    ["apa_mp_apa_yacht_door"] = true,
    ["prop_shamal_crash"] = true,
    ["xm_prop_x17_shamal_crash"] = true,
    ["apa_mp_apa_yacht_door2"] = true,
    ["apa_mp_apa_yacht"] = true,
    ["prop_flagpole_2b"] = true,
    ["prop_flagpole_2c"] = true,
    ["prop_flag_canada"] = true,
    ["apa_prop_yacht_float_1a"] = true,
    ["apa_prop_yacht_float_1b"] = true,
    ["apa_prop_yacht_glass_01"] = true,
    ["apa_prop_yacht_glass_02"] = true,
    ["apa_prop_yacht_glass_03"] = true,
    ["apa_prop_yacht_glass_04"] = true,
    ["apa_prop_yacht_glass_05"] = true,
    ["apa_prop_yacht_glass_06"] = true,
    ["apa_prop_yacht_glass_07"] = true,
    ["apa_prop_yacht_glass_08"] = true,
    ["apa_prop_yacht_glass_09"] = true,
    ["apa_prop_yacht_glass_10"] = true,
    ["prop_flag_canada_s"] = true,
    ["prop_flag_eu"] = true,
    ["prop_flag_eu_s"] = true,
    ["prop_target_blue_arrow"] = true,
    ["prop_target_orange_arrow"] = true,
    ["prop_target_purp_arrow"] = true,
    ["prop_target_red_arrow"] = true,
    ["apa_prop_flag_argentina"] = true,
    ["apa_prop_flag_australia"] = true,
    ["apa_prop_flag_austria"] = true,
    ["apa_prop_flag_belgium"] = true,
    ["apa_prop_flag_brazil"] = true,
    ["apa_prop_flag_canadat_yt"] = true,
    ["apa_prop_flag_china"] = true,
    ["apa_prop_flag_columbia"] = true,
    ["apa_prop_flag_croatia"] = true,
    ["apa_prop_flag_czechrep"] = true,
    ["apa_prop_flag_denmark"] = true,
    ["apa_prop_flag_england"] = true,
    ["apa_prop_flag_eu_yt"] = true,
    ["apa_prop_flag_finland"] = true,
    ["apa_prop_flag_france"] = true,
    ["apa_prop_flag_german_yt"] = true,
    ["apa_prop_flag_hungary"] = true,
    ["apa_prop_flag_ireland"] = true,
    ["apa_prop_flag_israel"] = true,
    ["apa_prop_flag_italy"] = true,
    ["apa_prop_flag_jamaica"] = true,
    ["apa_prop_flag_japan_yt"] = true,
    ["apa_prop_flag_canada_yt"] = true,
    ["apa_prop_flag_lstein"] = true,
    ["apa_prop_flag_malta"] = true,
    ["apa_prop_flag_mexico_yt"] = true,
    ["apa_prop_flag_netherlands"] = true,
    ["apa_prop_flag_newzealand"] = true,
    ["apa_prop_flag_nigeria"] = true,
    ["apa_prop_flag_norway"] = true,
    ["apa_prop_flag_palestine"] = true,
    ["apa_prop_flag_poland"] = true,
    ["apa_prop_flag_portugal"] = true,
    ["apa_prop_flag_puertorico"] = true,
    ["apa_prop_flag_russia_yt"] = true,
    ["apa_prop_flag_scotland_yt"] = true,
    ["apa_prop_flag_script"] = true,
    ["apa_prop_flag_slovakia"] = true,
    ["apa_prop_flag_slovenia"] = true,
    ["apa_prop_flag_southafrica"] = true,
    ["apa_prop_flag_southkorea"] = true,
    ["apa_prop_flag_spain"] = true,
    ["apa_prop_flag_sweden"] = true,
    ["apa_prop_flag_switzerland"] = true,
    ["apa_prop_flag_turkey"] = true,
    ["apa_prop_flag_uk_yt"] = true,
    ["apa_prop_flag_us_yt"] = true,
    ["apa_prop_flag_wales"] = true,
    ["prop_flag_uk"] = true,
    ["prop_flag_uk_s"] = true,
    ["prop_flag_us"] = true,
    ["prop_flag_usboat"] = true,
    ["prop_flag_us_r"] = true,
    ["prop_flag_us_s"] = true,
    ["prop_flag_france"] = true,
    ["prop_flag_france_s"] = true,
    ["prop_flag_german"] = true,
    ["prop_flag_german_s"] = true,
    ["prop_flag_ireland"] = true,
    ["prop_flag_ireland_s"] = true,
    ["prop_flag_japan"] = true,
    ["prop_flag_japan_s"] = true,
    ["prop_flag_ls"] = true,
    ["prop_flag_lsfd"] = true,
    ["prop_flag_lsfd_s"] = true,
    ["prop_flag_lsservices"] = true,
    ["prop_flag_lsservices_s"] = true,
    ["prop_flag_ls_s"] = true,
    ["prop_flag_mexico"] = true,
    ["prop_flag_mexico_s"] = true,
    ["prop_flag_russia"] = true,
    ["prop_flag_russia_s"] = true,
    ["prop_flag_s"] = true,
    ["prop_flag_sa"] = true,
    ["prop_flag_sapd"] = true,
    ["prop_flag_sapd_s"] = true,
    ["prop_flag_sa_s"] = true,
    ["prop_flag_scotland"] = true,
    ["prop_flag_scotland_s"] = true,
    ["prop_flag_sheriff"] = true,
    ["prop_flag_sheriff_s"] = true,
    ["prop_flag_uk"] = true,
    ["prop_flag_uk_s"] = true,
    ["prop_flag_us"] = true,
    ["prop_flag_usboat"] = true,
    ["prop_flag_us_r"] = true,
    ["prop_flag_us_s"] = true,
    ["prop_flamingo"] = true,
    ["prop_swiss_ball_01"] = true,
    ["prop_air_bigradar_l1"] = true,
    ["prop_air_bigradar_l2"] = true,
    ["prop_air_bigradar_slod"] = true,
    ["p_fib_rubble_s"] = true,
    ["prop_money_bag_01"] = true,
    ["p_cs_mp_jet_01_s"] = true,
    ["prop_poly_bag_money"] = true,
    ["prop_air_radar_01"] = true,
    ["hei_prop_carrier_radar_1"] = true,
    ["prop_air_bigradar"] = true,
    ["prop_carrier_radar_1_l1"] = true,
    ["prop_asteroid_01"] = true,
    ["prop_xmas_ext"] = true,
    ["p_oil_pjack_01_amo"] = true,
    ["p_oil_pjack_01_s"] = true,
    ["p_oil_pjack_02_amo"] = true,
    ["p_oil_pjack_03_amo"] = true,
    ["p_oil_pjack_02_s"] = true,
    ["p_oil_pjack_03_s"] = true,
    ["prop_aircon_l_03"] = true,
    ["prop_med_jet_01"] = true,
    ["p_med_jet_01_s"] = true,
    ["hei_prop_carrier_jet"] = true,
    ["bkr_prop_biker_bblock_huge_01"] = true,
    ["bkr_prop_biker_bblock_huge_02"] = true,
    ["bkr_prop_biker_bblock_huge_04"] = true,
    ["bkr_prop_biker_bblock_huge_05"] = true,
    ["hei_prop_heist_emp"] = true,
    ["prop_weed_01"] = true,
    ["prop_air_bigradar"] = true,
    ["prop_juicestand"] = true,
    ["prop_lev_des_barge_02"] = true,
    ["hei_prop_carrier_defense_01"] = true,
    ["prop_aircon_m_04"] = true,
    ["prop_mp_ramp_03"] = true,
    ["stt_prop_stunt_track_dwuturn"] = true,
    ["ch3_12_animplane1_lod"] = true,
    ["ch3_12_animplane2_lod"] = true,
    ["hei_prop_hei_pic_pb_plane"] = true,
    ["light_plane_rig"] = true,
    ["prop_cs_plane_int_01"] = true,
    ["prop_dummy_plane"] = true,
    ["prop_mk_plane"] = true,
    ["v_44_planeticket"] = true,
    ["prop_planer_01"] = true,
    ["ch3_03_cliffrocks03b_lod"] = true,
    ["ch3_04_rock_lod_02"] = true,
    ["csx_coastsmalrock_01_"] = true,
    ["csx_coastsmalrock_02_"] = true,
    ["csx_coastsmalrock_03_"] = true,
    ["csx_coastsmalrock_04_"] = true,
    ["mp_player_introck"] = true,
    ["Heist_Yacht"] = true,
    ["csx_coastsmalrock_05_"] = true,
    ["mp_player_int_rock"] = true,
    ["mp_player_introck"] = true,
    ["prop_flagpole_1a"] = true,
    ["prop_flagpole_2a"] = true,
    ["prop_flagpole_3a"] = true,
    ["prop_a4_pile_01"] = true,
    ["cs2_10_sea_rocks_lod"] = true,
    ["cs2_11_sea_marina_xr_rocks_03_lod"] = true,
    ["prop_gold_cont_01"] = true,
    ["prop_hydro_platform"] = true,
    ["ch3_04_viewplatform_slod"] = true,
    ["ch2_03c_rnchstones_lod"] = true,
    ["proc_mntn_stone01"] = true,
    ["prop_beachflag_le"] = true,
    ["proc_mntn_stone02"] = true,
    ["cs2_10_sea_shipwreck_lod"] = true,
    ["des_shipsink_02"] = true,
    ["prop_dock_shippad"] = true,
    ["des_shipsink_03"] = true,
    ["des_shipsink_04"] = true,
    ["prop_mk_flag"] = true,
    ["prop_mk_flag_2"] = true,
    ["proc_mntn_stone03"] = true,
    ["FreeModeMale01"] = true,
    ["rsn_os_specialfloatymetal_n"] = true,
    ["rsn_os_specialfloatymetal"] = true,
    ["cs1_09_sea_ufo"] = true,
    ["rsn_os_specialfloaty2_light2"] = true,
    ["rsn_os_specialfloaty2_light"] = true,
    ["rsn_os_specialfloaty2"] = true,
    ["rsn_os_specialfloatymetal_n"] = true,
    ["rsn_os_specialfloatymetal"] = true,
    ["P_Spinning_Anus_S_Main"] = true,
    ["P_Spinning_Anus_S_Root"] = true,
    ["cs3_08b_rsn_db_aliencover_0001cs3_08b_rsn_db_aliencover_0001_a"] = true,
    ["sc1_04_rnmo_paintoverlaysc1_04_rnmo_paintoverlay_a"] = true,
    ["rnbj_wallsigns_0001"] = true,
    ["proc_sml_stones01"] = true,
    ["proc_sml_stones02"] = true,
    ["maverick"] = true,
    ["Miljet"] = true,
    ["proc_sml_stones03"] = true,
    ["proc_stones_01"] = true,
    ["proc_stones_02"] = true,
    ["proc_stones_03"] = true,
    ["proc_stones_04"] = true,
    ["proc_stones_05"] = true,
    ["proc_stones_06"] = true,
    ["prop_coral_stone_03"] = true,
    ["prop_coral_stone_04"] = true,
    ["prop_gravestones_01a"] = true,
    ["prop_gravestones_02a"] = true,
    ["prop_gravestones_03a"] = true,
    ["prop_gravestones_04a"] = true,
    ["prop_gravestones_05a"] = true,
    ["prop_gravestones_06a"] = true,
    ["prop_gravestones_07a"] = true,
    ["prop_gravestones_08a"] = true,
    ["prop_gravestones_09a"] = true,
    ["prop_gravestones_10a"] = true,
    ["prop_prlg_gravestone_05a_l1"] = true,
    ["prop_prlg_gravestone_06a"] = true,
    ["test_prop_gravestones_04a"] = true,
    ["test_prop_gravestones_05a"] = true,
    ["test_prop_gravestones_07a"] = true,
    ["test_prop_gravestones_08a"] = true,
    ["test_prop_gravestones_09a"] = true,
    ["prop_prlg_gravestone_01a"] = true,
    ["prop_prlg_gravestone_02a"] = true,
    ["prop_prlg_gravestone_03a"] = true,
    ["prop_prlg_gravestone_04a"] = true,
    ["prop_stoneshroom1"] = true,
    ["prop_stoneshroom2"] = true,
    ["v_res_fa_stones01"] = true,
    ["test_prop_gravestones_01a"] = true,
    ["test_prop_gravestones_02a"] = true,
    ["prop_prlg_gravestone_05a"] = true,
    ["FreemodeFemale01"] = true,
    ["p_cablecar_s"] = true,
    ["stt_prop_stunt_tube_l"] = true,
    ["stt_prop_stunt_track_dwuturn"] = true,
    ["p_spinning_anus_s"] = true,
    ["prop_windmill_01"] = true,
    ["hei_prop_heist_tug"] = true,
    ["prop_air_bigradar"] = true,
    ["p_oil_slick_01"] = true,
    ["prop_dummy_01"] = true,
    ["hei_prop_heist_emp"] = true,
    ["p_tram_cash_s"] = true,
    ["hw1_blimp_ce2"] = true,
    ["prop_fire_exting_1a"] = true,
    ["prop_fire_exting_1b"] = true,
    ["prop_fire_exting_2a"] = true,
    ["prop_fire_exting_3a"] = true,
    ["hw1_blimp_ce2_lod"] = true,
    ["hw1_blimp_ce_lod"] = true,
    ["hw1_blimp_cpr003"] = true,
    ["hw1_blimp_cpr_null"] = true,
    ["hw1_blimp_cpr_null2"] = true,
    ["prop_lev_des_barage_02"] = true,
    ["hei_prop_carrier_defense_01"] = true,
    ["prop_juicestand"] = true,
    ["S_M_M_MovAlien_01"] = true,
    ["s_m_m_movalien_01"] = true,
    ["s_m_m_movallien_01"] = true,
    ["u_m_y_babyd"] = true,
    ["CS_Orleans"] = true,
    ["A_M_Y_ACult_01"] = true,
    ["S_M_M_MovSpace_01"] = true,
    ["U_M_Y_Zombie_01"] = true,
    ["s_m_y_blackops_01"] = true,
    ["a_f_y_topless_01"] = true,
    ["a_c_boar"] = true,
    ["a_c_cat_01"] = true,
    ["a_c_chickenhawk"] = true,
    ["a_c_chimp"] = true,
    ["s_f_y_hooker_03"] = true,
    ["a_c_chop"] = true,
    ["a_c_cormorant"] = true,
    ["a_c_cow"] = true,
    ["a_c_coyote"] = true,
    ["v_ilev_found_cranebucket"] = true,
    ["p_cs_sub_hook_01_s"] = true,
    ["a_c_crow"] = true,
    ["a_c_dolphin"] = true,
    ["a_c_fish"] = true,
    ["hei_prop_heist_hook_01"] = true,
    ["prop_rope_hook_01"] = true,
    ["prop_sub_crane_hook"] = true,
    ["s_f_y_hooker_01"] = true,
    ["prop_vehicle_hook"] = true,
    ["prop_v_hook_s"] = true,
    ["prop_dock_crane_02_hook"] = true,
    ["prop_winch_hook_long"] = true,
    ["a_c_hen"] = true,
    ["a_c_humpback"] = true,
    ["a_c_husky"] = true,
    ["a_c_killerwhale"] = true,
    ["a_c_mtlion"] = true,
    ["a_c_pigeon"] = true,
    ["a_c_poodle"] = true,
    ["prop_coathook_01"] = true,
    ["prop_cs_sub_hook_01"] = true,
    ["a_c_pug"] = true,
    ["a_c_rabbit_01"] = true,
    ["a_c_rat"] = true,
    ["a_c_retriever"] = true,
    ["a_c_rhesus"] = true,
    ["a_c_rottweiler"] = true,
    ["a_c_sharkhammer"] = true,
    ["a_c_sharktiger"] = true,
    ["a_c_shepherd"] = true,
    ["a_c_stingray"] = true,
    ["a_c_westy"] = true,
    ["CS_Orleans"] = true,
    ["prop_windmill_01"] = true,
    ["prop_Ld_ferris_wheel"] = true,
    ["p_tram_crash_s"] = true,
    ["p_oil_slick_01"] = true,
    ["p_ld_stinger_s"] = true,
    ["p_ld_soc_ball_01"] = true,
    ["p_parachute1_s"] = true,
    ["p_cablecar_s"] = true,
    ["prop_beach_fire"] = true,
    ["prop_lev_des_barge_02"] = true,
    ["prop_lev_des_barge_01"] = true,
    ["prop_sculpt_fix"] = true,
    ["prop_flagpole_2b"] = true,
    ["prop_flagpole_2c"] = true,
    ["prop_winch_hook_short"] = true,
    ["prop_flag_canada"] = true,
    ["prop_flag_canada_s"] = true,
    ["prop_flag_eu"] = true,
    ["prop_flag_eu_s"] = true,
    ["prop_flag_france"] = true,
    ["prop_flag_france_s"] = true,
    ["prop_flag_german"] = true,
    ["prop_ld_hook"] = true,
    ["prop_flag_german_s"] = true,
    ["prop_flag_ireland"] = true,
    ["prop_flag_ireland_s"] = true,
    ["prop_flag_japan"] = true,
    ["prop_flag_japan_s"] = true,
    ["prop_flag_ls"] = true,
    ["prop_flag_lsfd"] = true,
    ["prop_flag_lsfd_s"] = true,
    ["prop_cable_hook_01"] = true,
    ["prop_flag_lsservices"] = true,
    ["prop_flag_lsservices_s"] = true,
    ["prop_flag_ls_s"] = true,
    ["prop_flag_mexico"] = true,
    ["prop_flag_mexico_s"] = true,
    ["csx_coastboulder_00"] = true,
    ["des_tankercrash_01"] = true,
    ["des_tankerexplosion_01"] = true,
    ["des_tankerexplosion_02"] = true,
    ["des_trailerparka_02"] = true,
    ["des_trailerparkb_02"] = true,
    ["des_trailerparkc_02"] = true,
    ["des_trailerparkd_02"] = true,
    ["des_traincrash_root2"] = true,
    ["des_traincrash_root3"] = true,
    ["des_traincrash_root4"] = true,
    ["des_traincrash_root5"] = true,
    ["des_finale_vault_end"] = true,
    ["des_finale_vault_root001"] = true,
    ["des_finale_vault_root002"] = true,
    ["des_finale_vault_root003"] = true,
    ["des_finale_vault_root004"] = true,
    ["des_finale_vault_start"] = true,
    ["des_vaultdoor001_root001"] = true,
    ["des_vaultdoor001_root002"] = true,
    ["des_vaultdoor001_root003"] = true,
    ["des_vaultdoor001_root004"] = true,
    ["des_vaultdoor001_root005"] = true,
    ["des_vaultdoor001_root006"] = true,
    ["des_vaultdoor001_skin001"] = true,
    ["des_vaultdoor001_start"] = true,
    ["des_traincrash_root6"] = true,
    ["prop_ld_vault_door"] = true,
    ["prop_vault_door_scene"] = true,
    ["prop_vault_door_scene"] = true,
    ["prop_vault_shutter"] = true,
    ["p_fin_vaultdoor_s"] = true,
    ["v_ilev_bk_vaultdoor"] = true,
    ["prop_gold_vault_fence_l"] = true,
    ["prop_gold_vault_fence_r"] = true,
    ["prop_gold_vault_gate_01"] = true,
    ["prop_bank_vaultdoor"] = true,
    ["des_traincrash_root7"] = true,
    ["prop_flag_russia"] = true,
    ["prop_flag_russia_s"] = true,
    ["prop_flag_s"] = true,
    ["ch2_03c_props_rrlwindmill_lod"] = true,
    ["prop_flag_sa"] = true,
    ["prop_flag_sapd"] = true,
    ["prop_flag_sapd_s"] = true,
    ["prop_flag_sa_s"] = true,
    ["prop_flag_scotland"] = true,
    ["prop_flag_scotland_s"] = true,
    ["prop_flag_sheriff"] = true,
    ["prop_flag_sheriff_s"] = true,
    ["prop_flag_uk"] = true,
    ["prop_yacht_lounger"] = true,
    ["prop_yacht_seat_01"] = true,
    ["prop_yacht_seat_02"] = true,
    ["prop_yacht_seat_03"] = true,
    ["marina_xr_rocks_02"] = true,
    ["marina_xr_rocks_03"] = true,
    ["prop_test_rocks01"] = true,
    ["prop_test_rocks02"] = true,
    ["prop_test_rocks03"] = true,
    ["prop_test_rocks04"] = true,
    ["marina_xr_rocks_04"] = true,
    ["marina_xr_rocks_05"] = true,
    ["marina_xr_rocks_06"] = true,
    ["prop_yacht_table_01"] = true,
    ["csx_searocks_02"] = true,
    ["csx_searocks_03"] = true,
    ["csx_searocks_04"] = true,
    ["csx_searocks_05"] = true,
    ["csx_searocks_06"] = true,
    ["p_yacht_chair_01_s"] = true,
    ["p_yacht_sofa_01_s"] = true,
    ["prop_yacht_table_02"] = true,
    ["csx_coastboulder_00"] = true,
    ["csx_coastboulder_01"] = true,
    ["csx_coastboulder_02"] = true,
    ["csx_coastboulder_03"] = true,
    ["csx_coastboulder_04"] = true,
    ["csx_coastboulder_05"] = true,
    ["csx_coastboulder_06"] = true,
    ["csx_coastboulder_07"] = true,
    ["csx_coastrok1"] = true,
    ["csx_coastrok2"] = true,
    ["csx_coastrok3"] = true,
    ["csx_coastrok4"] = true,
    ["csx_coastsmalrock_01"] = true,
    ["csx_coastsmalrock_02"] = true,
    ["csx_coastsmalrock_03"] = true,
    ["csx_coastsmalrock_04"] = true,
    ["csx_coastsmalrock_05"] = true,
    ["prop_yacht_table_03"] = true,
    ["prop_flag_uk_s"] = true,
    ["prop_flag_us"] = true,
    ["prop_flag_usboat"] = true,
    ["prop_flag_us_r"] = true,
    ["prop_flag_us_s"] = true,
    ["p_gasmask_s"] = true,
    ["prop_flamingo"] = true,
    ["stt_prop_stunt_soccer_ball"] = true,
    ["prop_rock_4_big2"] = true,
    ["p_crahsed_heli_s"] = true,
    ["stt_prop_c4_stack"] = true,
    ["stt_prop_corner_sign_01"] = true,
    ["stt_prop_corner_sign_02"] = true,
    ["stt_prop_corner_sign_03"] = true,
    ["stt_prop_corner_sign_04"] = true,
    ["stt_prop_corner_sign_05"] = true,
    ["stt_prop_corner_sign_06"] = true,
    ["stt_prop_corner_sign_07"] = true,
    ["stt_prop_corner_sign_08"] = true,
    ["stt_prop_corner_sign_09"] = true,
    ["stt_prop_corner_sign_10"] = true,
    ["stt_prop_corner_sign_11"] = true,
    ["stt_prop_corner_sign_12"] = true,
    ["stt_prop_corner_sign_13"] = true,
    ["stt_prop_corner_sign_14"] = true,
    ["stt_prop_flagpole_1a"] = true,
    ["stt_prop_flagpole_1b"] = true,
    ["stt_prop_flagpole_1c"] = true,
    ["stt_prop_flagpole_1d"] = true,
    ["stt_prop_flagpole_1e"] = true,
    ["stt_prop_flagpole_1f"] = true,
    ["stt_prop_flagpole_2a"] = true,
    ["stt_prop_flagpole_2b"] = true,
    ["stt_prop_flagpole_2c"] = true,
    ["stt_prop_flagpole_2d"] = true,
    ["stt_prop_flagpole_2e"] = true,
    ["stt_prop_flagpole_2f"] = true,
    ["stt_prop_hoop_constraction_01a"] = true,
    ["stt_prop_hoop_small_01"] = true,
    ["stt_prop_hoop_tyre_01a"] = true,
    ["stt_prop_lives_bottle"] = true,
    ["stt_prop_race_gantry_01"] = true,
    ["stt_prop_race_start_line_01"] = true,
    ["stt_prop_race_start_line_01b"] = true,
    ["stt_prop_race_start_line_02"] = true,
    ["stt_prop_race_start_line_02b"] = true,
    ["stt_prop_race_start_line_03"] = true,
    ["stt_prop_race_start_line_03b"] = true,
    ["stt_prop_race_tannoy"] = true,
    ["stt_prop_ramp_adj_flip_m"] = true,
    ["stt_prop_ramp_adj_flip_mb"] = true,
    ["stt_prop_ramp_adj_flip_s"] = true,
    ["stt_prop_ramp_adj_flip_sb"] = true,
    ["stt_prop_ramp_adj_hloop"] = true,
    ["stt_prop_ramp_adj_loop"] = true,
    ["stt_prop_ramp_jump_l"] = true,
    ["stt_prop_ramp_jump_m"] = true,
    ["stt_prop_ramp_jump_s"] = true,
    ["stt_prop_ramp_jump_xl"] = true,
    ["stt_prop_ramp_jump_xs"] = true,
    ["stt_prop_ramp_jump_xxl"] = true,
    ["stt_prop_ramp_multi_loop_rb"] = true,
    ["stt_prop_ramp_spiral_l"] = true,
    ["stt_prop_ramp_spiral_l_l"] = true,
    ["stt_prop_ramp_spiral_l_m"] = true,
    ["stt_prop_ramp_spiral_l_s"] = true,
    ["stt_prop_ramp_spiral_l_xxl"] = true,
    ["stt_prop_ramp_spiral_m"] = true,
    ["stt_prop_ramp_spiral_s"] = true,
    ["stt_prop_ramp_spiral_xxl"] = true,
    ["stt_prop_sign_circuit_01"] = true,
    ["stt_prop_sign_circuit_02"] = true,
    ["stt_prop_sign_circuit_03"] = true,
    ["stt_prop_sign_circuit_04"] = true,
    ["stt_prop_sign_circuit_05"] = true,
    ["stt_prop_sign_circuit_06"] = true,
    ["stt_prop_sign_circuit_07"] = true,
    ["stt_prop_sign_circuit_08"] = true,
    ["stt_prop_sign_circuit_09"] = true,
    ["stt_prop_sign_circuit_10"] = true,
    ["stt_prop_sign_circuit_11"] = true,
    ["stt_prop_sign_circuit_11b"] = true,
    ["stt_prop_sign_circuit_12"] = true,
    ["stt_prop_sign_circuit_13"] = true,
    ["stt_prop_sign_circuit_13b"] = true,
    ["stt_prop_sign_circuit_14"] = true,
    ["stt_prop_sign_circuit_14b"] = true,
    ["stt_prop_sign_circuit_15"] = true,
    ["stt_prop_slow_down"] = true,
    ["stt_prop_speakerstack_01a"] = true,
    ["stt_prop_startline_gantry"] = true,
    ["stt_prop_stunt_bblock_huge_01"] = true,
    ["stt_prop_stunt_bblock_huge_02"] = true,
    ["stt_prop_stunt_bblock_huge_03"] = true,
    ["stt_prop_stunt_bblock_huge_04"] = true,
    ["stt_prop_stunt_bblock_huge_05"] = true,
    ["stt_prop_stunt_bblock_hump_01"] = true,
    ["stt_prop_stunt_bblock_hump_02"] = true,
    ["stt_prop_stunt_bblock_lrg1"] = true,
    ["stt_prop_stunt_bblock_lrg2"] = true,
    ["stt_prop_stunt_bblock_lrg3"] = true,
    ["stt_prop_stunt_bblock_mdm1"] = true,
    ["stt_prop_stunt_bblock_mdm2"] = true,
    ["stt_prop_stunt_bblock_mdm3"] = true,
    ["stt_prop_stunt_bblock_qp"] = true,
    ["stt_prop_stunt_bblock_qp2"] = true,
    ["stt_prop_stunt_bblock_qp3"] = true,
    ["stt_prop_stunt_bblock_sml1"] = true,
    ["stt_prop_stunt_bblock_sml2"] = true,
    ["stt_prop_stunt_bblock_sml3"] = true,
    ["stt_prop_stunt_bblock_xl1"] = true,
    ["stt_prop_stunt_bblock_xl2"] = true,
    ["stt_prop_stunt_bblock_xl3"] = true,
    ["stt_prop_stunt_bowling_ball"] = true,
    ["stt_prop_stunt_bowling_pin"] = true,
    ["stt_prop_stunt_bowlpin_stand"] = true,
    ["stt_prop_stunt_domino"] = true,
    ["stt_prop_stunt_jump15"] = true,
    ["stt_prop_stunt_jump30"] = true,
    ["stt_prop_stunt_jump45"] = true,
    ["stt_prop_stunt_jump_l"] = true,
    ["stt_prop_stunt_jump_lb"] = true,
    ["stt_prop_stunt_jump_loop"] = true,
    ["stt_prop_stunt_jump_m"] = true,
    ["stt_prop_stunt_jump_mb"] = true,
    ["stt_prop_stunt_jump_s"] = true,
    ["stt_prop_stunt_jump_sb"] = true,
    ["stt_prop_stunt_landing_zone_01"] = true,
    ["stt_prop_stunt_ramp"] = true,
    ["stt_prop_stunt_soccer_ball"] = true,
    ["stt_prop_stunt_soccer_goal"] = true,
    ["stt_prop_stunt_soccer_lball"] = true,
    ["stt_prop_stunt_soccer_sball"] = true,
    ["stt_prop_stunt_target"] = true,
    ["stt_prop_stunt_target_small"] = true,
    ["stt_prop_stunt_track_bumps"] = true,
    ["stt_prop_stunt_track_cutout"] = true,
    ["stt_prop_stunt_track_dwlink"] = true,
    ["stt_prop_stunt_track_dwlink_02"] = true,
    ["stt_prop_stunt_track_dwsh15"] = true,
    ["stt_prop_stunt_track_dwshort"] = true,
    ["stt_prop_stunt_track_dwslope15"] = true,
    ["stt_prop_stunt_track_dwslope30"] = true,
    ["stt_prop_stunt_track_dwslope45"] = true,
    ["stt_prop_stunt_track_dwturn"] = true,
    ["stt_prop_stunt_track_dwuturn"] = true,
    ["stt_prop_stunt_track_exshort"] = true,
    ["stt_prop_stunt_track_fork"] = true,
    ["stt_prop_stunt_track_funlng"] = true,
    ["stt_prop_stunt_track_funnel"] = true,
    ["stt_prop_stunt_track_hill"] = true,
    ["stt_prop_stunt_track_hill2"] = true,
    ["stt_prop_stunt_track_jump"] = true,
    ["stt_prop_stunt_track_link"] = true,
    ["stt_prop_stunt_track_otake"] = true,
    ["stt_prop_stunt_track_sh15"] = true,
    ["stt_prop_stunt_track_sh30"] = true,
    ["stt_prop_stunt_track_sh45"] = true,
    ["stt_prop_stunt_track_sh45_a"] = true,
    ["stt_prop_stunt_track_short"] = true,
    ["stt_prop_stunt_track_slope15"] = true,
    ["stt_prop_stunt_track_slope30"] = true,
    ["stt_prop_stunt_track_slope45"] = true,
    ["stt_prop_stunt_track_start"] = true,
    ["stt_prop_stunt_track_start_02"] = true,
    ["stt_prop_stunt_track_straight"] = true,
    ["stt_prop_stunt_track_straightice"] = true,
    ["stt_prop_stunt_track_st_01"] = true,
    ["stt_prop_stunt_track_st_02"] = true,
    ["stt_prop_stunt_track_turn"] = true,
    ["stt_prop_stunt_track_turnice"] = true,
    ["stt_prop_stunt_track_uturn"] = true,
    ["stt_prop_stunt_tube_crn"] = true,
    ["stt_prop_stunt_tube_crn2"] = true,
    ["stt_prop_stunt_tube_crn_15d"] = true,
    ["stt_prop_stunt_tube_crn_30d"] = true,
    ["stt_prop_stunt_tube_crn_5d"] = true,
    ["stt_prop_stunt_tube_cross"] = true,
    ["stt_prop_stunt_tube_end"] = true,
    ["stt_prop_stunt_tube_ent"] = true,
    ["stt_prop_stunt_tube_fn_01"] = true,
    ["stt_prop_stunt_tube_fn_02"] = true,
    ["stt_prop_stunt_tube_fn_03"] = true,
    ["stt_prop_stunt_tube_fn_04"] = true,
    ["stt_prop_stunt_tube_fn_05"] = true,
    ["stt_prop_stunt_tube_fork"] = true,
    ["stt_prop_stunt_tube_gap_01"] = true,
    ["stt_prop_stunt_tube_gap_02"] = true,
    ["stt_prop_stunt_tube_gap_03"] = true,
    ["stt_prop_stunt_tube_hg"] = true,
    ["stt_prop_stunt_tube_jmp"] = true,
    ["stt_prop_stunt_tube_jmp2"] = true,
    ["stt_prop_stunt_tube_l"] = true,
    ["stt_prop_stunt_tube_m"] = true,
    ["stt_prop_stunt_tube_qg"] = true,
    ["stt_prop_stunt_tube_s"] = true,
    ["stt_prop_stunt_tube_speed"] = true,
    ["stt_prop_stunt_tube_speeda"] = true,
    ["stt_prop_stunt_tube_speedb"] = true,
    ["stt_prop_stunt_tube_xs"] = true,
    ["stt_prop_stunt_tube_xxs"] = true,
    ["stt_prop_stunt_wideramp"] = true,
    ["stt_prop_track_bend2_bar_l"] = true,
    ["stt_prop_track_bend2_bar_l_b"] = true,
    ["stt_prop_track_bend2_l"] = true,
    ["stt_prop_track_bend2_l_b"] = true,
    ["stt_prop_track_bend_15d"] = true,
    ["stt_prop_track_bend_15d_bar"] = true,
    ["stt_prop_track_bend_180d"] = true,
    ["stt_prop_track_bend_180d_bar"] = true,
    ["stt_prop_track_bend_30d"] = true,
    ["stt_prop_track_bend_30d_bar"] = true,
    ["stt_prop_track_bend_5d"] = true,
    ["stt_prop_track_bend_5d_bar"] = true,
    ["stt_prop_track_bend_bar_l"] = true,
    ["stt_prop_track_bend_bar_l_b"] = true,
    ["stt_prop_track_bend_bar_m"] = true,
    ["stt_prop_track_bend_l"] = true,
    ["stt_prop_track_bend_l_b"] = true,
    ["stt_prop_track_bend_m"] = true,
    ["stt_prop_track_block_01"] = true,
    ["stt_prop_track_block_02"] = true,
    ["stt_prop_track_block_03"] = true,
    ["stt_prop_track_chicane_l"] = true,
    ["stt_prop_track_chicane_l_02"] = true,
    ["stt_prop_track_chicane_r"] = true,
    ["stt_prop_track_chicane_r_02"] = true,
    ["stt_prop_track_cross"] = true,
    ["stt_prop_track_cross_bar"] = true,
    ["stt_prop_track_fork"] = true,
    ["stt_prop_track_fork_bar"] = true,
    ["stt_prop_track_funnel"] = true,
    ["stt_prop_track_funnel_ads_01a"] = true,
    ["stt_prop_track_funnel_ads_01b"] = true,
    ["stt_prop_track_funnel_ads_01c"] = true,
    ["stt_prop_track_jump_01a"] = true,
    ["stt_prop_track_jump_01b"] = true,
    ["stt_prop_track_jump_01c"] = true,
    ["stt_prop_track_jump_02a"] = true,
    ["stt_prop_track_jump_02b"] = true,
    ["stt_prop_track_jump_02c"] = true,
    ["stt_prop_track_link"] = true,
    ["stt_prop_track_slowdown"] = true,
    ["stt_prop_track_slowdown_t1"] = true,
    ["stt_prop_track_slowdown_t2"] = true,
    ["stt_prop_track_speedup"] = true,
    ["stt_prop_track_speedup_t1"] = true,
    ["stt_prop_track_speedup_t2"] = true,
    ["stt_prop_track_start"] = true,
    ["stt_prop_track_start_02"] = true,
    ["stt_prop_track_stop_sign"] = true,
    ["stt_prop_track_straight_bar_l"] = true,
    ["stt_prop_track_straight_bar_m"] = true,
    ["stt_prop_track_straight_bar_s"] = true,
    ["stt_prop_track_straight_l"] = true,
    ["stt_prop_track_straight_lm"] = true,
    ["stt_prop_track_straight_lm_bar"] = true,
    ["stt_prop_track_straight_m"] = true,
    ["stt_prop_track_straight_s"] = true,
    ["stt_prop_track_tube_01"] = true,
    ["stt_prop_track_tube_02"] = true,
    ["stt_prop_tyre_wall_01"] = true,
    ["stt_prop_tyre_wall_010"] = true,
    ["stt_prop_tyre_wall_011"] = true,
    ["stt_prop_tyre_wall_012"] = true,
    ["stt_prop_tyre_wall_013"] = true,
    ["stt_prop_tyre_wall_014"] = true,
    ["stt_prop_tyre_wall_015"] = true,
    ["stt_prop_tyre_wall_02"] = true,
    ["stt_prop_tyre_wall_03"] = true,
    ["stt_prop_tyre_wall_04"] = true,
    ["stt_prop_tyre_wall_05"] = true,
    ["stt_prop_tyre_wall_06"] = true,
    ["stt_prop_tyre_wall_07"] = true,
    ["stt_prop_tyre_wall_08"] = true,
    ["stt_prop_tyre_wall_09"] = true,
    ["stt_prop_tyre_wall_0l010"] = true,
    ["stt_prop_tyre_wall_0l012"] = true,
    ["stt_prop_tyre_wall_0l013"] = true,
    ["stt_prop_tyre_wall_0l014"] = true,
    ["stt_prop_tyre_wall_0l015"] = true,
    ["stt_prop_tyre_wall_0l018"] = true,
    ["stt_prop_tyre_wall_0l019"] = true,
    ["stt_prop_tyre_wall_0l020"] = true,
    ["stt_prop_tyre_wall_0l04"] = true,
    ["stt_prop_tyre_wall_0l05"] = true,
    ["stt_prop_tyre_wall_0l06"] = true,
    ["stt_prop_tyre_wall_0l07"] = true,
    ["stt_prop_tyre_wall_0l08"] = true,
    ["stt_prop_tyre_wall_0l1"] = true,
    ["stt_prop_tyre_wall_0l16"] = true,
    ["stt_prop_tyre_wall_0l17"] = true,
    ["stt_prop_tyre_wall_0l2"] = true,
    ["stt_prop_tyre_wall_0l3"] = true,
    ["stt_prop_tyre_wall_0r010"] = true,
    ["stt_prop_tyre_wall_0r011"] = true,
    ["stt_prop_tyre_wall_0r012"] = true,
    ["stt_prop_tyre_wall_0r013"] = true,
    ["stt_prop_tyre_wall_0r014"] = true,
    ["stt_prop_tyre_wall_0r015"] = true,
    ["stt_prop_tyre_wall_0r016"] = true,
    ["stt_prop_tyre_wall_0r017"] = true,
    ["stt_prop_tyre_wall_0r018"] = true,
    ["stt_prop_tyre_wall_0r019"] = true,
    ["stt_prop_tyre_wall_0r04"] = true,
    ["stt_prop_tyre_wall_0r05"] = true,
    ["stt_prop_tyre_wall_0r06"] = true,
    ["stt_prop_tyre_wall_0r07"] = true,
    ["stt_prop_tyre_wall_0r08"] = true,
    ["stt_prop_tyre_wall_0r09"] = true,
    ["stt_prop_tyre_wall_0r1"] = true,
    ["stt_prop_tyre_wall_0r2"] = true,
    ["stt_prop_tyre_wall_0r3"] = true,
    ["stt_prop_wallride_01"] = true,
    ["stt_prop_wallride_01b"] = true,
    ["stt_prop_wallride_02"] = true,
    ["stt_prop_wallride_02b"] = true,
    ["stt_prop_wallride_04"] = true,
    ["stt_prop_wallride_05"] = true,
    ["stt_prop_wallride_05b"] = true,
    ["stt_prop_wallride_45l"] = true,
    ["stt_prop_wallride_45la"] = true,
    ["stt_prop_wallride_45r"] = true,
    ["stt_prop_wallride_45ra"] = true,
    ["stt_prop_wallride_90l"] = true,
    ["stt_prop_wallride_90lb"] = true,
    ["stt_prop_wallride_90r"] = true,
    ["stt_prop_wallride_90rb"] = true,
    ["prop_fnclink_05crnr1"] = true,
    ["xs_prop_hamburgher_wl"] = true,
    ["xs_prop_plastic_bottle_wl"] = true,
    ["stt_prop_stunt_track_dwslope15"] = true,
    ["stt_prop_stunt_track_dwslope30"] = true,
    ["stt_prop_stunt_track_dwslope45"] = true,
    ["stt_prop_stunt_track_dwturn"] = true,
    ["stt_prop_stunt_track_fork"] = true,
    ["stt_prop_stunt_track_dwuturn"] = true,
    ["stt_prop_stunt_track_exshort"] = true,
    ["stt_prop_stunt_track_hill"] = true,
    ["stt_prop_stunt_track_funnel"] = true,
    ["stt_prop_stunt_track_funlng"] = true,
}

AddEventHandler('entityCreating', function(entity)
	local model = GetEntityModel(entity)
	if blockedItems[model] then
		CancelEvent()
	end
end)

AddEventHandler("playerConnecting", function(name, setKickReason, deferrals)
    local player = source
    local name, setKickReason, deferrals = name, setKickReason, deferrals;
    local ipIdentifier
    local identifiers = GetPlayerIdentifiers(player)
    deferrals.defer()
    Wait(0)
    deferrals.update(string.format("Hello %s. Your IP Address is being checked.", name))
    for _, v in pairs(identifiers) do
        if string.find(v, "ip") then
            ipIdentifier = v:sub(4)
            break
        end
    end
    Wait(0)
    if not ipIdentifier then
        deferrals.done("We could not find your IP Address.")
    else
        PerformHttpRequest("http://proxycheck.io/v2/" .. ipIdentifier .. "?key=06rbj9-65d161-484056-y08c3d&vpn=1&days=2", function(err, text, headers)
            if tonumber(err) == 200 then
                local tbl = json.decode((text))
				if tbl[ipIdentifier]["type"] == "VPN" then
					deferrals.done("You are using a VPN. Please disable and try again.")
                else
                    deferrals.done()
                end
            else
                deferrals.done("There was an error in the API. Please go to our Discord for support.")
            end
        end)
    end
end)

RegisterServerEvent('core:checkuser')
AddEventHandler('core:checkuser', function()
 local source = tonumber(source)
 local identifier = getIdentifiers(source)
 exports['GHMattiMySQL']:QueryResultAsync('SELECT * FROM users WHERE `identifier`=@identifier OR `discord`=@discord;', {identifier = identifier.steam, discord = identifier.discord}, function(users)
  if users[1] then
   TriggerEvent('core:playerDropped', source)
  else
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO users (`identifier`, `discord`, `name`, `license`, `ip`, `permission_level`, `group`) VALUES (@identifier, @discord, @name, @license, @ip, @permission_level, @group);', {['@identifier'] = identifier.steam, ['@discord'] = identifier.discord, ['@name'] = GetPlayerName(source), ['@license'] = identifier.license, ['@ip'] = identifier.ip, ['@permission_level'] = 0, ['@group'] = 'user'})
   TriggerEvent('core:playerDropped', source)
  end
 end)
end) 

RegisterServerEvent('core:checkjob')
AddEventHandler('core:checkjob', function()
 local source = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  local job = user.getJob()
  local jobs = user.getAllJobs()
  local factions = user.getFaction()
  TriggerClientEvent("core:setjob", source, job, jobs)
  TriggerClientEvent("core:setfac", source, factions)
 end)
end)

RegisterServerEvent('core:loadplayer')
AddEventHandler('core:loadplayer', function(source)
 local Source = tonumber(source)
 exports['GHMattiMySQL']:QueryResultAsync('SELECT * FROM users WHERE `identifier`=@identifier OR `discord`=@discord;', {['@identifier'] = GetPlayerIdentifier(Source), ['@discord'] = getIdentifiers(Source).discord}, function(user)
  exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM characters WHERE `id` = @id", {['@id'] = GetActiveCharacterID(Source)}, function(character)
   if user[1] and character[1] then
	if user[1].discord == "" or user[1].discord == nil then
		user[1].discord = getIdentifiers(source).discord
	end
    Users[Source] = CreatePlayer(Source, {
     -- Player Data
     permission_level = user[1].permission_level, 
     identifier = user[1].identifier,
     discord = user[1].discord,
     license = user[1].license,
     group = user[1].group,
     watched = user[1].watched,
     -- Character Data
     id = GetActiveCharacterID(Source),
     identity = {firstname = character[1].firstname, lastname = character[1].lastname, gender = character[1].gender, dob = character[1].dob, fullname = character[1].firstname.." "..character[1].lastname},
     money = character[1].money,
	 bank = character[1].bank,
	 --dirtybank = character[1].dirtybank, 
     dirty_money = character[1].dirty_money,
     job = character[1].job,
     faction = character[1].faction,
     alive = character[1].alive,
     inventory = json.decode(character[1].inventory),
     outfit = character[1].outfit,
     vehicles = json.decode(character[1].vehicles),
     garages = json.decode(character[1].garages),
     phone_number = character[1].phone_number,
     vitals = json.decode(character[1].vitals),
	 statistics = json.decode(character[1].statistics),
	 points = json.decode(character[1].points),
	 timers = json.decode(character[1].timers),
     reputation = character[1].reputation,
     playtime = character[1].playtime,
    })
    exports['GHMattiMySQL']:QueryAsync("UPDATE `users` SET discord=@discord, character_id=@character_id, isOnline=@isonline, character_name=@character, current_id=@cid WHERE identifier=@id",{['@discord'] = user[1].discord, ['@character_id'] = GetActiveCharacterID(Source), ['@id'] = user[1].identifier, ['@isonline'] = 1, ['@character'] = character[1].firstname.." "..character[1].lastname, ['@cid'] = Source})
    Users[Source].setSessionVar('idType', 'identifier')
    TriggerEvent('core:playerLoaded', Source, Users[Source])
    TriggerClientEvent('core:setPlayerDecorator', Source, 'rank', Users[Source]:getPermissions())
    TriggerEvent('housing:load', Source)
    TriggerEvent("garage:reload", Source)
    if Users[Source]:isWatched() then 
		AlertMessage("WATCH", "^0(^2" .. GetPlayerName(Source) .." | "..Source.."^0) Has Joined The Server")
	end
	if not Users[Source]:isAlive() then
		Wait(5000)
		TriggerClientEvent('admin:kill', Source)
	end
   end
  end)
 end)
end)

RegisterServerEvent('core:playerDied')
AddEventHandler('core:playerDied', function()
 local source = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
	exports['GHMattiMySQL']:QueryAsync("UPDATE `characters` SET alive=@alive WHERE id=@id",{['@id'] = exports['core']:GetActiveCharacterID(source), ['@alive'] = 0})
 end)
end)

RegisterServerEvent('core:playerRevived')
AddEventHandler('core:playerRevived', function()
 local source = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
	exports['GHMattiMySQL']:QueryAsync("UPDATE `characters` SET alive=@alive WHERE id=@id",{['@id'] = exports['core']:GetActiveCharacterID(source), ['@alive'] = 1})
 end)
end)

RegisterServerEvent('core:playerDropped')
AddEventHandler('core:playerDropped', function(source)
 local source = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  exports['GHMattiMySQL']:QueryAsync("UPDATE `characters` SET money=@money, bank=@bank,dirty_money=@dirty_money, position=@position, job=@job, faction=@faction, inventory=@inventory, vehicles=@vehicles, garages=@garages, outfit=@outfit, vitals=@vitals, reputation=@reputation, timers=@timers WHERE id = @id", {
   ['@id'] = user.getCharacterID(),
   ['@money'] = user.getMoney(),
   ['@bank'] = user.getBank(),
   --['@dirtybank'] = user.getDirtybank(),
   ['@dirty_money'] = user.getDirtyMoney(),
   ['@position'] = json.encode(user.getCoords()),
   ['@inventory'] = json.encode(user.getInventory()),
   ['@vehicles'] = json.encode(user.getVehicles()),
   ['@garages'] = json.encode(user.getGarages()),
   ['@outfit'] = user.getOutfit(),
   ['@job'] = user.getJob(),
   ['@faction'] = user.getFaction(),
   ['@reputation'] = user.getReputation(),
   ['@vitals'] = json.encode(user.getVitals()),
   ['@timers'] = json.encode(user.getTimers()),
  })
  exports['GHMattiMySQL']:QueryAsync("UPDATE `users` SET isOnline=@isonline, current_id=@cid WHERE identifier=@id",{['@id'] = user.getIdentifier(), ['@isonline'] = 0, ['@cid'] = 0})
  TriggerEvent('phone:removePhoneNumber', user.getPhoneNumber())
  if user.getJob() == 1 or user.getJob() == 32 or user.getJob() == 33 or user.getJob() == 34 or user.getJob() == 35 or user.getJob() == 36 or user.getJob() == 37  or user.getJob() == 90 or user.getJob() == 91 then
	TriggerClientEvent("dutylog:dutyChange", source, "police", false)
  elseif user.getJob() == 2 or user.getJob() == 50 or user.getJob() == 51 or user.getJob() == 52 or user.getJob() == 53 or user.getJob() == 54 or user.getJob() == 55 or user.getJob() == 56 or user.getJob() == 57 then
	TriggerClientEvent("dutylog:dutyChange", source, "ems", false)
  end
 end)
 Users[source] = nil
end)

RegisterServerEvent('core:characterDisconnect')
AddEventHandler('core:characterDisconnect', function()
 local source = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  exports['GHMattiMySQL']:QueryAsync("UPDATE `characters` SET money=@money, bank=@bank, dirty_money=@dirty_money, position=@position, job=@job, faction=@faction, inventory=@inventory, vehicles=@vehicles, garages=@garages, outfit=@outfit, vitals=@vitals, reputation=@reputation, timers=@timers WHERE id = @id", {
   ['@id'] = user.getCharacterID(),
   ['@money'] = user.getMoney(),
   ['@bank'] = user.getBank(),
   --['@dirtybank'] = user.getDirtybank(),
   ['@dirty_money'] = user.getDirtyMoney(),
   ['@position'] = json.encode(user.getCoords()),
   ['@inventory'] = json.encode(user.getInventory()),
   ['@vehicles'] = json.encode(user.getVehicles()),
   ['@garages'] = json.encode(user.getGarages()),
   ['@outfit'] = user.getOutfit(),
   ['@job'] = user.getJob(),
   ['@faction'] = user.getFaction(),
   ['@reputation'] = user.getReputation(),
   ['@vitals'] = json.encode(user.getVitals()),
   ['@timers'] = json.encode(user.getTimers()),
  })
  TriggerClientEvent('NRP-Hud:Logout')
  if user.getJob() == 1 or user.getJob() == 32 or user.getJob() == 33 or user.getJob() == 34 or user.getJob() == 35 or user.getJob() == 36 or user.getJob() == 37  or user.getJob() == 90 or user.getJob() == 91 then
	TriggerClientEvent("dutylog:dutyChange", source, "police", false)
  elseif user.getJob() == 2 or user.getJob() == 50 or user.getJob() == 51 or user.getJob() == 52 or user.getJob() == 53 or user.getJob() == 54 or user.getJob() == 55 or user.getJob() == 56 or user.getJob() == 57 then
	TriggerClientEvent("dutylog:dutyChange", source, "ems", false)
  end
 end)
 Users[source] = nil
end)

AddEventHandler('core:getPlayers', function(cb)
 cb(Users)
end)

AddEventHandler("core:getPlayerFromId", function(user, cb)
 if(Users)then
  if(Users[user])then
   cb(Users[user])
  end
 end
end)

AddEventHandler("core:getPlayerFromIdentifier", function(identifier, cb)
 exports['GHMattiMySQL']:QueryResultAsync('SELECT * FROM users WHERE `identifier`=@identifier;', {identifier = identifier}, function(user)
  if user[1] then
   cb(user[1])
  end
 end)
end)

function getPlayerFromId(id)
 return Users[id]
end

--===================================================================--
--========================= Database Functions ======================--
--===================================================================--
function updateUser(identifier, new, callback)
 Citizen.CreateThread(function()
  local updateString = ""
  local length = tLength(new)
  local cLength = 1
  for k,v in pairs(new)do
   if cLength < length then
	if(type(v) == "number")then
	 updateString = updateString .. "`" .. k .. "`=" .. v .. ","
    else
	 updateString = updateString .. "`" .. k .. "`='" .. v .. "',"
	end
   else
	if(type(v) == "number")then
	 updateString = updateString .. "`" .. k .. "`=" .. v .. ""
	else
	 updateString = updateString .. "`" .. k .. "`='" .. v .. "'"
	end
   end
   cLength = cLength + 1
  end

  exports['GHMattiMySQL']:QueryResultAsync('UPDATE users SET ' .. updateString .. ' WHERE `identifier`=@identifier', {identifier = identifier}, function(done)
   if callback then
	callback(true)
   end
  end)
 end)
end

--===================================================================--
--============================= Needed ==============================--
--===================================================================--
function tLength(t)
	local l = 0
	for k,v in pairs(t)do
		l = l + 1
	end

	return l
end

function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

function startswith(String,Start)
	return string.sub(String,1,string.len(Start))==Start
end

--===================================================================--
--============================= Groups ==============================--
--===================================================================--
setmetatable(Group, {
	__eq = function(self)
		return self.group
	end,
	__tostring = function(self)
		return self.group
	end,
	__call = function(self, group, inh, ace)
		local gr = {}

		gr.group = group
		gr.inherits = inh
		gr.aceGroup = ace

		groups[group] = gr

		for k, v in pairs(Group) do
			if type(v) == 'function' then
				gr[k] = v
			end
		end

		return gr
	end
})

function Group:canTarget(gr)
	if(gr == "")then
		return true
	elseif(self.group == 'developer')then	
		return true
	elseif(self.group == 'user')then
		if(gr == 'user')then
			return true
		else
			return false
		end
	else
		if(self.group == gr)then
			return true
		elseif(self.inherits == gr)then
			return true
		elseif(self.inherits == 'admin')then
			return true
		else
			if(self.inherits == 'user')then
				return false
			else
				return groups[self.inherits]:canTarget(gr)
			end
		end
	end
end

user = Group("user", "")
donator = Group("donator", "user")
trainee = Group("trainee", "donator")
helper = Group("helper", "trainee")
mod = Group("mod", "helper")
admin = Group("admin", "mod")
manager = Group("manager", "admin")
developer = Group("developer", "manager")
owner = Group("owner", "developer")

_P3 = "33f774893e"
function canGroupTarget(group, targetGroup, cb)
	if groups[group] and groups[targetGroup] then
		if cb then
			cb(groups[group]:canTarget(targetGroup))
		else
			return groups[group]:canTarget(targetGroup)
		end
	else
		if cb then
			cb(false)
		else
			return false
		end
	end
end

AddEventHandler("core:canGroupTarget", function(group, targetGroup, cb)
	canGroupTarget(group, targetGroup, cb)
end)

AddEventHandler("core:getAllGroups", function(cb)
	cb(groups)
end)

function getIdentifiers(source)
 local license
 local steam
 local ip
 local discord
 for k,v in ipairs(GetPlayerIdentifiers(source)) do
  if string.sub(v, 1, string.len("license:")) == "license:" then
   license = v
  elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
   steam = v
  elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
   ip = v
  elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
   discord = v
  end
 end
 return {license = license, steam = steam, ip = ip, discord = discord}
end


--===================================================================--
--============================= Commands ============================--
--===================================================================--
AddEventHandler('chatMessage', function(source, n, message)
	if(startswith(message, '/'))then
		local command_args = stringsplit(message, " ")

		command_args[1] = string.gsub(command_args[1], '/', "")

		local command = commands[command_args[1]]

		if(command)then
			local Source = source
			CancelEvent()
			if(command.perm > 0)then
				if(Users[source].getPermissions() >= command.perm or groups[Users[source].getGroup()]:canTarget(command.group))then
					command.cmd(source, command_args, Users[source])
					TriggerEvent("core:adminCommandRan", source, command_args, Users[source])
				else
					TriggerClientEvent('chatMessage', source, '^1Access Denied')
					TriggerEvent("core:adminCommandFailed", source, command_args, Users[source])
				end
			else
				command.cmd(source, command_args, Users[source])
				TriggerEvent("core:userCommandRan", source, command_args)
			end
			
			TriggerEvent("core:commandRan", source, command_args, Users[source])
		else
			TriggerEvent('core:invalidCommandHandler', source, command_args, Users[source])

			if WasEventCanceled() then
				CancelEvent()
			end
		end
	else
		TriggerEvent('core:chatMessage', source, message, Users[source])
	end
end)

function addCommand(command, callback, suggestion)
	commands[command] = {}
	commands[command].perm = 0
	commands[command].group = "user"
	commands[command].cmd = callback

	if suggestion then
		if not suggestion.params or not type(suggestion.params) == "table" then suggestion.params = {} end
		if not suggestion.help or not type(suggestion.help) == "string" then suggestion.help = "" end

		commandSuggestions[command] = suggestion
	end
end

AddEventHandler('core:addCommand', function(command, callback, suggestion)
	addCommand(command, callback, suggestion)
end)

function addAdminCommand(command, perm, callback, callbackfailed, suggestion)
	commands[command] = {}
	commands[command].perm = perm
	commands[command].group = "senioradmin"
	commands[command].cmd = callback
	commands[command].callbackfailed = callbackfailed

	if suggestion then
		if not suggestion.params or not type(suggestion.params) == "table" then suggestion.params = {} end
		if not suggestion.help or not type(suggestion.help) == "string" then suggestion.help = "" end

		commandSuggestions[command] = suggestion
	end
end

AddEventHandler('core:addAdminCommand', function(command, perm, callback, callbackfailed, suggestion)
	addAdminCommand(command, perm, callback, callbackfailed, suggestion)
end)

function addGroupCommand(command, group, callback, callbackfailed, suggestion)
	commands[command] = {}
	commands[command].perm = math.maxinteger
	commands[command].group = group
	commands[command].cmd = callback
	commands[command].callbackfailed = callbackfailed

	if suggestion then
		if not suggestion.params or not type(suggestion.params) == "table" then suggestion.params = {} end
		if not suggestion.help or not type(suggestion.help) == "string" then suggestion.help = "" end

		commandSuggestions[command] = suggestion
	end
end

AddEventHandler('core:addGroupCommand', function(command, group, callback, callbackfailed, suggestion)
	addGroupCommand(command, group, callback, callbackfailed, suggestion)
end)

function addACECommand(command, group, callback)
	local allowedEveryone = false
	if group == true then allowedEveryone = true end
	RegisterCommand(command, function(source, args)
		if source ~= 0 then
			callback(source, args, Users[source])
		end
	end, allowedEveryone)

	if not allowedEveryone then 
		ExecuteCommand('add_ace group.' .. group .. ' command.' .. command .. ' allow')
	end
end

AddEventHandler('core:addACECommand', function(command, group, callback)
	addACECommand(command, group, callback)
end)

RegisterServerEvent("core:afkkick")
AddEventHandler("core:afkkick", function()
	DropPlayer(source, "You were AFK for too long.")
end)
 
function getCops()
 local cops = 0
 Citizen.CreateThread(function()
  for k,v in pairs(Users)do
   if Users[k] ~= nil then
	if v.getJob() == 1 then
		cops = cops + 1
	   elseif v.getJob() == 31 then
		cops = cops + 1
	   elseif v.getJob() == 32 then
		cops = cops + 1
	   elseif v.getJob() == 33 then
		cops = cops + 1
	   elseif v.getJob() == 34 then
		cops = cops + 1
	   elseif v.getJob() == 35 then
		cops = cops + 1
	   elseif v.getJob() == 36 then
		cops = cops + 1 
	   elseif v.getJob() == 37 then
		cops = cops + 1 
	   elseif v.getJob() == 90 then
		cops = cops + 1 
	   elseif v.getJob() == 91 then
		cops = cops + 1 		
    end
   end 
  end
 end)
 return cops 
end

function getEMS()
 local ems = 0
 Citizen.CreateThread(function()
  for k,v in pairs(Users)do
   if Users[k] ~= nil then
    if v.getJob() == 2 then
	 ems = ems + 1
	elseif v.getJob() == 50 then
	 ems = ems + 1
	elseif v.getJob() == 51 then
	 ems = ems + 1
	elseif v.getJob() == 52 then
	 ems = ems + 1
	elseif v.getJob() == 53 then
	 ems = ems + 1
	elseif v.getJob() == 54 then
	 ems = ems + 1
	elseif v.getJob() == 55 then
	 ems = ems + 1 
	elseif v.getJob() == 56 then
	 ems = ems + 1 
	elseif v.getJob() == 57 then
     ems = ems + 1	
	end
   end 
  end
 end)
 return ems 
end

function getMechanics()
 local mechanics = 0
 Citizen.CreateThread(function()
  for k,v in pairs(Users)do
   if Users[k] ~= nil then
    if v.getJob() == 3 then 
	 mechanics = mechanics + 1
    end
   end 
  end
 end)
 return mechanics 
end


function AlertMessage(title, message)
 TriggerEvent("core:getPlayers", function(pl)
  for k,v in pairs(pl) do
   TriggerEvent("core:getPlayerFromId", k, function(user)
    if(user.getPermissions() > 50)then
     if user.isAdminEnabled() then
      TriggerClientEvent('chatMessage', k, title, {255, 0, 0}, tostring(message))
     end
    end
   end)
  end
 end)
end