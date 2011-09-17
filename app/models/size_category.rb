# -*- encoding: utf-8 -*-

class SizeCategory < ActiveRecord::Base
  def get_speed(dragon_race_age)
    gra_fly_flag = 0
    additional_move_array = dragon_race_age.additional_move.split("、")
    additional_move_array.each {|array|
      gra_fly_flag = -1 if array.strip == "優雅なる飛行"
    }
    fly_muverabillity = FlyMuverabillity.find(:first, :conditions => ["id = ?", self.fly_muverabillity.to_i + gra_fly_flag])
    return ", 飛行 " + self.fly_speed + "(" + fly_muverabillity.name + ")"
  end

  def get_melee(dragon_race_age, dragon)
    melee = "噛みつき (" + self.bite_damage + sprintf("%+d", (dragon["str_modifer"] * 1.5).to_i)
    sp_array = dragon_race_age.special_attack.split(",")
    sp_array.each {|sp|
      if sp.strip == "Acidic bite"
        melee = melee + "、加えて"
        if dragon_race_age.age_id == 12
          melee = melee + "6d6［酸］"
        elsif dragon_race_age.age_id > 9
          melee = melee + "4d6［酸］"
        else
          melee = melee + "2d6［酸］"
        end
      end
    }
    melee = melee + ")"
    melee = melee + "、爪(x2) (" + self.claws_damage + sprintf("%+d", dragon["str_modifer"].to_i) + ")"
    melee = melee + "、翼(x2) (" + self.wings_damage + sprintf("%+d", (dragon["str_modifer"] * 0.5).to_i) + ")" if self.wings_damage != ""
    melee = melee + "、尾の打撃 (" + self.tail_slap_damage + sprintf("%+d", (dragon["str_modifer"] * 1.5).to_i) + ")" if self.tail_slap_damage != ""
    return melee
  end
end
