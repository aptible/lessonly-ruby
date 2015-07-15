module Lessonly
  class Group < Resource
    has_many :assignments

    def create_membership(user)
      new_memberships = memberships || []
      new_memberships.push({ id: user.id })

      update(memberships: new_memberships)
    end
  end
end