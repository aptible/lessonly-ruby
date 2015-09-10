require 'spec_helper'

describe Lessonly::User do
  describe '#all' do
    it 'should return all users' do
      users = Lessonly::User.all
      expect(users.count).to eq 3
    end
  end

  describe '#find' do
    it 'should find a single user' do
      user = Lessonly::User.find(1)
      expect(user.name).to eq 'Chas Ballew'
    end
  end

  describe '#assigned_to?' do
    it 'should return true if user is assigned to course' do
      user = Lessonly::User.find(1)
      course = Lessonly::Course.find(1)

      expect(user.assigned_to?(course)).to eq true
    end

    it 'should return false if user is not assigned to course' do
      user = Lessonly::User.find(3)
      course = Lessonly::Course.find(1)

      expect(user.assigned_to?(course)).to eq false
    end
  end

  describe '#serialize' do
    let(:agent) { Sawyer::Agent.new('') }
    subject do
      Lessonly::User.new(agent, name: 'Test++ +User!!@', role: 'learner',
                                email: 'user@example.com')
    end

    it 'should remove invalid characters' do
      expect(subject.serialize.name).to eq 'Test User'
    end
  end
end
