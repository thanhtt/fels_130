class Word < ActiveRecord::Base
 	belongs_to :course

  has_many :results, dependent: :destroy
  has_many :lessons, through: :results
  has_many :word_options, dependent: :destroy
end
