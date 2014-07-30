class Message < ActiveRecord::Base

attr_readonly :user_id, :conversation_id, except: {on: :create}

mount_uploader :photo, PhotoUploader

validates :user_id, :conversation_id, presence: true
validates :body, length: {maximum: 5000}
validate :photo_or_body

after_commit :set_to_unread


belongs_to :user

belongs_to(
  :conversation, 
  inverse_of: :messages
  )

has_many(
  :conversation_users, 
  through: :conversation
  )

has_many(
  :recipients, 
  class_name: "User", 
  through: :conversation_users,
  source: :user
  )
  
accepts_nested_attributes_for :conversation

  def set_to_unread
    self.conversation_users.where("user_id != ?", self.user_id).update_all(read: false)
  end

  def photo_or_body
    return if self.photo.present?  ||  self.body.present?
    errors.add(:base, "Don't send a blank message!")
  end

end
