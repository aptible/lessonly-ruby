module Lessonly
  class Course < Resource
    has_many :assignments

    def initialize(agent, data = {})
      super(agent, data)

      define_has_many_lessons if @attrs[:lessons]
    end

    def define_has_many_lessons
      self.lessons = @attrs[:lessons].map do |l|
        Lessonly::Lesson.new(agent, l.attrs)
      end
    end

    def create_assignment(user, due_by = 1.year.from_now)
      self.assignments = assignments.push(
        Lessonly::Assignment.new(agent, assignee_id: user.id, due_by: due_by)
      )

      client.put "#{href}/assignments",
                 Resource.new(agent, assignments: assignments)
    end

    def destroy_assignment(user)
      self.assignments = assignments.select { |a| a.assignee_id != user.id }

      client.put "#{href}/assignments",
                 Resource.new(agent, assignments: assignments)
    end
  end
end
