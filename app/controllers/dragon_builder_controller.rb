class DragonBuilderController < ApplicationController
  def index
    @dragon_races = DragonRace.all
    @dragon_age_categories = DragonAgeCategory.all
    @dragon_id = {}
    @dragon_id[:dragon_race] = 1
    @dragon_id[:dragon_age] = 1
    if (params[:dragon_race] != nil && params[:dragon_age] != nil)
      @dragon_id[:dragon_race] = params[:dragon_race].to_i
      @dragon_id[:dragon_age] = params[:dragon_age].to_i

      if @dragon_id[:dragon_race] > 6
      @dragon_id[:dragon_race] = 1
      @dragon_id[:dragon_age] = 1

      else
      dragon_race = DragonRace.find(params[:dragon_race].to_i)
      dragon_age_category = DragonAgeCategory.find(params[:dragon_age].to_i)
      dragon_race_age = DragonRaceAge.find(:first, :conditions => ["race_id = ? and age_id = ?", params[:dragon_race].to_i, params[:dragon_age].to_i])
      @dragon = {}
      @dragon["hit_dice_number"] = 12
      @dragon["defence_describe"] = ""

      @dragon["dragon_race_name"] = dragon_race.name
      @dragon["dragon_age_name"] = dragon_age_category.age_category
      @dragon["cr"] = dragon_race.cr + dragon_age_category.cr
      size_category = SizeCategory.find(:first, :conditions => ["size_id = ?", dragon_race.size + dragon_age_category.size])
      @dragon["size"] = size_category.name
      @dragon["ba_size_modifer"] = size_category.ba_size_modifer
      @dragon["space"] = size_category.space
      @dragon["reach"] = size_category.reach
      @dragon["bite_reach"] = size_category.bite_reach

      @dragon["alignment"] = dragon_race.alignment
      @dragon["types"] = dragon_race.creature_category
      @dragon["subtypes"] = dragon_race.creature_subcategory
      @dragon["natural_armor"] = dragon_race.natural_armor + dragon_age_category.natural_armor
      @dragon["hit_dice_count"] = dragon_race.hit_dice + dragon_age_category.hit_dice
      @dragon["immune"] = dragon_race.immune
      @dragon["weakness"] = dragon_race.weakness
      @dragon["burrow_speed"] = dragon_race.burrow_speed
      @dragon["swim_speed"] = dragon_race.swim_speed
      @dragon["str"] = dragon_race.str + dragon_age_category.str
      @dragon["dex"] = dragon_race.dex + dragon_age_category.dex
      @dragon["con"] = dragon_race.con + dragon_age_category.con
      @dragon["int"] = dragon_race.int + dragon_age_category.int
      @dragon["wis"] = dragon_race.wis + dragon_age_category.wis
      @dragon["chr"] = dragon_race.chr + dragon_age_category.chr
      @dragon["racial_modifer"] = dragon_race.racial_modifer
      @dragon["language"] = dragon_race.language
      @dragon["environment"] = dragon_race.env
      @dragon["organization"] = dragon_race.organization
      @dragon["treasure"] = dragon_race.treasure

      @dragon["sense"] = dragon_race_age.sense
#      @dragon["aura"] = dragon_race_age.aura
      @dragon["defensive_ability"] = dragon_race_age.defensive_ability
      @dragon["dr"] = dragon_race_age.dr
      @dragon["sr_flag"] = dragon_race_age.sr
      @dragon["additional_move"] = dragon_race_age.additional_move
