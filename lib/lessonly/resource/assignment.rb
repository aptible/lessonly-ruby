module Lessonly
  class Assignment < Resource
    has_one :user, klass: 'Lessonly::User', using: :assignee_id
  end
end