# == Schema Information
#
# Table name: microposts
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#
class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order 'created_at DESC' }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  def self.from_users_followed_by(user)
    # followed_user_ids = user.followed_user_ids
    # Same as: User.first.followed_users.map &:id
    # where("user_id IN (:followed_user_ids) OR user_id = :user_id",
    #       followed_user_ids: followed_user_ids, user_id: user)
    followed_user_ids = "SELECT followed_id FROM relationships
    WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end
end
