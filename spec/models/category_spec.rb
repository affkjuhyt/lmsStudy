require 'rails_helper'

RSpec.describe Category, type: :model do
  subject { category }

  let!(:category) { FactoryBot.create :category, name: "Web development"}

  describe "Validations" do
    before { category.save }

    it { expect(subject).to be_valid }

    it { is_expected.to validate_presence_of(:category).with_message("can't be blank") }
    it { is_expected.to validate_length_of(:category).is_at_most(Settings.course_type.maximum) }
  end

  describe "Associations" do
    it { is_expected.to have_many(:courses) }
  end
end
