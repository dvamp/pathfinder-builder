# -*- encoding: utf-8 -*-

class DragonRace < ActiveRecord::Base
  def get_speed
    speed = self.land_speed
    speed = speed + ", 穴掘り " + self.burrow_speed if self.burrow_speed != ""
    speed = speed + ", 水泳 " + self.swim_speed if self.swim_speed != ""
    return speed
  end

  def get_name_local
    return I18n.t("models.dragon_race.name.#{self.name}")
  end

  def get_creature_category_local
    return I18n.t("models.dragon_race.creature_category.#{self.creature_category}")
  end

  def get_creature_subcategory_local
    return I18n.t("models.dragon_race.creature_subcategory.#{self.creature_subcategory}")
  end
end
