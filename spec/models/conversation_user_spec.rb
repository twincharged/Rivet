require 'spec_helper'

describe ConversationUser do

  describe "validations" do

  	it { should have_readonly_attribute(:user_id) }
  	it { should have_readonly_attribute(:conversation_id) }
  	it { should validate_presence_of(:user_id) }
  	it { should validate_presence_of(:conversation_id) }
  	it { should respond_to(:read) }

  end

  
  describe "associations" do
    
    it { should belong_to(:user) }
    it { should belong_to(:conversation) }
  	it { should have_many(:messages) }

  end


  describe "(for invalid conversation user attributes)" do

  	it "should reject invalid user" do
  		FactoryGirl.build(:conversation_user, user: nil).should_not be_valid
  	end

  	it "should reject invalid conversation" do
  		FactoryGirl.build(:conversation_user, conversation: nil).should_not be_valid
  	end

  	it "should reject invalid read boolean" do
  		FactoryGirl.build(:conversation_user, read: nil).should_not be_valid
  	end
  end
  
end
