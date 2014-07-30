require 'spec_helper'

describe Block do

  
  describe "validations" do

  	user_block = FactoryGirl.build(:blocked_user)
  	post_block = FactoryGirl.build(:blocked_post)

    context "should validate user block" do
  	  subject { user_block }
  	  it { should validate_presence_of(:blocker_id) }
  	  it { should have_readonly_attribute(:blocker_id) }
      it { should validate_uniqueness_of(:blocker_id).scoped_to(:blockable_id, :blockable_type) }
      it { should ensure_inclusion_of(:blockable_type).in_array(%w( User Post )) }
    end

    context "should validate post block" do
      subject { post_block }
  	  it { should validate_presence_of(:blocker_id) }
  	  it { should have_readonly_attribute(:blocker_id) }
      it { should validate_uniqueness_of(:blocker_id).scoped_to(:blockable_id, :blockable_type) }
  	  it { should ensure_inclusion_of(:blockable_type).in_array(%w( User Post )) }
    end

  end

  
  describe "associations" do

    it { should belong_to(:blocker) }
  	it { should respond_to(:blockable) }
  	it { should respond_to(:blocked_user) }
  	it { should respond_to(:post) }

  end


  describe "(for invalid block attributes)" do

    it "should require blocker" do
      FactoryGirl.build(:blocked_post, blocker: nil).should_not be_valid
    end

    it "should require blocked object" do
      FactoryGirl.build(:blocked_post, blockable: nil).should_not be_valid
    end

    it "should require correct blocked object" do
      object = FactoryGirl.create(:post_like)
      FactoryGirl.build(:blocked_post, blockable: object).should_not be_valid
    end

    it "should reject self blocks" do
      user = FactoryGirl.create(:user)
      post = FactoryGirl.create(:post, user: user)
      FactoryGirl.build(:blocked_post, blocker: user, blockable: post).should_not be_valid
      FactoryGirl.build(:blocked_post, blocker: user, blockable: user).should_not be_valid
    end

    it "should require unique blocked object" do
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      Block.create(blocker: user1, blockable: user2)
      Block.new(blocker: user1, blockable: user2).should_not be_valid
    end
  end


  describe "(for valid block attributes)" do

    it "should create block" do
      FactoryGirl.build(:blocked_user).should be_valid
    end
  end

  describe "(for dependent destruction)" do

    it "should destroy relationship one" do
      follower = FactoryGirl.create(:user)
      followed = FactoryGirl.create(:user)
      follower.follow!(followed)
      followed.block!(follower)
      relate = Relationship.find_by(follower: follower, followed: followed)
      relate.should be_nil
    end

    it "should destroy relationship two" do
      follower = FactoryGirl.create(:user)
      followed = FactoryGirl.create(:user)
      follower.follow!(followed)
      follower.block!(followed)
      relate = Relationship.find_by(follower: follower, followed: followed)
      relate.should be_nil
    end

  end


end
