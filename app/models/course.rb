class Course < ActiveRecord::Base
	has_many :words, dependent: :destroy
  	has_many :lessons, dependent: :destroy
end
