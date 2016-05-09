class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: User.name
  belongs_to :followed, class_name: User.name
  after_create :create_activity_follow
  before_destroy :create_activity_unfollow

  validates :follower, presence: true
  validates :followed, presence: true

  private
  def create_activity_follow
    Activity.create user_id: self.follower_id, target_id: self.followed_id, action: Settings.activity.follow
  end

  def create_activity_unfollow
    Activity.create user_id: self.follower_id, target_id: self.followed_id, action: Settings.activity.unfollow
  end
end
