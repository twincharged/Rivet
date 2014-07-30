class Setting < ActiveRecord::Base

attr_readonly :user_id, except: [on: :create]

validates :user_id, presence: true
validates :follower_approval, :email_notifications, :lock_all_self_content, inclusion: { in: [true, false]}
validate  :one_setting_per_user

before_save :build_entity_settings

belongs_to :user

private

  def build_entity_settings
  	return unless self.user.entity?
  		self.follower_approval = false
  end

  def one_setting_per_user
  	return unless Setting.find_by(user_id: self.user_id).present?
  	errors.add(:base, 'Already a setting for that user.')
  end

end
