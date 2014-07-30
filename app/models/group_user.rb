class GroupUser < ActiveRecord::Base

attr_readonly :group_id, except: {on: :create}

validates :group_id, :user_id, presence: true
validates :user_id, uniqueness: {scope: :group_id}

before_save :disallow_group_self, :verify_blocked_status

belongs_to(
  :user, 
  inverse_of: :group_users
  )

belongs_to(
  :group, 
  inverse_of: :group_users
  )

  def verify_blocked_status
    return unless user.blocked_by?(group.user) || user.blocked?(group.user)
    errors.add(:base, "Access blocked for this user.")    
  end

  def disallow_group_self
  	return unless self.user_id == self.group.user_id
  	   errors.add(:base, 'Cannot add self.')
  end

end
