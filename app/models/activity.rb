class Activity < ActiveRecord::Base
  belongs_to :user

  def load_lesson
    Lesson.find_by id: self.target_id
  end

  def load_user
    User.find_by id: self.target_id
  end

  QUERRY_ACTIVITIES = "user_id in (select followed_id from
    relationships where follower_id = ?) or user_id = ?"

  scope :activities, ->user_id do
    where(QUERRY_ACTIVITIES, user_id, user_id).order created_at: :desc
  end
end