#      @dragon["special_attack"] = dragon_race_age.special_attack
      @dragon["spell_like_ability"] = dragon_race_age.sp
      @dragon["spell_caster_level"] = dragon_race_age.caster_level
      @dragon["spell_caster_source"] = dragon_race_age.caster_source
      @dragon["sq"] = dragon_race_age.sq

        @dragon["str_modifer"] = ((@dragon["str"] - 10) / 2).to_i
        @dragon["dex_modifer"] = ((@dragon["dex"] - 10) / 2).to_i
        @dragon["con_modifer"] = ((@dragon["con"] - 10) / 2).to_i
        @dragon["int_modifer"] = ((@dragon["int"] - 10) / 2).to_i
        @dragon["wis_modifer"] = ((@dragon["wis"] - 10) / 2).to_i
        @dragon["chr_modifer"] = ((@dragon["chr"] - 10) / 2).to_i

        @dragon["aura"] = dragon_race_age.get_aura(dragon_race_age, @dragon)
        @dragon["melee"] = size_category.get_melee(dragon_race_age, @dragon)
        @dragon["special_attack"] = dragon_race_age.get_special_attack(dragon_race, dragon_age_category, size_category, @dragon)

        @dragon["defence_describe"] = "(" + sprintf("%+d", @dragon["dex_modifer"]) + " 【敏】"
        if @dragon["defence_describe"] != ""
          @dragon["defence_describe"] = @dragon["defence_describe"] + ", " + sprintf("%+d", @dragon["natural_armor"]) + " 外皮"
        else
          @dragon["defence_describe"] = "(" + sprintf("%+d", @dragon["natural_armor"]) + " 外皮"
        end
        if @dragon["ba_size_modifer"] != 0
          @dragon["defence_describe"] = @dragon["defence_describe"] + ", " + sprintf("%+d", @dragon["ba_size_modifer"]) + " サイズ)"
        else
          @dragon["defence_describe"] = @dragon["defence_describe"] + ")"
        end

        @dragon["ac"] = 10 + @dragon["dex_modifer"] + @dragon["natural_armor"] + @dragon["ba_size_modifer"]
        @dragon["touch"] = 10 + @dragon["dex_modifer"] + @dragon["ba_size_modifer"]
        @dragon["flat_footed"] = 10 + @dragon["natural_armor"] + @dragon["ba_size_modifer"]
        if @dragon["dex_modifer"] < 0
          @dragon["flat_footed"] = @dragon["flat_footed"] + @dragon["dex_modifer"]
        end
        @dragon["hp"] = (@dragon["hit_dice_count"] / 2).to_i * 7 + (@dragon["hit_dice_count"] - (@dragon["hit_dice_count"] / 2).to_i) * 6 + @dragon["con_modifer"] * @dragon["hit_dice_count"]
        @dragon["hp_con_modifer"] = sprintf("%+d", @dragon["con_modifer"] * @dragon["hit_dice_count"])
        @dragon["fort"] = sprintf("%+d", ((@dragon["hit_dice_count"] / 2).to_i + 2 + @dragon["con_modifer"]))
        @dragon["ref"] = sprintf("%+d", ((@dragon["hit_dice_count"] / 2).to_i + 2 + @dragon["dex_modifer"]))
        @dragon["will"] = sprintf("%+d", ((@dragon["hit_dice_count"] / 2).to_i + 2 + @dragon["wis_modifer"]))
        @dragon["speed"] = dragon_race.get_speed + size_category.get_speed + dragon_race_age.get_speed
#        @dragon["speed"] = @dragon["speed"] + "; " + @dragon["additional_move"] if @dragon["additional_move"] != ""
        @dragon["spell_like_ability_cl"] = @dragon["hit_dice_count"]
        @dragon["spell_like_ability_concentration"] = @dragon["hit_dice_count"] + @dragon["chr_modifer"]
        @dragon["spell_caster_concentration"] = @dragon["spell_caster_level"] + @dragon["chr_modifer"]
        @dragon["base_attack"] = sprintf("%+d", @dragon["hit_dice_count"])
        @dragon["cmb"] = sprintf("%+d", (@dragon["hit_dice_count"] + size_category.cmb_size_modifer + @dragon["str_modifer"]))
        @dragon["cmd"] = (10 + @dragon["hit_dice_count"] + size_category.cmb_size_modifer + @dragon["str_modifer"] + @dragon["dex_modifer"])
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
        if @dragon["sr_flag"] == 1
          @dragon["sr"] = @dragon["cr"] + 11
        else
          @dragon["sr"] = 0
        end
      end
    end
  end
end
