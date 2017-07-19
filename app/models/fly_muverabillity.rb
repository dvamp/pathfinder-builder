class FlyMuverabillity < ActiveRecord::Base
  def name_localizable
    return I18n.t("models.fly_muverabillity.name.#{self.name}")
  end
end
