require 'spec_helper'

describe Lessonly::Group do
  context '#all' do
    it 'should return all groups' do
      groups = Lessonly::Group.all
      expect(groups.count).to eq 1
    end
  end

  context '#find' do
    it 'should find a single group' do
      group = Lessonly::Group.find(1)
      expect(group.name).to eq 'Developers'
    end
  end

  context '#create_membership' do
    it 'should add a user to the group\'s members' do
      group = Lessonly::Group.find(1)
      user = Lessonly::User.find(3)

      group.create_membership(user)

      expect(group.members.map(&:name)).to include(user.name)
      expect(group.members.count).to eq(3)
    end
  end

  context '#destroy_membership' do
    it 'should remove a user from the group\'s members' do
      group = Lessonly::Group.find(1)
      user = Lessonly::User.find(1)

      group.destroy_membership(user)

      member = group.members.find { |m| m.id == user.id }
      expect(member.remove).to eq(true)
    end
  end
end
