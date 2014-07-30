# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :setting do
  	follower_approval false
  	email_notifications true
  	lock_all_self_content false
  end
end
