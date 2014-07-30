# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :conversation_user do
  	user { FactoryGirl.create(:user) }
  	conversation { FactoryGirl.create(:user_conversation) }
  	read false
  end
end
