require 'spec_helper'

describe BannedUser do

	describe "validations" do

  	  it { should validate_presence_of(:email) }
  	  it { should validate_uniqueness_of(:email) }
  	  it { should validate_presence_of(:ban_report) }
  	  it { should ensure_length_of(:ban_report) }

	end


	describe "for invalid user ban" do

    it "should require user email" do
     	FactoryGirl.build(:banned_user, email: nil).should_not be_valid
	  end

    it "should require ban report" do
     	FactoryGirl.build(:banned_user, ban_report: nil).should_not be_valid
	  end


    it "should require unique user email" do
      FactoryGirl.create(:banned_user, email: 'yada@email.az.edu')
     	FactoryGirl.build(:banned_user, email: 'yada@email.az.edu').should_not be_valid
	  end

    it "should reject ban report that is too long" do
      report = "Too long." * 700
     	FactoryGirl.build(:banned_user, ban_report: report).should_not be_valid
	  end
	end


	describe "for valid user ban" do

    it "should create banned user" do
     	FactoryGirl.create(:banned_user).should be_valid
	  end
	end
  
end
