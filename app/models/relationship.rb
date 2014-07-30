class Relationship < ActiveRecord::Base

attr_readonly :follower_id, :followed_id, except: {on: :create}

validates :follower_id, :followed_id, presence: true
validates :followed_id, uniqueness: { scope: :follower_id}
validates :accepted, inclusion: {in: [true, false]}
validate  :valid_follow?, :disallow_blocked_follows

before_create :default_approved_boolean


belongs_to(
  :follower, 
  class_name: "User"
  )

belongs_to(
  :followed, 
  class_name: "User"
  )

has_many(
  :notifications,
  as: :notifiable,
  dependent: :destroy
  )

private

  def default_approved_boolean
    if followed.setting.follower_approval == true
      self.accepted = false
    else
      self.accepted = true
    end
  end

  def valid_follow?
    if follower_id == followed_id
       errors.add(:base, 'Cannot follow self.')
    end
  end

  def disallow_blocked_follows
    return unless Block.where("(blockable_id = ? AND blocker_id = ? AND blockable_type = ?) OR 
                               (blocker_id = ? AND blockable_id = ? AND blockable_type = ?)", 
                               follower_id, followed_id, "User", 
                               follower_id, followed_id, "User").present?
       errors.add(:base, 'Cannot follow this user.')
  end

end
