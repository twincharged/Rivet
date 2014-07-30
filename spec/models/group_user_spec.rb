require 'spec_helper'

describe GroupUser do

  describe "validations" do
    
  	gu = FactoryGirl.create(:group_user)
    
  	subject { gu }
  	it { should validate_presence_of(:user_id) }
  	it { should validate_presence_of(:group_id) }
  	it { should have_readonly_attribute(:group_id) }
  	it { should validate_uniqueness_of(:user_id).scoped_to(:group_id) }

  end

  
  describe "associations" do
    
    it { should belong_to(:user) }
  	it { should belong_to(:group) }

  end


  describe "(for invalid user attributes)" do
    
    it "should require user" do
      FactoryGirl.build(:group_user, user: nil).should_not be_valid
    end

    it "should require group" do
      FactoryGirl.build(:group_user, group: nil).should_not be_valid
    end
  end


  describe "(for valid user attributes)" do
    
    it "should create group user" do
      FactoryGirl.build(:group_user).should be_valid
    end
  end

end
