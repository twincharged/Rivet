class ConversationsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_conversation_user, only: [:destroy]
  before_filter :set_conversation, only: [:show]


def index
  @conversations = current_user.conversations.to_a
end

def show
end


##### METHODS BELOW NOT TO SEND MESSAGE TO EXISTING CONVERSATION, BUT TO START NEW CONVERSATION AND SEND A NEW MESSAGE #####


def new
  @conversation = Conversation.new
  @conversation.messages.build
end


def create
    @conversation = Conversation.create!
    @conversation.conversation_users.create(user: current_user)
    @conversation.create_conversation_users!(conversation_user_params[:recipient_ids])
    @message = @conversation.messages.build(body: params[:body])
    @message.user = current_user
    @message.save!
    redirect_to conversation_path(@conversation)
end


##### LEAVING A GROUP CHAT #####


def destroy
  @conversation_user.destroy
  redirect_to :back
end


##### CREATE CU FROM CURRENT USER, REPLICATE ERROR, CLEAN/SPEED UP CODE, CREATE MESSAGES/ROUTES #####


  private

    def set_conversation_user
      @conversation_user = ConversationUser.find(params[:id])
    end

    def set_conversation
      @conversation = Conversation.find(params[:id])
    end

    def conversation_user_params
      params.require(:conversation_user).permit(recipient_ids: [])
    end

end
