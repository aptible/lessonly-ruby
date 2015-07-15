module Lessonly
  class Lesson < Resource
    has_many :assignments
  end
end