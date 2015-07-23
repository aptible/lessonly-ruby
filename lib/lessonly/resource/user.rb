module Lessonly
  class User < Resource
    def assigned_to?(course)
      course.assignments.map(&:assignee_id).include?(id)
    end
  end
end
