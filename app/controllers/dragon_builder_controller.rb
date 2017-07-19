class DragonBuilderController < ApplicationController
  before_action :set_locale

  def index
    @dragon_races = DragonRace.all
    @dragon_age_categories = DragonAgeCategory.all
    @selected = {dragon_race: 1, dragon_age: 1}
    if (params[:dragon_race] != nil && params[:dragon_age] != nil && params[:dragon_race].to_i < 11 && params[:dragon_age].to_i < 13)
      @selected[:dragon_race] = params[:dragon_race].to_i
      @selected[:dragon_age] = params[:dragon_age].to_i

      dragon_race = DragonRace.find(@selected[:dragon_race])
      dragon_age_category = DragonAgeCategory.find(@selected[:dragon_age])
      dragon_race_age = DragonRaceAge.find_by(["race_id = ? and age_id = ?", @selected[:dragon_race], @selected[:dragon_age]])
      @dragon = {hit_dice_number: 12}
      @dragon[:defence_describe] = ""

      if params[:locale] == 'ja'
        @dragon[:name] = I18n.t("models.dragon_age_category.age_category.#{dragon_age_category.age_category}") + "・" + dragon_race.name_localizable + "・ドラゴン"
      else
        @dragon[:name] = dragon_race.name_localizable + " Dragon, " + I18n.t("models.dragon_age_category.age_category.#{dragon_age_category.age_category}")
      end

      @dragon["cr"] = dragon_race.cr + dragon_age_category.cr
      size_category = SizeCategory.find_by(["size_id = ?", dragon_race.size + dragon_age_category.size])
      @dragon["size"] = size_category.name_localizable
      @dragon["ba_size_modifer"] = size_category.ba_size_modifer
      @dragon["space"] = size_category.space
      @dragon["reach"] = size_category.reach
      @dragon["bite_reach"] = size_category.bite_reach

      @dragon["alignment"] = dragon_race.alignment
      @dragon["types"] = dragon_race.creature_category_localizable
      @dragon["subtypes"] = dragon_race.creature_subcategory_localizable
      @dragon["natural_armor"] = dragon_race.natural_armor + dragon_age_category.natural_armor
      @dragon["hit_dice_count"] = dragon_race.hit_dice + dragon_age_category.hit_dice
      @dragon["immune"] = dragon_race.immune_localizable
      @dragon["weakness"] = dragon_race.weakness_localizable
      @dragon["burrow_speed"] = dragon_race.burrow_speed
      @dragon["swim_speed"] = dragon_race.swim_speed
      @dragon["str"] = dragon_race.str + dragon_age_category.str
      @dragon["dex"] = dragon_race.dex + dragon_age_category.dex
      @dragon["con"] = dragon_race.con + dragon_age_category.con
      @dragon["int"] = dragon_race.int + dragon_age_category.int
      @dragon["wis"] = dragon_race.wis + dragon_age_category.wis
      @dragon["chr"] = dragon_race.chr + dragon_age_category.chr
      @dragon["racial_modifer"] = dragon_race.racial_modifer_localizable
      @dragon["language"] = dragon_race.language_localizable
      @dragon["environment"] = dragon_race.env_localizable
      @dragon["organization"] = dragon_race.organization_localizable
      @dragon["treasure"] = dragon_race.treasure_localizable

      @dragon["sense"] = dragon_race_age.sense_localizable
      @dragon["defensive_ability"] = dragon_race_age.defensive_ability_localizable
      @dragon["dr"] = dragon_race_age.dr_localizable
      @dragon["sr_flag"] = dragon_race_age.sr
      @dragon["spell_like_ability"] = dragon_race_age.sp_localizable
      @dragon["spell_caster_level"] = dragon_race_age.caster_level
      @dragon["spell_caster_source"] = dragon_race_age.caster_source_localizable
      @dragon["sq"] = dragon_race_age.sq_localizable

      @dragon["str_modifer"] = ((@dragon["str"] - 10) / 2).to_i
      @dragon["dex_modifer"] = ((@dragon["dex"] - 10) / 2).to_i
      @dragon["con_modifer"] = ((@dragon["con"] - 10) / 2).to_i
      @dragon["int_modifer"] = ((@dragon["int"] - 10) / 2).to_i
      @dragon["wis_modifer"] = ((@dragon["wis"] - 10) / 2).to_i
      @dragon["chr_modifer"] = ((@dragon["chr"] - 10) / 2).to_i

      @dragon["aura"] = dragon_race_age.get_aura(dragon_race, @dragon)
      @dragon["melee"] = size_category.get_melee(dragon_race_age, @dragon)
      @dragon["special_attack"] = dragon_race_age.get_special_attack(dragon_race, dragon_age_category, size_category, @dragon)

      @dragon[:defence_describe] = "(" + sprintf("%+d", @dragon["dex_modifer"]) + " " + I18n.t(:label_small_dex)
      if @dragon[:defence_describe] != ""
        @dragon[:defence_describe] = @dragon[:defence_describe] + ", " + sprintf("%+d", @dragon["natural_armor"]) + " " + I18n.t(:label_natural)
      else
        @dragon[:defence_describe] = "(" + sprintf("%+d", @dragon["natural_armor"]) + " " + I18n.t(:label_natural)
      end
      if @dragon["ba_size_modifer"] != 0
        @dragon[:defence_describe] = @dragon[:defence_describe] + ", " + sprintf("%+d", @dragon["ba_size_modifer"]) + " " + I18n.t(:label_size) + ")"
      else
        @dragon[:defence_describe] = @dragon[:defence_describe] + ")"
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
      @dragon["speed"] = dragon_race_age.get_speed(dragon_race, dragon_age_category, size_category)
      @dragon["spell_like_ability_cl"] = @dragon["hit_dice_count"]
      @dragon["spell_like_ability_concentration"] = @dragon["hit_dice_count"] + @dragon["chr_modifer"]
      @dragon["spell_caster_concentration"] = @dragon["spell_caster_level"] + @dragon["chr_modifer"]
      @dragon["base_attack"] = sprintf("%+d", @dragon["hit_dice_count"])
      @dragon["cmb"] = sprintf("%+d", (@dragon["hit_dice_count"] + size_category.cmb_size_modifer + @dragon["str_modifer"]))
      @dragon["cmd"] = (10 + @dragon["hit_dice_count"] + size_category.cmb_size_modifer + @dragon["str_modifer"] + @dragon["dex_modifer"])
      @dragon["cmd"] = @dragon["cmd"].to_s + " (" + (@dragon["cmd"] + 4).to_s + " " + I18n.t(:label_cmd_vs_trip) + ")"
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

  def set_locale
    # if params[:locale] is nil then I18n.default_locale will be used
    if params[:locale] != ''
      I18n.locale = params[:locale]
    else
      I18n.locale = 'en'
    end
  end
end
