class Notification < ActiveRecord::Base

attr_readonly :user_id, :notifiable_type, :notifiable_id, except: {on: [:create, :destroy]}

validates :notifiable_type, inclusion: {in: %w( Post Comment )}
validates :notifiable_id, :user_id, :notifiable_type, :body, presence: true

belongs_to(
  :notifiable,
  polymorphic: true
  )

belongs_to :user


end
