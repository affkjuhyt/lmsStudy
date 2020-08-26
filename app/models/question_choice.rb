class QuestionChoice < ApplicationRecord
  belongs_to :question

  has_many :answers
  accepts_nested_attributes_for :answers
end
