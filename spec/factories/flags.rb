# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :post_flag, class: "Flag" do
  	user { FactoryGirl.create(:user) }
  	flagable { FactoryGirl.create(:post) }
  end

  factory :user_flag, class: "Flag" do
  	user { FactoryGirl.create(:user) }
  	flagable { FactoryGirl.create(:user) }
  end

end
