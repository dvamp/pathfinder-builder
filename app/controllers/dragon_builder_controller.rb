class DragonBuilderController < ApplicationController
  def index
    @dragon_id = {}
    @dragon_id[:dragon_race] = 1
    @dragon_id[:dragon_age] = 1
    if (params[:dragon_race] != nil && params[:dragon_age] != nil)
      @dragon_id[:dragon_race] = params[:dragon_race].to_i
      @dragon_id[:dragon_age] = params[:dragon_age].to_i

      if @dragon_id[:dragon_race] > 5
      @dragon_id[:dragon_race] = 1
      @dragon_id[:dragon_age] = 1

      else if params[:dragon] != nil
      dragon_race = DragonRace.find(params[:dragon_race].to_i)
      dragon_age_category = DragonAgeCategory.find(params[:dragon_age].to_i)
      @dragon = {}
      @dragon["dragon_race_name"] = dragon_race.name
      @dragon["dragon_age_name"] = dragon_age_category.age_category
      @dragon["cr"] = dragon_race.cr + dragon_age_category.cr
      @dragon["size"] = dragon_race.size + dragon_age_category.size
      @dragon["alignment"] = dragon_race.alignment
      @dragon["types"] = dragon_race.creature_category
      @dragon["subtypes"] = dragon_race.creature_subcategory
      @dragon["natural_armor"] = dragon_race.natural_armor + dragon_age_category.natural_armor
      @dragon["hit_dice_count"] = dragon_race.hit_dice + dragon_age_category.hit_dice
      @dragon["str"] = dragon_race.str + dragon_age_category.str
      @dragon["dex"] = dragon_race.dex + dragon_age_category.dex
      @dragon["con"] = dragon_race.con + dragon_age_category.con
      @dragon["int"] = dragon_race.int + dragon_age_category.int
      @dragon["wis"] = dragon_race.wis + dragon_age_category.wis
      @dragon["chr"] = dragon_race.chr + dragon_age_category.chr

      @dragon["hit_dice_number"] = 12
      @dragon["language"] = "竜語"

      @dragon["environment"] = dragon_race.env
      @dragon["organization"] = dragon_race.organization
      @dragon["treasure"] = dragon_race.treasure

      @dragon["defence_describe"] = ""  #固定ではない？
      @dragon["burrow_speed"] = ""
      @dragon["swim_speed"] = ""
      @dragon["defensive_ability"] = ""
        case @dragon_id[:dragon_age]
        when 1..4
          @dragon["dr"] = ""
        when 5..6
          @dragon["dr"] = "5/魔法"
        when 7..8
          @dragon["dr"] = "10/魔法"
        when 9..10
          @dragon["dr"] = "15/魔法"
        when 11..12
          @dragon["dr"] = "20/魔法"
        end
        case @dragon_id[:dragon_age]
        when 1..4
          @dragon["sr_flag"] = false
        when 5..12
          @dragon["sr_flag"] = true
        end
        @dragon["additional_move"] = ""
          @dragon["sense"] = "竜の超感覚"
          @dragon["immune"] = "［酸］、麻痺、睡眠"
          @dragon["weakness"] = ""
          @dragon["land_speed"] = "40ft."
          @dragon["swim_speed"] = "40ft."
          case @dragon_id[:dragon_age]
          when 1..2
            @dragon["spell_like_ability"] = ""
          when 3
            @dragon["spell_like_ability"] = "エンタングル"
          when 4..5
            @dragon["spell_like_ability"] = "エンタングル、チャーム・パースン"
          when 6..7
            @dragon["spell_like_ability"] = "エンタングル、チャーム・パースン、サジェスチョン"
          when 8..9
            @dragon["spell_like_ability"] = "エンタングル、チャーム・パースン、サジェスチョン、プラント・グロウス"
          when 10..11
            @dragon["spell_like_ability"] = "エンタングル、チャーム・パースン、サジェスチョン、プラント・グロウス、ドミネイト・パースン"
          when 12
            @dragon["spell_like_ability"] = "エンタングル、チャーム・パースン、サジェスチョン、プラント・グロウス、ドミネイト・パースン、コマンド・プランツ"
          end
          @dragon["spell_caster_level"] = -7 + (@dragon_id[:dragon_age] * 2)
          @dragon["spell_caster_source"] = "ソーサラー"
          @dragon["racial_modifer"] = "+8 〈水泳〉"
          case @dragon_id[:dragon_age]
          when 1
            @dragon["sq"] = "水中呼吸"
          when 2
            @dragon["sq"] = "水中呼吸、森渡り"
          when 6..7
            @dragon["sq"] = "水中呼吸、森渡り、跡なき足取り"
          when 8..12
            @dragon["sq"] = "水中呼吸、森渡り、跡なき足取り、カモフラージュ"
          end
          case @dragon_id[:dragon_age]
          when 1
            @dragon["aura"] = ""
            @dragon["melee"] = "噛みつき (1d6+1)、爪(x2) (1d4+1)"
            @dragon["special_attack"] = "ブレス攻撃 (円錐形 15ft.、 DC13、2d6 ［酸］)"
          when 2
            @dragon["aura"] = ""
            @dragon["melee"] = "噛みつき (1d8+4)、爪(x2) (1d6+3)、翼(x2) (1d4+3)"
            @dragon["special_attack"] = "ブレス攻撃 (円錐形 20ft.、 DC15、4d6 ［酸］)"
          when 3
            @dragon["aura"] = ""
            @dragon["melee"] = "噛みつき (2d6+7)、爪(x2) (1d8+5)、翼(x2) (1d6+2)、尾の打撃 (1d8+7)"
            @dragon["special_attack"] = "ブレス攻撃 (円錐形 30ft.、 DC17、6d6 ［酸］)"
          when 4
            @dragon["aura"] = "畏怖すべき存在(120ft.、DC17)"
            @dragon["melee"] = "噛みつき (2d6+9)、爪(x2) (1d8+6)、翼(x2) (1d6+3)、尾の打撃 (1d8+9)"
            @dragon["special_attack"] = "ブレス攻撃 (円錐形 40ft.、 DC19、8d6 ［酸］)"
          when 5
            @dragon["aura"] = "畏怖すべき存在(150ft.、DC18)"
            @dragon["melee"] = "噛みつき (2d8+10)、爪(x2) (2d6+7)、翼(x2) (1d8+3)、尾の打撃 (2d6+10)"
            @dragon["special_attack"] = "ブレス攻撃 (円錐形 50ft.、 DC20、10d6［酸］)、押し潰し (小型、DC20、2d8+10)"
          when 6
            @dragon["aura"] = "畏怖すべき存在(180ft.、DC20)"
            @dragon["melee"] = "噛みつき (2d8+12)、爪(x2) (2d6+8)、翼(x2) (1d8+4)、尾の打撃 (2d6+12)"
            @dragon["special_attack"] = "ブレス攻撃 (円錐形 50ft.、 DC22、12d6［酸］)、押し潰し (小型、DC22、2d8+12)"
          when 7
            @dragon["aura"] = "畏怖すべき存在(210ft.、DC21)"
            @dragon["melee"] = "噛みつき (2d8+13)、爪(x2) (2d6+9)、翼(x2) (1d8+4)、尾の打撃 (2d6+13)"
            @dragon["special_attack"] = "ブレス攻撃 (円錐形 50ft.、 DC23、14d6［酸］)、押し潰し (小型、DC23、2d8+13)"
          when 8
            @dragon["aura"] = "畏怖すべき存在(240ft.、DC23)"
            @dragon["melee"] = "噛みつき (4d6+15)、爪(x2) (2d8+10)、翼(x2) (2d6+5)、尾の打撃 (2d8+15)"
            @dragon["special_attack"] = "ブレス攻撃 (円錐形 60ft.、 DC25、16d6［酸］)、押し潰し (中型、DC25、4d6+15)、尾による一掃 (小型、DC25、2d6+15)"
          when 9
            @dragon["aura"] = "畏怖すべき存在(270ft.、DC24)"
            @dragon["melee"] = "噛みつき (4d6+16)、爪(x2) (2d8+11)、翼(x2) (2d6+5)、尾の打撃 (2d8+16)"
            @dragon["special_attack"] = "ブレス攻撃 (円錐形 60ft.、 DC26、18d6［酸］)、押し潰し (中型、DC26、4d6+16)、尾による一掃 (小型、DC26、2d6+16)"
          when 10
            @dragon["aura"] = "畏怖すべき存在(300ft.、DC26)"
            @dragon["melee"] = "噛みつき (4d6+18)、爪(x2) (2d8+12)、翼(x2) (2d6+6)、尾の打撃 (2d8+18)"
            @dragon["special_attack"] = "ブレス攻撃 (円錐形 60ft.、 DC28、20d6［酸］)、押し潰し (中型、DC28、4d6+18)、尾による一掃 (小型、DC28、2d6+18)、瘴気"
          when 11
            @dragon["aura"] = "畏怖すべき存在(330ft.、DC27)"
            @dragon["melee"] = "噛みつき (4d6+19)、爪(x2) (2d8+13)、翼(x2) (2d6+6)、尾の打撃 (2d8+19)"
            @dragon["special_attack"] = "ブレス攻撃 (円錐形 60ft.、 DC29、22d6［酸］)、押し潰し (中型、DC29、4d6+19)、尾による一掃 (小型、DC29、2d6+19)、瘴気"
          when 12
            @dragon["aura"] = "畏怖すべき存在(360ft.、DC29)"
            @dragon["melee"] = "噛みつき (4d8+21)、爪(x2) (4d6+14)、翼(x2) (2d8+7)、尾の打撃 (4d6+21)"
            @dragon["special_attack"] = "ブレス攻撃 (円錐形 70ft.、 DC31、24d6［酸］)、押し潰し (大型、DC31、4d8+21)、尾による一掃 (中型、DC31、2d8+21)、瘴気、トリエント覚醒"
          end
        case @dragon["size"]
        when 3
          @dragon["size"] = "超小型"
        when 4
          @dragon["size"] = "小型"
        when 5
          @dragon["size"] = "中型"
        when 6
          @dragon["size"] = "大型"
        when 7
          @dragon["size"] = "超大型"
        when 8
          @dragon["size"] = "巨大"
        when 9
          @dragon["size"] = "超巨大"
        end
        @dragon["str_modifer"] = ((@dragon["str"] - 10) / 2).to_i
        @dragon["dex_modifer"] = ((@dragon["dex"] - 10) / 2).to_i
        @dragon["con_modifer"] = ((@dragon["con"] - 10) / 2).to_i
        @dragon["int_modifer"] = ((@dragon["int"] - 10) / 2).to_i
        @dragon["wis_modifer"] = ((@dragon["wis"] - 10) / 2).to_i
        @dragon["chr_modifer"] = ((@dragon["chr"] - 10) / 2).to_i
        if @dragon["dex_modifer"] > 0
          @dragon["init"] = "+" + @dragon["dex_modifer"].to_s
        else
          @dragon["init"] = @dragon["dex_modifer"]
        end
        if @dragon["size"] == "超小型"
          @dragon["size_modifer_attack"] = 2
          @dragon["size_modifer_cmb"] = @dragon["size_modifer_attack"] * -1
          @dragon["fly_speed"] = "100ft."
          @dragon["fly_muverabillity"] = "標準"
          @dragon["space"] = "2.5ft."
          @dragon["reach"] = "0ft."
          @dragon["bite_reach"] = "5ft."
        elsif @dragon["size"] == "小型"
          @dragon["size_modifer_attack"] = 1
          @dragon["size_modifer_cmb"] = @dragon["size_modifer_attack"] * -1
          @dragon["fly_speed"] = "150ft."
          @dragon["fly_muverabillity"] = "標準"
          @dragon["space"] = "5ft."
          @dragon["reach"] = "5ft."
          @dragon["bite_reach"] = "5ft."
        elsif @dragon["size"] == "中型"
          @dragon["size_modifer_attack"] = 0
          @dragon["size_modifer_cmb"] = @dragon["size_modifer_attack"] * -1
          @dragon["fly_speed"] = "150ft."
          @dragon["fly_muverabillity"] = "標準"
          @dragon["space"] = "5ft."
          @dragon["reach"] = "5ft."
          @dragon["bite_reach"] = "5ft."
        elsif @dragon["size"] == "大型"
          @dragon["size_modifer_attack"] = -1
          @dragon["size_modifer_cmb"] = @dragon["size_modifer_attack"] * -1
          @dragon["fly_speed"] = "200ft."
          @dragon["fly_muverabillity"] = "貧弱"
          @dragon["space"] = "10ft."
          @dragon["reach"] = "5ft."
          @dragon["bite_reach"] = "10ft."
        elsif @dragon["size"] == "超大型"
          @dragon["size_modifer_attack"] = -2
          @dragon["size_modifer_cmb"] = @dragon["size_modifer_attack"] * -1
          @dragon["fly_speed"] = "200ft."
          @dragon["fly_muverabillity"] = "貧弱"
          @dragon["space"] = "15ft."
          @dragon["reach"] = "10ft."
          @dragon["bite_reach"] = "15ft."
        elsif @dragon["size"] == "巨大"
          @dragon["size_modifer_attack"] = -4
          @dragon["size_modifer_cmb"] = @dragon["size_modifer_attack"] * -1
          @dragon["fly_speed"] = "250ft."
          @dragon["fly_muverabillity"] = "劣悪"
          @dragon["space"] = "20ft."
          @dragon["reach"] = "15ft."
          @dragon["bite_reach"] = "20ft."
        elsif @dragon["size"] == "超巨大"
          @dragon["size_modifer_attack"] = -8
          @dragon["size_modifer_cmb"] = @dragon["size_modifer_attack"] * -1
          @dragon["fly_speed"] = "250ft."
          @dragon["fly_muverabillity"] = "劣悪"
          @dragon["space"] = "30ft."
          @dragon["reach"] = "20ft."
          @dragon["bite_reach"] = "30ft."
        end
        if @dragon["dex_modifer"] > 0
          @dragon["defence_describe"] = "(+" + @dragon["dex_modifer"].to_s + " 【敏】"
        elsif @dragon["dex_modifer"] < 0
          @dragon["defence_describe"] = "(" + @dragon["dex_modifer"].to_s + " 【敏】"
        end
        if @dragon["defence_describe"] != ""
          @dragon["defence_describe"] = @dragon["defence_describe"] + ", +" + @dragon["natural_armor"].to_s + " 外皮"
        else
          @dragon["defence_describe"] = "(+" + @dragon["natural_armor"].to_s + " 外皮"
        end
        if @dragon["size_modifer_attack"] > 0
          @dragon["defence_describe"] = @dragon["defence_describe"] + ", +" + @dragon["size_modifer_attack"].to_s + " サイズ)"
        elsif @dragon["size_modifer_attack"] < 0
          @dragon["defence_describe"] = @dragon["defence_describe"] + ", " + @dragon["size_modifer_attack"].to_s + " サイズ)"
        else
          @dragon["defence_describe"] = @dragon["defence_describe"] + ")"
        end
        @dragon["ac"] = 10 + @dragon["dex_modifer"] + @dragon["natural_armor"] + @dragon["size_modifer_attack"]
        @dragon["touch"] = 10 + @dragon["dex_modifer"] + @dragon["size_modifer_attack"]
        @dragon["flat_footed"] = 10 + @dragon["natural_armor"] + @dragon["size_modifer_attack"]
        if @dragon["dex_modifer"] < 0
          @dragon["flat_footed"] = @dragon["flat_footed"] + @dragon["dex_modifer"]
        end
        @dragon["hp"] = (@dragon["hit_dice_count"] / 2).to_i * 7 + (@dragon["hit_dice_count"] - (@dragon["hit_dice_count"] / 2).to_i) * 6 + @dragon["con_modifer"] * @dragon["hit_dice_count"]
        if @dragon["con_modifer"] > 0
          @dragon["hp_con_modifer"] = "+" + (@dragon["con_modifer"] * @dragon["hit_dice_count"]).to_s
        else
          @dragon["hp_con_modifer"] = ""
        end
        @dragon["fort"] = "+" + ((@dragon["hit_dice_count"] / 2).to_i + 2 + @dragon["con_modifer"]).to_s
        @dragon["ref"] = "+" + ((@dragon["hit_dice_count"] / 2).to_i + 2 + @dragon["dex_modifer"]).to_s
        @dragon["will"] = "+" + ((@dragon["hit_dice_count"] / 2).to_i + 2 + @dragon["wis_modifer"]).to_s
        @dragon["speed"] = @dragon["land_speed"]
        if @dragon["burrow_speed"] != ""
          @dragon["speed"] = @dragon["speed"] + ", 穴掘り " + @dragon["burrow_speed"]
        end
        if @dragon["swim_speed"] != ""
          @dragon["speed"] = @dragon["speed"] + ", 水泳 " + @dragon["swim_speed"]
        end
        @dragon["speed"] = @dragon["speed"] + ", 飛行 " + @dragon["fly_speed"] + "(" + @dragon["fly_muverabillity"] + ")"
        if @dragon["additional_move"] != ""
          @dragon["speed"] = @dragon["speed"] + "; " + @dragon["additional_move"]
        end
        if @dragon["spell_like_ability"] != ""
          @dragon["spell_like_ability_cl"] = @dragon["hit_dice_count"]
          @dragon["spell_like_ability_concentration"] = @dragon["hit_dice_count"] + @dragon["chr_modifer"]
        else
          @dragon["spell_like_ability_cl"] = ""
          @dragon["spell_like_ability_concentration"] = ""
        end
        if @dragon["spell_caster_level"] != ""
          @dragon["spell_caster_concentration"] = @dragon["spell_caster_level"] + @dragon["chr_modifer"]
        else
          @dragon["spell_caster_concentration"] = ""
        end
        @dragon["base_attack"] = "+" + @dragon["hit_dice_count"].to_s
        @dragon["cmb"] = "+" + (@dragon["hit_dice_count"] + @dragon["size_modifer_cmb"] + @dragon["str_modifer"]).to_s 
        @dragon["cmd"] = (10 + @dragon["hit_dice_count"] + @dragon["size_modifer_cmb"] + @dragon["str_modifer"] + @dragon["dex_modifer"])
        @dragon["cmd"] = @dragon["cmd"].to_s + " (" + (@dragon["cmd"] + 4).to_s + " 対足払い)"
        @dragon["feet_count"] = (@dragon["hit_dice_count"] / 2).to_i + 1
        @dragon["skill_per_rank"] = @dragon["int_modifer"] + 6
        @dragon["skill_sum_rank"] = @dragon["skill_per_rank"] * @dragon["hit_dice_count"]
        if @dragon["int_modifer"] < 0
          @dragon["language_count"] = 0
        else
          @dragon["language_count"] = @dragon["int_modifer"]
        end
        i = 0
        base = 1
        while i < (@dragon["cr"] / 2).to_i
          base = base * 2
          i += 1
        end
        if (@dragon["cr"] & 1) == 1
          @dragon["xp"] = 400 * base
        else
          @dragon["xp"] = 300 * base
        end
        if @dragon["sr_flag"] == true
          @dragon["sr"] = @dragon["cr"] + 11
        else
          @dragon["sr"] = 0
        end
      else
              @dragon = {}
      @dragon["types"] = "竜"
      @dragon["hit_dice_number"] = 12
      @dragon["language"] = "竜語"
      @dragon["organization"] = "単体"
      @dragon["treasure"] = "x3"
      @dragon["defence_describe"] = ""
      @dragon["burrow_speed"] = ""
      @dragon["swim_speed"] = ""
      @dragon["defensive_ability"] = ""
      case @dragon_id[:dragon_age]
      when 1..4
        @dragon["dr"] = ""
      when 5..6
        @dragon["dr"] = "5/魔法"
      when 7..8
        @dragon["dr"] = "10/魔法"
      when 9..10
        @dragon["dr"] = "15/魔法"
      when 11..12
        @dragon["dr"] = "20/魔法"
      end
      case @dragon_id[:dragon_age]
      when 1..4
        @dragon["sr_flag"] = false
      when 5..12
        @dragon["sr_flag"] = true
      end
      @dragon["additional_move"] = ""
      case @dragon_id[:dragon_race]
      when 1
        @dragon["dragon_race_name"] = "グリーン"
        @dragon["cr"] = 4
        @dragon["alignment"] = "秩序にして悪"
        @dragon["size"] = 4
        @dragon["sense"] = "竜の超感覚"
        @dragon["subtypes"] = "風"
        @dragon["natural_armor"] = 4
        @dragon["hit_dice_count"] = 5
        @dragon["immune"] = "［酸］、麻痺、睡眠"
        @dragon["weakness"] = ""
        @dragon["land_speed"] = "40ft."
        @dragon["swim_speed"] = "40ft."
        case @dragon_id[:dragon_age]
        when 1..2
          @dragon["spell_like_ability"] = ""
        when 3
          @dragon["spell_like_ability"] = "エンタングル"
        when 4..5
          @dragon["spell_like_ability"] = "エンタングル、チャーム・パースン"
        when 6..7
          @dragon["spell_like_ability"] = "エンタングル、チャーム・パースン、サジェスチョン"
        when 8..9
          @dragon["spell_like_ability"] = "エンタングル、チャーム・パースン、サジェスチョン、プラント・グロウス"
        when 10..11
          @dragon["spell_like_ability"] = "エンタングル、チャーム・パースン、サジェスチョン、プラント・グロウス、ドミネイト・パースン"
        when 12
          @dragon["spell_like_ability"] = "エンタングル、チャーム・パースン、サジェスチョン、プラント・グロウス、ドミネイト・パースン、コマンド・プランツ"
        end
        @dragon["spell_caster_level"] = -7 + (@dragon_id[:dragon_age] * 2)
        @dragon["spell_caster_source"] = "ソーサラー"
        @dragon["str"] = 13
        @dragon["dex"] = 14
        @dragon["con"] = 13
        @dragon["int"] = 10
        @dragon["wis"] = 11
        @dragon["chr"] = 10
        @dragon["racial_modifer"] = "+8 〈水泳〉"
        case @dragon_id[:dragon_age]
        when 1
          @dragon["sq"] = "水中呼吸"
        when 2
          @dragon["sq"] = "水中呼吸、森渡り"
        when 6..7
          @dragon["sq"] = "水中呼吸、森渡り、跡なき足取り"
        when 8..12
          @dragon["sq"] = "水中呼吸、森渡り、跡なき足取り、カモフラージュ"
        end
        @dragon["environment"] = "温暖/森林"
        case @dragon_id[:dragon_age]
        when 1
          @dragon["aura"] = ""
          @dragon["melee"] = "噛みつき (1d6+1)、爪(x2) (1d4+1)"
          @dragon["special_attack"] = "ブレス攻撃 (円錐形 15ft.、 DC13、2d6 ［酸］)"
        when 2
          @dragon["aura"] = ""
          @dragon["melee"] = "噛みつき (1d8+4)、爪(x2) (1d6+3)、翼(x2) (1d4+3)"
          @dragon["special_attack"] = "ブレス攻撃 (円錐形 20ft.、 DC15、4d6 ［酸］)"
        when 3
          @dragon["aura"] = ""
          @dragon["melee"] = "噛みつき (2d6+7)、爪(x2) (1d8+5)、翼(x2) (1d6+2)、尾の打撃 (1d8+7)"
          @dragon["special_attack"] = "ブレス攻撃 (円錐形 30ft.、 DC17、6d6 ［酸］)"
        when 4
          @dragon["aura"] = "畏怖すべき存在(120ft.、DC17)"
          @dragon["melee"] = "噛みつき (2d6+9)、爪(x2) (1d8+6)、翼(x2) (1d6+3)、尾の打撃 (1d8+9)"
          @dragon["special_attack"] = "ブレス攻撃 (円錐形 40ft.、 DC19、8d6 ［酸］)"
        when 5
          @dragon["aura"] = "畏怖すべき存在(150ft.、DC18)"
          @dragon["melee"] = "噛みつき (2d8+10)、爪(x2) (2d6+7)、翼(x2) (1d8+3)、尾の打撃 (2d6+10)"
          @dragon["special_attack"] = "ブレス攻撃 (円錐形 50ft.、 DC20、10d6［酸］)、押し潰し (小型、DC20、2d8+10)"
        when 6
          @dragon["aura"] = "畏怖すべき存在(180ft.、DC20)"
          @dragon["melee"] = "噛みつき (2d8+12)、爪(x2) (2d6+8)、翼(x2) (1d8+4)、尾の打撃 (2d6+12)"
          @dragon["special_attack"] = "ブレス攻撃 (円錐形 50ft.、 DC22、12d6［酸］)、押し潰し (小型、DC22、2d8+12)"
        when 7
          @dragon["aura"] = "畏怖すべき存在(210ft.、DC21)"
          @dragon["melee"] = "噛みつき (2d8+13)、爪(x2) (2d6+9)、翼(x2) (1d8+4)、尾の打撃 (2d6+13)"
          @dragon["special_attack"] = "ブレス攻撃 (円錐形 50ft.、 DC23、14d6［酸］)、押し潰し (小型、DC23、2d8+13)"
        when 8
          @dragon["aura"] = "畏怖すべき存在(240ft.、DC23)"
          @dragon["melee"] = "噛みつき (4d6+15)、爪(x2) (2d8+10)、翼(x2) (2d6+5)、尾の打撃 (2d8+15)"
          @dragon["special_attack"] = "ブレス攻撃 (円錐形 60ft.、 DC25、16d6［酸］)、押し潰し (中型、DC25、4d6+15)、尾による一掃 (小型、DC25、2d6+15)"
        when 9
          @dragon["aura"] = "畏怖すべき存在(270ft.、DC24)"
          @dragon["melee"] = "噛みつき (4d6+16)、爪(x2) (2d8+11)、翼(x2) (2d6+5)、尾の打撃 (2d8+16)"
          @dragon["special_attack"] = "ブレス攻撃 (円錐形 60ft.、 DC26、18d6［酸］)、押し潰し (中型、DC26、4d6+16)、尾による一掃 (小型、DC26、2d6+16)"
        when 10
          @dragon["aura"] = "畏怖すべき存在(300ft.、DC26)"
          @dragon["melee"] = "噛みつき (4d6+18)、爪(x2) (2d8+12)、翼(x2) (2d6+6)、尾の打撃 (2d8+18)"
          @dragon["special_attack"] = "ブレス攻撃 (円錐形 60ft.、 DC28、20d6［酸］)、押し潰し (中型、DC28、4d6+18)、尾による一掃 (小型、DC28、2d6+18)、瘴気"
        when 11
          @dragon["aura"] = "畏怖すべき存在(330ft.、DC27)"
          @dragon["melee"] = "噛みつき (4d6+19)、爪(x2) (2d8+13)、翼(x2) (2d6+6)、尾の打撃 (2d8+19)"
          @dragon["special_attack"] = "ブレス攻撃 (円錐形 60ft.、 DC29、22d6［酸］)、押し潰し (中型、DC29、4d6+19)、尾による一掃 (小型、DC29、2d6+19)、瘴気"
        when 12
          @dragon["aura"] = "畏怖すべき存在(360ft.、DC29)"
          @dragon["melee"] = "噛みつき (4d8+21)、爪(x2) (4d6+14)、翼(x2) (2d8+7)、尾の打撃 (4d6+21)"
          @dragon["special_attack"] = "ブレス攻撃 (円錐形 70ft.、 DC31、24d6［酸］)、押し潰し (大型、DC31、4d8+21)、尾による一掃 (中型、DC31、2d8+21)、瘴気、トリエント覚醒"
        end
      when 2
        @dragon["dragon_race_name"] = "ブラック"
        @dragon["cr"] = 3
        @dragon["alignment"] = "混沌にして悪"
        @dragon["size"] = 3
        @dragon["sense"] = "竜の超感覚"
        @dragon["subtypes"] = "水"
        @dragon["natural_armor"] = 3
        @dragon["hit_dice_count"] = 4
        @dragon["immune"] = "［酸］、麻痺、睡眠"
        @dragon["weakness"] = ""
        @dragon["land_speed"] = "60ft."
        @dragon["swim_speed"] = "60ft."
        case @dragon_id[:dragon_age]
        when 1..3
          @dragon["spell_like_ability"] = ""
        when 4..7
          @dragon["spell_like_ability"] = "ダークネス"
        when 8..9
          @dragon["spell_like_ability"] = "ダークネス、プラント・グロウス"
        when 10..12
          @dragon["spell_like_ability"] = "ダークネス、プラント・グロウス、インセクト・プレイグ"
        end
        @dragon["spell_caster_level"] = -9 + (@dragon_id[:dragon_age] * 2)
        @dragon["spell_caster_source"] = "ソーサラー"
        @dragon["str"] = 11
        @dragon["dex"] = 16
        @dragon["con"] = 13
        @dragon["int"] = 8
        @dragon["wis"] = 11
        @dragon["chr"] = 8
        @dragon["racial_modifer"] = "+8 〈水泳〉"
        case @dragon_id[:dragon_age]
        when 1
          @dragon["sq"] = "水中呼吸"
        when 2
          @dragon["sq"] = "水中呼吸、沼渡り"
        when 3..11
          @dragon["sq"] = "水中呼吸、沼渡り、爬虫類との会話"
        when 12
          @dragon["sq"] = "水中呼吸、沼渡り、爬虫類との会話、爬虫類魅惑"
        end
        @dragon["environment"] = "暑熱/湿地"
        case @dragon_id[:dragon_age]
        when 1
          @dragon["aura"] = ""
          @dragon["melee"] = "噛みつき (1d4)、爪(x2) (1d3)"
          @dragon["special_attack"] = "ブレス攻撃 (直線状 30ft.、 DC13、2d6［酸］)"
        when 2
          @dragon["aura"] = ""
          @dragon["melee"] = "噛みつき (1d6+3)、爪(x2) (1d4+2)"
          @dragon["special_attack"] = "ブレス攻撃 (直線状 40ft.、 DC15、4d6［酸］)"
        when 3
          @dragon["aura"] = ""
          @dragon["melee"] = "噛みつき (1d8+6)、爪(x2) (1d6+4)、翼(x2) (1d4+4)"
          @dragon["special_attack"] = "ブレス攻撃 (直線状 60ft.、 DC17、6d6［酸］)"
        when 4
          @dragon["aura"] = ""
          @dragon["melee"] = "噛みつき (1d8+7)、爪(x2) (1d6+5)、翼(x2) (1d4+5)"
          @dragon["special_attack"] = "ブレス攻撃 (直線状 60ft.、 DC19、8d6［酸］)"
        when 5
          @dragon["aura"] = ""
          @dragon["melee"] = "噛みつき (2d6+9)、爪(x2) (1d8+6)、翼(x2) (1d6+3)、尾の打撃 (1d8+9)"
          @dragon["special_attack"] = "ブレス攻撃 (直線状 80ft.、 DC20、10d6［酸］)"
        when 6
          @dragon["aura"] = "畏怖すべき存在(180ft.、DC19)"
          @dragon["melee"] = "噛みつき (2d6+10)、爪(x2) (1d8+7)、翼(x2) (1d6+3)、尾の打撃 (1d8+10)"
          @dragon["special_attack"] = "ブレス攻撃 (直線状 80ft.、 DC22、12d6［酸］)、水穢し"
        when 7
          @dragon["aura"] = "畏怖すべき存在(210ft.、DC20)"
          @dragon["melee"] = "噛みつき (2d6+12)、爪(x2) (1d8+8)、翼(x2) (1d6+4)、尾の打撃 (1d8+12)"
          @dragon["special_attack"] = "ブレス攻撃 (直線状 80ft.、 DC23、14d6［酸］)、水穢し"
        when 8
          @dragon["aura"] = "畏怖すべき存在(240ft.、DC22)"
          @dragon["melee"] = "噛みつき (2d8+13、加えて2d6［酸］)、爪(x2) (2d6+9)、翼(x2) (1d8+4)、尾の打撃 (2d6+13)"
          @dragon["special_attack"] = "［酸］の噛みつき、ブレス攻撃 (直線状 100ft.、 DC25、16d6［酸］)、水穢し、押し潰し (小型、DC25、2d8+13)、水穢し"
        when 9
          @dragon["aura"] = "畏怖すべき存在(270ft.、DC23)"
          @dragon["melee"] = "噛みつき (2d8+15、加えて2d6［酸］)、爪(x2) (2d6+10)、翼(x2) (1d8+5)、尾の打撃 (2d6+15)"
          @dragon["special_attack"] = "［酸］の噛みつき、ブレス攻撃 (直線状 100ft.、 DC26、18d6［酸］)、水穢し、押し潰し (小型、DC26、2d8+15)、水穢し"
        when 10
          @dragon["aura"] = "畏怖すべき存在(300ft.、DC25)"
          @dragon["melee"] = "噛みつき (2d8+16、加えて4d6［酸］)、爪(x2) (2d6+11)、翼(x2) (1d8+5)、尾の打撃 (2d6+16)"
          @dragon["special_attack"] = "［酸］の溜り(半径 50ft.)、［酸］の噛みつき、ブレス攻撃 (直線状 100ft.、 DC28、20d6［酸］)、水穢し、押し潰し (小型、DC28、2d8+16)、水穢し"
        when 11
          @dragon["aura"] = "畏怖すべき存在(330ft.、DC26)"
          @dragon["melee"] = "噛みつき (2d8+18、加えて4d6［酸］)、爪(x2) (2d6+12)、翼(x2) (1d8+6)、尾の打撃 (2d6+18)"
          @dragon["special_attack"] = "［酸］の溜り(半径 55ft.)、［酸］の噛みつき、ブレス攻撃 (直線状 100ft.、 DC29、22d6［酸］)、水穢し、押し潰し (小型、DC29、2d8+18)、水穢し"
        when 12
          @dragon["aura"] = "畏怖すべき存在(360ft.、DC28)"
          @dragon["melee"] = "噛みつき (4d6+19、加えて6d6［酸］)、爪(x2) (2d8+13)、翼(x2) (2d6+6)、尾の打撃 (2d8+19)"
          @dragon["special_attack"] = "［酸］の溜り(半径 60ft.)、［酸］の噛みつき、ブレス攻撃 (直線状 120ft.、 DC31、24d6［酸］)、押し潰し (中型、DC31、4d6+19)、尾による一掃 (小型、DC31、2d6+19)、水穢し"
        end
      when 3
        @dragon["dragon_race_name"] = "ブルー"
        @dragon["cr"] = 5
        @dragon["alignment"] = "秩序にして悪"
        @dragon["size"] = 4
        @dragon["sense"] = "竜の超感覚"
        @dragon["subtypes"] = "地"
        @dragon["natural_armor"] = 5
        @dragon["hit_dice_count"] = 6
        @dragon["immune"] = "［電気］、麻痺、睡眠"
        @dragon["weakness"] = ""
        @dragon["land_speed"] = "40ft."
        @dragon["burrow_speed"] = "20ft."
        case @dragon_id[:dragon_age]
        when 1..2
          @dragon["spell_like_ability"] = ""
        when 3
          @dragon["spell_like_ability"] = "ゴースト・サウンド"
        when 4..5
          @dragon["spell_like_ability"] = "ゴースト・サウンド、マイナー・イメージ"
        when 6..7
          @dragon["spell_like_ability"] = "ゴースト・サウンド、マイナー・イメージ、ヴェントリロキズム"
        when 8..9
          @dragon["spell_like_ability"] = "ゴースト・サウンド、マイナー・イメージ、ヴェントリロキズム、ハリューサナトリ・テレイン"
        when 10..11
          @dragon["spell_like_ability"] = "ゴースト・サウンド、マイナー・イメージ、ヴェントリロキズム、ハリューサナトリ・テレイン、ヴェイル"
        when 12
          @dragon["spell_like_ability"] = "ゴースト・サウンド、マイナー・イメージ、ヴェントリロキズム、ハリューサナトリ・テレイン、ヴェイル、ミラージュ・アーケイナ"
        end
        @dragon["spell_caster_level"] = -7 + (@dragon_id[:dragon_age] * 2)
        @dragon["spell_caster_source"] = "ソーサラー"
        @dragon["str"] = 13
        @dragon["dex"] = 14
        @dragon["con"] = 13
        @dragon["int"] = 10
        @dragon["wis"] = 11
        @dragon["chr"] = 10
        @dragon["racial_modifer"] = ""
        case @dragon_id[:dragon_age]
        when 1
          @dragon["sq"] = ""
        when 2..12
          @dragon["sq"] = "音真似"
        end
        @dragon["environment"] = "暑熱/砂漠"
        case @dragon_id[:dragon_age]
        when 1
          @dragon["aura"] = ""
          @dragon["melee"] = "噛みつき (1d6+1)、爪(x2) (1d4+1)"
          @dragon["special_attack"] = "ブレス攻撃 (直線状 40ft.、 DC14、2d8［電気］)、砂漠の渇き(DC14)"
        when 2
          @dragon["aura"] = ""
          @dragon["melee"] = "噛みつき (1d8+4)、爪(x2) (1d6+3)、翼(x2) (1d4+3)"
          @dragon["special_attack"] = "ブレス攻撃 (直線状 60ft.、 DC16、4d8［電気］)、砂漠の渇き(DC16)"
        when 3
          @dragon["aura"] = ""
          @dragon["melee"] = "噛みつき (2d6+7)、爪(x2) (1d8+5)、翼(x2) (1d6+2)、尾の打撃 (1d8+7)"
          @dragon["special_attack"] = "ブレス攻撃 (直線状 80ft.、 DC18、6d8［電気］)、砂漠の渇き(DC18)"
        when 4
          @dragon["aura"] = "畏怖すべき存在(120ft.、DC18)"
          @dragon["melee"] = "噛みつき (2d6+9)、爪(x2) (1d8+6)、翼(x2) (1d6+3)、尾の打撃 (1d8+9)"
          @dragon["special_attack"] = "ブレス攻撃 (直線状 80ft.、 DC20、8d8［電気］)、砂漠の渇き(DC20)"
        when 5
          @dragon["aura"] = "畏怖すべき存在(150ft.、DC19)"
          @dragon["melee"] = "噛みつき (2d8+10)、爪(x2) (2d6+7)、翼(x2) (1d8+3)、尾の打撃 (2d6+10)"
          @dragon["special_attack"] = "ブレス攻撃 (直線状 100ft.、 DC21、10d8［電気］)、押し潰し (小型、DC21、2d8+10)、砂漠の渇き(DC21)"
        when 6
          @dragon["aura"] = "［電気］(5ft.、1d6 ［電気］)、畏怖すべき存在(180ft.、DC21)"
          @dragon["melee"] = "噛みつき (2d8+12)、爪(x2) (2d6+8)、翼(x2) (1d8+4)、尾の打撃 (2d6+12)"
          @dragon["special_attack"] = "ブレス攻撃 (直線状 100ft.、 DC23、12d8［電気］)、押し潰し (小型、DC23、2d8+12)、砂漠の渇き(DC23)"
        when 7
          @dragon["aura"] = "［電気］(5ft.、1d6 ［電気］)、畏怖すべき存在(210ft.、DC22)"
          @dragon["melee"] = "噛みつき (2d8+13)、爪(x2) (2d6+9)、翼(x2) (1d8+4)、尾の打撃 (2d6+13)"
          @dragon["special_attack"] = "ブレス攻撃 (直線状 100ft.、 DC24、14d8［電気］)、押し潰し (小型、DC24、2d8+13)、砂漠の渇き(DC24)"
        when 8
          @dragon["aura"] = "［電気］(10ft.、1d6 ［電気］)、畏怖すべき存在(240ft.、DC24)"
          @dragon["melee"] = "噛みつき (4d6+15)、爪(x2) (2d8+10)、翼(x2) (2d6+5)、尾の打撃 (2d8+15)"
          @dragon["special_attack"] = "ブレス攻撃 (直線状 120ft.、 DC26、16d8［電気］)、押し潰し (中型、DC26、4d6+15)、砂漠の渇き(DC26)、蜃気楼、尾による一掃 (小型、DC26、2d6+15)"
        when 9
          @dragon["aura"] = "［電気］(10ft.、1d6 ［電気］)、畏怖すべき存在(270ft.、DC25)"
          @dragon["melee"] = "噛みつき (4d6+16)、爪(x2) (2d8+11)、翼(x2) (2d6+5)、尾の打撃 (2d8+16)"
          @dragon["special_attack"] = "ブレス攻撃 (直線状 120ft.、 DC27、18d8［電気］)、押し潰し (中型、DC27、4d6+16)、砂漠の渇き(DC27)、蜃気楼、尾による一掃 (小型、DC27、2d6+16)"
        when 10
          @dragon["aura"] = "［電気］(10ft.、2d6 ［電気］)、畏怖すべき存在(300ft.、DC27)"
          @dragon["melee"] = "噛みつき (4d6+18)、爪(x2) (2d8+12)、翼(x2) (2d6+6)、尾の打撃 (2d8+18)"
          @dragon["special_attack"] = "ブレス攻撃 (直線状 120ft.、 DC29、20d8［電気］)、押し潰し (中型、DC29、4d6+18)、砂漠の渇き(DC29)、蜃気楼、嵐のブレス (DC29、20d8［電気］)、尾による一掃 (小型、DC29、2d6+18)"
        when 11
          @dragon["aura"] = "［電気］(10ft.、2d6 ［電気］)、畏怖すべき存在(330ft.、DC28)"
          @dragon["melee"] = "噛みつき (4d6+19)、爪(x2) (2d8+13)、翼(x2) (2d6+6)、尾の打撃 (2d8+19)"
          @dragon["special_attack"] = "ブレス攻撃 (直線状 120ft.、 DC30、22d8［電気］)、押し潰し (中型、DC30、4d6+19)、砂漠の渇き(DC30)、蜃気楼、嵐のブレス (DC30、22d8［電気］)、尾による一掃 (小型、DC30、2d6+19)"
        when 12
          @dragon["aura"] = "［電気］(10ft.、2d6 ［電気］)、畏怖すべき存在(360ft.、DC30)"
          @dragon["melee"] = "噛みつき (4d8+21)、爪(x2) (4d6+14)、翼(x2) (2d8+7)、尾の打撃 (4d6+21)"
          @dragon["special_attack"] = "ブレス攻撃 (直線状 140ft.、 DC32、24d8［電気］)、押し潰し (大型、DC32、4d8+21)、砂漠の渇き(DC32)、蜃気楼、嵐のブレス (DC32、24d8［電気］)、尾による一掃 (中型、DC32、2d8+21)"
        end
      when 4
        @dragon["dragon_race_name"] = "ホワイト"
        @dragon["cr"] = 2
        @dragon["alignment"] = "混沌にして悪"
        @dragon["size"] = 3
        case @dragon_id[:dragon_age]
        when 1
          @dragon["sense"] = "竜の超感覚"
        when 2..12
          @dragon["sense"] = "竜の超感覚、雪の見通し"
        end
        @dragon["subtypes"] = "冷気"
        @dragon["natural_armor"] = 2
        @dragon["hit_dice_count"] = 3
        @dragon["immune"] = "［冷気］、麻痺、睡眠"
        @dragon["weakness"] = "［火］に対する脆弱性"
        @dragon["land_speed"] = "60ft."
        @dragon["burrow_speed"] = "30ft."
        @dragon["swim_speed"] = "60ft."
        case @dragon_id[:dragon_age]
        when 1..3
          @dragon["spell_like_ability"] = ""
        when 4
          @dragon["spell_like_ability"] = "フォッグ・クラウド"
        when 5..9
          @dragon["spell_like_ability"] = "フォッグ・クラウド、ガスト・オヴ・ウィンド"
        when 10..11
          @dragon["spell_like_ability"] = "フォッグ・クラウド、ガスト・オヴ・ウィンド、ウォール・オヴ・アイス"
        when 12
          @dragon["spell_like_ability"] = "フォッグ・クラウド、ガスト・オヴ・ウィンド、ウォール・オヴ・アイス、コントロール・ウェザー"
        end
        @dragon["spell_caster_level"] = -11 + (@dragon_id[:dragon_age] * 2)
        @dragon["spell_caster_source"] = "ソーサラー"
        @dragon["str"] = 11
        @dragon["dex"] = 16
        @dragon["con"] = 13
        @dragon["int"] = 6
        @dragon["wis"] = 9
        @dragon["chr"] = 6
        @dragon["racial_modifer"] = "+8 〈水泳〉"
        case @dragon_id[:dragon_age]
        when 1..2
          @dragon["sq"] = "氷上歩行"
        when 3..12
          @dragon["sq"] = "氷上歩行、氷の形成"
        end
        @dragon["environment"] = "寒冷/山岳"
        case @dragon_id[:dragon_age]
        when 1
          @dragon["aura"] = ""
          @dragon["melee"] = "噛みつき (1d4)、爪(x2) (1d3)"
          @dragon["special_attack"] = "ブレス攻撃 (円錐形 15ft.、 DC12、2d4［冷気］)"
        when 2
          @dragon["aura"] = ""
          @dragon["melee"] = "噛みつき (1d6+3)、爪(x2) (1d4+2)"
          @dragon["special_attack"] = "ブレス攻撃 (円錐形 20ft.、 DC14、4d4［冷気］)"
        when 3
          @dragon["aura"] = ""
          @dragon["melee"] = "噛みつき (1d8+6)、爪(x2) (1d6+4)、翼(x2) (1d4+4)"
          @dragon["special_attack"] = "ブレス攻撃 (円錐形 30ft.、 DC16、6d4［冷気］)"
        when 4
          @dragon["aura"] = ""
          @dragon["melee"] = "噛みつき (1d8+7)、爪(x2) (1d6+5)、翼(x2) (1d4+5)"
          @dragon["special_attack"] = "ブレス攻撃 (円錐形 30ft.、 DC18、8d4［冷気］)"
        when 5
          @dragon["aura"] = ""
          @dragon["melee"] = "噛みつき (2d6+9)、爪(x2) (1d8+6)、翼(x2) (1d6+3)、尾の打撃 (1d8+9)"
          @dragon["special_attack"] = "ブレス攻撃 (円錐形 40ft.、 DC19、10d4［冷気］)"
        when 6
          @dragon["aura"] = "畏怖すべき存在(180ft.、DC19)"
          @dragon["melee"] = "噛みつき (2d6+10)、爪(x2) (1d8+7)、翼(x2) (1d6+3)、尾の打撃 (1d8+10)"
          @dragon["special_attack"] = "ブレス攻撃 (円錐形 40ft.、 DC21、12d4［冷気］)"
        when 7
          @dragon["aura"] = "畏怖すべき存在(210ft.、DC20)"
          @dragon["melee"] = "噛みつき (2d6+12)、爪(x2) (1d8+8)、翼(x2) (1d6+4)、尾の打撃 (1d8+12)"
          @dragon["special_attack"] = "ブレス攻撃 (円錐形 40ft.、 DC22、14d4［冷気］)"
        when 8
          @dragon["aura"] = "畏怖すべき存在(240ft.、DC22)"
          @dragon["melee"] = "噛みつき (2d8+13)、爪(x2) (2d6+9)、翼(x2) (1d8+4)、尾の打撃 (2d6+13)"
          @dragon["special_attack"] = "ブレス攻撃 (円錐形 50ft.、 DC24、16d4［冷気］)、押し潰し (小型、DC24、2d8+13)、氷結の霧(3回/日、DC18)"
        when 9
          @dragon["aura"] = "畏怖すべき存在(270ft.、DC23)"
          @dragon["melee"] = "噛みつき (2d8+15)、爪(x2) (2d6+10)、翼(x2) (1d8+5)、尾の打撃 (2d6+15)"
          @dragon["special_attack"] = "ブレス攻撃 (円錐形 50ft.、 DC25、18d4［冷気］)、押し潰し (小型、DC25、2d8+15)、氷結の霧(3回/日、DC18)"
        when 10
          @dragon["aura"] = "畏怖すべき存在(300ft.、DC25)"
          @dragon["melee"] = "噛みつき (2d8+16)、爪(x2) (2d6+11)、翼(x2) (1d8+5)、尾の打撃 (2d6+16)"
          @dragon["special_attack"] = "猛吹雪、ブレス攻撃 (円錐形 50ft.、 DC27、20d4［冷気］)、押し潰し (小型、DC27、2d8+16)、氷結の霧(3回/日、DC19)"
        when 11
          @dragon["aura"] = "畏怖すべき存在(330ft.、DC26)"
          @dragon["melee"] = "噛みつき (2d8+18)、爪(x2) (2d6+12)、翼(x2) (1d8+6)、尾の打撃 (2d6+18)"
          @dragon["special_attack"] = "猛吹雪、ブレス攻撃 (円錐形 50ft.、 DC28、22d4［冷気］)、押し潰し (小型、DC28、2d8+18)、氷結の霧(3回/日、DC19)"
        when 12
          @dragon["aura"] = "畏怖すべき存在(360ft.、DC28)"
          @dragon["melee"] = "噛みつき (4d6+19)、爪(x2) (2d8+13)、翼(x2) (2d6+6)、尾の打撃 (2d8+19)"
          @dragon["special_attack"] = "猛吹雪、ブレス攻撃 (円錐形 60ft.、 DC30、24d4［冷気］)、押し潰し (中型、DC30、4d6+19)、尾による一掃 (小型、DC30、2d6+19)、氷の墓標(1回/日、DC23)、氷結の霧(3回/日、DC20)"
        end
      when 5
        @dragon["dragon_race_name"] = "レッド"
        @dragon["cr"] = 6
        @dragon["alignment"] = "混沌にして悪"
        @dragon["size"] = 4
        case @dragon_id[:dragon_age]
        when 1
          @dragon["sense"] = "竜の超感覚"
        when 2..12
          @dragon["sense"] = "竜の超感覚、煙の見通し"
        end
        @dragon["subtypes"] = "火"
        @dragon["natural_armor"] = 6
        @dragon["hit_dice_count"] = 7
        @dragon["immune"] = "［火］、麻痺、睡眠"
        @dragon["weakness"] = "［冷気］に対する脆弱性"
        @dragon["land_speed"] = "40ft."
        case @dragon_id[:dragon_age]
        when 1..2
          @dragon["spell_like_ability"] = ""
        when 3
          @dragon["spell_like_ability"] = "ディテクト・マジック"
        when 4..5
          @dragon["spell_like_ability"] = "ディテクト・マジック、パイロテクニクス"
        when 6..7
          @dragon["spell_like_ability"] = "ディテクト・マジック、パイロテクニクス、サジェスチョン"
        when 8..9
          @dragon["spell_like_ability"] = "ディテクト・マジック、パイロテクニクス、サジェスチョン、ウォール・オヴ・ファイアー"
        when 10..11
          @dragon["spell_like_ability"] = "ディテクト・マジック、パイロテクニクス、サジェスチョン、ウォール・オヴ・ファイアー、ファインド・ザ・パス"
        when 12
          @dragon["spell_like_ability"] = "ディテクト・マジック、パイロテクニクス、サジェスチョン、ウォール・オヴ・ファイアー、ファインド・ザ・パス、ディサーン・ロケーション"
        end
        @dragon["spell_caster_level"] = -5 + (@dragon_id[:dragon_age] * 2)
        @dragon["spell_caster_source"] = "ソーサラー"
        @dragon["str"] = 17
        @dragon["dex"] = 14
        @dragon["con"] = 15
        @dragon["int"] = 10
        @dragon["wis"] = 11
        @dragon["chr"] = 10
        @dragon["racial_modifer"] = ""
        case @dragon_id[:dragon_age]
        when 1..12
          @dragon["sq"] = ""
        end
        @dragon["environment"] = "暑熱/山岳"
        case @dragon_id[:dragon_age]
        when 1
          @dragon["aura"] = ""
          @dragon["melee"] = "噛みつき (1d6+4)、爪(x2) (1d4+3)"
          @dragon["special_attack"] = "ブレス攻撃 (円錐形 20ft.、 DC15、2d10［火］)"
        when 2
          @dragon["aura"] = ""
          @dragon["melee"] = "噛みつき (1d8+7)、爪(x2) (1d6+5)、翼(x2) (1d4+5)"
          @dragon["special_attack"] = "ブレス攻撃 (円錐形 30ft.、 DC17、4d10［火］)"
        when 3
          @dragon["aura"] = ""
          @dragon["melee"] = "噛みつき (2d6+10)、爪(x2) (1d8+7)、翼(x2) (1d6+3)、尾の打撃 (1d8+10)"
          @dragon["special_attack"] = "ブレス攻撃 (円錐形 40ft.、 DC19、6d10［火］)"
        when 4
          @dragon["aura"] = "畏怖すべき存在(120ft.、DC18)"
          @dragon["melee"] = "噛みつき (2d6+12)、爪(x2) (1d8+8)、翼(x2) (1d6+4)、尾の打撃 (1d8+12)"
          @dragon["special_attack"] = "ブレス攻撃 (円錐形 40ft.、 DC21、8d10［火］)"
        when 5
          @dragon["aura"] = "畏怖すべき存在(150ft.、DC19)"
          @dragon["melee"] = "噛みつき (2d8+13)、爪(x2) (2d6+9)、翼(x2) (1d8+4)、尾の打撃 (2d6+13)"
          @dragon["special_attack"] = "ブレス攻撃 (円錐形 50ft.、 DC22、10d10［火］)、押し潰し (小型、DC22、2d8+13)"
        when 6
          @dragon["aura"] = "［火］(5ft.、1d6 ［火］)、畏怖すべき存在(180ft.、DC21)"
          @dragon["melee"] = "噛みつき (2d8+15)、爪(x2) (2d6+10)、翼(x2) (1d8+5)、尾の打撃 (2d6+15)"
          @dragon["special_attack"] = "ブレス攻撃 (円錐形 50ft.、 DC24、12d10［火］)、押し潰し (小型、DC24、2d8+15)"
        when 7
          @dragon["aura"] = "［火］(5ft.、1d6 ［火］)、畏怖すべき存在(210ft.、DC22)"
          @dragon["melee"] = "噛みつき (2d8+16)、爪(x2) (2d6+11)、翼(x2) (1d8+5)、尾の打撃 (2d6+16)"
          @dragon["special_attack"] = "ブレス攻撃 (円錐形 50ft.、 DC25、14d10［火］)、押し潰し (小型、DC25、2d8+16)"
        when 8
          @dragon["aura"] = "［火］(10ft.、1d6 ［火］)、畏怖すべき存在(240ft.、DC24)"
          @dragon["melee"] = "噛みつき (4d6+18)、爪(x2) (2d8+12)、翼(x2) (2d6+6)、尾の打撃 (2d8+18)"
          @dragon["special_attack"] = "ブレス攻撃 (円錐形 60ft.、 DC27、16d10［火］)、押し潰し (中型、DC27、4d6+18)、尾による一掃 (小型、DC27、2d6+18)、炎の制御"
        when 9
          @dragon["aura"] = "［火］(10ft.、1d6 ［火］)、畏怖すべき存在(270ft.、DC25)"
          @dragon["melee"] = "噛みつき (4d6+19)、爪(x2) (2d8+13)、翼(x2) (2d6+6)、尾の打撃 (2d8+19)"
          @dragon["special_attack"] = "ブレス攻撃 (円錐形 60ft.、 DC28、18d10［火］)、押し潰し (中型、DC28、4d6+19)、尾による一掃 (小型、DC28、2d6+19)、炎の制御"
        when 10
          @dragon["aura"] = "［火］(10ft.、2d6 ［火］)、畏怖すべき存在(300ft.、DC27)"
          @dragon["melee"] = "噛みつき (4d6+21)、爪(x2) (2d8+14)、翼(x2) (2d6+7)、尾の打撃 (2d8+21)"
          @dragon["special_attack"] = "ブレス攻撃 (円錐形 60ft.、 DC30、20d10［火］)、押し潰し (中型、DC30、4d6+21)、尾による一掃 (小型、DC30、2d6+21)、炎の制御、溶岩"
        when 11
          @dragon["aura"] = "［火］(10ft.、2d6 ［火］)、畏怖すべき存在(330ft.、DC28)"
          @dragon["melee"] = "噛みつき (4d6+22)、爪(x2) (2d8+15)、翼(x2) (2d6+7)、尾の打撃 (2d8+22)"
          @dragon["special_attack"] = "ブレス攻撃 (円錐形 60ft.、 DC31、22d10［火］)、押し潰し (中型、DC31、4d6+22)、尾による一掃 (小型、DC31、2d6+22)、炎の制御、溶岩"
        when 12
          @dragon["aura"] = "［火］(10ft.、2d6 ［火］)、畏怖すべき存在(360ft.、DC30)"
          @dragon["melee"] = "噛みつき (4d8+24)、爪(x2) (4d6+16)、翼(x2) (2d8+8)、尾の打撃 (4d6+24)"
          @dragon["special_attack"] = "ブレス攻撃 (円錐形 70ft.、 DC33、24d10［火］)、押し潰し (大型、DC33、4d8+24)、尾による一掃 (中型、DC33、2d8+24)、炎の制御、溶岩、火葬"
        end
      when 6
        @dragon["dragon_race_name"] = "カッパー"
        @dragon["cr"] = 4
        @dragon["alignment"] = "混沌にして善"
        @dragon["size"] = 3
        @dragon["sense"] = "竜の超感覚"
        @dragon["subtypes"] = "地"
        @dragon["natural_armor"] = 4
        @dragon["hit_dice_count"] = 5
        case @dragon_id[:dragon_age]
        when 3..12
          @dragon["defensive_ability"] = "直感回避"
        end
        case @dragon_id[:dragon_age]
        when 2..12
          @dragon["additional_move"] = "石登り"
        end

        @dragon["immune"] = "［酸］、麻痺、睡眠"
        @dragon["weakness"] = ""
        @dragon["land_speed"] = "40ft."
        case @dragon_id[:dragon_age]
        when 1
          @dragon["spell_like_ability"] = ""
        when 2..3
          @dragon["spell_like_ability"] = "グリース"
        when 4..5
          @dragon["spell_like_ability"] = "グリース、ヒディアス・ラフター"
        when 6..7
          @dragon["spell_like_ability"] = "グリース、ヒディアス・ラフター、ストーン・シェイプ"
        when 8..9
          @dragon["spell_like_ability"] = "グリース、ヒディアス・ラフター、ストーン・シェイプ、トランスミュート・ロック・トゥ・マッド"
        when 10..11
          @dragon["spell_like_ability"] = "グリース、ヒディアス・ラフター、ストーン・シェイプ、トランスミュート・ロック・トゥ・マッド、ウォール・オヴ・ストーン"
        when 12
          @dragon["spell_like_ability"] = "グリース、ヒディアス・ラフター、ストーン・シェイプ、トランスミュート・ロック・トゥ・マッド、ウォール・オヴ・ストーン、ムーヴ・アース"
        end
        @dragon["spell_caster_level"] = -5 + (@dragon_id[:dragon_age] * 2)
        @dragon["spell_caster_source"] = "ソーサラー"
        @dragon["str"] = 11
        @dragon["dex"] = 16
        @dragon["con"] = 13
        @dragon["int"] = 12
        @dragon["wis"] = 13
        @dragon["chr"] = 12
        @dragon["racial_modifer"] = ""
        case @dragon_id[:dragon_age]
        when 1..3
          @dragon["sq"] = ""
        when 4..12
          @dragon["sq"] = "罠の達人"
        end
        @dragon["environment"] = "暑熱/丘陵"
        case @dragon_id[:dragon_age]
        when 1
          @dragon["aura"] = ""
          @dragon["melee"] = "噛みつき (1d4)、爪(x2) (1d3)"
          @dragon["special_attack"] = "ブレス攻撃 (直線状 30ft.、 DC13、2d6［酸］)、減速化のブレス (円錐形 15ft.、 DC13、1d6+1R 減速状態)"
        when 2
          @dragon["aura"] = ""
          @dragon["melee"] = "噛みつき (1d6+3)、爪(x2) (1d4+2)"
          @dragon["special_attack"] = "ブレス攻撃 (直線状 40ft.、 DC15、4d6［酸］)、減速化のブレス (円錐形 20ft.、 DC15、1d6+2R 減速状態)"
        when 3
          @dragon["aura"] = ""
          @dragon["melee"] = "噛みつき (1d8+6)、爪(x2) (1d6+4)、翼(x2) (1d4+4)"
          @dragon["special_attack"] = "ブレス攻撃 (直線状 60ft.、 DC17、6d6［酸］)、減速化のブレス (円錐形 30ft.、 DC17、1d6+3R 減速状態)"
        when 4
          @dragon["aura"] = ""
          @dragon["melee"] = "噛みつき (1d8+7)、爪(x2) (1d6+5)、翼(x2) (1d4+5)"
          @dragon["special_attack"] = "ブレス攻撃 (直線状 60ft.、 DC19、8d6［酸］)、減速化のブレス (円錐形 30ft.、 DC19、1d6+4R 減速状態)"
        when 5
          @dragon["aura"] = ""
          @dragon["melee"] = "噛みつき (2d6+9)、爪(x2) (1d8+6)、翼(x2) (1d6+3)、尾の打撃 (1d8+9)"
          @dragon["special_attack"] = "ブレス攻撃 (直線状 80ft.、 DC20、10d6［酸］)、減速化のブレス (円錐形 40ft.、 DC20、1d6+5R 減速状態)"
        when 6
          @dragon["aura"] = "畏怖すべき存在(180ft.、DC21)"
          @dragon["melee"] = "噛みつき (2d6+10)、爪(x2) (1d8+7)、翼(x2) (1d6+3)、尾の打撃 (1d8+10)"
          @dragon["special_attack"] = "ブレス攻撃 (直線状 80ft.、 DC22、12d6［酸］)、減速化のブレス (円錐形 40ft.、 DC22、1d6+6R 減速状態)"
        when 7
          @dragon["aura"] = "畏怖すべき存在(210ft.、DC22)"
          @dragon["melee"] = "噛みつき (2d6+12)、爪(x2) (1d8+8)、翼(x2) (1d6+4)、尾の打撃 (1d8+12)"
          @dragon["special_attack"] = "ブレス攻撃 (直線状 80ft.、 DC23、14d6［酸］)、減速化のブレス (円錐形 40ft.、 DC23、1d6+7R 減速状態)"
        when 8
          @dragon["aura"] = "畏怖すべき存在(240ft.、DC24)、減速化(5ft.、DC25、1R 減速状態)"
          @dragon["melee"] = "噛みつき (2d8+13)、爪(x2) (2d6+9)、翼(x2) (1d8+4)、尾の打撃 (2d6+13)"
          @dragon["special_attack"] = "ブレス攻撃 (直線状 100ft.、 DC25、16d6［酸］)、押し潰し (小型、DC25、2d8+13)、減速化のブレス (円錐形 50ft.、 DC25、1d6+8R 減速状態)"
        when 9
          @dragon["aura"] = "畏怖すべき存在(270ft.、DC25)、減速化(5ft.、DC26、1R 減速状態)"
          @dragon["melee"] = "噛みつき (2d8+15)、爪(x2) (2d6+10)、翼(x2) (1d8+5)、尾の打撃 (2d6+15)"
          @dragon["special_attack"] = "ブレス攻撃 (直線状 100ft.、 DC26、18d6［酸］)、押し潰し (小型、DC26、2d8+15)、減速化のブレス (円錐形 50ft.、 DC26、1d6+9R 減速状態)"
        when 10
          @dragon["aura"] = "畏怖すべき存在(300ft.、DC27)、減速化(10ft.、DC28、1R 減速状態)"
          @dragon["melee"] = "噛みつき (2d8+16)、爪(x2) (2d6+11)、翼(x2) (1d8+5)、尾の打撃 (2d6+16)"
          @dragon["special_attack"] = "ブレス攻撃 (直線状 100ft.、 DC28、20d6［酸］)、押し潰し (小型、DC28、2d8+16)、大受け(DC22)、減速化のブレス (円錐形 50ft.、 DC28、1d6+10R 減速状態)"
        when 11
          @dragon["aura"] = "畏怖すべき存在(330ft.、DC28)、減速化(10ft.、DC29、1R 減速状態)"
          @dragon["melee"] = "噛みつき (2d8+18)、爪(x2) (2d6+12)、翼(x2) (1d8+6)、尾の打撃 (2d6+18)"
          @dragon["special_attack"] = "ブレス攻撃 (直線状 100ft.、 DC29、22d6［酸］)、押し潰し (小型、DC29、2d8+18)、大受け(DC22)、減速化のブレス (円錐形 50ft.、 DC29、1d6+11R 減速状態)"
        when 12
          @dragon["aura"] = "畏怖すべき存在(360ft.、DC30)、減速化(10ft.、DC31、1d4R 減速状態)"
          @dragon["melee"] = "噛みつき (4d6+19)、爪(x2) (2d8+13)、翼(x2) (2d6+6)、尾の打撃 (2d8+19)"
          @dragon["special_attack"] = "アブないジョーク(DC26)、ブレス攻撃 (直線状 120ft.、 DC31、24d6［酸］)、押し潰し (中型、DC31、4d6+19)、大受け(DC23)、尾による一掃 (小型、DC31、2d6+19)、減速化のブレス (円錐形 60ft.、DC31、1d6+12R 減速状態)"
        end
      when 7
        @dragon["dragon_race_name"] = "ゴールド"
      when 8
        @dragon["dragon_race_name"] = "シルヴァー"
      when 9
        @dragon["dragon_race_name"] = "ブラス"
      when 10
        @dragon["dragon_race_name"] = "ブロンズ"
      end
      case @dragon_id[:dragon_age]
      when 1
        @dragon["dragon_age_name"] = "ワームリング"
        case @dragon["size"]
        when 3
          @dragon["size"] = "超小型"
        when 4
          @dragon["size"] = "小型"
        end
      when 2
        @dragon["dragon_age_name"] = "ヴェリー・ヤング"
        @dragon["cr"] = @dragon["cr"] + 2
        case @dragon["size"]
        when 3
          @dragon["size"] = "小型"
        when 4
          @dragon["size"] = "中型"
        end
        @dragon["str"] = @dragon["str"] + 4
        @dragon["dex"] = @dragon["dex"] - 2
        @dragon["con"] = @dragon["con"] + 2
        @dragon["int"] = @dragon["int"] + 2
        @dragon["wis"] = @dragon["wis"] + 2
        @dragon["chr"] = @dragon["chr"] + 2
      when 3
        @dragon["dragon_age_name"] = "ヤング"
        @dragon["cr"] = @dragon["cr"] + 4
        case @dragon["size"]
        when 3
          @dragon["size"] = "中型"
        when 4
          @dragon["size"] = "大型"
        end
        @dragon["str"] = @dragon["str"] + 8
        @dragon["dex"] = @dragon["dex"] - 2
        @dragon["con"] = @dragon["con"] + 4
        @dragon["int"] = @dragon["int"] + 2
        @dragon["wis"] = @dragon["wis"] + 2
        @dragon["chr"] = @dragon["chr"] + 2
      when 4
        @dragon["dragon_age_name"] = "ジュヴナイル"
        @dragon["cr"] = @dragon["cr"] + 5
        case @dragon["size"]
        when 3
          @dragon["size"] = "中型"
        when 4
          @dragon["size"] = "大型"
        end
        @dragon["str"] = @dragon["str"] + 10
        @dragon["dex"] = @dragon["dex"] - 2
        @dragon["con"] = @dragon["con"] + 6
        @dragon["int"] = @dragon["int"] + 4
        @dragon["wis"] = @dragon["wis"] + 4
        @dragon["chr"] = @dragon["chr"] + 4
      when 5
        @dragon["dragon_age_name"] = "ヤング・アダルト"
        @dragon["cr"] = @dragon["cr"] + 7
        case @dragon["size"]
        when 3
          @dragon["size"] = "大型"
        when 4
          @dragon["size"] = "超大型"
        end
        @dragon["str"] = @dragon["str"] + 12
        @dragon["dex"] = @dragon["dex"] - 4
        @dragon["con"] = @dragon["con"] + 6
        @dragon["int"] = @dragon["int"] + 4
        @dragon["wis"] = @dragon["wis"] + 4
        @dragon["chr"] = @dragon["chr"] + 4
      when 6
        @dragon["dragon_age_name"] = "アダルト"
        @dragon["cr"] = @dragon["cr"] + 8
        case @dragon["size"]
        when 3
          @dragon["size"] = "大型"
        when 4
          @dragon["size"] = "超大型"
        end
        @dragon["str"] = @dragon["str"] + 14
        @dragon["dex"] = @dragon["dex"] - 4
        @dragon["con"] = @dragon["con"] + 8
        @dragon["int"] = @dragon["int"] + 6
        @dragon["wis"] = @dragon["wis"] + 6
        @dragon["chr"] = @dragon["chr"] + 6
      when 7
        @dragon["dragon_age_name"] = "マチュア・アダルト"
        @dragon["cr"] = @dragon["cr"] + 9
        case @dragon["size"]
        when 3
          @dragon["size"] = "大型"
        when 4
          @dragon["size"] = "超大型"
        end
        @dragon["str"] = @dragon["str"] + 16
        @dragon["dex"] = @dragon["dex"] - 4
        @dragon["con"] = @dragon["con"] + 8
        @dragon["int"] = @dragon["int"] + 6
        @dragon["wis"] = @dragon["wis"] + 6
        @dragon["chr"] = @dragon["chr"] + 6
      when 8
        @dragon["dragon_age_name"] = "オールド"
        @dragon["cr"] = @dragon["cr"] + 11
        case @dragon["size"]
        when 3
          @dragon["size"] = "超大型"
        when 4
          @dragon["size"] = "巨大"
        end
        @dragon["str"] = @dragon["str"] + 18
        @dragon["dex"] = @dragon["dex"] - 6
        @dragon["con"] = @dragon["con"] + 10
        @dragon["int"] = @dragon["int"] + 8
        @dragon["wis"] = @dragon["wis"] + 8
        @dragon["chr"] = @dragon["chr"] + 8
      when 9
        @dragon["dragon_age_name"] = "ヴェリー・オールド"
        @dragon["cr"] = @dragon["cr"] + 12
        case @dragon["size"]
        when 3
          @dragon["size"] = "超大型"
        when 4
          @dragon["size"] = "巨大"
        end
        @dragon["str"] = @dragon["str"] + 20
        @dragon["dex"] = @dragon["dex"] - 6
        @dragon["con"] = @dragon["con"] + 10
        @dragon["int"] = @dragon["int"] + 8
        @dragon["wis"] = @dragon["wis"] + 8
        @dragon["chr"] = @dragon["chr"] + 8
      when 10
        @dragon["dragon_age_name"] = "エインシャント"
        @dragon["cr"] = @dragon["cr"] + 13
        case @dragon["size"]
        when 3
          @dragon["size"] = "超大型"
        when 4
          @dragon["size"] = "巨大"
        end
        @dragon["str"] = @dragon["str"] + 22
        @dragon["dex"] = @dragon["dex"] - 6
        @dragon["con"] = @dragon["con"] + 12
        @dragon["int"] = @dragon["int"] + 10
        @dragon["wis"] = @dragon["wis"] + 10
        @dragon["chr"] = @dragon["chr"] + 10
      when 11
        @dragon["dragon_age_name"] = "ワーム"
        @dragon["cr"] = @dragon["cr"] + 14
        case @dragon["size"]
        when 3
          @dragon["size"] = "超大型"
        when 4
          @dragon["size"] = "巨大"
        end
        @dragon["str"] = @dragon["str"] + 24
        @dragon["dex"] = @dragon["dex"] - 8
        @dragon["con"] = @dragon["con"] + 12
        @dragon["int"] = @dragon["int"] + 10
        @dragon["wis"] = @dragon["wis"] + 10
        @dragon["chr"] = @dragon["chr"] + 10
      when 12
        @dragon["dragon_age_name"] = "グレート・ワーム"
        @dragon["cr"] = @dragon["cr"] + 16
        case @dragon["size"]
        when 3
          @dragon["size"] = "巨大"
        when 4
          @dragon["size"] = "超巨大"
        end
        @dragon["str"] = @dragon["str"] + 26
        @dragon["dex"] = @dragon["dex"] - 8
        @dragon["con"] = @dragon["con"] + 14
        @dragon["int"] = @dragon["int"] + 12
        @dragon["wis"] = @dragon["wis"] + 12
        @dragon["chr"] = @dragon["chr"] + 12
      end
      @dragon["str_modifer"] = ((@dragon["str"] - 10) / 2).to_i
      @dragon["dex_modifer"] = ((@dragon["dex"] - 10) / 2).to_i
      @dragon["con_modifer"] = ((@dragon["con"] - 10) / 2).to_i
      @dragon["int_modifer"] = ((@dragon["int"] - 10) / 2).to_i
      @dragon["wis_modifer"] = ((@dragon["wis"] - 10) / 2).to_i
      @dragon["chr_modifer"] = ((@dragon["chr"] - 10) / 2).to_i
      if @dragon["dex_modifer"] > 0
        @dragon["init"] = "+" + @dragon["dex_modifer"].to_s
      else
        @dragon["init"] = @dragon["dex_modifer"]
      end
      if @dragon["size"] == "超小型"
        @dragon["size_modifer_attack"] = 2
        @dragon["size_modifer_cmb"] = @dragon["size_modifer_attack"] * -1
        @dragon["fly_speed"] = "100ft."
        @dragon["fly_muverabillity"] = "標準"
        @dragon["space"] = "2.5ft."
        @dragon["reach"] = "0ft."
        @dragon["bite_reach"] = "5ft."
      elsif @dragon["size"] == "小型"
        @dragon["size_modifer_attack"] = 1
        @dragon["size_modifer_cmb"] = @dragon["size_modifer_attack"] * -1
        @dragon["fly_speed"] = "150ft."
        @dragon["fly_muverabillity"] = "標準"
        @dragon["space"] = "5ft."
        @dragon["reach"] = "5ft."
        @dragon["bite_reach"] = "5ft."
      elsif @dragon["size"] == "中型"
        @dragon["size_modifer_attack"] = 0
        @dragon["size_modifer_cmb"] = @dragon["size_modifer_attack"] * -1
        @dragon["fly_speed"] = "150ft."
        @dragon["fly_muverabillity"] = "標準"
        @dragon["space"] = "5ft."
        @dragon["reach"] = "5ft."
        @dragon["bite_reach"] = "5ft."
      elsif @dragon["size"] == "大型"
        @dragon["size_modifer_attack"] = -1
        @dragon["size_modifer_cmb"] = @dragon["size_modifer_attack"] * -1
        @dragon["fly_speed"] = "200ft."
        @dragon["fly_muverabillity"] = "貧弱"
        @dragon["space"] = "10ft."
        @dragon["reach"] = "5ft."
        @dragon["bite_reach"] = "10ft."
      elsif @dragon["size"] == "超大型"
        @dragon["size_modifer_attack"] = -2
        @dragon["size_modifer_cmb"] = @dragon["size_modifer_attack"] * -1
        @dragon["fly_speed"] = "200ft."
        @dragon["fly_muverabillity"] = "貧弱"
        @dragon["space"] = "15ft."
        @dragon["reach"] = "10ft."
        @dragon["bite_reach"] = "15ft."
      elsif @dragon["size"] == "巨大"
        @dragon["size_modifer_attack"] = -4
        @dragon["size_modifer_cmb"] = @dragon["size_modifer_attack"] * -1
        @dragon["fly_speed"] = "250ft."
        @dragon["fly_muverabillity"] = "劣悪"
        @dragon["space"] = "20ft."
        @dragon["reach"] = "15ft."
        @dragon["bite_reach"] = "20ft."
      elsif @dragon["size"] == "超巨大"
        @dragon["size_modifer_attack"] = -8
        @dragon["size_modifer_cmb"] = @dragon["size_modifer_attack"] * -1
        @dragon["fly_speed"] = "250ft."
        @dragon["fly_muverabillity"] = "劣悪"
        @dragon["space"] = "30ft."
        @dragon["reach"] = "20ft."
        @dragon["bite_reach"] = "30ft."
      end
      @dragon["natural_armor"] = @dragon["natural_armor"] + ((@dragon_id[:dragon_age] - 1) * 3)
      @dragon["hit_dice_count"] = @dragon["hit_dice_count"] + ((@dragon_id[:dragon_age] - 1) * 2)
      if @dragon["dex_modifer"] > 0
        @dragon["defence_describe"] = "(+" + @dragon["dex_modifer"].to_s + " 【敏】"
      elsif @dragon["dex_modifer"] < 0
        @dragon["defence_describe"] = "(" + @dragon["dex_modifer"].to_s + " 【敏】"
      end
      if @dragon["defence_describe"] != ""
        @dragon["defence_describe"] = @dragon["defence_describe"] + ", +" + @dragon["natural_armor"].to_s + " 外皮"
      else
        @dragon["defence_describe"] = "(+" + @dragon["natural_armor"].to_s + " 外皮"
      end
      if @dragon["size_modifer_attack"] > 0
        @dragon["defence_describe"] = @dragon["defence_describe"] + ", +" + @dragon["size_modifer_attack"].to_s + " サイズ)"
      elsif @dragon["size_modifer_attack"] < 0
        @dragon["defence_describe"] = @dragon["defence_describe"] + ", " + @dragon["size_modifer_attack"].to_s + " サイズ)"
      else
        @dragon["defence_describe"] = @dragon["defence_describe"] + ")"
      end
      @dragon["ac"] = 10 + @dragon["dex_modifer"] + @dragon["natural_armor"] + @dragon["size_modifer_attack"]
      @dragon["touch"] = 10 + @dragon["dex_modifer"] + @dragon["size_modifer_attack"]
      @dragon["flat_footed"] = 10 + @dragon["natural_armor"] + @dragon["size_modifer_attack"]
      if @dragon["dex_modifer"] < 0
        @dragon["flat_footed"] = @dragon["flat_footed"] + @dragon["dex_modifer"]
      end
      @dragon["hp"] = (@dragon["hit_dice_count"] / 2).to_i * 7 + (@dragon["hit_dice_count"] - (@dragon["hit_dice_count"] / 2).to_i) * 6 + @dragon["con_modifer"] * @dragon["hit_dice_count"]
      if @dragon["con_modifer"] > 0
        @dragon["hp_con_modifer"] = "+" + (@dragon["con_modifer"] * @dragon["hit_dice_count"]).to_s
      else
        @dragon["hp_con_modifer"] = ""
      end
      @dragon["fort"] = "+" + ((@dragon["hit_dice_count"] / 2).to_i + 2 + @dragon["con_modifer"]).to_s
      @dragon["ref"] = "+" + ((@dragon["hit_dice_count"] / 2).to_i + 2 + @dragon["dex_modifer"]).to_s
      @dragon["will"] = "+" + ((@dragon["hit_dice_count"] / 2).to_i + 2 + @dragon["wis_modifer"]).to_s
      @dragon["speed"] = @dragon["land_speed"]
      if @dragon["burrow_speed"] != ""
        @dragon["speed"] = @dragon["speed"] + ", 穴掘り " + @dragon["burrow_speed"]
      end
      if @dragon["swim_speed"] != ""
        @dragon["speed"] = @dragon["speed"] + ", 水泳 " + @dragon["swim_speed"]
      end
      @dragon["speed"] = @dragon["speed"] + ", 飛行 " + @dragon["fly_speed"] + "(" + @dragon["fly_muverabillity"] + ")"
      if @dragon["additional_move"] != ""
        @dragon["speed"] = @dragon["speed"] + "; " + @dragon["additional_move"]
      end
      if @dragon["spell_like_ability"] != ""
        @dragon["spell_like_ability_cl"] = @dragon["hit_dice_count"]
        @dragon["spell_like_ability_concentration"] = @dragon["hit_dice_count"] + @dragon["chr_modifer"]
      else
        @dragon["spell_like_ability_cl"] = ""
        @dragon["spell_like_ability_concentration"] = ""
      end
      if @dragon["spell_caster_level"] != ""
        @dragon["spell_caster_concentration"] = @dragon["spell_caster_level"] + @dragon["chr_modifer"]
      else
        @dragon["spell_caster_concentration"] = ""
      end
      @dragon["base_attack"] = "+" + @dragon["hit_dice_count"].to_s
      @dragon["cmb"] = "+" + (@dragon["hit_dice_count"] + @dragon["size_modifer_cmb"] + @dragon["str_modifer"]).to_s 
      @dragon["cmd"] = (10 + @dragon["hit_dice_count"] + @dragon["size_modifer_cmb"] + @dragon["str_modifer"] + @dragon["dex_modifer"])
      @dragon["cmd"] = @dragon["cmd"].to_s + " (" + (@dragon["cmd"] + 4).to_s + " 対足払い)"
      @dragon["feet_count"] = (@dragon["hit_dice_count"] / 2).to_i + 1
      @dragon["skill_per_rank"] = @dragon["int_modifer"] + 6
      @dragon["skill_sum_rank"] = @dragon["skill_per_rank"] * @dragon["hit_dice_count"]
      if @dragon["int_modifer"] < 0
        @dragon["language_count"] = 0
      else
        @dragon["language_count"] = @dragon["int_modifer"]
      end
      i = 0
      base = 1
      while i < (@dragon["cr"] / 2).to_i
        base = base * 2
        i += 1
      end
      if (@dragon["cr"] & 1) == 1
        @dragon["xp"] = 400 * base
      else
        @dragon["xp"] = 300 * base
      end
      if @dragon["sr_flag"] == true
        @dragon["sr"] = @dragon["cr"] + 11
      else
        @dragon["sr"] = 0
      end
      end
      end
    end
  end
end
