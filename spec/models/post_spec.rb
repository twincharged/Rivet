require 'spec_helper'

describe Post do

  describe "validations" do

  	it { should have_readonly_attribute(:user_id) }
  	it { should validate_presence_of(:user_id) }
    
  end
  

  describe "associations" do

  	it { should belong_to(:user) }
    it { should have_many(:notifications) }
  	it { should respond_to(:shareable) }
  	it { should have_many(:shares) }
  	it { should have_many(:comments) }
  	it { should have_many(:likes) }
  	it { should have_many(:flags) }
  	it { should have_many(:blocks) }

  end


  describe "(for invalid post attributes)" do

  	it "should require user" do
      FactoryGirl.build(:post, user: nil).should_not be_valid
    end

    it "should require content" do
      FactoryGirl.build(:post, body: nil).should_not be_valid
    end

  end


  describe "(for valid post attributes)" do

  	it "should create post" do
      FactoryGirl.build(:post).should be_valid
    end

  	it "should create post with body" do
      FactoryGirl.build(:post, body: 'WELL HELLO').should be_valid
    end

    it "should create post with photo" do
      file = File.open("app/assets/images/logo-white.png")
      FactoryGirl.build(:post, photo: file).should be_valid
    end

    it "should share post with youtube" do
      FactoryGirl.build(:youtube_post).should be_valid
    end

    it "should share post" do
      shared_post = FactoryGirl.create(:post)
      post = FactoryGirl.create(:post, shareable: shared_post)
      post.should be_valid
      shared_post.shares.first.should == post
    end
  end


  describe "(for recieving posts)" do

    ##### MANUAL FEED SPECS FOR SQLITE #####

    it "should create follow feed" do
      followed1 = FactoryGirl.create(:user)
      followed2 = FactoryGirl.create(:user)
      follower = FactoryGirl.create(:user)
      follower.follow!(followed1)
      follower.follow!(followed2)
      post1 = FactoryGirl.create(:post, user: followed1)
      post2 = FactoryGirl.create(:post, user: followed2)
      unfollowed_post = FactoryGirl.create(:post)
      followee_ids = Relationship.where(follower: follower).pluck(:followed_id)
      posts = Post.where(user_id: followee_ids)
      posts.should include(post1, post2)
      posts.should_not include(unfollowed_post)
    end

    ##### MANUAL FEED SPECS FOR SQLITE #####

    it "should create follow feed" do
      post1 = FactoryGirl.create(:post)
      post2 = FactoryGirl.create(:post)
      unfollowed_post = FactoryGirl.create(:post)
      follower = FactoryGirl.create(:user)
      follower.follow!(post1.user)
      follower.follow!(post2.user)
      posts = follower.follow_feed
      posts.should include(post1, post2)
      posts.should_not include(unfollowed_post)
    end
  end


end
