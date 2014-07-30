class BannedUser < ActiveRecord::Base

validates :email, presence: true, uniqueness: true
validates :ban_report, presence: true, length: {maximum: 5000}

end
