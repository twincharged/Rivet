class Comment < ActiveRecord::Base

attr_readonly :user_id, except: {on: :create}

validates :user_id, :threadable_id, :threadable_type, presence: true
validates :body, presence: true, length: { maximum: 500 }
validates :threadable_type, inclusion: {in: %w( Post )}

before_save :verify_blocked_status, on: [:create, :update]
after_save :send_notification, :update_notification, on: [:create, :update]
after_destroy :destroy_notification


belongs_to(
  :user,
  class_name: "User"
  )

belongs_to( 
	:threadable, 
	polymorphic: true
	)

has_many(
  :likes,
  as: :likeable,
  class_name: "Like",
  dependent: :destroy
  )

has_many(
  :notifications,
  as: :notifiable,
  dependent: :destroy
  )

private

  def verify_blocked_status
    return unless user.blocked_by?(threadable.user)
    errors.add(:base, "You are not allowed to comment on this user's post.")
  end

  def destroy_notification
    if self.threadable.comments.size == 0
      note = Notification.find_by(notifiable: self.threadable, from_comment: true)
      return if note.blank?
      note.destroy
    else
      return
    end
  end

  def send_notification
    return if Notification.find_by(notifiable: self.threadable, from_comment: true).present?  ||  self.user_id == self.threadable.user_id
    Notification.create(notifiable: threadable, user: threadable.user, from_comment: true, body: "#{self.user.name} commented on your #{self.threadable_type.downcase}.", read: false)
  end

  def update_notification
    return unless self.threadable.comments.size > 1  &&  self.user_id != self.threadable.user_id
    note = Notification.find_by(notifiable: self.threadable, user_id: self.threadable.user_id)
    note.update_attributes(body: "#{self.threadable.comments.size} new comments on your #{self.threadable_type.downcase}.", read: false)
  end


end
