require 'spec_helper'

describe Comment do

  describe "validations" do

  	it { should have_readonly_attribute(:user_id) }
  	it { should validate_presence_of(:user_id) }
  	it { should validate_presence_of(:threadable_id) }
  	it { should validate_presence_of(:threadable_type) }
  	it { should ensure_inclusion_of(:threadable_type).in_array(%w( Post )) }
  	it { should validate_presence_of(:body) }
  	it { should ensure_length_of(:body) }

  end
  

  describe "associations" do
    
    it { should belong_to(:user) }
  	it { should belong_to(:threadable) }
  	it { should have_many(:likes) }

  end


  describe "(for invalid comment attributes)" do

  	it "should require user" do
  	  FactoryGirl.build(:post_comment, user: nil).should_not be_valid
  	end

  	it "should require threadable" do
  	  FactoryGirl.build(:post_comment, threadable_type: nil, threadable_id: nil).should_not be_valid
  	end

  	it "should require body" do
  	  FactoryGirl.build(:post_comment, body: nil).should_not be_valid
  	end
  end


  describe "(for valid comment attributes)" do

  	it "should manually create comment" do
  	  FactoryGirl.build(:post_comment).should be_valid
  	end

    it "should methodically create post comment" do
      user = FactoryGirl.create(:user)
      post = FactoryGirl.create(:post)
      post.comments.size.should == 0
      user.comment_on(post, "I'm a comment!")
      post.comments.reload
      post.comments.size.should == 1
    end
  end

end
