class Conversation < ActiveRecord::Base  

has_many(
  :messages, 
  inverse_of: :conversation
  )

has_many(
  :conversation_users, 
  inverse_of: :conversation
  )

has_many(
  :users, 
  through: :conversation_users
  )

accepts_nested_attributes_for :messages

##### CONTROLLER METHOD FOR CREATING CROUP CHAT #####

  def create_conversation_users!(recipient_ids)
    return if recipient_ids.blank?
      recipient_ids.each do |u|
        conversation_users.create!(user_id: u, conversation: self)
      end
  end

end
