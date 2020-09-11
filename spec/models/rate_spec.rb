require 'rails_helper'

RSpec.describe Rate, type: :model do
  subject { rate }

  let!(:user) { FactoryBot.create :user }
  let!(:course) { FactoryBot.create :course }
  let!(:rate) { FactoryBot.create :rate, user_id: user.id, course_id: course.id }

  describe 'Validations' do
    before { rate.save }

    it { expect(subject).to be_valid }

    it { is_expected.to validate_uniqueness_of(:course_id).scoped_to(:user_id) }
  end

  describe 'Associations' do
    [:user, :course].each do |field|
      it { is_expected.to belong_to(field) }
    end
  end
end
