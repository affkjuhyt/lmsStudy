class Question < ApplicationRecord
  belongs_to :lesson

  has_many :question_choices
  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :question_choices, allow_destroy: true
end
