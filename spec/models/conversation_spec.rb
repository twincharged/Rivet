require 'spec_helper'

describe Conversation do

	describe "fields" do

		it { should respond_to(:started_by_entity) }

	end


	describe "associations" do

	it { should have_many(:messages) }
    it { should have_many(:conversation_users) }
    it { should have_many(:users) }

	end


	describe "(for a new conversation)" do

	  it "should deliver messages" do
	    user = FactoryGirl.create(:user)
	    users = FactoryGirl.create_list(:user, 4)
	    user_ids = users.collect(&:id)
		user.start_conversation(user_ids, "This is a new conversation!!!")
		users.each do |f|
		  f.received_messages.to_a.should include(user.messages.first)
		  f.conversation_users.first.conversation_id.should == user.conversations.first.id
		end
	  end


	  it "should set new conversation to unread" do
	  	user = FactoryGirl.create(:user)
	    users = FactoryGirl.create_list(:user, 4)
	    user_ids = users.collect(&:id)
		user.start_conversation(user_ids, "This is a new conversation that's unread!!!")
		users.each do |f|
		  f.unread_conversations.to_a.first.read.should == false
		end
	  end


	  it "should create reply" do
	  	user = FactoryGirl.create(:user)
	    users = FactoryGirl.create_list(:user, 4)
	    user_ids = users.collect(&:id)
	  	user.start_conversation(user_ids, "This is a new conversation!!!")
	  	user = users.last
  		mess2 = Message.create(conversation: user.conversations.first, user: user, body: "A reply!")
  		users.each do |f|
			f.received_messages.to_a.should include(mess2)
	    end
	  end

  	  it "should create new conversation for own group" do
  	  	user = FactoryGirl.create(:user)
  	  	group = FactoryGirl.create(:group, user: user)
  	  	gu = FactoryGirl.create_list(:group_user, 10, group: group)
  	  	user_ids = gu.collect(&:user_id)
  	  	user.start_conversation(user_ids, "Invited all my buddies to chat!")
  	  	gu.each do |f|
  	  	  f.user.conversations.first.should == user.conversations.first
  	  	end
  	  end
	end

end
