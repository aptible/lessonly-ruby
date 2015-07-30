require 'spec_helper'

describe Lessonly::Course do
  describe '#all' do
    it 'should return all courses' do
      courses = Lessonly::Course.all
      expect(courses.count).to eq 3
      expect(courses.first.title).to eq 'HIPAA Basic'
      expect(courses.first.id).to eq 1
    end
  end

  describe '#find' do
    it 'should find a single course' do
      course = Lessonly::Course.find(1)
      expect(course.title).to eq 'HIPAA Advanced'
    end
  end

  describe '#lessons' do
    it 'should have many lessons' do
      course = Lessonly::Course.find(1)

      expect(course.lessons.first).to be_a Lessonly::Lesson
      expect(course.lessons.first.title).to eq 'Basic HIPAA Lesson'
    end
  end

  describe '#assignments' do
    it 'should have many assignments' do
      course = Lessonly::Course.find(1)
      assignments = course.assignments

      expect(assignments.count).to eq 1
    end

    it 'should serialize assignment assignees as user' do
      course = Lessonly::Course.find(1)
      assignee = course.assignments.first.user

      expect(assignee).to be_a Lessonly::User
      expect(assignee.name).to eq 'Chas Ballew'
    end
  end

  describe '#create_assignment' do
    it 'should create a user assignment' do
      course = Lessonly::Course.find(1)
      user = Lessonly::User.find(3)

      course.create_assignment(user)

      expect(course.assignments.map(&:assignee_id)).to include(user.id)
      expect(course.assignments.count).to eq 2
    end
  end

  describe '#destroy_assignment' do
    it 'should remove a user assignment' do
      course = Lessonly::Course.find(1)
      user = Lessonly::User.find(1)

      course.destroy_assignment(user)

      expect(course.assignments.count).to eq 0
    end
  end
end
