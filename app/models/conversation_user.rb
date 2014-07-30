class ConversationUser < ActiveRecord::Base

attr_readonly :user_id, :conversation_id, except: {on: :create}

validates :user_id, :conversation_id, presence: true
validates :read, inclusion: [true, false]


belongs_to(
  :user, 
  inverse_of: :conversation_users
  )

belongs_to(
  :conversation, 
  inverse_of: :conversation_users
  )

has_many(
  :messages,
  through: :conversation
  )

delegate :users, to: :conversation
accepts_nested_attributes_for :conversation


  def create_and_acquire_conversation
  	return if self.conversation_id.present?
		self.create_conversation
  end

##### CALL THIS METHOD FROM FRONT END #####

  def read_message
    self.update(read: true)
  end

end
