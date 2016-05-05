class Word < ActiveRecord::Base
  belongs_to :course

  has_many :results, dependent: :destroy
  has_many :lessons, through: :results
  has_many :answers, dependent: :destroy

  QUERRY_WORD_LEARNDED = "id in (select word_lessons.word_id from
    word_lessons join lessons on word_lessons.lesson_id = lessons.id
    where lessons.user_id = ?)"

  QUERRY_WORD_NOT_LEARNDED = "id not in (select word_lessons.word_id from
    word_lessons join lessons on word_lessons.lesson_id = lessons.id
    where lessons.user_id = ?)"

  scope :all_words, -> user_id{}
  scope :learned, -> user_id{where QUERRY_WORD_LEARNDED, user_id}
  scope :not_learned, -> user_id{where QUERRY_WORD_NOT_LEARNDED, user_id}

  validates :content, presence: true
  accepts_nested_attributes_for :answers, allow_destroy: true
end
