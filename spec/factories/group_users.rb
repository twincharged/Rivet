# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :group_user do
  	group { FactoryGirl.create(:group) }
  	user { FactoryGirl.create(:user) }
  end
end
