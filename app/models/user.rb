class User < ActiveRecord::Base

include PgSearch
multisearchable against: [:first_name, :last_name] #need to prioritize relationships
pg_search_scope :weighted_search, 
  against: {first_name: 'A', last_name: 'B'},
  using: {tsearch: {prefix: true}}

devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable #, :omniauthable, :timeoutable, :lockable, :confirmable

mount_uploader :avatar, AvatarUploader
mount_uploader :backdrop, BackdropUploader

attr_readonly :email, except: {on: :create}   ##### TO OVERRIDE DEVISE SANITIZER #####

validates :first_name, :last_name, presence: true, format: {with: /\A[a-z ,.'-]+\z/i}, length: {minimum: 1, maximum: 20}
validates :gender, inclusion: {in: %w( MALE FEMALE )}, allow_nil: true
validate  :verify_email_not_banned

after_create :build_settings

# after_save :if self.deactivated == true then deactivate users page method


has_many(
  :flagged_objects,
  class_name: "Flag",
  dependent: :destroy
  )

has_many(
  :flags_on_self,
  class_name: "Flag",
  as: :flagable,
  dependent: :destroy
  )

has_one(
  :setting,
  dependent: :destroy
  )

has_many :feedbacks

has_many(
  :notifications,
  dependent: :destroy
  )

has_many(
  :blocks,
  as: :blockable,
  dependent: :destroy
  )

has_many(
  :blocked_objects,
  class_name: "Block",
  foreign_key: :blocker_id,
  dependent: :destroy
  )


has_many(
  :posts,
  dependent: :destroy
  )


has_many(
  :conversation_users, 
  inverse_of: :user,
  dependent: :destroy
  )

has_many(
  :conversations, 
  through: :conversation_users
  )

has_many :messages

has_many(
  :received_messages, 
  class_name: "Message", 
  through: :conversations,
  source: :messages
  )

has_many(
  :group_users, 
  inverse_of: :user,
  dependent: :destroy
  )

has_many(
  :groups,
  dependent: :destroy
  )

##### FOLLOWING #####

has_many( 
  :relationships, 
  -> { where("accepted = ?", true) },
  class_name: "Relationship",
  foreign_key: :follower_id,
  dependent: :destroy
  )

has_many( 
  :reverse_relationships, 
  -> { where("accepted = ?", true) },
  class_name: "Relationship",
  foreign_key: :followed_id,
  dependent: :destroy
  )

has_many( 
  :relationships_pending, 
  -> { where("accepted = ?", false) },
  class_name: "Relationship",
  foreign_key: :follower_id,
  dependent: :destroy
  )

has_many( 
  :reverse_relationships_pending, 
  -> { where("accepted = ?", false) },
  class_name: "Relationship",
  foreign_key: :followed_id,
  dependent: :destroy
  )

has_many( 
  :followers, 
  through: :reverse_relationships,
  source: :follower
  )

has_many( 
  :followed_users, 
  through: :relationships, 
  source: :followed
  )

has_many( 
  :pending_followers, 
  through: :reverse_relationships_pending,
  source: :follower
  )

has_many( 
  :pending_followed_users, 
  through: :relationships_pending, 
  source: :followed
  )

#################

has_many(
  :comments,
  class_name: 'Comment',
  foreign_key: :user_id,
  dependent: :destroy
  )

has_many(
  :likes,
  class_name: 'Like',
  foreign_key: :user_id,
  dependent: :destroy
  )


  def name
    "#{self.first_name} #{self.last_name}"
  end

  def follow_feed
    followee_ids = self.relationships.pluck(:followed_id)
    posts = Post.where(user_id: followee_ids)
    posts.sort {|x,y| y.created_at <=> x.created_at}
  end


  def user_feed
    posts = self.posts.where(public: true)
    posts.sort {|x,y| y.created_at <=> x.created_at}
  end

##### BLOCKING USERS AND POSTS#####

  def block!(poly)
    self.blocked_objects.create!(blockable: poly)
  end

  def kill_block_on!(poly)
    self.blocked_objects.find_by(blockable: poly).destroy
  end

  def blocked?(poly)
    self.blocked_objects.find_by(blockable: poly).present?
  end

  def blocked_by?(user)
    user.blocked_objects.find_by(blockable: self).present?
  end

##### FOLLOWING USERS #####
  	  
  def following?(user)
    self.relationships.find_by(followed_id: user.id, accepted: true)
  end

  def valid_follow?(user)
    !self.following?(user) && self != user
  end

  def follow!(user)
    self.relationships.create!(followed_id: user.id)
  end

  def accept_follow!(user)
    self.reverse_relationships_pending.find_by(follower_id: user.id).update(accepted: true)
  end

  def accept_all_follows!
    self.reverse_relationships_pending.update_all(accepted: true)
  end

  def unfollow!(user)
    self.relationships.find_by(followed_id: user.id).destroy
  end

##### UNREAD ALERTS #####

  def unread_conversations
    self.conversation_users.where(read: false)
  end

  def unread_notifications # add .size in front end
    self.notifications.where(read: false)
  end

##### BANNING #####

  def ban!
      puts "Are you sure you want to ban #{self.email}? [Y/n]"
      answer = gets.chomp
    if answer == "Y" || answer == "y"
      puts "Enter the ban report."      
      reason = gets.chomp
      self.update(deactivated: true)
      BannedUser.create(email: self.email, ban_report: reason)
      puts "#{self.email} is now banned!"
    else
      puts "#{self.email} not banned. Exiting function."
    end
  end

  def banned?(email)
    BannedUser.find_by(email: email).present?
  end

##### SHARE #####

  def share(item)
    self.posts.create(shareable: item)
  end

##### SEARCH #####

  def search_bar(query)
    start = Time.now
    results = []
    PgSearch.multisearch(query).find_each do |document|
      case document.searchable_type
      when "Post"
        break unless document.searchable.public == true
        results << document
      when "User"
        results << document
      end
    end
    stop = Time.now - start
    puts "#{results}"
    return "The query took #{stop} seconds."
  end

##### TEST MESSAGING #####

  def start_conversation(ids, body)
    conv = Conversation.create
    conv.create_conversation_users!(ids << self.id)
    self.messages.create(conversation: conv, body: body)
  end

##### FLAGGING #####

  def flag!(object)
    self.flagged_objects.create(flagable: object)
  end

##### COMMENTING #####

  def comment_on(object, body)
    self.comments.create(threadable: object, body: body)
  end

##### LIKING #####

  def like_on(object)
    self.likes.create(likeable: object)
  end

private


  def build_settings
    self.create_setting
  end

  def verify_email_not_banned
    return unless banned?(self.email)
    errors.add(:base, 'You have been banned from creating an account.')
  end

  
end
