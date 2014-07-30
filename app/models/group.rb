class Group < ActiveRecord::Base

validates :user_id, :name, presence: true
validates :name, uniqueness: {scope: :user_id}, length: {maximum: 60}

belongs_to :user

has_many(
  :group_users, 
  inverse_of: :group,
  dependent: :destroy
  )


  def create_group_users!(user_ids)
    return if user_ids.blank?
      user_ids.each do |u|
        group_users.create!(user_id: u, group: self)
      end
  end

end
