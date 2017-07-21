class FlyMuverabillity < ActiveRecord::Base
  enum name: {
      # Since average can not be used with the following error, use average_
      #
      # ArgumentError: You tried to define an enum named "name" on the model
      # "FlyMuverabillity", but this will generate a class method "average",
      # which is already defined by Active Record.
      perfect: 1, good: 2, average_: 3, poor: 4, clumsy: 5
  }
end
