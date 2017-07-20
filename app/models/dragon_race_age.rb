# -*- encoding: utf-8 -*-

class DragonRaceAge < ActiveRecord::Base
  def get_speed(dragon_race, dragon_age_category, size_category)
    fly_category = size_category
    sq_array = self.sq.split(",")
    sq_array.each {|elem|
      fly_category = SizeCategory.find_by(["size_id = ?", dragon_race.size + dragon_age_category.size + 1]) if elem.strip == "fast flight"
    }
    speed = dragon_race.get_speed + fly_category.get_speed(self)
    speed = speed + "; " + self.additional_move_localizable if self.additional_move_localizable != ""
    return speed
  end

  def get_aura(dragon_race, dragon)
    aura = ""
    aura_array = self.aura.split(",")
    aura_array.each {|elem|
      aura = aura + ", " if aura != ""
      if elem.strip == "frightful presence"
        aura = aura + I18n.t("models.dragon_race_age.aura.#{elem.strip}") + "(" + (self.age_id * 30).to_s + "ft., DC" + (10 + (dragon[:hit_dice_count] * 0.5).to_i + dragon[:chr_modifer]).to_s + ")"
      elsif elem.strip == "cold aura" or elem.strip == "electricity aura" or elem.strip == "fire aura"
        element = ""
        if elem.strip == "cold aura"
          element = I18n.t("models.dragon_race.breath_category.cold")
        elsif elem.strip == "electricity aura"
          element = I18n.t("models.dragon_race.breath_category.electricity")
        elsif elem.strip == "fire aura"
          element = I18n.t("models.dragon_race.breath_category.fire")
        end
        dragon_power = self.age_id
        dragon_power = self.age_id - 2 if dragon_race.category_id == 2
        aura = aura + element
        if dragon_power > 9
          aura = aura + "(10ft., 2d6 " + element + ")"
        elsif dragon_power > 7
          aura = aura + "(10ft., 1d6 " + element + ")"
        else
          aura = aura + "(5ft., 1d6 " + element + ")"
        end
      end
      if elem.strip == "slow aura"
        aura = aura + I18n.t("models.dragon_race_age.aura.#{elem.strip}")
        if self.age_id > 11
          aura = aura + "(10ft., DC" + (10 + (dragon[:hit_dice_count] * 0.5).to_i + dragon[:con_modifer]).to_s + "、1d4R)"
        elsif self.age_id > 9
          aura = aura + "(10ft., DC" + (10 + (dragon[:hit_dice_count] * 0.5).to_i + dragon[:con_modifer]).to_s + "、1R)"
        else
          aura = aura + "(5ft., DC" + (10 + (dragon[:hit_dice_count] * 0.5).to_i + dragon[:con_modifer]).to_s + "、1R)"
        end
      end
    }
    return aura
  end

  def get_special_attack(dragon_race, dragon_age_category, size_category, dragon)
    special_attack = ""
    spa_array = self.special_attack.split(",")
    # 成長段階で獲得する特殊攻撃
    spa_array.each {|elem|
      special_attack = special_attack + ", " if special_attack != ""
      if elem.strip == "breath weapon"
        special_attack = special_attack + I18n.t("models.dragon_race_age.special_attack.#{elem.strip}") + "(" + dragon_race.breath_shape_localizable
        if dragon_race.breath_shape == "line"
          special_attack = special_attack + " " + size_category.breath_range_line
        else # dragon_race.breath_shape == "cone"
          special_attack = special_attack + " " + size_category.breath_range_cone
        end
        special_attack = special_attack + " DC" + (10 + (dragon[:hit_dice_count] * 0.5).to_i + dragon[:con_modifer]).to_s + " " + (dragon_race.breath_damage_num * dragon_age_category.breath).to_s + dragon_race.breath_damage_dice + " " + dragon_race.breath_category_localizable + ")"
      elsif elem.strip == "miasma" or elem.strip == "awaken treants" or
          elem.strip == "corrupt water" or elem.strip == "acidic bite" or
          elem.strip == "mirage" or elem.strip == "sandstorm" or
          elem.strip == "blizzard" or elem.strip == "manipulate flames" or
          elem.strip == "melt stone" or elem.strip == "incinerate" or
          elem.strip == "slow breath" or elem.strip == "weakening breath" or
          elem.strip == "paralyzing breath" or elem.strip == "sleep breath" or
          elem.strip == "desert wind" or elem.strip == "sandstorm" or
          elem.strip == "repulsion breath" or elem.strip == "vortex" or
          elem.strip == "tidal wave"
        special_attack = special_attack + I18n.t("models.dragon_race_age.special_attack.#{elem.strip}")
      elsif elem.strip == "acid pool"
        special_attack = special_attack + I18n.t("models.dragon_race_age.special_attack.#{elem.strip}") + "(" + I18n.t(:label_radius) + " " + (dragon_age_category.id * 5).to_s + "ft.)"
      elsif elem.strip == "desert thirst"
        special_attack = special_attack + I18n.t("models.dragon_race_age.special_attack.#{elem.strip}") + "(DC" + (10 + (dragon[:hit_dice_count] * 0.5).to_i + dragon[:con_modifer]).to_s + ")"
      elsif elem.strip == "storm breath"
        special_attack = special_attack + I18n.t("models.dragon_race_age.special_attack.#{elem.strip}") + "(DC" + (10 + (dragon[:hit_dice_count] * 0.5).to_i + dragon[:con_modifer]).to_s + ")"
        special_attack = special_attack + ", " + (dragon_race.breath_damage_num * dragon_age_category.breath).to_s + dragon_race.breath_damage_dice + " " + dragon_race.breath_category_localizable + ")"
      elsif elem.strip == "freezing fog"
        special_attack = special_attack + I18n.t("models.dragon_race_age.special_attack.#{elem.strip}") + "(3回/日 DC" + (10 + 6 + dragon[:chr_modifer]).to_s + ")"
      elsif elem.strip == "ice tomb"
        special_attack = special_attack + I18n.t("models.dragon_race_age.special_attack.#{elem.strip}") + "(1回/日 DC" + (10 + 9 + dragon[:chr_modifer]).to_s + ")"
      elsif elem.strip == "mass laughter"
        special_attack = special_attack + I18n.t("models.dragon_race_age.special_attack.#{elem.strip}") + "(DC" + (10 + 6 + dragon[:chr_modifer]).to_s + ")"
      elsif elem.strip == "deadly joke"
        special_attack = special_attack + I18n.t("models.dragon_race_age.special_attack.#{elem.strip}") + "(DC" + (10 + 9 + dragon[:chr_modifer]).to_s + ")"
      end
    }
    # サイズ段階で獲得する特殊攻撃
    if size_category.crush_damage != ""
      temp_size_category = SizeCategory.find_by(["size_id = ?", dragon_race.size + dragon_age_category.size - 3])
      special_attack = special_attack + ", " + I18n.t("models.dragon_race_age.special_attack.crush") +"(" + temp_size_category.name_localizable + " DC" + (10 + (dragon[:hit_dice_count] * 0.5).to_i + dragon[:con_modifer]).to_s + " " + size_category.crush_damage + "+" + ((dragon[:str_modifer] * 1.5).to_i).to_s + ")"
    end
    if size_category.tail_sweep_damage != ""
      temp_size_category = SizeCategory.find_by(["size_id = ?", dragon_race.size + dragon_age_category.size - 4])
      special_attack = special_attack + ", " + I18n.t("models.dragon_race_age.special_attack.tail sweep") +"(" + temp_size_category.name_localizable + " DC" + (10 + (dragon[:hit_dice_count] * 0.5).to_i + dragon[:con_modifer]).to_s + " " + size_category.tail_sweep_damage + "+" + ((dragon[:str_modifer] * 1.5).to_i).to_s + ")"
    end
    return special_attack
  end

  def sense_localizable
    sense = ""
    sense_array = self.sense.split(",")
    sense_array.each {|elem|
      sense = sense + ", " if sense != ""
      sense = sense + I18n.t("models.dragon_race_age.sense.#{elem.strip}")
    }
    return sense
  end

  def defensive_ability_localizable
    if self.defensive_ability != ""
      defensive_ability = ""
      defensive_ability_array = self.defensive_ability.split(",")
      defensive_ability_array.each{|elem|
        defensive_ability = defensive_ability + ", " if defensive_ability != ""
        defensive_ability = defensive_ability + I18n.t("models.dragon_race_age.defensive_ability.#{elem.strip}")
      }
      return defensive_ability
    else
      return self.defensive_ability
    end
  end

  def dr_localizable
    if self.dr != ""
      dr = ""
      dr_array = self.dr.split("/")
      dr_array.each_with_index{|elem, i|
        if i%2 == 0
          dr = elem
        else
          dr = dr + "/" + I18n.t("models.dragon_race_age.dr.#{elem.strip}")
        end
      }
      return dr
    else
      return self.dr
    end
  end

  def additional_move_localizable
    if self.additional_move != ""
      additional_move = ""
      additional_move_array = self.additional_move.split(",")
      additional_move_array.each{|elem|
        additional_move = additional_move + ", " if additional_move != ""
        additional_move = additional_move + I18n.t("models.dragon_race_age.additional_move.#{elem.strip}")
      }
      return additional_move
    else
      return self.additional_move
    end
  end

  def sp_localizable
    if self.sp != ""
      sp = ""
      sp_array = self.sp.split(",")
      sp_array.each {|elem|
        sp = sp + ", " if sp != ""
        sp = sp + I18n.t("models.dragon_race_age.sp.#{elem.strip}")
      }
      return sp
    else
      return self.sp
    end
  end

  def caster_source_localizable
    if self.caster_source != ""
      return I18n.t("models.dragon_race_age.caster_source.#{self.caster_source}")
    else
      return self.caster_source
    end
  end

  def sq_localizable
    if self.sq != ""
      sq = ""
      sq_array = self.sq.split(",")
      sq_array.each {|elem|
        sq = sq + ", " if sq != ""
        sq = sq + I18n.t("models.dragon_race_age.sq.#{elem.strip}")
      }
      return sq
    else
      return self.sq
    end
  end
end
