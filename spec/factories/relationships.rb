# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :relationship do
  	follower {FactoryGirl.create(:user)}
  	followed {FactoryGirl.create(:user)}
  	accepted true
  end
end
