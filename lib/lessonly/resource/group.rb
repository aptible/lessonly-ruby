module Lessonly
  class Group < Resource
    def destroy_membership(user)
      return unless members.any?

      new_members = members.map do |m|
        m.remove = true if m.id == user.id
      end

      update(members: new_members)
    end

    def create_membership(user)
      self.members = members.push(user)
      update(members: members)
    end
  end
end
