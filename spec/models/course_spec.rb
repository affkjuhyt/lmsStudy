require 'rails_helper'

RSpec.describe Course, type: :model do
  subject { course }

  let!(:user) { FactoryBot.create :user, first_name: "admin", last_name: "admin1", email: "admin@gmail.com", is_admin: true }
  let!(:course) { FactoryBot.create :course, user_id: user.id }

  describe "Validations" do
    before { course.save }

    it { expect(subject).to be_valid }

    [:user_id, :title, :overview, :description].each do |field|
      it { is_expected.to validate_presence_of(field).with_message("can't be blank") }
    end
  end

  describe "Associations" do
    [:user].each do |field|
      it { is_expected.to belong_to(field) }
    end
    [:user_courses, :review_courses, :lessons, :rates].each do |field|
      it { is_expected.to have_many(field).dependent(:destroy) }
    end
  end
end
