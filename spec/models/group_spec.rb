require 'spec_helper'

describe Group do

  describe "validations" do

  	it { should validate_presence_of(:user_id) }
  	it { should validate_presence_of(:name) }
  	it { should validate_uniqueness_of(:name).scoped_to(:user_id) }
  	it { should ensure_length_of(:name) }

  end

  
  describe "associations" do
    
    it { should belong_to(:user) }
  	it { should have_many(:group_users) }

  end


  describe "(for invalid user attributes)" do
    
    it "should require user" do
      FactoryGirl.build(:group, user: nil).should_not be_valid
    end

    it "should require name" do
      FactoryGirl.build(:group, name: nil).should_not be_valid
    end
  end


  describe "(for valid user attributes)" do
    
    it "should create group" do
      FactoryGirl.build(:group).should be_valid
	  end
  end
  
end
