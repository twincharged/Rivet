require 'spec_helper'

describe Relationship do

	describe "validations" do

		follower = FactoryGirl.create(:user)
  	followed = FactoryGirl.create(:user)
    relationship = follower.relationships.create(followed: followed, accepted: false)
  	
    subject { relationship }
  	it { should have_readonly_attribute(:follower_id) }
  	it { should have_readonly_attribute(:followed_id) }
  	it { should validate_presence_of(:follower_id) }
  	it { should validate_presence_of(:followed_id) }
  	it { should validate_uniqueness_of(:followed_id).scoped_to(:follower_id) }

	end


	describe "associations" do

  	it { should belong_to(:follower) }
  	it { should belong_to(:followed) }
  	it { should have_many(:notifications) }
    
	end


  describe "(for invalid relationships)" do

    it "should not create blocked relationship" do
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      # debugger
      user1.block!(user2)
      FactoryGirl.build(:relationship, follower: user2, followed: user1).should_not be_valid
      FactoryGirl.build(:relationship, follower: user1, followed: user2).should_not be_valid
    end

  end


	describe "(for valid relationships)" do

		it "should manually create relationship" do
  		FactoryGirl.build(:relationship).should be_valid
		end

		it "should methodically create relationship" do
  		follower = FactoryGirl.create(:user)
  		followed = FactoryGirl.create(:user)
  		follower.follow!(followed).should be_valid
		end

		it "should manually accept relationship" do
  		relationship = FactoryGirl.create(:relationship, accepted: false)
  		relationship.update(accepted: true)
  		relationship.accepted.should == true
		end

		it "should maintain values" do
			follower = FactoryGirl.create(:user)
  		followed = FactoryGirl.create(:user)
  		relationship = FactoryGirl.create(:relationship, follower: follower, followed: followed, accepted: false)
  		relationship.follower.should == follower
  		relationship.followed.should == followed
		end
	end
  
end