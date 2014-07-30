require 'spec_helper'

describe Setting do
  
  describe "validations" do

  	it { should have_readonly_attribute(:user_id) }

  end


  describe "associations" do

  	it { should belong_to(:user) }

  end


  describe "(for invalid setting attributes)" do

    it "should require user" do
      FactoryGirl.build(:setting, user: nil).should_not be_valid
    end

    it "should reject multiple settings" do
      user = FactoryGirl.create(:user)
      set = FactoryGirl.build(:setting, user: user).should_not be_valid
    end
  end


  describe "(for valid setting attributes)" do

    it "should create setting" do
      user2 = FactoryGirl.create(:user)
      expect(user2.setting).to_not be_nil
    end

    it "should update setting" do
      user2 = FactoryGirl.create(:user)
      set = user2.setting
      set.toggle!(:lock_all_self_content)
      set.lock_all_self_content.should == true
    end
  end

end
