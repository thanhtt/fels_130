class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  has_many :activities, dependent: :destroy
  has_many :words, through: :results
  has_many :results, dependent: :destroy
end
