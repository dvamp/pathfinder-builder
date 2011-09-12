# -*- encoding: utf-8 -*-

class DragonRace < ActiveRecord::Base
  def get_speed
    speed = self.land_speed
    speed = speed + ", 穴掘り " + self.burrow_speed if self.burrow_speed != ""
    speed = speed + ", 水泳 " + self.swim_speed if self.swim_speed != ""
    return speed
  end
end
