# -*- encoding: utf-8 -*-

class DragonRaceAge < ActiveRecord::Base
  def get_speed(dragon_race, dragon_age_category, size_category)
    fly_category = size_category
    sq_array = self.sq.split("、")
    sq_array.each {|sqs|
      fly_category = SizeCategory.find(:first, :conditions => ["size_id = ?", dragon_race.size + dragon_age_category.size + 1]) if sqs.strip == "高速飛行"
    }
    speed = dragon_race.get_speed + fly_category.get_speed(self)
    speed = speed + "; " + self.additional_move if self.additional_move != ""
    return speed
  end

  def get_aura(dragon_race_age, dragon)
    aura = ""
    aura_array = self.aura.split(",")
    aura_array.each {|auras|
      if auras.strip == "Frightful presence"
        aura = aura + "、" if aura != ""
        aura = aura + "畏怖すべき存在(" + (self.age_id * 30).to_s + "ft.、DC" + (10 + (dragon["hit_dice_count"] * 0.5).to_i + dragon["chr_modifer"]).to_s + ")"
      end
      if auras.strip == "Electricity aura"
        aura = aura + "、" if aura != ""
        aura = aura + "［電気］"
        if dragon_race_age.age_id > 9
          aura = aura + "(10ft.、2d6 ［電気］)"
        elsif dragon_race_age.age_id > 7
          aura = aura + "(10ft.、1d6 ［電気］)"
        else
          aura = aura + "(5ft.、1d6 ［電気］)"
        end
      end
      if auras.strip == "Cold aura"
        aura = aura + "、" if aura != ""
        aura = aura + "［冷気］"
        if dragon_race_age.age_id > 9
          aura = aura + "(10ft.、2d6 ［冷気］)"
        elsif dragon_race_age.age_id > 7
          aura = aura + "(10ft.、1d6 ［冷気］)"
        else
          aura = aura + "(5ft.、1d6 ［冷気］)"
        end
      end
      if auras.strip == "Fire aura"
        aura = aura + "、" if aura != ""
        aura = aura + "［火］"
        if dragon_race_age.age_id > 9
          aura = aura + "(10ft.、2d6 ［火］)"
        elsif dragon_race_age.age_id > 7
          aura = aura + "(10ft.、1d6 ［火］)"
        else
          aura = aura + "(5ft.、1d6 ［火］)"
        end
      end
      if auras.strip == "Slow aura"
        aura = aura + "、" if aura != ""
        aura = aura + "減速化"
        if dragon_race_age.age_id > 11
          aura = aura + "(10ft.、DC" + (10 + (dragon["hit_dice_count"] * 0.5).to_i + dragon["con_modifer"]).to_s + "、1d4R)"
        elsif dragon_race_age.age_id > 9
          aura = aura + "(10ft.、DC" + (10 + (dragon["hit_dice_count"] * 0.5).to_i + dragon["con_modifer"]).to_s + "、1R)"
        else
          aura = aura + "(5ft.、DC" + (10 + (dragon["hit_dice_count"] * 0.5).to_i + dragon["con_modifer"]).to_s + "、1R)"
        end
      end
      if auras.strip == "Fire aura gold dragon"
        aura = aura + "、" if aura != ""
        aura = aura + "［火］"
        if dragon_race_age.age_id > 11
          aura = aura + "(10ft.、2d6 ［火］)"
        elsif dragon_race_age.age_id > 9
          aura = aura + "(10ft.、1d6 ［火］)"
        else
          aura = aura + "(5ft.、1d6 ［火］)"
        end
      end
      if auras.strip == "Cold aura silver dragon"
        aura = aura + "、" if aura != ""
        aura = aura + "［冷気］"
        if dragon_race_age.age_id > 11
          aura = aura + "(10ft.、2d6 ［冷気］)"
        elsif dragon_race_age.age_id > 9
          aura = aura + "(10ft.、1d6 ［冷気］)"
        else
          aura = aura + "(5ft.、1d6 ［冷気］)"
        end
      end
    }
    return aura
  end

  def get_special_attack(dragon_race, dragon_age_category, size_category, dragon)
    special_attack = ""
    sp_array = self.special_attack.split(",")
    # 成長段階で獲得する特殊攻撃
    sp_array.each {|sp|
      if sp.strip == "Breath Weapon"
        special_attack = special_attack + "ブレス攻撃(" + dragon_race.breath_shape
        if dragon_race.breath_shape == "直線状"
          special_attack = special_attack + " " + size_category.breath_range_line + "、 DC" + (10 + (dragon["hit_dice_count"] * 0.5).to_i + dragon["con_modifer"]).to_s + "、" + (dragon_race.breath_damage_num * dragon_age_category.breath).to_s + dragon_race.breath_damage_dice + "［" + dragon_race.breath_category + "］)"
        else # dragon_race.breath_shape == "円錐形"
          special_attack = special_attack + " " + size_category.breath_range_cone + "、 DC" + (10 + (dragon["hit_dice_count"] * 0.5).to_i + dragon["con_modifer"]).to_s + "、" + (dragon_race.breath_damage_num * dragon_age_category.breath).to_s + dragon_race.breath_damage_dice + "［" + dragon_race.breath_category + "］)"
        end
      end
      special_attack = special_attack + "、瘴気" if sp.strip == "Miasma"
      special_attack = special_attack + "、トリエント覚醒" if sp.strip == "Awaken treants"
      special_attack = special_attack + "、水穢し" if sp.strip == "Corrupt water"
      special_attack = special_attack + "、［酸］の噛みつき" if sp.strip == "Acidic bite"
      special_attack = special_attack + "、［酸］の溜り(半径" + (dragon_age_category.id * 5).to_s + "ft.)" if sp.strip == "Acid pool"
      special_attack = special_attack + "、砂漠の渇き(DC" + (10 + (dragon["hit_dice_count"] * 0.5).to_i + dragon["con_modifer"]).to_s + ")" if sp.strip == "Desert thirst"
      special_attack = special_attack + "、蜃気楼" if sp.strip == "Mirage"
      special_attack = special_attack + "、嵐のブレス(DC" + (10 + (dragon["hit_dice_count"] * 0.5).to_i + dragon["con_modifer"]).to_s + "、" + (dragon_race.breath_damage_num * dragon_age_category.breath).to_s + dragon_race.breath_damage_dice + "［" + dragon_race.breath_category + "］)" if sp.strip == "Storm breath"
      special_attack = special_attack + "、砂塵嵐" if sp.strip == "Sandstorm"
      special_attack = special_attack + "、氷結の霧(3回/日、DC" + (10 + 6 + dragon["chr_modifer"]).to_s + ")" if sp.strip == "Freezing fog"
      special_attack = special_attack + "、猛吹雪" if sp.strip == "Blizzard"
      special_attack = special_attack + "、氷の墓標(1回/日、DC" + (10 + 9 + dragon["chr_modifer"]).to_s + ")" if sp.strip == "Ice tomb"
      special_attack = special_attack + "、炎の制御" if sp.strip == "Manipulate flames"
      special_attack = special_attack + "、溶岩" if sp.strip == "Melt stone"
      special_attack = special_attack + "、火葬" if sp.strip == "Incinerate"
      special_attack = special_attack + "、減速化のブレス" if sp.strip == "Slow breath"
      special_attack = special_attack + "、大受け(DC" + (10 + 6 + dragon["chr_modifer"]).to_s + ")" if sp.strip == "Mass laughter"
      special_attack = special_attack + "、アブないジョーク(DC" + (10 + 9 + dragon["chr_modifer"]).to_s + ")" if sp.strip == "Deadly joke"
      special_attack = special_attack + "、麻痺のブレス" if sp.strip == "Paralyzing breath"
    }
    # サイズ段階で獲得する特殊攻撃
    if size_category.crush_damage != ""
      temp_size_category = SizeCategory.find(:first, :conditions => ["size_id = ?", dragon_race.size + dragon_age_category.size - 3])
      special_attack = special_attack + "、押し潰し(" + temp_size_category.name + "、 DC" + (10 + (dragon["hit_dice_count"] * 0.5).to_i + dragon["con_modifer"]).to_s + "、" + size_category.crush_damage + "+" + ((dragon["str_modifer"] * 1.5).to_i).to_s + ")"
    end
    if size_category.tail_sweep_damage != ""
      temp_size_category = SizeCategory.find(:first, :conditions => ["size_id = ?", dragon_race.size + dragon_age_category.size - 4])
      special_attack = special_attack + "、尾による一掃(" + temp_size_category.name + "、 DC" + (10 + (dragon["hit_dice_count"] * 0.5).to_i + dragon["con_modifer"]).to_s + "、" + size_category.tail_sweep_damage + "+" + ((dragon["str_modifer"] * 1.5).to_i).to_s + ")"
    end
    return special_attack
  end

  def get_sense_local
    sense = ""
    sense_array = self.sense.split(",")
    sense_array.each {|value|
      if sense == ""
        sense = I18n.t("models.dragon_race_age.sense.#{value}")
      else
        sense = sense + ", " + I18n.t("models.dragon_race_age.sense.#{value}")
      end
    }
    return sense
  end
end
