class Word < ActiveRecord::Base
  belongs_to :course

  has_many :results, dependent: :destroy
  has_many :lessons, through: :results
  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :answers,
    reject_if: proc {|attributes| attributes[:content].blank?},
    allow_destroy: true

  QUERRY_WORD_LEARNDED = "id in (select results.word_id from
    results join lessons on results.lesson_id = lessons.id
    where lessons.user_id = ?)"

  QUERRY_WORD_NOT_LEARNDED = "id not in (select results.word_id from
    results join lessons on results.lesson_id = lessons.id
    where lessons.user_id = ?)"

  scope :all_words, -> user_id{}
  scope :learned, -> user_id{where QUERRY_WORD_LEARNDED, user_id}
  scope :not_learned, -> user_id{where QUERRY_WORD_NOT_LEARNDED, user_id}

  validates :content, presence: true
end
