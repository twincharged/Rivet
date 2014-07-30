require 'spec_helper'

describe Message do

  describe "validations" do

    it { should have_readonly_attribute(:user_id) }
    it { should have_readonly_attribute(:conversation_id) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:conversation_id) }
    it { should ensure_length_of(:body) }

  end

  
  describe "associations" do
    
    it { should belong_to(:user) }
    it { should belong_to(:conversation) }
    it { should have_many(:conversation_users) }
    it { should have_many(:recipients) }

  end


  describe "(for invalid message attributes)" do

  	it "should require body or photo" do
  	  message = FactoryGirl.build(:message, body: nil, photo: nil)
  	  message.should_not be_valid
  	end

  	it "should reject lengthy body" do
  	  long = "real long" * 1000
  	  message = FactoryGirl.build(:message, body: long)
  	  message.should_not be_valid
  	end

  	it "should require user" do
  	  message = FactoryGirl.build(:message, user: nil)
  	  message.should_not be_valid
  	end

  	it "should require conversation" do
  	  message = FactoryGirl.build(:message, conversation: nil)
  	  message.should_not be_valid
  	end
  end


  describe "(for valid message attributes)" do

  	it "should allow photo" do
  	  message = FactoryGirl.build(:message, photo: File.open("app/assets/images/logo-white.png"))
  	  message.should be_valid
  	end

  	it "should allow photo and body" do
  	  message = FactoryGirl.build(:message, body: "HEY", photo: File.open("app/assets/images/logo-white.png"))
  		message.should be_valid
  	end
  end

end