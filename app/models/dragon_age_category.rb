class DragonAgeCategory < ActiveRecord::Base
  enum age_category: {
      wyrmling: 1, very_young: 2, young: 3, juvenile: 4, young_adult: 5,
      adult: 6, mature_adult: 7, old: 8, very_old: 9, ancient: 10,
      wyrm: 11, great_wyrm: 12
  }
end
