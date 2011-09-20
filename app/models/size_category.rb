# -*- encoding: utf-8 -*-

class SizeCategory < ActiveRecord::Base
  def get_speed(dragon_race_age)
    gra_fly_flag = 0
    additional_move_array = dragon_race_age.additional_move.split(",")
    additional_move_array.each {|array|
      gra_fly_flag = -1 if array.strip == "graceful flight"
    }
    fly_muverabillity = FlyMuverabillity.find(:first, :conditions => ["id = ?", self.fly_muverabillity.to_i + gra_fly_flag])
    return ", " + I18n.t(:label_fly) + " " + self.fly_speed + "(" + fly_muverabillity.name_localizable + ")"
  end

  def get_melee(dragon_race_age, dragon)
    melee = I18n.t(:label_bite) + " (" + self.bite_damage + sprintf("%+d", (dragon["str_modifer"] * 1.5).to_i)
    sp_array = dragon_race_age.special_attack.split(",")
    sp_array.each {|sp|
      if sp.strip == "acidic bite"
        melee = melee + " " + I18n.t(:label_plus)
        if dragon_race_age.age_id == 12
          melee = melee + " 6d6 " + I18n.t("models.dragon_race.breath_category.acid")
        elsif dragon_race_age.age_id > 9
          melee = melee + " 4d6 " + I18n.t("models.dragon_race.breath_category.acid")
        else
          melee = melee + " 2d6 " + I18n.t("models.dragon_race.breath_category.acid")
        end
      end
    }
    melee = melee + ")"
    melee = melee + ", " + I18n.t(:label_claws) + " (" + self.claws_damage + sprintf("%+d", dragon["str_modifer"].to_i) + ")"
    melee = melee + ", " + I18n.t(:label_wings) + " (" + self.wings_damage + sprintf("%+d", (dragon["str_modifer"] * 0.5).to_i) + ")" if self.wings_damage != ""
    melee = melee + ", " + I18n.t(:label_tail_slap) + " (" + self.tail_slap_damage + sprintf("%+d", (dragon["str_modifer"] * 1.5).to_i) + ")" if self.tail_slap_damage != ""
    return melee
  end

  def name_localizable
    return I18n.t("models.#{self.class.model_name.underscore}.name.#{self.name}")
  end
end
