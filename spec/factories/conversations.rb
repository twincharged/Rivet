# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :entity_conversation, class: "Conversation" do
  	started_by_entity true
  end

  factory :user_conversation, class: "Conversation" do
  	started_by_entity false
  end

end
