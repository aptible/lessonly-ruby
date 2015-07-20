require 'spec_helper'

describe Lessonly::User do
  context '#all' do
    it 'should return all users' do
      users = Lessonly::User.all
      expect(users.count).to eq 3
    end
  end

  context '#find' do
    it 'should find a single user' do
      user = Lessonly::User.find(1)
      expect(user.name).to eq 'Chas Ballew'
    end
  end
end
