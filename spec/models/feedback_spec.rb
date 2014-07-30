require 'spec_helper'

describe Feedback do

  describe "validations" do

  	it { should have_readonly_attribute(:user_id) }
  	it { should validate_presence_of(:user_id) }
  	it { should ensure_length_of(:subject) }
  	it { should validate_presence_of(:body) }
  	it { should ensure_length_of(:body) }

  end

  
  describe "associations" do
    
    it { should belong_to(:user) }

  end


  describe "(for invalid feedback attributes)" do

  	it "should require user" do
  	  FactoryGirl.build(:feedback, user: nil).should_not be_valid
  	end

  	it "should require body" do
  	  FactoryGirl.build(:feedback, body: nil).should_not be_valid
  	end
  end
  

  describe "(for valid feedback attributes)" do

  	it "should create feedback" do
  	  FactoryGirl.build(:feedback).should be_valid
  	end
  end
  
end
