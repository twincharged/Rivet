# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feedback do
  	user { FactoryGirl.create(:user) }
  	subject { Faker::Lorem.characters(50) }
  	body { Faker::Lorem.sentences(10) }
  end
end
