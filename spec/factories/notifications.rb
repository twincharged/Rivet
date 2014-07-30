# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do


  factory :comment_notification, class: "Notification" do
  end

  factory :like_notification, class: "Notification" do
  end

  factory :relationship_notification, class: "Notification" do
  end

end
