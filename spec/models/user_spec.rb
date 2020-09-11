require 'rails_helper'

RSpec.describe User, type: :model do
  subject { user }

  let!(:user) { FactoryBot.create :user }
  let(:u1) { FactoryBot.create :user, first_name: 'derre', last_name: 'rosa', email: 'derre@gmail.com', created_at: '2020-09-01 10:00:00' }
  let(:u2) { FactoryBot.create :user, first_name: 'fred', last_name: 'rosa', email: 'fred@gmail.com', created_at: '2020-09-01 10:00:00' }
  let(:u3) { FactoryBot.create :user, first_name: 'sam', last_name: 'rosa', email: 'sam#@2gmail.com', created_at: '2020-09-01 10:00:00' }

  describe "Validation" do
    before { user.save }

    it { expect(subject).to be_valid }

    it { is_expected.to validate_presence_of(:first_name).with_message("can't be blank") }
    it { is_expected.to validate_presence_of(:last_name).with_message("can't be blank") }
    it { is_expected.to validate_length_of(:first_name).is_at_most(Settings.first_name.maximum) }
    it { is_expected.to validate_length_of(:first_name).is_at_most(Settings.last_name.maximum) }
    it 'is not valid for first_name and last_name with special characters' do
      user.email = 'thienlinh$'
      expect(user).not_to be_valid
    end

    it { is_expected.to validate_presence_of(:email).with_message("can't be blank") }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive.with_message("has already been taken") }
    it { is_expected.to allow_value('nguyenthienlinhptit@gmail.com').for(:email) }
    it { is_expected.not_to allow_value('nguyenthienlinhp#tit@gmail.com').for(:email) }
    
    it { expect(subject.is_admin?).to be false }
  end

  describe 'Associations' do
    it 'has many courses' do
      assc = User.reflect_on_association :courses
      expect(assc.macro).to eq :has_many
    end

    it { is_expected.to have_many(:courses).through(:user_courses) }
    [:user_courses, :review_courses, :exams, :rates].each do |field|
      it { is_expected.to have_many(field).dependent(:destroy) }
    end
  end
end
