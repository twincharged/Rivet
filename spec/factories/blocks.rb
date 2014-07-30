# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :blocked_user, class: "Block" do
  	blocker { FactoryGirl.create(:user) }
  	blockable { FactoryGirl.create(:user) }
  end

  factory :blocked_post, class: "Block" do
  	blocker { FactoryGirl.create(:user) }
  	blockable { FactoryGirl.create(:post) }
  end


end
