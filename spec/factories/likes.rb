# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :post_like, class: "like" do
  	user { FactoryGirl.create(:user) }
  	likeable { FactoryGirl.create(:post) }
  end

  factory :comment_like, class: "Like" do
  	user { FactoryGirl.create(:user) }
  	likeable { FactoryGirl.create(:post_comment) }
  end

end
