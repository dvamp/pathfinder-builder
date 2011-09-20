class FlyMuverabillity < ActiveRecord::Base
  def name_localizable
    return I18n.t("models.#{self.class.model_name.underscore}.name.#{self.name}")
  end
end
