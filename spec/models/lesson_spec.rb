require 'rails_helper'

RSpec.describe Lesson, type: :model do
  subject { lesson }

  let!(:user) { FactoryBot.create :user, first_name: 'admin', last_name: 'admin1', email: 'admin@gmail.com', is_admin: true }
  let!(:course) { FactoryBot.create :course, user_id: user.id }
  let!(:lesson) { FactoryBot.create :lesson, name: 'test 1'}

  describe 'Validations' do
    before { course.save }

    it { expect(subject).to be_valid }

    [:lesson_type, :check_point, :video_url].each do |field|
      it { is_expected.to validate_presence_of(field).with_message("can't be blank") }
    end
    
    it { is_expected.to validate_length_of(:name).is_at_most(Settings.first_name.maximum) }
    
    it 'does not greater than number of questions' do
      lesson = build(:lesson, check_point: 2)
      lesson.valid?
      expect(lesson.errors[:check_point].size).to eq(1)
    end
  end

  describe 'Associations' do
    [:course].each do |field|
      it { is_expected.to belong_to(field) }
    end
    [:exams, :questions].each do |field|
      it { is_expected.to have_many(field).dependent(:destroy) }
    end
  end
end
