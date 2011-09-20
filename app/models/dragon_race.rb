# -*- encoding: utf-8 -*-

class DragonRace < ActiveRecord::Base
#class DragonRace < ApplicationModel
#  acts_as_column_i18n :name

  def get_speed
    speed = self.land_speed
    speed = speed + ", " + I18n.t(:label_burrow) + " " + self.burrow_speed if self.burrow_speed != ""
    speed = speed + ", " + I18n.t(:label_swim) + " " + self.swim_speed if self.swim_speed != ""
    return speed
  end

  def name_localizable
    return I18n.t("models.#{self.class.model_name.underscore}.name.#{self.name}")
  end

  def creature_category_localizable
    return I18n.t("models.#{self.class.model_name.underscore}.creature_category.#{self.creature_category}")
  end

  def creature_subcategory_localizable
    return I18n.t("models.#{self.class.model_name.underscore}.creature_subcategory.#{self.creature_subcategory}")
  end

  def immune_localizable
    immune = ""
    immune_array = self.immune.split(", ")
    immune_array.each {|imm|
      if immune == ""
        immune = I18n.t("models.#{self.class.model_name.underscore}.immune.#{imm.strip}")
      else
        immune = immune + ", " + I18n.t("models.#{self.class.model_name.underscore}.immune.#{imm.strip}")
      end
    }
    return immune
  end

  def weakness_localizable
    if self.weakness != ""
      return I18n.t("models.#{self.class.model_name.underscore}.weakness.#{self.weakness}")
    else
      self.weakness
    end
  end

  def breath_shape_localizable
    return I18n.t("models.#{self.class.model_name.underscore}.breath_shape.#{self.breath_shape}")
  end

  def breath_category_localizable
    return I18n.t("models.#{self.class.model_name.underscore}.breath_category.#{self.breath_category}")
  end

  def racial_modifer_localizable
    if self.racial_modifer != ""
      racial_modifer = ""
      racial_modifer_hash = self.racial_modifer.split(" ")
      racial_modifer_hash.each_with_index{|elem, i|
        if i%2 == 0
          racial_modifer = elem
        else
          racial_modifer = racial_modifer + " " + I18n.t("models.#{self.class.model_name.underscore}.racial_modifer.#{elem.strip}")
        end
      }
      return racial_modifer
    else
      return self.racial_modifer
    end
  end

  def language_localizable
    return I18n.t("models.#{self.class.model_name.underscore}.language.#{self.language}")
  end

  def env_localizable
    return I18n.t("models.#{self.class.model_name.underscore}.env.#{self.env}")
  end

  def organization_localizable
    return I18n.t("models.#{self.class.model_name.underscore}.organization.#{self.organization}")
  end

  def treasure_localizable
    return I18n.t("models.#{self.class.model_name.underscore}.treasure.#{self.treasure}")
  end
end
