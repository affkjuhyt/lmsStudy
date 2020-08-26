class Question < ApplicationRecord
  belongs_to :lesson

  has_many :question_choices
  has_many :answers, dependent: :destroy
end
