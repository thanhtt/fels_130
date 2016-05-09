class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  before_create :create_word
  after_create :create_activity

  has_many :activities, dependent: :destroy
  has_many :words, through: :results
  has_many :results

  validate :word_min, on: :create

  accepts_nested_attributes_for :results

  private
  def create_word
    self.words = self.course.words.order("RANDOM()").
      limit Settings.number_words_per_lesson
  end

  def word_min
    errors.add :create, I18n.t("create_lesson_fail") if self.course.words.size < Settings.number_words_min
  end

  def create_activity
    Activity.create user_id: self.user_id, target_id: self.id, action: Settings.activity.learned
  end
end
