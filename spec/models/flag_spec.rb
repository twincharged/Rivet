require 'spec_helper'

describe Flag do

  describe "validations" do

  	it { should have_readonly_attribute(:user_id) }
  	it { should have_readonly_attribute(:flagable_id) }
  	it { should have_readonly_attribute(:flagable_type) }
  	it { should validate_presence_of(:user_id) }
  	it { should validate_presence_of(:flagable_id) }
  	it { should validate_presence_of(:flagable_type) }
  	it { should ensure_inclusion_of(:flagable_type).in_array(%w( Post )) }

  end

  
  describe "associations" do

  	it { should belong_to(:user) }
  	it { should belong_to(:flagable) }

  end


  describe "(for invalid flag attributes)" do
    
    it "should require user" do
      FactoryGirl.build(:post_flag, user: nil).should_not be_valid
      FactoryGirl.build(:user_flag, user: nil).should_not be_valid
    end

    it "should require flagable for post flag" do
      FactoryGirl.build(:post_flag, flagable: nil).should_not be_valid
      FactoryGirl.build(:user_flag, flagable: nil).should_not be_valid
    end

  end


  describe "(for valid flag attributes)" do

    it "should create post flag" do
      FactoryGirl.build(:post_flag).should be_valid
    end

    it "should create user flag" do
      FactoryGirl.build(:user_flag).should be_valid
    end

    it "should methodically create post flag" do
      user = FactoryGirl.create(:user)
      post = FactoryGirl.create(:post)
      user.flag!(post)
      flag = Flag.find_by(user: user, flagable: post)
      flag.should_not be_nil
    end

    it "should methodically create user flag" do
      user = FactoryGirl.create(:user)
      flagged_user = FactoryGirl.create(:user)
      user.flag!(flagged_user)
      flag = Flag.find_by(user: user, flagable: flagged_user)
      flag.should_not be_nil    
    end
  end

end
