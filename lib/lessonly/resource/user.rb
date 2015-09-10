module Lessonly
  class User < Resource
    def assigned_to?(course)
      course.assignments.map(&:assignee_id).include?(id)
    end

    def serialize
      blacklist = /[`!@#\$%\^&\*\+=\(\)\|\[\];]/
      attrs[:name] = name.gsub(blacklist, '').strip.squeeze(' ')
      self
    end
  end
end
