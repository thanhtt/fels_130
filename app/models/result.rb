class Result < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :word
  belongs_to :answer

  scope :is_correct_answers, ->{joins(:answer).where answers: {is_correct: true}}
end
