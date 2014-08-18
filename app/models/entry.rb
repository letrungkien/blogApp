class Entry < ActiveRecord::Base
  before_save { self.title = title.strip }
  before_save { self.body = body.strip }
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :title, presence: true, length: { maximum: 140 }
  validates :body, presence: true, length: { maximum: 500 }
  validates :user_id, presence: true

  # Returns microposts from the users being followed by the given user.
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end
end