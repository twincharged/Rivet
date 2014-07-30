require 'spec_helper'

describe Like do

  describe "validations" do

  	it { should have_readonly_attribute(:user_id) }
  	it { should validate_presence_of(:user_id) }
  	it { should validate_presence_of(:likeable_id) }
  	it { should validate_presence_of(:likeable_type) }
  	it { should ensure_inclusion_of(:likeable_type).in_array(%w( Post )) }

  end

  
  describe "associations" do
    
    it { should belong_to(:user) }
  	it { should belong_to(:likeable) }

  end


  describe "(for invalid like attributes)" do

  	it "should require user" do
  	  FactoryGirl.build(:post_like, user: nil).should_not be_valid
  	end

  	it "should require likeable" do
  	  FactoryGirl.build(:post_like, likeable_type: nil, likeable_id: nil).should_not be_valid
  	  FactoryGirl.build(:comment_like, likeable_type: nil, likeable_id: nil).should_not be_valid
  	end
  end
  

  describe "(for valid like attributes)" do

  	it "should manually create like" do
  	  FactoryGirl.build(:post_like).should be_valid
  	  FactoryGirl.build(:comment_like).should be_valid
  	end

    it "should methodically create post like" do
      user = FactoryGirl.create(:user)
      post = FactoryGirl.create(:post)
      post.likes.size.should == 0
      user.like_on(post)
      post.likes.reload
      post.likes.size.should == 1
    end

    it "should methodically create comment like" do
      user = FactoryGirl.create(:user)
      comment = FactoryGirl.create(:post_comment)
      comment.likes.size.should == 0
      user.like_on(comment)
      comment.likes.reload
      comment.likes.size.should == 1
    end
  end

end
