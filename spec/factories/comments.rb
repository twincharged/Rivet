# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :post_comment, class: "Comment" do
  	user { FactoryGirl.create(:user) }
  	threadable { FactoryGirl.create(:post) }
  	body { Faker::Lorem.sentence(word_count = 10) }
  end

  
end
