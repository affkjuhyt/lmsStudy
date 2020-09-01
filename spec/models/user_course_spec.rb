require 'rails_helper'

RSpec.describe UserCourse, type: :model do
  subject { user_course }

  let!(:user) { FactoryBot.create :user }
  let!(:course) { FactoryBot.create :course }
  let!(:user_course) { FactoryBot.build :user_course, user_id: user.id, course_id: course.id }

  describe "Validations" do
    it { expect(subject).to be_valid }

    [:course_id, :user_id].each do |field|
      it { is_expected.to validate_presence_of(field).with_message("can't be blank") }
      it { is_expected.to validate_numericality_of(field) }
    end
    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:course_id) }
  end

  describe "Associations" do
    [:user, :course].each do |field|
      it { is_expected.to belong_to(field) }
    end
  end
end
