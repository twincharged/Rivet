class Flag < ActiveRecord::Base

attr_readonly :user_id, :flagable_type, :flagable_id, except: {on: :create}
validates :user_id, :flagable_type, :flagable_id, presence: true
validates :flagable_type, inclusion: {in: %w( Post User )}


belongs_to :user

belongs_to(
  :flagable,
  polymorphic: true
  )

end
