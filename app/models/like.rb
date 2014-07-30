class Like < ActiveRecord::Base

attr_readonly :user_id, except: {on: :create}

validates :user_id, uniqueness: {scope: [:likeable_id, :likeable_type]}
validates :user_id, :likeable_id, :likeable_type, presence: true
validates :likeable_type, inclusion: {in: %w( Post Comment )}

before_save :verify_blocked_status, on: [:create, :update]
after_save :send_notification, :update_notification, on: [:create, :update]
after_destroy :destroy_notification


belongs_to(
  :user,
  class_name: "User"
  )

belongs_to( 
  :likeable, 
  polymorphic: true,
  counter_cache: true
  )

private

  def verify_blocked_status
    return unless user.blocked_by?(likeable.user)
    errors.add(:base, "You are not allowed to like this user's post.")
  end

  def destroy_notification
    if self.likeable.likes.size == 0
      note = Notification.find_by(notifiable: self.likeable, from_comment: false)
      return if note.nil?
      note.destroy
    else
      return
    end
  end

  def send_notification
    return if Notification.find_by(notifiable: self.likeable, from_comment: false).present?  ||  self.user_id == self.likeable.user_id
    Notification.create!(notifiable: self.likeable, user: self.likeable.user, from_comment: false, body: "#{self.user.name} liked your #{self.likeable_type.downcase}.", read: false)
  end

  def update_notification
    return unless self.likeable.likes.size > 1  &&  self.user_id != self.likeable.user_id
    note = Notification.find_by(notifiable: self.likeable, user_id: self.likeable.user_id)
    note.update_attributes(body: "#{self.likeable.likes.size} new likes on your #{self.likeable_type.downcase}.", read: false)
  end


end
