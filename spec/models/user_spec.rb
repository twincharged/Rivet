require 'spec_helper'

describe User do

##### AUTOMATED SPECS #####
  
  describe "validations" do

  	it { should validate_presence_of(:email) }
  	it { should validate_presence_of(:first_name) }
  	it { should ensure_length_of(:first_name) }
  	it { should validate_presence_of(:last_name) }
  	it { should ensure_length_of(:last_name) }
  	it { should validate_uniqueness_of(:email) }
  	it { should validate_presence_of(:password) }
  	it { should ensure_length_of(:password) }

  end

  
  describe "associations" do
    
    it { should have_many(:blocks) }
  	it { should have_many(:blocked_objects) }
  	it { should have_one(:setting) }
  	it { should have_many(:flagged_objects) }
    it { should have_many(:flags_on_self) }
  	it { should have_many(:feedbacks) }
  	it { should have_many(:notifications) }
  	it { should have_many(:posts) }
  	it { should have_many(:conversation_users) }
  	it { should have_many(:conversations) }
  	it { should have_many(:messages) }
  	it { should have_many(:group_users) }
  	it { should have_many(:groups) }
  	it { should have_many(:relationships) }
  	it { should have_many(:reverse_relationships) }
  	it { should have_many(:relationships_pending) }
  	it { should have_many(:reverse_relationships_pending) }
  	it { should have_many(:followers) }
  	it { should have_many(:followed_users) }
  	it { should have_many(:pending_followers) }
  	it { should have_many(:pending_followed_users) }
  	it { should have_many(:comments) }
  	it { should have_many(:likes) }

  end
  
##### MANUAL SPECS #####  
  
  describe "(for invalid user attributes)" do
  
  ##### INVALID EMAIL #####
  
    it "should require email" do
      FactoryGirl.build(:user, email: "").should_not be_valid
    end
  
  ##### INVALID FIRST NAME #####
  
    it "should require first name" do
      FactoryGirl.build(:user, first_name: "").should_not be_valid
    end
  
    it "should reject lengthy first names" do
      lengthy_name = "long" * 6
      FactoryGirl.build(:user, first_name: lengthy_name).should_not be_valid
    end
  
    it "should reject first name" do
      invalid_users = ["invalid_fname1", "2not valid", "@invalid3", "4invalid:", "5invalid?", "_invalid6", "/invalid7", "|invalid8", "invalid\9", "invalid{10"]
      invalid_users.each do |invalid_users|
      FactoryGirl.build(:user, first_name: invalid_users).should_not be_valid
      end
    end
  
  ##### INVALID LAST NAME #####
  
    it "should require last name" do
      FactoryGirl.build(:user, last_name: "").should_not be_valid
    end
  
    it "should reject lengthy last names" do
      lengthy_name = "long" * 6
      FactoryGirl.build(:user, last_name: lengthy_name).should_not be_valid
    end
  
    it "should reject last names" do
      invalid_users = ["invalid_fname1", "2not valid", "@invalid3", "4invalid:", "5invalid?", "_invalid6", "/invalid7", "|invalid8", "invalid\9", "invalid''10"]
      invalid_users.each do |invalid_users|
      FactoryGirl.build(:user, last_name: invalid_users).should_not be_valid
      end
    end
  
  ##### INVALID PASSWORD #####
  
    it "should require password" do
      FactoryGirl.build(:user, password: "").should_not be_valid
    end
  
    it "should reject lengthy passwords" do
      lengthy_password = "longpassword" * 5
      FactoryGirl.build(:user, password: lengthy_password).should_not be_valid
    end
  
    it "should reject short passwords" do
      FactoryGirl.build(:user, password: "short").should_not be_valid
    end
  
  ##### INVALID GENDER #####
  
    it "should reject genders" do
      FactoryGirl.build(:user, gender: "SHIM").should_not be_valid
    end
  
  ##### INVALID BDAY #####
  
    # it "should reject birthdays that are invalid" do
    #   FactoryGirl.build(:user, birthday: "YESTERDAY").should_not be_valid
    # end
  end
  

  describe "(for valid user attributes)" do

  	it "should create valid user" do
  		FactoryGirl.create(:user).should be_valid
  	end
  
    it "should accept email" do
      valid_emails = ["jhran@email.arizona.edu", "egnog@email.asu.edu", "zachf@email.seas.harvard.edu", "jimbo@email.stanford.edu"]
      valid_emails.each do |valid_emails|
      FactoryGirl.build(:user, email: valid_emails).should be_valid
      end
    end
  
    it "should accept first name" do
      valid_users = ["John", "Matt", "Amit", "Hassan-Al", "McClain", "L'Trell"]
      valid_users.each do |valid_users|
      FactoryGirl.build(:user, first_name: valid_users).should be_valid
      end
    end
  
    it "should accept last name" do
      valid_users = ["Smith", "Freal", "Case", "El-Ar", "McCormick", "L'Neal"]
      valid_users.each do |valid_users|
      FactoryGirl.build(:user, last_name: valid_users).should be_valid
      end
    end
  
    it "should accept password" do
      valid_users = ["CoolKid119", "iheartfalloutboy2", "Im pretty nifty", "0xboxsucks0", "Why so serious", "Ima show you how great I am."]
      valid_users.each do |valid_users|
      FactoryGirl.build(:user, password: valid_users, password_confirmation: valid_users).should be_valid
      end
    end
  
    it "should not require description" do
      FactoryGirl.build(:user, description: nil).should be_valid
    end
  
    it "should accept entity" do
      FactoryGirl.build(:user, entity: true).should be_valid
    end
  
    it "should accept moderator" do
      FactoryGirl.build(:user, moderator: true).should be_valid
    end
  
    it "should accept deactivated" do
      FactoryGirl.build(:user, deactivated: true).should be_valid
    end
  
    it "should create setting" do
      valid_user = FactoryGirl.create(:user)
      Setting.find_by_user_id(valid_user.id).should_not be_nil
    end
  end

end
