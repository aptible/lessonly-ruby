module Lessonly
  class Course < Resource
    has_many :assignments

    def initialize(agent, data = {})
      super(agent, data)

      has_many_lessons if @attrs[:lessons]
    end

    def has_many_lessons
      # Lessons is a string for some weird reason
      @attrs[:lessons] = JSON.parse(@attrs[:lessons]).map do |lesson|
        Lessonly::Lesson.new(agent, lesson)
      end
    end

    def create_assignment(user, due_by = false)
      due_by ||= 1.year.from_now

      assignments = [{ assignee_id: user.id, due_by: due_by }]
      client.put "#{href}/assignments",
                 Resource.new(agent, { assignments: assignments })
    end
  end
end