# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
  	user { FactoryGirl.create(:user) }
  	conversation { FactoryGirl.create(:user_conversation) }
  	body { Faker::Lorem.characters(30) }
  	photo { File.open("app/assets/images/logo-white.png") }
  end
end
