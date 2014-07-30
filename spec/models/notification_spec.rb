require 'spec_helper'
require 'debugger'


##### THIS SPEC IS OVER-COMPLICATED BECAUSE I WAS NEEDING FURTHER SPEC CLARITY FOR UNKNOWN FAILING SPECS #####

describe Notification do

  describe "validations" do

    context "should validate comment notification on post" do
      notified = FactoryGirl.create(:user, entity: true)
      notified_post = FactoryGirl.create(:post, user: notified)
      comment1 = FactoryGirl.create(:post_comment, threadable: notified_post)
      note1 = notified.notifications.find_by(notifiable: notified_post, from_comment: true)

  	  subject { note1 }
  	  it { should have_readonly_attribute(:user_id) }
  	  it { should have_readonly_attribute(:notifiable_id) }
  	  it { should have_readonly_attribute(:notifiable_type) }
  	  it { should validate_presence_of(:user_id) }
  	  it { should validate_presence_of(:notifiable_id) }
  	  it { should validate_presence_of(:notifiable_type) }
  	  it { should ensure_inclusion_of(:notifiable_type).in_array(%w( Post Comment )) }
    end
   
    context "should validate like notification on post" do
      notified = FactoryGirl.create(:user, entity: true)
      notified_post = FactoryGirl.create(:post, user: notified)
      like1 = FactoryGirl.create(:post_like, likeable: notified_post)
      note2 = notified.notifications.find_by(notifiable: notified_post, from_comment: false)

      subject { note2 }
  	  it { should have_readonly_attribute(:user_id) }
  	  it { should have_readonly_attribute(:notifiable_id) }
  	  it { should have_readonly_attribute(:notifiable_type) }
  	  it { should validate_presence_of(:user_id) }
  	  it { should validate_presence_of(:notifiable_id) }
  	  it { should validate_presence_of(:notifiable_type) }
  	  it { should ensure_inclusion_of(:notifiable_type).in_array(%w( Post Comment )) }
    end

    context "should validate like notification on comment" do
      notified = FactoryGirl.create(:user, entity: true)
      notified_post = FactoryGirl.create(:post, user: notified)
      comment1 = FactoryGirl.create(:post_comment, threadable: notified_post)
      like2 = FactoryGirl.create(:comment_like, likeable: comment1)
      note3 = comment1.user.notifications.find_by(notifiable: comment1, from_comment: false)

      subject { note3 }
      it { should have_readonly_attribute(:user_id) }
      it { should have_readonly_attribute(:notifiable_id) }
      it { should have_readonly_attribute(:notifiable_type) }
      it { should validate_presence_of(:user_id) }
      it { should validate_presence_of(:notifiable_id) }
      it { should validate_presence_of(:notifiable_type) }
      it { should ensure_inclusion_of(:notifiable_type).in_array(%w( Post Comment )) }
    end
  end
  

  describe "associations" do
    
    it { should belong_to(:user) }
    it { should belong_to(:notifiable) }

  end


  describe "(for dependent destruction)" do
    
    it "should destroy notification for comment on post" do
      post = FactoryGirl.create(:post)
      comment = FactoryGirl.create(:post_comment, threadable: post)
      post.user.notifications.should_not be_nil
      comment.destroy
      note = post.user.notifications.find_by(notifiable: post, from_comment: true)
      note.should be_nil
    end

    it "should not destroy notification for comment on post" do
      post = FactoryGirl.create(:post)
      comments = FactoryGirl.create_list(:post_comment, 2, threadable: post)
      post.user.notifications.should_not be_nil
      comments.first.destroy
      note = post.user.notifications.find_by(notifiable: post, from_comment: true)
      note.should_not be_nil
    end

    it "should destroy notification for like on post" do
      post = FactoryGirl.create(:post)
      like = FactoryGirl.create(:post_like, likeable: post)
      post.user.notifications.should_not be_nil
      like.destroy
      note = post.user.notifications.find_by(notifiable: post, from_comment: false)
      note.should be_nil
    end

    it "should not destroy notification for like on post" do
      post = FactoryGirl.create(:post)
      likes = FactoryGirl.create_list(:post_like, 2, likeable: post)
      post.user.notifications.should_not be_nil
      likes.first.destroy
      note = post.user.notifications.find_by(notifiable: post, from_comment: false)
      note.should_not be_nil
    end

    it "should destroy notification for like on comment" do
      comment = FactoryGirl.create(:post_comment)
      like = FactoryGirl.create(:comment_like, likeable: comment)
      comment.user.notifications.should_not be_nil
      like.destroy
      note = comment.user.notifications.find_by(notifiable: comment, from_comment: false)
      note.should be_nil
    end

    it "should not destroy notification for like on comment" do
      comment = FactoryGirl.create(:post_comment)
      likes = FactoryGirl.create_list(:comment_like, 2, likeable: comment)
      comment.user.notifications.should_not be_nil
      likes.first.destroy
      note = comment.user.notifications.find_by(notifiable: comment, from_comment: false)
      note.should_not be_nil
    end
  end


  describe "(for updating notifications)" do

    it "should update notification for comments on post" do
      post = FactoryGirl.create(:post)
      comment = FactoryGirl.create(:post_comment, threadable: post)
      post.user.notifications.first.body.should == "#{comment.user.name} commented on your post."
      comments = FactoryGirl.create_list(:post_comment, 2, threadable: post)
      post.user.notifications.reload
      post.user.notifications.first.body.should == "#{post.comments.size} new comments on your post."
    end

    it "should update notification for likes on post" do
      post = FactoryGirl.create(:post)
      like = FactoryGirl.create(:post_like, likeable: post)
      post.user.notifications.first.body.should == "#{like.user.name} liked your post."
      likes = FactoryGirl.create_list(:post_like, 2, likeable: post)
      post.user.notifications.reload
      post.user.notifications.first.body.should == "#{post.likes.size} new likes on your post."
    end
  end


end
